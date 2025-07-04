Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64982F85DA;
	Fri,  4 Jul 2025 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635234; cv=none; b=PiT8AlPH0Xu4yhgNhpFubney8ptrzdUoNK0J9l/s/dNLCI52f0OagsCnDcn1XTN06Gpt8MeF0QT9KRkIhMWoJc+362/n8u/NfsKDnXoiufpPJs+St4AcBypoypcnMUH1qeUxWuiOc2WZnOTUf+16k6V+ENMXiR6jIuRDtzRECzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635234; c=relaxed/simple;
	bh=2IXfDh1oS1h6wWEMQZiEwy1hIKMEajle4bNe7OQluPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bta7PWw2XGodDo+JvszjETjAc4nASkZxOjLktFzB0TcEGYXZNqCtPS6kmBOMMMTYfpEqk1fksrh4lWuPWttHhN+VzAUCfwQf+BBPQrYhv0s0wgqRJdP72LxqwXXgZ3sBvkR0WTlSEUo0+h6PMS195/qeSir2yKIGaNpnx1PTnCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zBHSAIMT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=69Qs/5MK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zBHSAIMT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="69Qs/5MK"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWqBXMYBmwEqdQKIVhrED21UDRTdi5qDQ7ZTDhJVn3E=;
	b=zBHSAIMTNYhJIRUIaP0y0Ygqe86ekgDt5DglgIKLsbRJh5MX4l5u+3BmhhDRZMDOj6z+9j
	1ZcAVTIMxfdmLuhVxSNHOCO18U2ZWsARLCdT7yeerMHOtKN5xjgDVhWPxx3+f7lblPodBL
	oyOVKiyxsJdes5GFd9je87w/vy0JHvenKmkUxY5TQ7KPBJOdaGwiGvTLAfK+Nd/Df2lW1p
	9hpzX2jmBh4sAHr6Olo1fw54W+05osxixP1HRWtGO1UNTsiLT1/8BaiUCtsoI6MxZWEEb/
	KLcUuBWH9tf448Gg18dIq+9g6++/98VeRqwDp7naPVcFRHjAn/ROY26vfVLPGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWqBXMYBmwEqdQKIVhrED21UDRTdi5qDQ7ZTDhJVn3E=;
	b=69Qs/5MKLbVXsXzNVwAwHDNXrI8jRMQfgOH0faQiQ8S8hzqsC7goUshffC+Mi/HLb26Eq1
	ozM9UHWPD7wgq6Dw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v11 03/21] panic: Add vpanic()
Date: Fri,  4 Jul 2025 15:19:55 +0200
Message-Id: <fe90972795cf5b7c9c05f0dacdcbda3f90a628d6.1751634289.git.namcao@linutronix.de>
In-Reply-To: <cover.1751634289.git.namcao@linutronix.de>
References: <cover.1751634289.git.namcao@linutronix.de>
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
index 4adc65766935..0332c6d6771f 100644
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
index b0b9a8bf4560..6a1823c383d0 100644
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

