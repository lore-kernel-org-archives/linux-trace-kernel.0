Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F823FC66;
	Wed,  9 Jul 2025 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088906; cv=none; b=PJ86eo6WEUohf8p8j6m99mKbz3bA3PYQnwcej9otycDHAs+Fp5BFlJcgJ+he+RGqyLMNL3PAcRZ6CwSWYjziUKUXwQoHVTt/aA4yKmF1zsmkCAU/x6LkwDmPywvqIrIA095OWsfHJLJybSIJo7qp2VoY4pmY0naNSQDRt0BYafk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088906; c=relaxed/simple;
	bh=uUCFxmo45gH4FNKoJkFKyvfUrVp0TDpC9KtK9KK+nbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/3NFZLTkbbJkAebcLS4qD8s/BsPObr6Q+3onxCPl1DxKzrwlY/UNoykmJm1fB7lYAUQVf21BUI0bpEYk/scJ9ySgA6uCgGol04PmpM3jPjVeZ5nosVIqfqrLeLNj9GdIUL6C/4MHALlaWFG7f2Y+VTFnuuI9hcRm6RjLi2SR2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KkafzTSe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DKX/Ih0l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KkafzTSe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DKX/Ih0l"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752088902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cz7kLMF6V+pL7G20nftlZK+3bi9npXI9tcPWSQmYOx4=;
	b=KkafzTSeatKZVOSg4UCMmksRfod0BCo8vmKjqYJAcVX9bvjSH6MxHI1JsB5KXlczHTCGfW
	U7EbfclaH8fjhNXLA76EEp4pQjcKCbU8r7WxpTcQuD9tR9W8sYZO+TettXd2mGCn/Dz5qy
	fw4pq+ycWIinM8htp20gKVuAH98tbkyZYO9m69BBa5vCpn5igyE1WXMbo0Qk+MUaJo2WC2
	cjkTDMAqGf5zAH93xPbl7Rz8QlnwFQJ6UxYjIpfk0jEdn3SjqP3QeYL4V/j/SV9dqLvzmy
	yA7ZZ3iRSXwAtB1FvdFyXXnGeaLILFSzxz7H680RlkywBQinYX7diGquKaCdow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752088902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cz7kLMF6V+pL7G20nftlZK+3bi9npXI9tcPWSQmYOx4=;
	b=DKX/Ih0l9mfXAa8HRwt5rcHmyOK79b6swFUe5U+k34vIv8QqShjRIZS64pZdZBswAmvYJK
	KfTfevAiBa4QF1Dw==
To: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v13 02/12] printk: Make vprintk_deferred() public
Date: Wed,  9 Jul 2025 21:21:13 +0200
Message-Id: <66086aa267f2f3b431ff46dba1e7092030fcfe58.1752088709.git.namcao@linutronix.de>
In-Reply-To: <cover.1752088709.git.namcao@linutronix.de>
References: <cover.1752088709.git.namcao@linutronix.de>
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
v13: keep consistent format and put __printf(1, 0) in another line
---
 include/linux/printk.h   | 7 +++++++
 kernel/printk/internal.h | 1 -
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 5b462029d03c..5d22b803f51e 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -154,6 +154,8 @@ int vprintk_emit(int facility, int level,
=20
 asmlinkage __printf(1, 0)
 int vprintk(const char *fmt, va_list args);
+__printf(1, 0)
+int vprintk_deferred(const char *fmt, va_list args);
=20
 asmlinkage __printf(1, 2) __cold
 int _printk(const char *fmt, ...);
@@ -214,6 +216,11 @@ int vprintk(const char *s, va_list args)
 {
 	return 0;
 }
+static inline __printf(1, 0)
+int vprintk_deferred(const char *fmt, va_list args)
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

