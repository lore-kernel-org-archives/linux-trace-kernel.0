Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF4621A1C;
	Sun, 18 Aug 2024 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977791; cv=none; b=gJN/nhilbVTC2Ia+W2sv5lXnsQci45GlTMNyzZ7c7T1ah0nl/a8VbJ/3PO6rjUHUu6GVgzPwsrSC6guQ1/QFB6akJOAttDzgNQzLbDhMQ90Ic5KYJ0j754XhhwAg/xfpjHs3i63kTYObxadoANkVQmfFMo8ewGOloid1w21MqW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977791; c=relaxed/simple;
	bh=EvknbMhGf6LvKrk+oRW09wGeSmyN1oC8gV5vpMCp9L8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scb8Plp6qohLYsS272sz9Ow5IuOoXL0y4Bs2cT93OzsT941F0zCVnjNJKTFDa3fo+Yjix9lAUAe7rRwGsYQSmIe0TmvI/PjpMJSudHjAfOZTvJ3c5o1Gl2BR6peErAP8EYte1aO8g0jBrzZD9R2ezqpha/KQT2ksQvdm3JLrNhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Obyezy+q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Obyezy+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44DCC32786;
	Sun, 18 Aug 2024 10:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723977791;
	bh=EvknbMhGf6LvKrk+oRW09wGeSmyN1oC8gV5vpMCp9L8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Obyezy+qK84TS1wPFdk1yAvIzxceEAIFd8xEwEPcYcjF1a1tHihr1Ncb89ycxqGRM
	 X6OSdiNdsrs0mOlNKxgxDAAq9g0E4D3QjYTQnFW/1gVGNYbhBuD3TqeZsuub8T8W6X
	 Muf9SbPPf8RyUqO5u+UGecifchyF3qCYLalMHY9tgnC7e8Sw3RI3RiEdDnA10BAM8e
	 Rf3ibz9y5kMqGs3RYblYVMdNCPH+NvrzScm2yVBtisKsSFDKzSiQZeAu7WLw0D2JI7
	 +n7cOwW5TCmumDCSmtPhsZanJ9xlQcHaHK6Ckg+FpBR4xNmMSY/r6uQL/w+/YQhfoE
	 UXPBlN+i7o6mA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	don <zds100@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org
Subject: [PATCH v3 2/5] tracepoint: Support tterating tracepoints in a loading module
Date: Sun, 18 Aug 2024 19:43:07 +0900
Message-Id: <172397778740.286558.15781131277732977643.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172397776900.286558.8986646398199362026.stgit@devnote2>
References: <172397776900.286558.8986646398199362026.stgit@devnote2>
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

Add for_each_tracepoint_in_module() function to iterate tracepoints in
a module. This API is needed for handling tracepoints in a loading
module from tracepoint_module_notifier callback function.
This also update for_each_module_tracepoint() to pass the module to
callback function so that it can find module easily.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Newly added.
---
 include/linux/tracepoint.h |   17 +++++++++++++++--
 kernel/tracepoint.c        |   37 +++++++++++++++++++++++++++++--------
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 837fcf8ec0d5..93a9f3070b48 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -64,8 +64,13 @@ struct tp_module {
 bool trace_module_has_bad_taint(struct module *mod);
 extern int register_tracepoint_module_notifier(struct notifier_block *nb);
 extern int unregister_tracepoint_module_notifier(struct notifier_block *nb);
-void for_each_module_tracepoint(void (*fct)(struct tracepoint *, void *),
+void for_each_module_tracepoint(void (*fct)(struct tracepoint *,
+					struct module *, void *),
 				void *priv);
+void for_each_tracepoint_in_module(struct module *,
+				   void (*fct)(struct tracepoint *,
+					struct module *, void *),
+				   void *priv);
 #else
 static inline bool trace_module_has_bad_taint(struct module *mod)
 {
@@ -82,10 +87,18 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
 	return 0;
 }
 static inline
-void for_each_module_tracepoint(void (*fct)(struct tracepoint *, void *),
+void for_each_module_tracepoint(void (*fct)(struct tracepoint *,
+					struct module *, void *),
 				void *priv)
 {
 }
+static inline
+void for_each_tracepoint_in_module(struct module *mod,
+				   void (*fct)(struct tracepoint *,
+					struct module *, void *),
+				   void *priv)
+{
+}
 #endif /* CONFIG_MODULES */
 
 /*
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index bed4aad36d92..8879da16ef4d 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -736,24 +736,45 @@ static __init int init_tracepoints(void)
 }
 __initcall(init_tracepoints);
 
+/**
+ * for_each_tracepoint_in_module - iteration on all tracepoints in a module
+ * @mod: module
+ * @fct: callback
+ * @priv: private data
+ */
+void for_each_tracepoint_in_module(struct module *mod,
+				   void (*fct)(struct tracepoint *tp,
+				    struct module *mod, void *priv),
+				   void *priv)
+{
+	tracepoint_ptr_t *begin, *end, *iter;
+
+	lockdep_assert_held(&tracepoint_module_list_mutex);
+
+	if (!mod)
+		return;
+
+	begin = mod->tracepoints_ptrs;
+	end = mod->tracepoints_ptrs + mod->num_tracepoints;
+
+	for (iter = begin; iter < end; iter++)
+		fct(tracepoint_ptr_deref(iter), mod, priv);
+}
+
 /**
  * for_each_module_tracepoint - iteration on all tracepoints in all modules
  * @fct: callback
  * @priv: private data
  */
-void for_each_module_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
+void for_each_module_tracepoint(void (*fct)(struct tracepoint *tp,
+				 struct module *mod, void *priv),
 				void *priv)
 {
 	struct tp_module *tp_mod;
-	struct module *mod;
 
 	mutex_lock(&tracepoint_module_list_mutex);
-	list_for_each_entry(tp_mod, &tracepoint_module_list, list) {
-		mod = tp_mod->mod;
-		for_each_tracepoint_range(mod->tracepoints_ptrs,
-			mod->tracepoints_ptrs + mod->num_tracepoints,
-			fct, priv);
-	}
+	list_for_each_entry(tp_mod, &tracepoint_module_list, list)
+		for_each_tracepoint_in_module(tp_mod->mod, fct, priv);
 	mutex_unlock(&tracepoint_module_list_mutex);
 }
 #endif /* CONFIG_MODULES */

