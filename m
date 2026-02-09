Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A999D363C5F;
	Mon,  9 Feb 2026 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629134; cv=none; b=CqE136vuISATU7Kxs9Te9ikDCSeb0uXtHY7K4OJ8SfxWPD2JYxu7SnfFqFpXpqAaQnjuTKFz7KEmztYTOiBU0AQNyUyEjPS7dEnEMLjtpplXSgY+BeOYAVT1z6BtuQclpePPFdz6nhMETCRB4cN6xyGZsjqsgC8Fh5WOoHAut+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629134; c=relaxed/simple;
	bh=V/+j7kQfNuspu+Q5e0iTMIHqcYsXeUFZ+qYU0M2iJGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZUFsDOa4mrmMuGbvF6YxxCqZU/i/jowextVh0sEwbFyNWoSuMOeQyCc5yNrCGHIvtnN0L4lUUuUX4DSExK/WIcGiISUddYFtbkJ8kyqGMApsT3r5+D2IRywrn9hU/8vV3I3HUm0qraoxotUlbsnAWfdGYvZKCVl6y630fS499w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKsv4lHq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKsv4lHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCB6C2BC86;
	Mon,  9 Feb 2026 09:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770629134;
	bh=V/+j7kQfNuspu+Q5e0iTMIHqcYsXeUFZ+qYU0M2iJGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKsv4lHqhWxYHfQxsoPN2WTwixVhj63rnpYwDui9oX1oe3UqdakkXaU0Oee5+xN7G
	 p0qJvE2ev3zfO0dMEtrN8qf6WQDx5eYbGG+BqkZJXDiqIuRH+b4tUTRLfB1ntCxvxC
	 E9mPFfvCnTblnkXWL4LorDVCOqKstxoKdH0amhLwFr6YXf2fct2HaiGL1ugHpPwjkF
	 bh6QJ2rdNf347yEH7y10xetucDFcj+o1uCaCM1fplNG/oEiuRejhEqdNR1GnO5DM77
	 6qgc76DWT6HLsql4uQz30DbyBzz1ZinFKcWsjqa49HByPteudyRPUuDjdiDSbzWsry
	 Q2wI/GfQ/sBYw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 1/4] tracing: Reset last_boot_info if ring buffer is reset
Date: Mon,  9 Feb 2026 18:25:32 +0900
Message-ID:  <177062913185.1230888.10201577470513915058.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
In-Reply-To:  <177062912135.1230888.17419570791737357433.stgit@mhiramat.tok.corp.google.com>
References:  <177062912135.1230888.17419570791737357433.stgit@mhiramat.tok.corp.google.com>
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
Changes in v7:
 - Remove unneeded update_last_data_if_empty() call from
   tracing_snapshot_write() because snapshot is disabled on
   persistent instances.
---
 kernel/trace/trace.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 845b8a165daf..9e1cff78a1ca 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4127,6 +4127,8 @@ static int tracing_single_release_tr(struct inode *inode, struct file *file)
 	return single_release(inode, file);
 }
 
+static bool update_last_data_if_empty(struct trace_array *tr);
+
 static int tracing_open(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
@@ -4151,6 +4153,8 @@ static int tracing_open(struct inode *inode, struct file *file)
 			tracing_reset_online_cpus(trace_buf);
 		else
 			tracing_reset_cpu(trace_buf, cpu);
+
+		update_last_data_if_empty(tr);
 	}
 
 	if (file->f_mode & FMODE_READ) {
@@ -5215,6 +5219,7 @@ tracing_set_trace_read(struct file *filp, char __user *ubuf,
 int tracer_init(struct tracer *t, struct trace_array *tr)
 {
 	tracing_reset_online_cpus(&tr->array_buffer);
+	update_last_data_if_empty(tr);
 	return t->init(tr);
 }
 
@@ -7028,6 +7033,7 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 		ring_buffer_set_clock(tr->snapshot_buffer.buffer, trace_clocks[i].func);
 	tracing_reset_online_cpus(&tr->snapshot_buffer);
 #endif
+	update_last_data_if_empty(tr);
 
 	if (tr->scratch && !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT)) {
 		struct trace_scratch *tscratch = tr->scratch;

