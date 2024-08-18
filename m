Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDB817BBF;
	Sun, 18 Aug 2024 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977782; cv=none; b=MUTTGvV/lNfImkHvYoZKv6drS/HIMCiTgW+ug9avUy2DDPlAvQ0ZnvfK+dnU1PvjfCyxTx2IggK02ZiJ7Iy65NnuQxoEI2UEradDXZeHp/7hNsOZkVbwuMh8qBAk4L9oG/DwCHeobd3CxnI6Epgwyn/bMynOSEsCwktUPdKlHpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977782; c=relaxed/simple;
	bh=K+YhhYrm6wZmaypIZoaE8lkjUEUnYcCHGJ03mCynMzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ei8Cx31us0hc2fULWFzHsmHNN3HRY/8fpit6b+b3drfGB2nx47yOqS5AuRwdmZooj9XB3+d1Ao9gcjmHxgI4K1jI1SkfrpProwQ45veEuar8+pxjG9OtNcMhNs5q/ptdoIAxvylYcgNXNFow/tI23EeZjp5AG+LPvRJe/se4/w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQdxoY6/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQdxoY6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8906EC32786;
	Sun, 18 Aug 2024 10:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723977782;
	bh=K+YhhYrm6wZmaypIZoaE8lkjUEUnYcCHGJ03mCynMzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NQdxoY6/5vQZDSFrmpKhLxatsRhhfz7n+9brTbyy4ipMUWGqmZ1IYaVHrSiHRfsKQ
	 czzCv0PAZR9IvqrpUj1YrhNQIaoz3rq9V+MbwS7O2aS8luovAgH/yZGKO7pOLan8cw
	 n1u26jXmO2ZKkA3hdC7L92msz02JUBPWVc0/1fPtY4nIBD3ksXSJAsETYERzZgSS49
	 8tSGZBXYf6b06iZxQ7nfAidbNCuVHJRf69xCHlD4rjIO5v2+uT428mX3EKgiI1S8JX
	 2ZJkQbenCNyLyENhvlrwyCBb4f2egxNw41s6YVUezHIWennlsJC13DpSIaQCCO8t3y
	 WjzLBtkogTd4A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	don <zds100@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org
Subject: [PATCH v3 1/5] tracepoint: Support iterating over tracepoints on modules
Date: Sun, 18 Aug 2024 19:42:58 +0900
Message-Id: <172397777800.286558.14554748203446214056.stgit@devnote2>
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

Add for_each_module_tracepoint() for iterating over tracepoints
on modules. This is similar to the for_each_kernel_tracepoint()
but only for the tracepoints on modules (not including kernel
built-in tracepoints).

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Add kerneldoc for for_each_module_tracepoint.
---
 include/linux/tracepoint.h |    7 +++++++
 kernel/tracepoint.c        |   21 +++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 6be396bb4297..837fcf8ec0d5 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -64,6 +64,8 @@ struct tp_module {
 bool trace_module_has_bad_taint(struct module *mod);
 extern int register_tracepoint_module_notifier(struct notifier_block *nb);
 extern int unregister_tracepoint_module_notifier(struct notifier_block *nb);
+void for_each_module_tracepoint(void (*fct)(struct tracepoint *, void *),
+				void *priv);
 #else
 static inline bool trace_module_has_bad_taint(struct module *mod)
 {
@@ -79,6 +81,11 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
 {
 	return 0;
 }
+static inline
+void for_each_module_tracepoint(void (*fct)(struct tracepoint *, void *),
+				void *priv)
+{
+}
 #endif /* CONFIG_MODULES */
 
 /*
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 8d1507dd0724..bed4aad36d92 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -735,6 +735,27 @@ static __init int init_tracepoints(void)
 	return ret;
 }
 __initcall(init_tracepoints);
+
+/**
+ * for_each_module_tracepoint - iteration on all tracepoints in all modules
+ * @fct: callback
+ * @priv: private data
+ */
+void for_each_module_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
+				void *priv)
+{
+	struct tp_module *tp_mod;
+	struct module *mod;
+
+	mutex_lock(&tracepoint_module_list_mutex);
+	list_for_each_entry(tp_mod, &tracepoint_module_list, list) {
+		mod = tp_mod->mod;
+		for_each_tracepoint_range(mod->tracepoints_ptrs,
+			mod->tracepoints_ptrs + mod->num_tracepoints,
+			fct, priv);
+	}
+	mutex_unlock(&tracepoint_module_list_mutex);
+}
 #endif /* CONFIG_MODULES */
 
 /**

