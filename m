Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B293528F5;
	Fri, 17 Apr 2026 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442714; cv=none; b=nawee12Gmz6hTuqlVU5pnhBFXPdgqMckmE5IE8jQhqleHvL7GWSJkQ9YY2r2NoM/mgIbqxjuqXiL7sZ32GsGi+CLAreZxoKVFGwQStQc2+u3ucYfRk9SOhEMtFbXFRnRiixIl7tR8p6hLHIsb+SbSDLC92Tx7JArQcLD9hpCO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442714; c=relaxed/simple;
	bh=AxNeNAyL/6BHAbljZCKYBK8EnELRZQ8y3F7zFDAkdOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9ThdoYSIdfjmOY0c7TxrU6YM8Goi4Wz1FeA15rzv7f475PLcNr8JEbFwBsVVRQt9TEUQnIrL9NjQbRmy3A2EmIXNXGtX8YWaQQNgsmrhtDzPs6UtMKd3aH8xQlrzxhPXRhcIqPxMHBCz/9ha0/HU6gDJ0DGPwKSt5aNYvnPJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9dl8EhS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9dl8EhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D7FC19425;
	Fri, 17 Apr 2026 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776442714;
	bh=AxNeNAyL/6BHAbljZCKYBK8EnELRZQ8y3F7zFDAkdOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9dl8EhS+xDe7X0Wf3H5d7ZaZMs/dT1tLAIFBCibLzYxcdrlU9qs+JI9ONFUCbYpF
	 8PW6k9tHSSjA2wAse1uTW+TjvR4wszdnt+hGy8tzniOf6zMXt/Tb0CZOcL4X5/MHmc
	 tL8quCpMgrIdwgsRC8K/TYCCcatNqTlhz09bSoKySEt+hGqxsstZPg9w8G0GWHBs3/
	 vJUWXf+5Eau2uX6SalI4GtQN7vymgodJH8XcZtQf28rtzQ2J2VDl/DnTSXqio3HZtm
	 xTO4E93rR9gAWFIwzCZDuVT+tgVlUaKwYEoMf5uFitLWWwLS5zqAXLWaJLzaH3yXrO
	 UIpuPPp78qtpA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v9 6/8] tracing/fprobe: Fix to unregister ftrace_ops if it is empty on module unloading
Date: Sat, 18 Apr 2026 01:18:31 +0900
Message-ID:  <177644271176.584467.7530496355395544191.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
In-Reply-To:  <177644266147.584467.8179035927318998910.stgit@mhiramat.tok.corp.google.com>
References:  <177644266147.584467.8179035927318998910.stgit@mhiramat.tok.corp.google.com>
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

Fix fprobe to unregister ftrace_ops if corresponding type of fprobe
does not exist on the fprobe_ip_table and it is expected to be empty
when unloading modules.

Since ftrace thinks that the empty hash means everything to be traced,
if we set fprobes only on the unloaded module, all functions are traced
unexpectedly after unloading module.
e.g.

 # modprobe xt_LOG.ko
 # echo 'f:test log_tg*' > dynamic_events
 # echo 1 > events/fprobes/test/enable
 # cat enabled_functions
log_tg [xt_LOG] (1)             tramp: 0xffffffffa0004000 (fprobe_ftrace_entry+0x0/0x490) ->fprobe_ftrace_entry+0x0/0x490
log_tg_check [xt_LOG] (1)               tramp: 0xffffffffa0004000 (fprobe_ftrace_entry+0x0/0x490) ->fprobe_ftrace_entry+0x0/0x490
log_tg_destroy [xt_LOG] (1)             tramp: 0xffffffffa0004000 (fprobe_ftrace_entry+0x0/0x490) ->fprobe_ftrace_entry+0x0/0x490
 # rmmod xt_LOG
 # wc -l enabled_functions
34085 enabled_functions

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v9:
  - Remove fprobe_graph_active and fprobe_ftrace_active to fix
    remove fprobe after unload module case.
 Changes in v8:
  - Fix to check fprobe_graph/ftrace_registered flag directly
    when registering ftrace_ops.
 Changes in v7:
  - Fix to split checking whether ftrace_ops is registered from
    the number of registered fprobes, because ftrace_ops can be
    unregistered in module unloading.
 Changes in v6:
  - Newly added.
---
 kernel/trace/fprobe.c |  206 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 151 insertions(+), 55 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index e3b5cc76151e..6a392936238a 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -79,7 +79,7 @@ static const struct rhashtable_params fprobe_rht_params = {
 };
 
 /* Node insertion and deletion requires the fprobe_mutex */
