Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555E02FA635;
	Fri,  4 Jul 2025 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635233; cv=none; b=sZm/4H3SN0hLeGpniYf0bOoBAh3SyxZVlOeNVghJTkvIfv3Xyf0M2LgxwrfPEjx/d2MMzCwS9BfK9tc/jP9n1Z2bTQ2XMF7EoGj9O4B2mnAicwFdJRl0HtQBRSpPk8yNBNq3Cr8qet6wVibnT60F6vc3GimcduNRDCwHhMeFHos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635233; c=relaxed/simple;
	bh=LurusvvHwNK7NPOvQtdp7+qI68/QKgI/S7v9tnjBiFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MlqJwoeq+BScTPfghDTJzVygoX4VaaUYwz3vyu4z4cRkV4GrCIRKkWqkUJnn7ym4kJGLa+wLlOSeCRbRlZWuru45cLbVoIok1N/NrjYercH3ySts5IHMIL2cz8Kr6mLP/AvqzWbd6rLm/22HNhSosoYoLWpv7jCjlQ/AuF1mg9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sv79dZEZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KPIun16L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sv79dZEZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KPIun16L"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inKkGcOaoWCjFkpqnB1GAtsANxmMpso8C0jLuD9eLHQ=;
	b=sv79dZEZJx7oTKuEV7UnJuWKWUsGC2h4y1431LkMSfHF1ObDjfKLPRh5gO+9oODhVA1VSR
	GRg5NfqVHCmGJicj84bQBYPZOFuq+H13rORZNdFLin/QWnr4E4hc3MEo71wN8bKg3EN/wf
	eCWswT4JbgsT7YnS8E/bm+I72GLVIVadFFP37g/YqkNwWa8C1Sw3B2BoMnvS07Ug8MXScC
	VkrZyotaH+O522xz8NJ+tx+vEBX0pgP+B0ikG1gdioL06ZzieaX95dY0xKV2xaHXocrBoi
	T4qQl+XzrEbiSVJ3NXl+SkmYgVOImZsOTtrJd3oAGhQG0kv7XcW7BEJfyF6tHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inKkGcOaoWCjFkpqnB1GAtsANxmMpso8C0jLuD9eLHQ=;
	b=KPIun16LYgfLYdvcAU/XDhet+CUwdS9m1g0vCKhMwpThCqscQRjAqDpzbhewg3VGF7VLyO
	VGRvao2T48qlSrCg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v11 02/21] printk: Make vprintk_deferred() public
Date: Fri,  4 Jul 2025 15:19:54 +0200
Message-Id: <6e110a17d50d7d6954e17f3194f555d18fe521af.1751634289.git.namcao@linutronix.de>
In-Reply-To: <cover.1751634289.git.namcao@linutronix.de>
References: <cover.1751634289.git.namcao@linutronix.de>
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

