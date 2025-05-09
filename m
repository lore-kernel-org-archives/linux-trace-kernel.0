Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D7D269B11;
	Fri,  9 May 2025 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778363; cv=none; b=PnqfLMHkDK3hhnnuwMYqcdBZsA0nWEB91EDXPB6jv4tJgI5hNeJqU6iK9dHCtYGWt+x5JaAg7i54//LIF8vcdTfkFvSU7sTSi8/pY9NcDL9wAvzQWItSlsPSBCutyeP/Uq57Qq07jhW5/bFdN1W7jMBsOoM3tRqMflRvN42+6xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778363; c=relaxed/simple;
	bh=LurusvvHwNK7NPOvQtdp7+qI68/QKgI/S7v9tnjBiFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AA+d5KGUAGWcbb+8cOsLyVt93X8rla6X4eN1k9TcCLyLguJS34ZBJqIi2Dgel4oqBmOHAwBt/SMrvv28deITuJ4uaAyhfoFXVROvWXsofD5jkvPFGyhlaxA7KJwrKQzF4g+Wnwb8fUX/DCU7zYsUDzHQpl/NbErZBEKRke5rlH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZDxQZsx5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yn3CZHWD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZDxQZsx5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yn3CZHWD"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746778360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inKkGcOaoWCjFkpqnB1GAtsANxmMpso8C0jLuD9eLHQ=;
	b=ZDxQZsx5fcPnts8NMl/gWkbeFbUGOInNlROfqRhkld4/al3DbdxbsCetoZRxd1a9M56gZu
	Zm8+Z0BjCkjQ7nUsDLJ1Dx45jkI2TZL5YyH4VcOhgydEgl/xF0EEVSI7vdQA2A+s7qxfrP
	upj6UqCJiBW61t8xlXmfH3aPLRypqHth8SogfOJtajpKeBEveyiwltHKUTKDGqbWkMuc2H
	57AmONzrSDx4TWB0ggCSJya4BUXSPBYmhQxwvvVe+ovcqXohja8tmwHA/6jVgqfPirpxRg
	zhNp5RLd6xRLwta15jR3gvHyd7lnBdWN5iPgZzbzYpPX6fgQeRUiebjB2kMwPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746778360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inKkGcOaoWCjFkpqnB1GAtsANxmMpso8C0jLuD9eLHQ=;
	b=yn3CZHWDgi5H7Ez9+zJbfwVQcPmXbVUMKCYwutc5Lt5O8YviZTJz2vSGaLcnmAkHPUdQPo
	SMdr/UVn/5JewgBQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v7 02/22] printk: Make vprintk_deferred() public
Date: Fri,  9 May 2025 10:12:01 +0200
Message-Id: <5fe659568530242b55bc5fb8e2c8be1d69d6b0aa.1746776116.git.namcao@linutronix.de>
In-Reply-To: <cover.1746776116.git.namcao@linutronix.de>
References: <cover.1746776116.git.namcao@linutronix.de>
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