-static int insert_fprobe_node(struct fprobe_hlist_node *node, struct fprobe *fp)
+static int __insert_fprobe_node(struct fprobe_hlist_node *node, struct fprobe *fp)
 {
 	int ret;
 
@@ -92,7 +92,7 @@ static int insert_fprobe_node(struct fprobe_hlist_node *node, struct fprobe *fp)
 	return ret;
 }
 
-static void delete_fprobe_node(struct fprobe_hlist_node *node)
+static void __delete_fprobe_node(struct fprobe_hlist_node *node)
 {
 	lockdep_assert_held(&fprobe_mutex);
 
@@ -250,7 +250,65 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 	return ret;
 }
 
+static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
+			       struct ftrace_regs *fregs);
+static void fprobe_return(struct ftrace_graph_ret *trace,
+			  struct fgraph_ops *gops,
+			  struct ftrace_regs *fregs);
+
+static struct fgraph_ops fprobe_graph_ops = {
+	.entryfunc	= fprobe_fgraph_entry,
+	.retfunc	= fprobe_return,
+};
+/* Number of fgraph fprobe nodes */
+static int nr_fgraph_fprobes;
+/* Is fprobe_graph_ops registered? */
+static bool fprobe_graph_registered;
+
+/* Add @addrs to the ftrace filter and register fgraph if needed. */
+static int fprobe_graph_add_ips(unsigned long *addrs, int num)
+{
+	int ret;
+
+	lockdep_assert_held(&fprobe_mutex);
+
+	ret = ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 0, 0);
+	if (ret)
+		return ret;
+
+	if (!fprobe_graph_registered) {
+		ret = register_ftrace_graph(&fprobe_graph_ops);
+		if (WARN_ON_ONCE(ret)) {
+			ftrace_free_filter(&fprobe_graph_ops.ops);
+			return ret;
+		}
+		fprobe_graph_registered = true;
+	}
+	return 0;
+}
+
+static void __fprobe_graph_unregister(void)
+{
+	if (fprobe_graph_registered) {
+		unregister_ftrace_graph(&fprobe_graph_ops);
+		ftrace_free_filter(&fprobe_graph_ops.ops);
+		fprobe_graph_registered = false;
+	}
+}
+
+/* Remove @addrs from the ftrace filter and unregister fgraph if possible. */
+static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
+{
+	lockdep_assert_held(&fprobe_mutex);
+
+	if (!nr_fgraph_fprobes)
+		__fprobe_graph_unregister();
+	else if (num)
+		ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
+}
+
 #if defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS) || defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
+
 /* ftrace_ops callback, this processes fprobes which have only entry_handler. */
 static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
 	struct ftrace_ops *ops, struct ftrace_regs *fregs)
@@ -293,7 +351,10 @@ static struct ftrace_ops fprobe_ftrace_ops = {
 	.func	= fprobe_ftrace_entry,
 	.flags	= FTRACE_OPS_FL_SAVE_ARGS,
 };
-static int fprobe_ftrace_active;
+/* Number of ftrace fprobe nodes */
+static int nr_ftrace_fprobes;
+/* Is fprobe_ftrace_ops registered? */
+static bool fprobe_ftrace_registered;
 
 static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
 {
@@ -305,26 +366,33 @@ static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
 	if (ret)
 		return ret;
 
-	if (!fprobe_ftrace_active) {
+	if (!fprobe_ftrace_registered) {
 		ret = register_ftrace_function(&fprobe_ftrace_ops);
 		if (ret) {
 			ftrace_free_filter(&fprobe_ftrace_ops);
 			return ret;
 		}
+		fprobe_ftrace_registered = true;
 	}
-	fprobe_ftrace_active++;
 	return 0;
 }
 
+static void __fprobe_ftrace_unregister(void)
+{
+	if (fprobe_ftrace_registered) {
+		unregister_ftrace_function(&fprobe_ftrace_ops);
+		ftrace_free_filter(&fprobe_ftrace_ops);
+		fprobe_ftrace_registered = false;
+	}
+}
+
 static void fprobe_ftrace_remove_ips(unsigned long *addrs, int num)
 {
 	lockdep_assert_held(&fprobe_mutex);
 
-	fprobe_ftrace_active--;
-	if (!fprobe_ftrace_active) {
-		unregister_ftrace_function(&fprobe_ftrace_ops);
-		ftrace_free_filter(&fprobe_ftrace_ops);
-	} else if (num)
+	if (!nr_ftrace_fprobes)
+		__fprobe_ftrace_unregister();
+	else if (num)
 		ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 1, 0);
 }
 
@@ -333,6 +401,40 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 	return !fp->exit_handler;
 }
 
