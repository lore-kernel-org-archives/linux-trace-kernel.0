Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351D81749;
	Sat,  1 Feb 2025 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738394595; cv=none; b=tp6+hrthFi8/kQY8dk3wpD3M5gIEN6h/NaLYLqjrPhApyLj2GEAuyNATn0dnU9G1NcUGreTa3YP9dmoImyjA3HfnEUQ+nuN89cckMm+2qu7sLPntjeWzh1qlP37OotM6k8BIE5CyIAEQXwujMmIKEjPau88452S2jYAzXli7sJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738394595; c=relaxed/simple;
	bh=+Cp+rqZpjieos4w+gk3fyrX4q/vH657CCHxNW4N5DSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyLykdIjb0wuo86NdesBf4kfZ4ir7iBShKqbE9Him2IGrouVgcpVEI06f4CJtaeozqdoLkOgwWU76mcpYLqLYyCXFYkvXTEKmI6YUkTdFtfozfM1C8VkBt8h4vem9KheHQOIlrrSoDsSe/QLeWIhHf0xjwAbP1MjSJfdEAIujJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNkF68lf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNkF68lf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9352FC4CED3;
	Sat,  1 Feb 2025 07:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738394595;
	bh=+Cp+rqZpjieos4w+gk3fyrX4q/vH657CCHxNW4N5DSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DNkF68lf877iH6ByEJLzMob6dlI/hWuzGvq2Q2B6q4cXfIYS56Z2G+TMtdeFGihg8
	 tmav7NJ+RR5U6xFRU+j9UijWJxbnbt7wtwBAztdXDUA+hFitxxHGXsqYM8rW0elb/D
	 0Gqz+RKbDlxp0MpnicTVU7JSRR40tRmRdbOy6R3CnhiXThOvHFrkhGBS94CZOuE2sO
	 6yMuPLZ98gPs5hK928Tt2ngtAQkfcHc5xzSG0JoLunfqPY9JnHOYimS2oAJTjPCx4R
	 0lNA5LrDQL3+umigLK2RzPuMct15ymk8PhvIxDodKxuQu8zoa+RpDSy3bpuhpFqrqS
	 WyGbxkLBdxPlg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: [PATCH v2 1/2] modules: Add __module_build_id() to find module by build_id
Date: Sat,  1 Feb 2025 16:23:11 +0900
Message-ID: <173839459112.2009498.16498824811045520238.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173839458022.2009498.14495253908367838065.stgit@devnote2>
References: <173839458022.2009498.14495253908367838065.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add __module_build_id() to find module by build_id. This also makes
module::build_id available with CONFIG_MODULE_BUILD_ID kconfig.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/module.h   |    8 +++++++-
 kernel/module/Kconfig    |    3 +++
 kernel/module/kallsyms.c |    4 ++--
 kernel/module/main.c     |   29 +++++++++++++++++++++++++++++
 lib/Kconfig.debug        |    1 +
 5 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index b3a643435357..e181056d6af6 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -416,7 +416,7 @@ struct module {
 	/* Unique handle for this module */
 	char name[MODULE_NAME_LEN];
 
-#ifdef CONFIG_STACKTRACE_BUILD_ID
+#ifdef CONFIG_MODULE_BUILD_ID
 	/* Module build ID */
 	unsigned char build_id[BUILD_ID_SIZE_MAX];
 #endif
@@ -622,6 +622,7 @@ static inline bool module_is_coming(struct module *mod)
 
 struct module *__module_text_address(unsigned long addr);
 struct module *__module_address(unsigned long addr);
+struct module *__module_build_id(unsigned char *build_id, int size);
 bool is_module_address(unsigned long addr);
 bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
 bool is_module_percpu_address(unsigned long addr);
@@ -791,6 +792,11 @@ static inline struct module *__module_text_address(unsigned long addr)
 	return NULL;
 }
 
+static inline struct module *__module_build_id(unsigned char *build_id, int size)
+{
+	return NULL;
+}
+
 static inline bool is_module_address(unsigned long addr)
 {
 	return false;
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 7b329057997a..5e81dea1afea 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -26,6 +26,9 @@ if MODULES
 config MODULE_DEBUGFS
 	bool
 
+config MODULE_BUILD_ID
+	bool
+
 config MODULE_DEBUG
 	bool "Module debugging"
 	depends on DEBUG_FS
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index bf65e0c3c86f..98f2661c1da8 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -224,7 +224,7 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	mod->core_kallsyms.num_symtab = ndst;
 }
 
-#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+#if IS_ENABLED(CONFIG_MODULE_BUILD_ID)
 void init_build_id(struct module *mod, const struct load_info *info)
 {
 	const Elf_Shdr *sechdr;
@@ -338,7 +338,7 @@ int module_address_lookup(unsigned long addr,
 		if (modname)
 			*modname = mod->name;
 		if (modbuildid) {
-#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+#if IS_ENABLED(CONFIG_MODULE_BUILD_ID)
 			*modbuildid = mod->build_id;
 #else
 			*modbuildid = NULL;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5399c182b3cb..fca9b6a692e3 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3746,6 +3746,35 @@ struct module *__module_text_address(unsigned long addr)
 	return mod;
 }
 
+/**
+ * __module_build_id() - get the module whose build_id start with an array.
+ * @build_id: the first part of the build_id.
+ * @size: the size of @build_id.
+ *
+ * Must be called with preempt disabled or module mutex held so that
+ * module doesn't get freed during this.
+ */
+struct module *__module_build_id(unsigned char *build_id, int size)
+{
+#ifdef CONFIG_MODULE_BUILD_ID
+	struct module *mod;
+
+	if (size < 0)
+		return NULL;
+
+	if (size > BUILD_ID_SIZE_MAX)
+		size = BUILD_ID_SIZE_MAX;
+
+	list_for_each_entry_rcu(mod, &modules, list) {
+		if (mod->state == MODULE_STATE_UNFORMED)
+			continue;
+		if (!memcmp(mod->build_id, build_id, size))
+			return mod;
+	}
+#endif
+	return NULL;
+}
+
 /* Don't grab lock, we're oopsing. */
 void print_modules(void)
 {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cf2a41dc7682..2d3a2f656a86 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -38,6 +38,7 @@ config PRINTK_CALLER
 config STACKTRACE_BUILD_ID
 	bool "Show build ID information in stacktraces"
 	depends on PRINTK
+	select MODULE_BUILD_ID if MODULES
 	help
 	  Selecting this option adds build ID information for symbols in
 	  stacktraces printed with the printk format '%p[SR]b'.

