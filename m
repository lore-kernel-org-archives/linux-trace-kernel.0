Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF1E21D59F;
	Wed,  9 Jul 2025 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083799; cv=none; b=Mail+1FOSZgb4pKglO9CyrvQPIahuw7jVXQusnLMUqUEzbWQUGU+6VCOQSPyi5LOgisw6LheHepnrgxY0cfh8Xs9/T5TensH9+0/7K9H0BjTyrZIJeMLtT84sSie3Ufd2GNV3rw0IvO1YgQyH38FnXK0J628ufd/nACAKe3KsE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083799; c=relaxed/simple;
	bh=QWxElFUqvaiUxOcx8gFngfNqEFXQwmTIXZmWyx1XZzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mJoiZiEf/JWfLDt8MoMqzUJGsG5pihokCYpS5BLRpghHqGcqdRYJGB1mPq4uWkpOQ4GycfxyGWJ+6yeDxTJcCfItkhBpQ2td7cgomHmCbIkFXDbA19qP9hbT4imA04mQWseHDh5/eF8HgZZPoKBvpmjmN2h/294GwuACqVT6XeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pGlY44Gz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YJ0kS8Rv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pGlY44Gz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YJ0kS8Rv"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752083796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SddVrFpznkZRTwpkimcsnAdj6oDOaNHRnPzIc8jST0k=;
	b=pGlY44Gzg+Szlhv8s1FWnBJbaP3L5iXFkk34g07P88bdTxas5+e7r/g2+sicD09zT8FsyW
	DLY8X76bNzbS6xPT6RbdZo1/baj2+X6OTQL9tXJc0Clrux3kZVTGzpemsZpzs9Ac2yN+Yp
	6hxVa421Lgvq6I1q2pZNmZJDTOSJIYCnzsFZpamywAqGA+zaizOeiZnt2G71yt8Q69dcXD
	q3em/hgM1f6HpWnqKEV7+6c4EXAfJe2O5BvjmYv/M6+KcPPFXsEc76aWNCMVQ1qlT+9jO2
	UEV31ajftIhuHr5v49yTxoQv9VK6qxLffXa0uhzYOqZqJhPRhs3tESO+4rIHsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752083796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SddVrFpznkZRTwpkimcsnAdj6oDOaNHRnPzIc8jST0k=;
	b=YJ0kS8RvWFF22cb2VP8KSLGeDHFDA4nvHahels8YLjJajMrqK2lC0XiTDMqx2yINW+qMWX
	+53+IWRa+g+/zpAA==
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
Subject: [PATCH v12 02/12] printk: Make vprintk_deferred() public
Date: Wed,  9 Jul 2025 19:56:19 +0200
Message-Id: <25d52fcad6d1ce8f8ac262199d3e8474e029961f.1752082806.git.namcao@linutronix.de>
In-Reply-To: <cover.1752082806.git.namcao@linutronix.de>
References: <cover.1752082806.git.namcao@linutronix.de>
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
v12:
  Add "static inline" to fix build issue when CONFIG_PRINTK=3Dn
---
 include/linux/printk.h   | 5 +++++
 kernel/printk/internal.h | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 5b462029d03c..d886ec98fbbd 100644
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
+static inline __printf(1, 0) int vprintk_deferred(const char *fmt, va_list=
 args)
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

