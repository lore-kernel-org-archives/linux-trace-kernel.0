Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260C633A6F7;
	Fri,  6 Feb 2026 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407937; cv=none; b=TQ1BPaPfy2oq6Z/RUTrEIKL87a2sew520vipc/EDWKcFpwesX1PHiasDJGEOXTuZZHsX3CB9EyQRswodPT1RjiqKCM8pAhtyI5AgImXE24ttRELjiCHPdxAARW+4WholiGg21u6STd00S41aVP8Qni//y/nAv/ZOvejJ6BjCTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407937; c=relaxed/simple;
	bh=ay4wjzfNs4Vg2jkQLNy4bi/QQ7cVserI/t7ElR3WQy4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MGRDENR9WiAFcQ/B0LBtmBZv0rde7Y1SKO2rnQ/SY24knLXcUQiN69zsnV+OslTZfKGPItqRsTouO3AFlBcRgUT7dX/x6D6w6KCgPOISy+BBf7h07DjWci+7jtPs02l24pz9qI/dVDHqB9+WvrdZ+6JxU2LH730INQSCJs6/Ggg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyQYJURD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyQYJURD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BF3C19425;
	Fri,  6 Feb 2026 19:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770407937;
	bh=ay4wjzfNs4Vg2jkQLNy4bi/QQ7cVserI/t7ElR3WQy4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=kyQYJURDPGmAyX3E5TvR2pDNjJEVmmwLTb5i/EfjpkoRIVnJENveQKWUzAO9p1eB6
	 hRPDS4Q0/sj8VAe2PuvQvX18SSTT01odu8kyQCoyiaIn3w/sjOkYh+vpwwgAUixwfc
	 QEyZt2rj4yepSyr1VTAl/zNyTSIs33czonuetrqn9KIxDsI0zp4KJiipL7ly5B2F3e
	 YWc8w6EpeHgf3RD0MLqHf3WphkCO27NvgiPazU5h4r8iSjP3wQpXz/fHwZYeFprked
	 YNkrYxCSkM951QZV0ryboM0PqqgcEPlvdvxQ+MdLumVJ9baD5te2k6zpT2rdLW755R
	 3qIC1pOEoTi0A==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1voRzM-0000000A6ph-17Em;
	Fri, 06 Feb 2026 14:59:36 -0500
Message-ID: <20260206195936.118522327@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 06 Feb 2026 14:37:49 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 08/12] tracing: Use system_state in trace_printk_init_buffers()
References: <20260206193741.767171392@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function trace_printk_init_buffers() is used to expand tha
trace_printk buffers when trace_printk() is used within the kernel or in
modules. On kernel boot up, it holds off from starting the sched switch
cmdline recorder, but will start it immediately when it is added by a
module.

Currently it uses a trick to see if the global_trace buffer has been
allocated or not to know if it was called by module load or not. But this
is more of a hack, and can not be used when this code is moved out of
trace.c. Instead simply look at the system_state and if it is running then
it is know that it could only be called by module load.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index db36d4aebc15..3b7fa2699301 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3245,10 +3245,9 @@ void trace_printk_init_buffers(void)
 	/*
 	 * trace_printk_init_buffers() can be called by modules.
 	 * If that happens, then we need to start cmdline recording
-	 * directly here. If the global_trace.buffer is already
-	 * allocated here, then this was called by module code.
+	 * directly here.
 	 */
-	if (global_trace.array_buffer.buffer)
+	if (system_state == SYSTEM_RUNNING)
 		tracing_start_cmdline_record();
 }
 EXPORT_SYMBOL_GPL(trace_printk_init_buffers);
-- 
2.51.0


