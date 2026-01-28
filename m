Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808FF125B2;
	Wed, 28 Jan 2026 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769558991; cv=none; b=gFKwqYtIGCqwnFyqJULLYBLL38eD1fHyRHPSqkmof4rvQl6pm/zimaAtEBcRSHBNIo81sXZGr9imzLAEfYENFeVoSoPUOqW6vojT+fRmoSTYpF3Q7RlB/68O+/Ef7fg6KZ5RxcijZOaCluuRaYlAoUxaC5PLi9vF0+0XH8WAH4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769558991; c=relaxed/simple;
	bh=YQL7l01WmvmK7If7bIbiNydjrUoMH+8UyFa2Eop9bCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3TX6XOcu+ke6MomqZBM3lt1BcdCBPPhzSqLf3lEPh2ElqFfhWtWh71lg0zM2brB1oeM/x+iqcaAWQyeXNlmerVQNWtVPYhT3786y22WcGg2znJbH/OvKvvMFFxKdoskymdjz1T+PCGdgAmTDMDed/YhkQft70SHf2786rQQhqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tin/Aphc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tin/Aphc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C2FC116C6;
	Wed, 28 Jan 2026 00:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769558991;
	bh=YQL7l01WmvmK7If7bIbiNydjrUoMH+8UyFa2Eop9bCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tin/AphcIAZJu10ZgsmeMDWfmjiHW6uDdOiPv7qgSiFkNRWzUI+CFUNxNo/5mceh2
	 PINIw1mcmOFS5TigHz/l/plSxEWtHtMtgl+Ek6/9XV9NV6dKWO0DtU4kY0upZZJlwZ
	 xmGAWJC8kl0bhyYKs8JhS0EjCUCgeYgCSfUgFTR5CAe5G8snhZXI5dA/oIokvUk8u7
	 ePwmlzsFMj/5u8e2rd8TnWFcyJtNVNJdHA52+tc6XVWF5nuTFq5nDNzy8uVxeTUHZk
	 1hMSvO+JiUuswIqYKZkYLCA6qhE2OR8me5XLtL75X/lCcKGnKjTkpNmgS4W74WJsjr
	 sFy3OfXFKbcBA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] tracing: Reset last_boot_info if ring buffer is reset
Date: Wed, 28 Jan 2026 09:09:48 +0900
Message-ID:  <176955898871.2786091.11770303255491867688.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To:  <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
References:  <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
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

