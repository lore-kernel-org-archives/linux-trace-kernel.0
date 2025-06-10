Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E214128B40E;
	Tue, 10 Jun 2025 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548644; cv=none; b=kFPBqUsGZF5LDW6QoTDYna+OYxM6NqEwSZ3djdNmEQxs4zoD6Bj0UvSI4Jz2WccqJDe2aQ8OOW+l9mtm+Ds3xgohAfJ+RV6Od1lPnTYYfw1F9hxXEJCrf3TMvkPfwpWSbGgyXRmx11/pTKACDLiK2kBZ4F0oRV1Jhyi6DIxV7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548644; c=relaxed/simple;
	bh=supLrbBgqlfVHpJQd/VDCWQKW3971y9ZBq7t13FDApc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PqSDL7tlP2zpGjEX6+5h4PBNIma8JBsPm2zYr5IhCIEI12ofidBqMqJNK5uKPozhuCxZ4Nsrhz9Dl9l2rQ6XxPWb7dcuxQxvjjxM1qPM/N4DfosqHY5FrBacjsWBgLnF994akgejv2HilFO8tCZ6cQiRnOJv5+thLF67HAUs48g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZfIIlLlH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x4A3k5p1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZfIIlLlH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x4A3k5p1"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749548640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIHRTBDNh9oUt0At0xhfEVeekpNiiwFXoAlhXf/7+2Y=;
	b=ZfIIlLlHgbQzb60B7YoKc1advV7BgSPWjxwZdJRdRb7QZEhaEi5RnppRHG6LYsu2vRcSEC
	sG7IfIRitr3LPmaXgOp6M1GF6Mu5J+ZpjFaggRkzWIQ+V22MJbygreib5doq61ueEnXths
	P9Dpkchb5jhwHB8ExJmGKVfGLgoEO9P4iAW5klVb3bzc8gLueJlEYjbrF9E3a5I4xejadJ
	uSolEOAYBQr6H/UKH1kFUl4HaH9IeKjVs26ABLObsLm8HKqYV4l+Vp/VqrjFPhxPrTYkXo
	j6qCx3n/xUx9GuB47f33POHdHCuD28a8mBQZjvgQZoONk9x8Ewpyd+OjotaAZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749548640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIHRTBDNh9oUt0At0xhfEVeekpNiiwFXoAlhXf/7+2Y=;
	b=x4A3k5p18fAt0xGGIxHxq876vfWZqfrYvTiDGDrqUIG9fm/1yB66EGgahPOvMr1qc6sIol
	RNwj2f26Q5OqJOBw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v10 02/19] printk: Make vprintk_deferred() public
Date: Tue, 10 Jun 2025 11:43:27 +0200
Message-Id: <056a008c3ab04cb206bcf8dab27398d19a89c625.1749547399.git.namcao@linutronix.de>
In-Reply-To: <cover.1749547399.git.namcao@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
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
index 5b462029d03c1..08f1775c60fde 100644
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
@@ -214,6 +215,10 @@ int vprintk(const char *s, va_list args)
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
index 48a24e7b309db..bbed41ad29cf0 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -72,7 +72,6 @@ int vprintk_store(int facility, int level,
 		  const char *fmt, va_list args);
=20
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
-__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
=20
 void __printk_safe_enter(void);
 void __printk_safe_exit(void);
--=20
2.39.5

