Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704B418030;
	Fri,  9 Aug 2024 03:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723175852; cv=none; b=JVMHKxMz61XHJy4AzTOU4QOUE84Fos9DiZMz3YrHe/7NtlQp9kYDl23S1DQfBWOQX3HE/Vi83zqq45i13+79ZqT+v+qBxuXpMRA6pwxPSA+zH3StQX+h87JdiS7bzYY+CJn8M3O+5lZGJ5BmpqSB2zoZoJXYaMqkk4sbBeUtsBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723175852; c=relaxed/simple;
	bh=qFFcT+JhE/9LwHW1Ava5QagIw5p1np85BxcmZwxsMWU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Q3OyFy+4DfFD8KyInwVV+EOBK6UZGTd9xXGA+n8RYcPpv4P6+F3FDe9EB06CKeP71rdIQW+++8wqUJ0NR5K6LdUWVCPoUDmZLPKc0v1s50TRhUwcZHbodRU2ip+Gl5cPAMKD5qSD/RUgAtZ4RgzAdc7Yad1X7PUnXbCONJonto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677E4C32782;
	Fri,  9 Aug 2024 03:57:31 +0000 (UTC)
Date: Thu, 8 Aug 2024 23:57:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Return from tracing_buffers_read() if the file has
 been closed
Message-ID: <20240808235730.78bf63e5@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

When running the following:

 # cd /sys/kernel/tracing/
 # echo 1 > events/sched/sched_waking/enable
 # echo 1 > events/sched/sched_switch/enable
 # echo 0 > tracing_on
 # dd if=per_cpu/cpu0/trace_pipe_raw of=/tmp/raw0.dat

The dd task would get stuck in an infinite loop in the kernel. What would
happen is the following:

When ring_buffer_read_page() returns -1 (no data) then a check is made to
see if the buffer is empty (as happens when the page is not full), it will
call wait_on_pipe() to wait until the ring buffer has data. When it is it
will try again to read data (unless O_NONBLOCK is set).

The issue happens when there's a reader and the file descriptor is closed.
The wait_on_pipe() will return when that is the case. But this loop will
continue to try again and wait_on_pipe() will again return immediately and
the loop will continue and never stop.

Simply check if the file was closed before looping and exit out if it is.

Cc: stable@vger.kernel.org
Fixes: 2aa043a55b9a7 ("tracing/ring-buffer: Fix wait_on_pipe() race")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 10cd38bce2f1..ebe7ce2f5f4a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7956,7 +7956,7 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 	trace_access_unlock(iter->cpu_file);
 
 	if (ret < 0) {
-		if (trace_empty(iter)) {
+		if (trace_empty(iter) && !iter->closed) {
 			if ((filp->f_flags & O_NONBLOCK))
 				return -EAGAIN;
 
-- 
2.43.0

