Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD87D33D516;
	Tue, 10 Feb 2026 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770713026; cv=none; b=l97z3TdQ5jA/a90tUJr4MJegmMiEEzaCA3ewSro3ljKC4bw5lgjeMct4IrMnFCvf9p9ln1bCZg3d9SacuP9WfxiVirkg4E1FtLPPh3EWja392wTdOgcRppvMb1YSHKhEMDaoOeuJ45bZ8BgKIJx9+MMiprt7khQasgmCqm6Kdmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770713026; c=relaxed/simple;
	bh=cCxCDeUbb8VZHuaRklOxBbrjGG/HQRFWUQIw/Qe0nCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGPXRiTgYtMwZp990OqDIlJVXBol0Wfqz6BCBSUpGBPkzs0xYb6eDIzCCGBHhjFwuRbEVKqKGHLbulknfEgxijuP3OS7JL6tE5zrAt6BSLrS9idlWSI6690iIULdHNVjjiUFJQ2x0RnBpfjwQpd2aJRIDxJJNs3EGI0/CLd83KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3mCnQOl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3mCnQOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A2EC116C6;
	Tue, 10 Feb 2026 08:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770713026;
	bh=cCxCDeUbb8VZHuaRklOxBbrjGG/HQRFWUQIw/Qe0nCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3mCnQOlaFrPPjCBbVIYCfh46HGGEpQJCEGmFhPnqMLFo+yYP2tPEJw9HVvSWvUZP
	 Gcz731o0avsAElEP1Q0nNim0l3cx3RD1+TAYS3E6H+JXcyTCxhjs0+s6tvEQndYm9j
	 G5VAvwkNKW/ELT+xN44kinxDCiUXNqzzy7rTx2Q1vIJLGc5zPWd/28InIHP+YduYgx
	 jRs/seZmE5RVtEohjfYgoh5spyVzyibEZeg0ruK7u4fjBK9KV4qVGuN1WiZSsISd3g
	 j4xSu9/2iePHl61H3TRFIhYBewW0kuFVZOCkcBvvDZ1XoOyiXRBPWHeUUqk7MD85Ai
	 C3YtohPwL3eNw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v8 2/6] tracing: Reset last_boot_info if ring buffer is reset
Date: Tue, 10 Feb 2026 17:43:43 +0900
Message-ID:  <177071302364.2293046.17895165659153977720.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
In-Reply-To:  <177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com>
References:  <177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com>
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
index fd470675809b..e884d32b7895 100644
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

