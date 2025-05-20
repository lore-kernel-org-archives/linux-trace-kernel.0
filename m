Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD11C6BE;
	Tue, 20 May 2025 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747721622; cv=none; b=Hd+FQd7P4Fr7k8g0wnIpeJFKjsUP+J/E2m3dstBNUSCHpyAbCwNhBNnLxygq3VtWIVW6jXt9t9vqQxow8veZ/O7G22UV8ohiQrBGT6fBUKOjki88+Hpdq6ZSw/x5YxwnmJbGHqDnHz4Nm21vzJ2MQD9HD8K6LmZFo9rxYSyQUys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747721622; c=relaxed/simple;
	bh=qv24cgaIowjqbztnCwTh6HyqJ2LT0oEfi9MxLUaIjUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbrk9lpp6lf1qLuGFJDNbXFz64OO76WhYD9yXINSkiZ6RVi/G4P1gfTBfSsYehNCRlTvAxDNZwxKeMphiQW9MbY+BikSQfREQqJjYfIHhnoVNLYp94d2U4D8n+H5vSLbJ8DIahrx4OK+ALBjZ5aqHB2l2fqO1PaGS6pLD5t4mJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKF/m41X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKF/m41X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12781C4CEE9;
	Tue, 20 May 2025 06:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747721621;
	bh=qv24cgaIowjqbztnCwTh6HyqJ2LT0oEfi9MxLUaIjUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKF/m41XkYWF6WjZcP3accTMgSHgfJaIOf79+sw65RQDHU4Oi04a62Z6UzaBkksaa
	 BueBeSZICIWvvVfEGVFAA939xchaWIc7QWcNJTLv1f6S86a6rb0dt5VAax2S71spZQ
	 B3WNE8S/+RMbJXIE3TQAahfXkeo/R5nOkf99jFTcUaCJTUdguphKMTkj5pnpp+KM9X
	 JvPpOgJ6dBNZ1DeXYScbLsUO+uVKFHrJSeSGIcwJAVSevOpGgvkYy/6nuwxVTrgA35
	 Z+LROySr56xZTaZkL5UgAUtyxeScx4VgyuOFHpgxXj42ienZi6owLiTFlXnooyoxdP
	 YHSaAXK/ztUIA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Reset last-boot buffers when reading out all cpu buffers
Date: Tue, 20 May 2025 15:13:38 +0900
Message-ID:  <174772161786.1341812.8912662133740822008.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
In-Reply-To:  <174730775661.3893490.10420015749079085314.stgit@mhiramat.tok.corp.google.com>
References:  <174730775661.3893490.10420015749079085314.stgit@mhiramat.tok.corp.google.com>
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

Reset the last-boot ring buffers when read() reads out all cpu
buffers through trace_pipe/trace_pipe_raw. This prevents ftrace to
unwind ring buffer read pointer next boot.

Note that this resets only when all per-cpu buffers are empty, and
read via read(2) syscall. For example, if you read only one of the
per-cpu trace_pipe, it does not reset it. Also, reading buffer by
splice(2) syscall, it does not reset because there will be the
data in reader page.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2c1764ed87b0..433671d3aa43 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6677,6 +6677,22 @@ static int tracing_wait_pipe(struct file *filp)
 	return 1;
 }
 
+static bool update_last_data_if_empty(struct trace_array *tr)
+{
+	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+		return false;
+
+	if (!ring_buffer_empty(tr->array_buffer.buffer))
+		return false;
+
+	/*
+	 * If the buffer contains the last boot data and all per-cpu
+	 * buffers are empty, reset it from the kernel side.
+	 */
+	update_last_data(tr);
+	return true;
+}
+
 /*
  * Consumer reader.
  */
@@ -6708,6 +6724,9 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 	}
 
 waitagain:
+	if (update_last_data_if_empty(iter->tr))
+		return 0;
+
 	sret = tracing_wait_pipe(filp);
 	if (sret <= 0)
 		return sret;
@@ -8286,6 +8305,9 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 
 	if (ret < 0) {
 		if (trace_empty(iter) && !iter->closed) {
+			if (update_last_data_if_empty(iter->tr))
+				return 0;
+
 			if ((filp->f_flags & O_NONBLOCK))
 				return -EAGAIN;
 

