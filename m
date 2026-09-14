Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D082547FB1A;
	Mon, 14 Sep 2026 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396257; cv=none; b=pvI5KTZZqreeHSkBgl2V39OuUB2BKnar1tHCKnFlo8dw4JKpYdcAu47kKMzetBGr0O4/ZmB6rHbEgxpFY0Qn0YmvGuroyqiUpkfH3Bqf8RsDPB9SEMptyztzNGf6PmsH3FfEjbm3sfIwYHq7teJt+KUMLzrxKm32ZJQBW8ncUxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396257; c=relaxed/simple;
	bh=URX8vYc8KtPY8CChyuSazeO6itWMsbkI6i5GQUyhLlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eu4wlxFmZ4GyWPLr4RQR48YcJnjnivNN3Ghn1RvnjrzxAvgDKb0gIGTD1FV/eY/0a4E9qJfvuxZ0plr6RQ267zwfoezJ2MVPZyfC8TB894dmq0mhYz69z1pwz/VkjS94N7ufKL9DfHl0tIwPDOqtuovbG5F6A7M9jQy540MjFNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lEIozhEn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lEIozhEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15A51F00893;
	Mon, 14 Sep 2026 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789396255;
	bh=IQgf6xMSaKfx++A8iUCfAMe8Zs9EXdbYSGldWIGIUGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lEIozhEn/QZnplosVw+ZvN+WZ3c5S/m8rh9c6aR5hzDauEgIR/q7zWqxHPORZD7vL
	 zuuwwNAsuwoCgQB3XwbAE6hgq43u70s/nVOXQBS4a1zlAuFT7CGhR9E01Ai7Rpb2Y1
	 JCpMiDCaBGstJL+HY0XB7QDgdsmDMWTzC/pnYCBo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 14 Sep 2026 16:30:31 +0200
Subject: [PATCH v4 1/3] module: pull out add_taint_module() to be public
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-bind_taint-v4-1-eadf8a090903@linuxfoundation.org>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
In-Reply-To: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Bradley Morgan <brads@mainlining.org>, 
 Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-usb@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2729;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=URX8vYc8KtPY8CChyuSazeO6itWMsbkI6i5GQUyhLlw=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkrWIVueJQWlUx/HlzCmfiVv1jWoT2PP/jHs7hF2szfx
 ddfitraEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABNZ1cEwP39dt63PVufqgqa9
 HRc1o0+UNhzsY5jv8HY6K4OWtqDntusvf7eozqh6U7MHAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

Other kernel code might want to call add_taint_module() so pull it out
and make it global.  If modules are not enabled, this defaults to a call
to add_taint(), so all is fine.

Reviewed-by: Johan Hovold <johan@kernel.org>
Tested-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/module.h | 10 ++++++++++
 kernel/module/main.c   | 16 +++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..f6f90cd88f15 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -29,6 +29,7 @@
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
 #include <linux/dynamic_debug.h>
+#include <linux/panic.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -770,6 +771,9 @@ static inline bool is_livepatch_module(struct module *mod)
 
 void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
 
+void add_taint_module(struct module *mod, unsigned flag,
+		      enum lockdep_ok lockdep_ok);
+
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
@@ -877,6 +881,12 @@ static inline bool module_is_coming(struct module *mod)
 static inline void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
 {
 }
+
+static inline void add_taint_module(struct module *mod, unsigned flag,
+				    enum lockdep_ok lockdep_ok)
+{
+	add_taint(flag, lockdep_ok);
+}
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0bd2ad0..444d990c9983 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -191,11 +191,21 @@ static inline int strong_try_module_get(struct module *mod)
 		return -ENOENT;
 }
 
-static inline void add_taint_module(struct module *mod, unsigned flag,
-				    enum lockdep_ok lockdep_ok)
+/**
+ * add_taint_module: add a taint flag if not already set for a specific module
+ * @mod: pointer to the module that caused the problem
+ * @flag: one of the TAINT_* constants.
+ * @lockdep_ok: whether lock debugging is still OK.
+ *
+ * If something bad has gone wrong, you'll want @lockdebug_ok = false, but for
+ * some noteworthy-but-not-corrupting cases, it can be set to true.
+ */
+void add_taint_module(struct module *mod, unsigned flag,
+		      enum lockdep_ok lockdep_ok)
 {
 	add_taint(flag, lockdep_ok);
-	set_bit(flag, &mod->taints);
+	if (mod)
+		set_bit(flag, &mod->taints);
 }
 
 /*

-- 
2.55.0

