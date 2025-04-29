Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265B211C;
	Tue, 29 Apr 2025 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928095; cv=none; b=rYE9vH+z76SO0aaplvdl5Bq4kUKAzrzdCKU1dU7/tdTU4QGQsnUf7+R3dGzbI4BNPMzDBeR64Kl/UrzyVV7VNbz5YVq1r8Bby80a1qeB4RrSPLJ+kGwLPXZDB1y11fmKMKG+TKkYlr639iaR9ZNsA3czaCMuDGZj4OcumrM8OqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928095; c=relaxed/simple;
	bh=XLIwTZUPwuaMfKzDKP66sLEghroVG+ojtKHrNXY4pD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q4VVyv4OCWwAGB+mX6E2veqr34SJOt982FlBlaUeuZZf9M0pvv4Tvhu5mnUu/v8zAOZq90L13fhffIAMl08l4EBgf6bER+f5I6zIM1K9ibADaOnctQ+RzOLX5c/qKK7JNSuX1oz4EJ7svqsITiUSK3LmwKy3fEFjQ0dymuLFSE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sx0IMs6A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n2ztEOGu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sx0IMs6A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n2ztEOGu"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745928086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLbwQQqpQiGUQcMTHG6q9ADA6juJe7ifpWtTjSR5QDs=;
	b=sx0IMs6A870Jb2Zz6Fy6gruLG6+Ji3YO+u2hYAnpTwTSPiTqu8aWtK/g6EabKi0nbgH/NH
	rZxbTS6JUE+KrEwx0+D9Q8JkvCLxuF2p9sh7Hr06JGQZK39Wa68nKJxxpyLy4HreAxMPGw
	FYH9CPwJruVnQI5xDNbFzFkd4Dn7mDP/8ahHDGeMB8+QZyHiArCoLX75GIF+6JWqUId5I5
	IU1mjfsiaHRzeDzMKf+YSWwD+lUUzaxEcGFAzQSMdw1qqIa1RBPNlDegmZ6Hs5sEj6Xmde
	QH7QJJTsk4dB7iOZwmHeH7CKufAz0xNpNz7kKIFnqfLQ6IGZ4wJH7DHo3BPVAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745928086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLbwQQqpQiGUQcMTHG6q9ADA6juJe7ifpWtTjSR5QDs=;
	b=n2ztEOGuOkB7xcXKrt+ciwLbPXotDmxKBWP43cpkHHBUKmSLz3cCbJLOv90+Go7m7NHPxr
	lfy/tBrAkkye+oBg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 02/23] printk: Make vprintk_deferred() public
Date: Tue, 29 Apr 2025 14:00:47 +0200
Message-Id: <42ce595f371c03598bbbdc5a7e0d9b1dd9275b33.1745926331.git.namcao@linutronix.de>
In-Reply-To: <cover.1745926331.git.namcao@linutronix.de>
References: <cover.1745926331.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

vprintk_deferred() is useful for implementing runtime verification
reactors. Make it public.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/printk.h   | 5 +++++
 kernel/printk/internal.h | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 4217a9f412b2..1b7eebe13f14 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -154,6 +154,7 @@ int vprintk_emit(int facility, int level,
=20
 asmlinkage __printf(1, 0)
 int vprintk(const char *fmt, va_list args);
+__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
=20
 asmlinkage __printf(1, 2) __cold
 int _printk(const char *fmt, ...);
@@ -213,6 +214,10 @@ int vprintk(const char *s, va_list args)
 {
 	return 0;
 }
+__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args)
+{
+	return 0;
+}
 static inline __printf(1, 2) __cold
 int _printk(const char *s, ...)
 {
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index a91bdf802967..28afdeb58412 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -71,7 +71,6 @@ int vprintk_store(int facility, int level,
 		  const char *fmt, va_list args);
=20
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
-__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
=20
 void __printk_safe_enter(void);
 void __printk_safe_exit(void);
--=20
2.39.5

