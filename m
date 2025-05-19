Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5958B26B2DD;
	Mon, 19 May 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650478; cv=none; b=EQ9Rls7XV3Oif1MfICGaXezwRoFaBz1YWUwIwIs6963ELAtJBT3rN4ZT2a6vYRh7KQVtivf5hyiSFE4gOAwf/DNMuLh9QTbIG5wUEQ+PxmurzUvJkNNjxIIePkjnDPU8axhsj2M1dR3CM+7rrAZz0TrCkCVdlx3UxZRcuMoKi7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650478; c=relaxed/simple;
	bh=qJDv1BXN5yWZ5K4l43v0Q0Y/hBlA52rY2AeOAgH0sp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BkFw0A0LAAHtUNHceHYjgXBM4s3xOGWY8PNSzF6CjeOASOAoxk78J8+kTL7qLv1wS9BxafRsqwm+esKx+cb06+WlrH6RxiQbWuk9X8vaRo/+mowBft0ZyYDQjc30UizYKR50vNFoTXymBMBtIJWo8fRM4w6gD31OH06JoE1+NN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gGe0iye/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O70+IAR4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gGe0iye/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O70+IAR4"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747650475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6cG4CYhJME6IWrbowQEwUqJrs4mnBUYPJ+5/yQExiE=;
	b=gGe0iye/U9sYWsGpHRtfdK/C1/NHaxuIK2P7EpLTBk1oYQLcegX8MVXztuEoPKuJoKo3Ow
	bkJ38Yh73xXxkpDRm/kHCUcabvGhE/tUZQonGAhCzArb24DaESyfVTQV+qhSxUpvkPHwnK
	P4mOUeXVkjViay0HuaV0l6igZGJ84TUivoYFxBYLYHm3v2JTqa4qCbDK6bFrhEfdJtKPF0
	v8AHZMov+zpYgol0pt6SnyAMkeDhUkCZJjxbD4hQITdScSlgiF7YrsPRGxFabeEM/qFkQt
	d4bGresOLRB85lV/Z7VjwwLa3MP8xFX0PSQMz4PgmcbvDv4Dwd0DfO/pmE3GQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747650475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6cG4CYhJME6IWrbowQEwUqJrs4mnBUYPJ+5/yQExiE=;
	b=O70+IAR4cUUN1HtDH2Mztvp1ZH5EvxCYTOngCaQhrd5dDW5oKHVUSMmZfYJadIbIdPMTlc
	98aE3zxQOaEYlEDg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v9 03/22] panic: Add vpanic()
Date: Mon, 19 May 2025 12:27:21 +0200
Message-Id: <9c150ab4d847f6ed9c2cdf17c78f8075a4cc32f9.1747649899.git.namcao@linutronix.de>
In-Reply-To: <cover.1747649899.git.namcao@linutronix.de>
References: <cover.1747649899.git.namcao@linutronix.de>
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
 kernel/panic.c        | 18 +++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 2494d51707ef..bcca63a02aef 100644
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
index a3889f38153d..278eae74bf17 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -277,17 +277,17 @@ static void panic_other_cpus_shutdown(bool crash_kexe=
c)
 }
=20
 /**
- *	panic - halt the system
+ *	vpanic - halt the system
  *	@fmt: The text string to print
+ *	@args: Arguments for the format string
  *
  *	Display a message, then perform cleanups.
  *
  *	This function never returns.
  */
-void panic(const char *fmt, ...)
+void vpanic(const char *fmt, va_list args)
 {
 	static char buf[1024];
-	va_list args;
 	long i, i_next =3D 0, len;
 	int state =3D 0;
 	int old_cpu, this_cpu;
@@ -338,9 +338,7 @@ void panic(const char *fmt, ...)
=20
 	console_verbose();
 	bust_spinlocks(1);
-	va_start(args, fmt);
 	len =3D vscnprintf(buf, sizeof(buf), fmt, args);
-	va_end(args);
=20
 	if (len && buf[len - 1] =3D=3D '\n')
 		buf[len - 1] =3D '\0';
@@ -477,7 +475,17 @@ void panic(const char *fmt, ...)
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

