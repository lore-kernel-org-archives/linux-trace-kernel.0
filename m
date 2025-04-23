Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB30267387;
	Wed, 23 Apr 2025 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391042; cv=none; b=U4WuNvNYVfEyyS0zvjqsVNMyuIK+hOlP0cXFhApnqk45fWB7mBQHHxKWasoQifLDoHl/dtHXvxYlF0TFA7/WxnvPCUzzf/POYkm8ZHvqEmv7aI7we1qdpi1OcD6bbuH9kz0Id3CQ7HTfAG+xtVXLfqA31oDfKDFMo2CJ7oXzF3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391042; c=relaxed/simple;
	bh=yE4+hvIpmyDO+d/5Facz2v3yIABL24Z4jtX31U2qtW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L/fN5xraPS6FCaj1Vm/dMT+Sc98xrjeRTZGKEbzVLENtllRjhQdHrFH5/+FUatWJ1XakbBqlQTcp9Ow1ZZJl7/3a8jcafDEQv97Xysg0SqMz4Zowr8O/zTAzHu1RGO4raWf1Y4HoPlM9gMAJD1VvqAqPwB5vWNrSUl6GKT1Cx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nppi7df9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tAmVQyQO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nppi7df9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tAmVQyQO"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745391032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFLrSzrjWHDz7RuayXpBZRe6H/UMM09LYKMjG3482lM=;
	b=Nppi7df9anCwBo0a8Br+8hHmwxrwVL3JFkE82K1Lb4kHxtoXLPLh75l/fH+do9zxZKf5ye
	4XelzoJottr3hgfCAobU/OGGkmaZMub5lVmpWjpOnvgECTpPuZQMB/MdsLGe7ayX3gcqYe
	YdgjKPrFLGqD/WZsTWe9htT70/WJPbzZDwI8zLcCmTMBwhweUT2Q1gKoAccwa9/vvCA9Yy
	us5NUWF/Yb2HiLaodVHWsRXO3ESzKoXHjyOYQEogAkg7bOczKiFB60LhjnhHgEzc8ON390
	8WPZcUkiZwcx4T+jxWq17HgTXNZFwhnFQ4VKB3S/DiBvad+rUL+BW2v40pycvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745391032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFLrSzrjWHDz7RuayXpBZRe6H/UMM09LYKMjG3482lM=;
	b=tAmVQyQOT95bmmb6Vp92QPT0KYmKoesPfxunW6s5ZwjPpMfK9yIPlhceGd71UNlf6kpyKS
	NaJOPXUIymgzywBg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v4 03/22] panic: Add vpanic()
Date: Wed, 23 Apr 2025 08:49:58 +0200
Message-Id: <48997b4e1fff2406135b38c922b287030ec63aa9.1745390829.git.namcao@linutronix.de>
In-Reply-To: <cover.1745390829.git.namcao@linutronix.de>
References: <cover.1745390829.git.namcao@linutronix.de>
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
 kernel/panic.c        | 17 ++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 54d90b6c5f47..3522f8c441f4 100644
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
index d8635d5cecb2..df799d784b61 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -277,17 +277,16 @@ static void panic_other_cpus_shutdown(bool crash_kexe=
c)
 }
=20
 /**
- *	panic - halt the system
+ *	vpanic - halt the system
  *	@fmt: The text string to print
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
@@ -338,9 +337,7 @@ void panic(const char *fmt, ...)
=20
 	console_verbose();
 	bust_spinlocks(1);
-	va_start(args, fmt);
 	len =3D vscnprintf(buf, sizeof(buf), fmt, args);
-	va_end(args);
=20
 	if (len && buf[len - 1] =3D=3D '\n')
 		buf[len - 1] =3D '\0';
@@ -477,7 +474,17 @@ void panic(const char *fmt, ...)
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

