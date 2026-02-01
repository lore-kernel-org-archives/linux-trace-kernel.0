Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C17F1F37D3;
	Sun,  1 Feb 2026 03:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769916550; cv=none; b=Ru/GDurrsBPxfuGWpqxPUJRKnHKRAkgyxBXF2CyBPqg3xMcLe0lkk3jqzHed9x1XqlrdZvAZIcMuMo2uNn3+oAD79PSsHdk2VPSu9cdMAdB8uigGzdbvhXC8dTDCJ7HgLM29uxF1RnGuc+d12zXb/qop/+vWmSwOQdDNk4RxvCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769916550; c=relaxed/simple;
	bh=YQL7l01WmvmK7If7bIbiNydjrUoMH+8UyFa2Eop9bCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nrw2/gufhTMNam5Outlt0kdbFCPgZuj1XVoB2zIi+2UsQn8FxgrFIWXl2GUEyunEWi6bGoOaaW5CL/IlJNiGpbSYBQPcdTdiKAW7l7Fmy8lD//aIsbm5Hi9bGAlLthxGEjLN74J5W+S01oQeG3OasBH+qLP4TKgyrt/sxH3U7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WW/79627; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WW/79627"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF55EC4CEF7;
	Sun,  1 Feb 2026 03:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769916549;
	bh=YQL7l01WmvmK7If7bIbiNydjrUoMH+8UyFa2Eop9bCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WW/79627xL3kywna44rDXHjBbMVyZ6XvQsnpWOVYvZHGG6lIkCasFO5vFslbs1i40
	 s7qz/sU4obQ7h+NmxP+lpIuRcCOviAApkTh9FTE6hHOBOV2AFU1PiqJ4myWsCBa2Zt
	 7OttVNDccM4xnidFZEdf0PZ9ycGE1VT3tbbNyJg+78WahLI3oEtMqPP8Z/c8vnipl9
	 IM6bIl8Qp9GzC5hSDjVKRlFrp6eY0WSV3/xx+c+uPerl2WNbhHxitNGrylmcVxv/q1
	 3FDnGZkn29fCpiti5ZE00TJXeiO3w8cfP9ATdEuF7UfzI6qkHNM/QDcrr2sckZflO9
	 NnmNIYX2UQAZQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] tracing: Reset last_boot_info if ring buffer is reset
Date: Sun,  1 Feb 2026 12:29:07 +0900
Message-ID:  <176991654703.4025429.9641092475053587709.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
In-Reply-To:  <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
References:  <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
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
index 396d59202438..5c3e4a554143 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4891,6 +4891,8 @@ static int tracing_single_release_tr(struct inode *inode, struct file *file)
 	return single_release(inode, file);
 }
 
+static bool update_last_data_if_empty(struct trace_array *tr);
+
 static int tracing_open(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
@@ -4915,6 +4917,8 @@ static int tracing_open(struct inode *inode, struct file *file)
 			tracing_reset_online_cpus(trace_buf);
 		else
 			tracing_reset_cpu(trace_buf, cpu);
+
+		update_last_data_if_empty(tr);
 	}
 
 	if (file->f_mode & FMODE_READ) {
@@ -5981,6 +5985,7 @@ tracing_set_trace_read(struct file *filp, char __user *ubuf,
 int tracer_init(struct tracer *t, struct trace_array *tr)
 {
 	tracing_reset_online_cpus(&tr->array_buffer);
+	update_last_data_if_empty(tr);
 	return t->init(tr);
 }
 
@@ -7799,6 +7804,7 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 		ring_buffer_set_clock(tr->max_buffer.buffer, trace_clocks[i].func);
 	tracing_reset_online_cpus(&tr->max_buffer);
 #endif
+	update_last_data_if_empty(tr);
 
 	if (tr->scratch && !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT)) {
 		struct trace_scratch *tscratch = tr->scratch;
@@ -8036,6 +8042,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 				tracing_reset_online_cpus(&tr->max_buffer);
 			else
 				tracing_reset_cpu(&tr->max_buffer, iter->cpu_file);
+			update_last_data_if_empty(tr);
 		}
 		break;
 	}

