Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591912C1094;
	Tue, 29 Apr 2025 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928095; cv=none; b=NMkIvVp4PK3vdaf9dPP64b9Uxfv05mpoj803u2flNkApV1HpPk02SkvdHVKlc6BHNq5XiwK2uCd5H/3LAswULuGwuVBubxu4owCkTDvOfd3xw1i02VvEZf5qRYSOHXQ+bZB9hCuWYK55IpWe0fMVFkj2bciMBIgXfquoaw9wVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928095; c=relaxed/simple;
	bh=yE4+hvIpmyDO+d/5Facz2v3yIABL24Z4jtX31U2qtW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jj9FIY69P0UVOdjwPv+E3XgIvugYa7XI/XLAvxWBT1yOudTdrzmldc00PetSP5sQAOA7eqmsHj0lIvzhPTSLo0B87KseIiGi95y9pzOgDYw6ZRveJsxRsvp7up59LUmpNZYm1FsMyCdoQi7RjcJzOoCdnSsC+0vC8zk1uxhOrdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0IguLx2U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rHnGyr4o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0IguLx2U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rHnGyr4o"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745928086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFLrSzrjWHDz7RuayXpBZRe6H/UMM09LYKMjG3482lM=;
	b=0IguLx2UAW5HRh+hl/DTWosFVc3VL3uulBqVBOwxHK7VI7uCdvUfcO9rxmehAj7Bu3NtsZ
	GjvNkvJnDCF/+K4DFVVu2SiMGrMT4v+Du+TagfTkjnOpelRI2BIRBVlTx5Zd69r5p78Rbu
	wr/7RYdskA7GEeDWViryjtAaSz1kP/q/nTvNIxuBP+3viBVYplRMtJIWPJZvZJ0+5djjdB
	EBqXJONpbeIaPZUcyp1rDKqbseun0Txr9Uzj1eXRAJseaxGrX2TpYv5QoWDYI8v6jkW80K
	mBo945+79S45hoO8/tdFgXMvp1pFbp0wN3U0FhOBEiPr+dYRaLV2HPkm/yxEbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745928086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFLrSzrjWHDz7RuayXpBZRe6H/UMM09LYKMjG3482lM=;
	b=rHnGyr4oqI/6+Eif0JsIS5tPSHJlUNyIJ7N3aghaaXtfRurB0dYQ0gDHqy3d65SUjGy1Ly
	3tJqw1O025d820Cg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 03/23] panic: Add vpanic()
Date: Tue, 29 Apr 2025 14:00:48 +0200
Message-Id: <390d7357d9b24362fde68d7c9f0fbd5ba740398c.1745926331.git.namcao@linutronix.de>
In-Reply-To: <cover.1745926331.git.namcao@linutronix.de>
References: <cover.1745926331.git.namcao@linutronix.de>
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

