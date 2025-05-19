Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDABAFBF6;
	Mon, 19 May 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650478; cv=none; b=f0buEjGUuzKrj4Uo6qwDkP6XQyslEoPc3DaUrD/hKJgESsSHUbw6Afz13s/SD5g+DOO6nimCcgqLSgMWcgm0+tFOFCTJoo9+IehYXCf5rrEgm6Wn0TJ3zVpx48m9KM4BgorEOCs9BR/hBtfr61Q4g21TBVCcMv7XfO+E5y9TdMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650478; c=relaxed/simple;
	bh=LurusvvHwNK7NPOvQtdp7+qI68/QKgI/S7v9tnjBiFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DodxNh8Y16AHRpGZPIPmGHBbVvMlficwraJCW2Zv2L7isJ6bm30RKCvgkiQ6K7XAx8cy8pG/y8VhqDiIUZR/7vd6HN7qOBu310G1MN/TredrDUA6TEor8odqExWPowP6bjmJtD6pSwqKHbrDRQMsKtQ+i6Evye8acH88abZUbQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b0B9102j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wrioFdcs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b0B9102j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wrioFdcs"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747650475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inKkGcOaoWCjFkpqnB1GAtsANxmMpso8C0jLuD9eLHQ=;
	b=b0B9102jlO3YUcFDSID5NiTwv53GI6TOtvwFhiEcIHitDnetWlO1DA2I14UEYwj6w+Ti4X
	IwOEqoMeolDdeAoZQ9olnRiRIL1loIF5oDaYSyxPYkVeQOiJmw2gai8xf6uPrrlx40NzWL
	vAtALaka8s9kiH+BMY1g4ycA8rzJChmXmOBDutsNruluB2dchqxOPX9+OmdjImKnEwjTU3
	h0JUhCU4ZgwIe7BbaxyFnMX1LDYOtpqOGXcH4HAsmHV2gw7WeWPHwFqA+9FZTkNX0jsCJo
	tmnWgeN3osJXIorlQ1yGI7wJp5uVT/93fuRensC8kMQmIJ3Hvx4ZVgJd4FNWNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747650475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inKkGcOaoWCjFkpqnB1GAtsANxmMpso8C0jLuD9eLHQ=;
	b=wrioFdcspYxEvx0ImJAxo7TomE0YIA+VKqaYS21/qZbLuiEyU+Us7XKl2hNGiYwH8bYb0q
	b8tB5rxVxkS6g8Ag==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v9 02/22] printk: Make vprintk_deferred() public
Date: Mon, 19 May 2025 12:27:20 +0200
Message-Id: <31f51f866753f0078b4e9fb7d9612ac79d836a23.1747649899.git.namcao@linutronix.de>
In-Reply-To: <cover.1747649899.git.namcao@linutronix.de>
References: <cover.1747649899.git.namcao@linutronix.de>
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
index 5b462029d03c..08f1775c60fd 100644
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
index 48a24e7b309d..bbed41ad29cf 100644
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

