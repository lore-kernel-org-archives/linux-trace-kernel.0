Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAC2267385;
	Wed, 23 Apr 2025 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391042; cv=none; b=dfBwLBKNkj9uQd3Vnjr6EYbIxpSRbBSP6DfRCYQVZqnaDiKvaDviyLxs9smQwJ9rDVX/xXtO6TxZG/FIVbP/mq14X/Lbmf8p7Pg1I0OjUU+p9clGNuehQCdcbhYWahLWQyVPPtCoq1iiXDMfFHEBtsqO0qFgwGVkaiqcJM5A9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391042; c=relaxed/simple;
	bh=XLIwTZUPwuaMfKzDKP66sLEghroVG+ojtKHrNXY4pD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XF4+bIpECf5I/lTMIptlKVABP6FwM9r6fLC9vIAPFlIuMDsap5aHpbPBeIujuQg+cBL9A1VVyYpXEFmmHjOiSJN1CKdvdGtWkToZuSfzCf39De0xhVJe5JnIh9coCLr7RigyeUPnwdDxmZWk+lSSkWCdj38uFoZMN+gsn77SUgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=40WVmQL6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6MXxcRmN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="40WVmQL6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6MXxcRmN"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745391032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLbwQQqpQiGUQcMTHG6q9ADA6juJe7ifpWtTjSR5QDs=;
	b=40WVmQL6xnVM0wcVyHLcSNje2W6yh++0nh/JJzO/0HIb4cMyCGBwgStVX842BmbrC2u37/
	YJVD0B307ANPDB7fhGqMlLiZw6rBnZzi2HCaLkMQpA+VLALru1+lf7Y334WLYB0lVFza6l
	ScnmnR5jrM71SmFsQFFz/ZZJzUWyqeTIQGBynGCEoeA6xq8jTKzhmrmhPy2JAdXNNolp8l
	f0uCcZ1JoI2vJPrEwzfVJSd3Yxf3qFNuCkkEa3uGEUGy8Kwtg1p++u3eGZu5BU+AhZGbq/
	X/zSG7Kcrr7Ldyw3PQiBCjitabqRlW/1y+MA7W6H8q6ui+SwhdJESDtfgf+saQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745391032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLbwQQqpQiGUQcMTHG6q9ADA6juJe7ifpWtTjSR5QDs=;
	b=6MXxcRmNOW5sQ2aEy72O1B9rAgoxQLazjFoES0xkH1xy3aBRnZfA1XtHZW4tZOcs0kmsPD
	NTx/E+T/eDLODLDw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v4 02/22] printk: Make vprintk_deferred() public
Date: Wed, 23 Apr 2025 08:49:57 +0200
Message-Id: <63f538ac0cef81e9019f23f041e9a1b26a03f30e.1745390829.git.namcao@linutronix.de>
In-Reply-To: <cover.1745390829.git.namcao@linutronix.de>
References: <cover.1745390829.git.namcao@linutronix.de>
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