+/* Node insertion and deletion requires the fprobe_mutex */
+static int insert_fprobe_node(struct fprobe_hlist_node *node, struct fprobe *fp)
+{
+	int ret;
+
+	lockdep_assert_held(&fprobe_mutex);
+
+	ret = __insert_fprobe_node(node, fp);
+	if (!ret) {
+		if (fprobe_is_ftrace(fp))
+			nr_ftrace_fprobes++;
+		else
+			nr_fgraph_fprobes++;
+	}
+
+	return ret;
+}
+
+static void delete_fprobe_node(struct fprobe_hlist_node *node)
+{
+	struct fprobe *fp;
+
+	lockdep_assert_held(&fprobe_mutex);
+
+	fp = READ_ONCE(node->fp);
+	if (fp) {
+		if (fprobe_is_ftrace(fp))
+			nr_ftrace_fprobes--;
+		else
+			nr_fgraph_fprobes--;
+	}
+	__delete_fprobe_node(node);
+}
+
 static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace)
 {
 	struct rhlist_head *head, *pos;
@@ -362,8 +464,15 @@ static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace)
 #ifdef CONFIG_MODULES
 static void fprobe_remove_ips(unsigned long *ips, unsigned int cnt)
 {
-	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, 1, 0);
-	ftrace_set_filter_ips(&fprobe_ftrace_ops, ips, cnt, 1, 0);
+	if (!nr_fgraph_fprobes)
+		__fprobe_graph_unregister();
+	else
+		ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, 1, 0);
+
+	if (!nr_ftrace_fprobes)
+		__fprobe_ftrace_unregister();
+	else
+		ftrace_set_filter_ips(&fprobe_ftrace_ops, ips, cnt, 1, 0);
 }
 #endif
 #else
@@ -381,6 +490,32 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 	return false;
 }
 
+/* Node insertion and deletion requires the fprobe_mutex */
+static int insert_fprobe_node(struct fprobe_hlist_node *node, struct fprobe *fp)
+{
+	int ret;
+
+	lockdep_assert_held(&fprobe_mutex);
+
+	ret = __insert_fprobe_node(node, fp);
+	if (!ret)
+		nr_fgraph_fprobes++;
+
+	return ret;
+}
+
+static void delete_fprobe_node(struct fprobe_hlist_node *node)
+{
+	struct fprobe *fp;
+
+	lockdep_assert_held(&fprobe_mutex);
+
+	fp = READ_ONCE(node->fp);
+	if (fp)
+		nr_fgraph_fprobes--;
+	__delete_fprobe_node(node);
+}
+
 static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace __maybe_unused)
 {
 	struct rhlist_head *head, *pos;
@@ -407,7 +542,10 @@ static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace __maybe_unused)
 #ifdef CONFIG_MODULES
 static void fprobe_remove_ips(unsigned long *ips, unsigned int cnt)
 {
-	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, 1, 0);
+	if (!nr_fgraph_fprobes)
+		__fprobe_graph_unregister();
+	else
+		ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, 1, 0);
 }
 #endif
 #endif /* !CONFIG_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
@@ -535,48 +673,6 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 }
 NOKPROBE_SYMBOL(fprobe_return);
 
-static struct fgraph_ops fprobe_graph_ops = {
-	.entryfunc	= fprobe_fgraph_entry,
-	.retfunc	= fprobe_return,
-};
-static int fprobe_graph_active;
-
-/* Add @addrs to the ftrace filter and register fgraph if needed. */
-static int fprobe_graph_add_ips(unsigned long *addrs, int num)
-{
-	int ret;
-
-	lockdep_assert_held(&fprobe_mutex);
-
-	ret = ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 0, 0);
-	if (ret)
-		return ret;
-
-	if (!fprobe_graph_active) {
-		ret = register_ftrace_graph(&fprobe_graph_ops);
-		if (WARN_ON_ONCE(ret)) {
-			ftrace_free_filter(&fprobe_graph_ops.ops);
-			return ret;
-		}
-	}
-	fprobe_graph_active++;
-	return 0;
-}
-
-/* Remove @addrs from the ftrace filter and unregister fgraph if possible. */
-static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
-{
-	lockdep_assert_held(&fprobe_mutex);
-
-	fprobe_graph_active--;
-	/* Q: should we unregister it ? */
-	if (!fprobe_graph_active) {
-		unregister_ftrace_graph(&fprobe_graph_ops);
-		ftrace_free_filter(&fprobe_graph_ops.ops);
-	} else if (num)
-		ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
-}
-
 #ifdef CONFIG_MODULES
 
 #define FPROBE_IPS_BATCH_INIT 128

