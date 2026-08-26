Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2ED388394;
	Wed, 26 Aug 2026 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787739686; cv=none; b=fBPz1G31PZ+tY72BsIDuPeE2POGZfLmlW5NqSO+Nuzp1bjnsc5Zl0RqGafNIv6+cfQ/UKSsUS+PKeZxqRJv68N23We+c0i5XhcvhUR30F/Mr6jEdTJGUCpwWm5XcWD3X3RuM1mpJqz4XvMvJZYpEoeGzFyoDbEWsACswtlJaH6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787739686; c=relaxed/simple;
	bh=7SCdvxoK0Z6e0C/Fm77VqCSXp0EzbmaMQ5H91NjQjmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iXS9xZ1uFHRU560r927OaY8aoTrlUoXjmPvx94izG0bg39H1pCQb+AGG/9FqJKPZgmLZVKP8KwgB3apqL9qInNqt9aQ2PW+Rb/ZQ3oiDO+JeuophHzDkHsXAvw78Y8mkWkRw/goIlCNCMsmLcTXYrsFPzR8ZwOEhhpv+7Cs4QLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UYvNVJ9Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UYvNVJ9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C1E1F000E9;
	Wed, 26 Aug 2026 10:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787739684;
	bh=YEUXFgAdOYZhq6WlTXAgBZCPoZlzq0VxDUe0Jo44nCo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UYvNVJ9QJGIODputgmB7wnNgRVGVdFtQitMj0XSvMZK+a0f3/cxKMr2FWAPowRrbF
	 VinU6yOTa6OXhDxvotzTxMOEu/9hD9fW9+IgDTmuonYLhhX6pDCq4V3gvaZe550PPy
	 Jj+3mSvEHHT+GZr+WFE8xG4ri2TsPqij/IuekGUM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 26 Aug 2026 11:19:32 +0200
Subject: [PATCH 1/2] module: pull out add_taint_module() to be public
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-bind_taint-v1-1-52b05f4a965c@linuxfoundation.org>
References: <20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org>
In-Reply-To: <20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2435;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=7SCdvxoK0Z6e0C/Fm77VqCSXp0EzbmaMQ5H91NjQjmE=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFl96zffXn45ez73/eMrvSft42cJU1Iz5TZesKygTqDT3
 eyO/izjjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhIaCHDPO0Pt/7Mbi7P+rlP
 w2rNCw3XtkPP5BnmJ3wTvORXnhywreb6v/OGN/7KxmS9BwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

Other kernel code might want to call add_taint_module() so pull it out
and make it global.  If modules are not enabled, this defaults to a call
to add_taint(), so all is fine.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/module.h |  8 ++++++++
 kernel/module/main.c   | 13 +++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..25221539e645 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -29,6 +29,7 @@
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
 #include <linux/dynamic_debug.h>
+#include <linux/panic.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -770,6 +771,8 @@ static inline bool is_livepatch_module(struct module *mod)
 
 void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
 
+void add_taint_module(struct module *mod, unsigned flag, enum lockdep_ok);
+
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
@@ -877,6 +880,11 @@ static inline bool module_is_coming(struct module *mod)
 static inline void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
 {
 }
+
+static inline void add_taint_module(struct module *mod, unsigned flag, enum lockdep_ok)
+{
+	add_taint(flag, lockdep_ok);
+}
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0bd2ad0..99cedb961898 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -191,8 +191,17 @@ static inline int strong_try_module_get(struct module *mod)
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
 	set_bit(flag, &mod->taints);

-- 
2.55.0

