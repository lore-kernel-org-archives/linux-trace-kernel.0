Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B897260A;
	Tue, 20 Jan 2026 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768871370; cv=none; b=MvivOlyecY7+HqFD4/r2mcNhf6E7bv7xDt0bcid4rSeQhXYIlUY5Xfu0PeIuFOAoKaIUn3VO7pLy+ayGByesayVDFkrLir14hNUng04EpWaSWmzpTsN7OUuqfSFWoucoL/lcMVr++eQzwTdhDJ69ctQ54oKGcCUg9QZCsm/Eul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768871370; c=relaxed/simple;
	bh=Cf2mbEmWcovYW5tS3zoShNkU5qDl/ggFL8Kh+ngWJ18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXksGnRRWmUsMh9PKYQ2h+0fmHmoi2RR245Ib1vZI4pB+z9E9Up4gpYpl0/K8OMBAtVSuvVB7g3EMZqsiL7VliiEenWpDhmF2/LYBwgttKM6GAGQPc2a/PlhaKxH3OHpYbK24RVb+MeaJXXIsuzbvqXDNyDugJi5q5zXKSm5UuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4W9mAZQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4W9mAZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE55C116C6;
	Tue, 20 Jan 2026 01:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768871370;
	bh=Cf2mbEmWcovYW5tS3zoShNkU5qDl/ggFL8Kh+ngWJ18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4W9mAZQWSo4dOPW9Jd1lJpCeB9jFuaeg0wIykKSAhtvqVTx4RW9vWTWYmsKcvlnK
	 AFyHCQnqd+p/RkU7zsgdi9WYuk6Gts550rLdqm5u8f+Y8Ct7XgfGj/jZ3ea6RW823A
	 elwWORb1kX0UMN8hIW+eCMHHxqme8F/LPTCvE2/xuD868aC5lTKeufVqxQHYh5xjDm
	 jQKSBoQpRUeWlxuNoCeG4sz+XSQrtw7fMtXVGjHToIwvNZksOubnbKZosQdcTXYxw0
	 XDAZGJtb4/s0a31LUB3Uj6FfF+FBbTw0xKGYCOK5+t2GLXDuK2DGtrYDeyuJAFDZq+
	 KT6z22Dwbe/rw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] tracing: Reset last_boot_info if ring buffer is reset
Date: Tue, 20 Jan 2026 10:09:28 +0900
Message-ID:  <176887136789.578403.10711988283653763711.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To:  <176887135615.578403.6988045330349053692.stgit@mhiramat.tok.corp.google.com>
References:  <176887135615.578403.6988045330349053692.stgit@mhiramat.tok.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Commit 32dc0042528d ("tracing: Reset last-boot buffers when reading
out all cpu buffers") resets the last_boot_info when user read out
all data via trace_pipe* files. But it is not reset when user
resets the buffer from other files. (e.g. write `trace` file)

Reset it when the corresponding ring buffer is reset too.

Fixes: 32dc0042528d ("tracing: Reset last-boot buffers when reading out all cpu buffers")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 38f7a7a55c23..5ddaeced9cb3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4873,6 +4873,8 @@ static int tracing_single_release_tr(struct inode *inode, struct file *file)
 	return single_release(inode, file);
 }
 
+static bool update_last_data_if_empty(struct trace_array *tr);
+
 static int tracing_open(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
@@ -4897,6 +4899,8 @@ static int tracing_open(struct inode *inode, struct file *file)
 			tracing_reset_online_cpus(trace_buf);
 		else
 			tracing_reset_cpu(trace_buf, cpu);
+
+		update_last_data_if_empty(tr);
 	}
 
 	if (file->f_mode & FMODE_READ) {
@@ -5963,6 +5967,7 @@ tracing_set_trace_read(struct file *filp, char __user *ubuf,
 int tracer_init(struct tracer *t, struct trace_array *tr)
 {
 	tracing_reset_online_cpus(&tr->array_buffer);
+	update_last_data_if_empty(tr);
 	return t->init(tr);
 }
 
@@ -7781,6 +7786,7 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 		ring_buffer_set_clock(tr->max_buffer.buffer, trace_clocks[i].func);
 	tracing_reset_online_cpus(&tr->max_buffer);
 #endif
+	update_last_data_if_empty(tr);
 
 	if (tr->scratch && !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT)) {
 		struct trace_scratch *tscratch = tr->scratch;
@@ -8018,6 +8024,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 				tracing_reset_online_cpus(&tr->max_buffer);
 			else
 				tracing_reset_cpu(&tr->max_buffer, iter->cpu_file);
+			update_last_data_if_empty(tr);
 		}
 		break;
 	}

