Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE16221DB7;
	Wed, 16 Apr 2025 06:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786318; cv=none; b=PU/ZpOtIZktawSKge/6bs27+Nvyvxq+pDyxnadPu97iPBtH0oihhbYlM/mADXtt83sK7GIzEk7hfm8M6bhSBncaaPoFbLQWsfLnKnqJcdCb+YdVOyQazsjJJYon+B/pl9KFHYnh2B9SMXjmoqS1M/DPnEISJzgHS9+dbJ66K5eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786318; c=relaxed/simple;
	bh=XLIwTZUPwuaMfKzDKP66sLEghroVG+ojtKHrNXY4pD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YlmGZcnns4g4YzMl47s9ISNtM5mVYRmTBNUZWtarh14s0zwG4CvKFVquH+0dI9ad0wQZzB02e6GR5x97wjw4RetpDW6dFI4CUBOEgmD96OiVhq5CeHY7XmLGs24AaxSqwG5AiJK8kQYlz7RE3C0JNk60upe6HL8i6x6gjpVYp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U36suWn1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wh+vOddL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U36suWn1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wh+vOddL"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744786315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLbwQQqpQiGUQcMTHG6q9ADA6juJe7ifpWtTjSR5QDs=;
	b=U36suWn1MdSHCJiZs8SEHN7L6/A78gUzzKM1YLUbHbF7OdjT4OqcXnh35mvu+/WmIzjyPQ
	2U3CHYbtHeeva9ruKXBDp360+PC30IyFDMBFj+097p50DyejbtL+52zAhf5XBxoJCnZNug
	FcuxnHD1GyvMFUVW3xFl9SRmlGzWAYFKdrYCT7k9JHqiuaIfl34JLdYgsHWEHjZEmyzdH+
	rouaCWhbE8QR1px9hYEvEjQ//Ys9CE5Z7jqiEwwGDFuOuvxOJCJA5DnutVnUPxQqeVyOyc
	MTHey9k8S9ZyFTLuoo1+pQZmNrghbaIFeiepfjN/gcSBAHQYE9WqjybXC3sM1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744786315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLbwQQqpQiGUQcMTHG6q9ADA6juJe7ifpWtTjSR5QDs=;
	b=wh+vOddLuoPf5OJr5hgoPM14aPSdI2XMgD5AXGWATzrM9PLmdol86Ckg6RTf+Dc78u3KFs
	vDlg7sl/YD+nzrBg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 02/22] printk: Make vprintk_deferred() public
Date: Wed, 16 Apr 2025 08:51:08 +0200
Message-Id: <a4178c6ad401f38f5b16ef7c733d15ea84fb9fd0.1744785335.git.namcao@linutronix.de>
In-Reply-To: <cover.1744785335.git.namcao@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
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

