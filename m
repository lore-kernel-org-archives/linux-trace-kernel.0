Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925C122D9EF;
	Thu, 29 May 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748538563; cv=none; b=YhqrBnt2U2Bi7lxvPjsX3gRRW57gxKrG8CD3471r34SSfzh+g5NpRnyQek8lDfVyUVeFYqDnCNCRMMsXNs05GUoj1ZA/OP7U5UoBxjj5SBXcJSFhjAMsc+fwWk1VZ8gYc1b6pti1EOB9Uqb1r/6/HD6Ute60DjJ8+3FllQpRqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748538563; c=relaxed/simple;
	bh=phWbfYQUtWSBgPuru1Y5ifpvko2MXVLO53DRKlF3uCI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ux1sciISx4uRZH0WS/1Tq7MKwtHwAn7ChZbG0b+COccG6w4COfHuGYNR+UxD5KGQlz1OoRcWlvOH8sGUXsjU81BxtbMN3YwF+OzhkO1h6ZsYG9G1n4bTjaSFKwjjI9xVoxPYV7JEQwuGERy5gSMuRv1/DYvl9slMN8Lx7gM8An0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F68C4CEEE;
	Thu, 29 May 2025 17:09:21 +0000 (UTC)
Date: Thu, 29 May 2025 13:10:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: [PATCH] x86/fpu: Remove unused trace events
Message-ID: <20250529131024.7c2ef96f@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The following trace events are not used and defining them just wastes
memory:

  x86_fpu_before_restore
  x86_fpu_after_restore
  x86_fpu_init_state

Simply remove them.

Link: https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/include/asm/trace/fpu.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
index 0454d5e60e5d..721b408d9a67 100644
--- a/arch/x86/include/asm/trace/fpu.h
+++ b/arch/x86/include/asm/trace/fpu.h
@@ -44,16 +44,6 @@ DEFINE_EVENT(x86_fpu, x86_fpu_after_save,
 	TP_ARGS(fpu)
 );
 
-DEFINE_EVENT(x86_fpu, x86_fpu_before_restore,
-	TP_PROTO(struct fpu *fpu),
-	TP_ARGS(fpu)
-);
-
-DEFINE_EVENT(x86_fpu, x86_fpu_after_restore,
-	TP_PROTO(struct fpu *fpu),
-	TP_ARGS(fpu)
-);
-
 DEFINE_EVENT(x86_fpu, x86_fpu_regs_activated,
 	TP_PROTO(struct fpu *fpu),
 	TP_ARGS(fpu)
@@ -64,11 +54,6 @@ DEFINE_EVENT(x86_fpu, x86_fpu_regs_deactivated,
 	TP_ARGS(fpu)
 );
 
-DEFINE_EVENT(x86_fpu, x86_fpu_init_state,
-	TP_PROTO(struct fpu *fpu),
-	TP_ARGS(fpu)
-);
-
 DEFINE_EVENT(x86_fpu, x86_fpu_dropped,
 	TP_PROTO(struct fpu *fpu),
 	TP_ARGS(fpu)
-- 
2.47.2

