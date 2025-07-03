Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711F82E5400;
	Thu,  3 Jul 2025 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546355; cv=none; b=BfaqyRyeaaPV9PLnYZELz0+CHrMEhihNrCEIbCNO7pdvNerOmCzcB9woVvAU4NWJ/xeJ0XHx52DNEv4y862IB4DLek5v0NZh2NdpKcy8KuXqjiOriBMWPDYN5rbCk6jCkp3/+2OmiDKmCeTxpx7NEpy8oN/Y1s8LlejILbRZfng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546355; c=relaxed/simple;
	bh=sS5BJFq5yl1Cpp9kuGgfCMujzkfDmeSN9fqRocDqWZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eS3wEp0ttuxK5gB9ilz/01NuRW03+vHTJLCZC5WjchDwabZO4WMyGKbvmOzsUx0/o44kzmerDUFcHBO+kpAR3QbufearcVL7+5ANgII29LtT5HNLV2tden92NAMbg4vGrY2XuJuIWOFNr8F/NEoCNDpG7B/hqREq/tg4klOICTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vzXpOSXZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FzUfzSgG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vzXpOSXZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FzUfzSgG"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751546351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Z0MqZuZk9ZorWcjtJWd2TxVCHlbiuTD5yZSdlZfeII=;
	b=vzXpOSXZEV/ki4Fz56c1LN7R+SoJv7a0tWyetgyw+Vv2V+U76gNI8tlqrmISKPXQy2SY6D
	0aqIr6/cHHuvlHMtZnazdEKO51Qb7fktkaM8LmoP47mIV/n8oERHZG4r7fNG9M1yvbgPsm
	pgYQmojQGYmXDyHS4cfaLe0WeLAH2JSdJHdKq1vUJHD7EHAGXVDsqMMuf0+2VpUmHHV7wg
	zE5IJjDCpmOvhkxkrrGUN7IBkErGnLEbnCOpVkstow06QoCV80pFViZkqdU2eV4I0PuNAr
	jbuvUxzD0pMvKIfYqx1aVt31nmEGX36gXVOXfDG5764NtgD+A6Nwf5l1tFc1hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751546351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Z0MqZuZk9ZorWcjtJWd2TxVCHlbiuTD5yZSdlZfeII=;
	b=FzUfzSgGPqvzHpwS71OnYN2WaJ+oJocoZiFsGmmcKJzDy6QxguVcuw8gMFoxVG2PvZI6Na
	mYXsXWIucs0CCKDg==
Date: Thu, 03 Jul 2025 14:38:55 +0200
Subject: [PATCH 2/2] um/ptrace: Implement HAVE_SYSCALL_TRACEPOINTS
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250703-uml-have_syscall_tracepoints-v1-2-23c1d3808578@linutronix.de>
References: <20250703-uml-have_syscall_tracepoints-v1-0-23c1d3808578@linutronix.de>
In-Reply-To: <20250703-uml-have_syscall_tracepoints-v1-0-23c1d3808578@linutronix.de>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751546346; l=2501;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=sS5BJFq5yl1Cpp9kuGgfCMujzkfDmeSN9fqRocDqWZY=;
 b=sGqrzfKZ+sO/4nzPW8zOoYWd7/SFalzFdwiFKLOhLCnOKZyiaLC0lwAQxnyzYWV3KIvuw15HZ
 AZJ7dueIW2tBUs+uy/X0/KmVvlNUmUJC+ibbivqmdK9MkypSeTSxHxf
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Implement syscall tracepoints through the generic tracing infrastructure.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Nam Cao <namcao@linutronix.de>
---
 arch/um/Kconfig                   | 1 +
 arch/um/include/asm/thread_info.h | 2 ++
 arch/um/kernel/ptrace.c           | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index f08e8a7fac93d9f98384de02710542fd75d23553..c2d2d2d99bbe3f5a5dc4afaa69e02a520e326c2d 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -35,6 +35,7 @@ config UML
 	select HAVE_RUST
 	select ARCH_HAS_UBSAN
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_SYSCALL_TRACEPOINTS
 	select THREAD_INFO_IN_TASK
 
 config MMU
diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index f9ad06fcc991a2b10e2aa6059880b993e3d60a2d..b8c021f97bd17515e4f9082206addfce05b9321e 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -43,6 +43,8 @@ struct thread_info {
 #define TIF_NOTIFY_RESUME	8
 #define TIF_SECCOMP		9	/* secure computing */
 #define TIF_SINGLESTEP		10	/* single stepping userspace */
+#define TIF_SYSCALL_TRACEPOINT	11	/* syscall tracepoint instrumentation */
+
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 2124624b7817439b8e1c962e8e6eb0e267db6f53..fdbb37b5c3996188d92cf307d31eeaeca1f0acce 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -9,6 +9,9 @@
 #include <linux/uaccess.h>
 #include <asm/ptrace-abi.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/syscalls.h>
+
 void user_enable_single_step(struct task_struct *child)
 {
 	set_tsk_thread_flag(child, TIF_SINGLESTEP);
@@ -126,6 +129,9 @@ int syscall_trace_enter(struct pt_regs *regs)
 			    UPT_SYSCALL_ARG3(&regs->regs),
 			    UPT_SYSCALL_ARG4(&regs->regs));
 
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
+		trace_sys_enter(regs, UPT_SYSCALL_NR(&regs->regs));
+
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return 0;
 
@@ -142,6 +148,9 @@ void syscall_trace_leave(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SINGLESTEP))
 		send_sigtrap(&regs->regs, 0);
 
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
+		trace_sys_exit(regs, PT_REGS_SYSCALL_RET(regs));
+
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return;
 

-- 
2.50.0

