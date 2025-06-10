Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF3B28B4F8;
	Tue, 10 Jun 2025 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548645; cv=none; b=PHwsvZevdfVQiaAu+XJhoVlH8CTNtGgnC7i9XdPr4ObXacR72Y6OzwAiTApnXQa7lVI+Ot2rJr+CEaWrfqhHh0DbX+NbrDmC37jyDq3IGZCb5ZPuHk1z7+/ynCA+LfZoqabm/TEQ7EXcMfHJCOO6NgIJO1sxEqgDeoUVzPhi7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548645; c=relaxed/simple;
	bh=LLexdrRrlhOMwMrLRDDPawXyZvvHbZImZff9BQQNDVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IV55bbG+FA9JqAbWYct6VJyLVq4bI051gcfySqoGLVEqEozm5bnUhZ88qLOpz57qQzdWGqxTI4rvKPKCvXfH49ZQQu1PDRk/+H27WQpYLNmE6F84hers3sB11HnVkE8hRoU1EhzBHmRE2ZMw8Rue335sUkB//7eAMAOH60HyODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pWu4A/zy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+lShx2jD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pWu4A/zy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+lShx2jD"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749548641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glurE0/hd74oU4W/AWaUvJwUtxXlM2bW+XyyAuaNRDE=;
	b=pWu4A/zyIeK4ASx0tnREty8pVwm/VJ/oOt2c+87E88KO4/h6KUZSYMTsRxh2nk2DO9E4p4
	AhcRA503GrWcLmdQa6v9CJmd4S671XXrIRfXr1R2z+yp0x1DMOwiCxJIQRrOi8WaEo8gYV
	gMu8xA3eCONSEErdgbIOTHgYB0uPTvQGxld6uDA19fdmDyYzZz/HWg6vkbOPhoW3j25QF8
	+FZBck3ccScUFI55v3H+qsfsGbdpqioLKMmU5WFW3wzIWaaZbGamDCGV+ARTP8v/sEhbM5
	X6GWp+r1LxyQIKNuDZE4lEGWd7Fr+z453nmu8QM4Pg6X8sNwTehnL0cdCp+nug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749548641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glurE0/hd74oU4W/AWaUvJwUtxXlM2bW+XyyAuaNRDE=;
	b=+lShx2jDg+52Us2LCOR4/ILBc1ywjSBGgIGbKFPCTGQqEOaze9xFybsLI6UlxZQYjsII+u
	5bQvc3tmecqHsbAA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v10 03/19] panic: Add vpanic()
Date: Tue, 10 Jun 2025 11:43:28 +0200
Message-Id: <52b5c4f9a9aede8ba0543c335e91b7e6ea2293b6.1749547399.git.namcao@linutronix.de>
In-Reply-To: <cover.1749547399.git.namcao@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

vpanic() is useful for implementing runtime verification reactors. Add it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/panic.h |  3 +++
 kernel/panic.c        | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 4adc657669354..0332c6d6771fb 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -3,6 +3,7 @@
 #define _LINUX_PANIC_H
=20
 #include <linux/compiler_attributes.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
=20
 struct pt_regs;
@@ -10,6 +11,8 @@ struct pt_regs;
 extern long (*panic_blink)(int state);
 __printf(1, 2)
 void panic(const char *fmt, ...) __noreturn __cold;
+__printf(1, 0)
+void vpanic(const char *fmt, va_list args) __noreturn __cold;
 void nmi_panic(struct pt_regs *regs, const char *msg);
 void check_panic_on_warn(const char *origin);
 extern void oops_enter(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index b0b9a8bf4560d..6a1823c383d01 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -309,13 +309,13 @@ static void panic_other_cpus_shutdown(bool crash_kexe=
c)
 /**
  * panic - halt the system
  * @fmt: The text string to print
+ * @args: Arguments for the format string
  *
  * Display a message, then perform cleanups. This function never returns.
  */
-void panic(const char *fmt, ...)
+void vpanic(const char *fmt, va_list args)
 {
 	static char buf[1024];
-	va_list args;
 	long i, i_next =3D 0, len;
 	int state =3D 0;
 	int old_cpu, this_cpu;
@@ -366,9 +366,7 @@ void panic(const char *fmt, ...)
=20
 	console_verbose();
 	bust_spinlocks(1);
-	va_start(args, fmt);
 	len =3D vscnprintf(buf, sizeof(buf), fmt, args);
-	va_end(args);
=20
 	if (len && buf[len - 1] =3D=3D '\n')
 		buf[len - 1] =3D '\0';
@@ -505,7 +503,17 @@ void panic(const char *fmt, ...)
 		mdelay(PANIC_TIMER_STEP);
 	}
 }
+EXPORT_SYMBOL(vpanic);
=20
+/* Identical to vpanic(), except it takes variadic arguments instead of va=
_list */
+void panic(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vpanic(fmt, args);
+	va_end(args);
+}
 EXPORT_SYMBOL(panic);
=20
 #define TAINT_FLAG(taint, _c_true, _c_false, _module)			\
--=20
2.39.5

