Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089C82BD0F;
	Sat,  1 Jun 2024 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717230161; cv=none; b=SBhMXb9NT/0sj/zo3eGhbi4ev1pk0hRGwQqiGr5HOQTDY46Q35TGuH8oCIz2V+YB5/+pvQr/h9qfRx1aEd0L5pqH2vzehwEx4Lu8sFjdrENIyVvpskf0kEkcZE8FEQ6swPVFw92DvLlHaweVI0i36OGCZ6gJZx/8UBYHk78QiKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717230161; c=relaxed/simple;
	bh=SEa6/naGWiY7r2mBFfkW8iDQpAWKMrIxI6Kmz0cQV7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUXaJI6kqfG2ppU7YUCqM8swPXf1hyJkLRd7Mf+PUAXc1ii8HNBD7KTYjDadnYphToqKSD8T4JFj0hMOaJco6quxGuK8ZAVchC0YKnJeQnbUrbIx7xr7iTloSKDblCgGM31qp5gt2g5kjy5YuNQHFRZToD0j/C6a1cr0Cj3LE1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dkgb3fBN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dkgb3fBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7E8C3277B;
	Sat,  1 Jun 2024 08:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717230160;
	bh=SEa6/naGWiY7r2mBFfkW8iDQpAWKMrIxI6Kmz0cQV7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dkgb3fBNELIPx0iqHx5H4BzpP0nrcQ2qs+LNXaqgfBhr11y4qu/TzTqnlNAVJ0ioG
	 jcFiMfbQiAnK7Ets+2e70k6v3nIB2B3+78eKormQglI1p7Lj0KUa+t1bv/o0g3SrFw
	 Yh8Kjti9jMxw3LayhLPvSp76HPQD/X/OnaQda7CAGxPXapctqEF0/KUTXmYRUTCUQf
	 L4ZXMmNIbqiMI/SlgY00Ehb3+f0vJS7EgpujOnuYhBImG/yX+k/kwhkLsuDyHwDoET
	 qKSxZ4MTd8GJvP2i9h1KqqlkCM4ax3AXqfPRXvJywb+u9vIIWXtdy7kfy9lZtWErIj
	 rrRvGkY1mWT9w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	don <zds100@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org
Subject: [PATCH v2 1/3] tracepoint: Support iterating over tracepoints on modules
Date: Sat,  1 Jun 2024 17:22:37 +0900
Message-Id: <171723015695.258703.10976621187063548530.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171723014778.258703.6731294779199848686.stgit@devnote2>
References: <171723014778.258703.6731294779199848686.stgit@devnote2>
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
 include/linux/tracepoint.h |    7 +++++++
 kernel/tracepoint.c        |   16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 689b6d71590e..46e6a5e759fd 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -65,6 +65,8 @@ struct tp_module {
 bool trace_module_has_bad_taint(struct module *mod);
 extern int register_tracepoint_module_notifier(struct notifier_block *nb);
 extern int unregister_tracepoint_module_notifier(struct notifier_block *nb);
+void for_each_module_tracepoint(void (*fct)(struct tracepoint *, void *),
+				void *priv);
 #else
 static inline bool trace_module_has_bad_taint(struct module *mod)
 {
@@ -80,6 +82,11 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
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
index 8d1507dd0724..b9b90dc46ab1 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -735,6 +735,22 @@ static __init int init_tracepoints(void)
 	return ret;
 }
 __initcall(init_tracepoints);
+
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

