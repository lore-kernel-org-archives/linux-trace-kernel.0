Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE39134E741;
	Mon, 20 Apr 2026 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693690; cv=none; b=bdsNJifysqbFpmBHZArMC/+gW+e6lXLSfqjPjgwilfu/R5ZFZkmhddsajRfi0W/UhDW0JsSyZtLS08X4fjAzIlvQQcVfGvWl+Ci/mA/ix5MdZJ3KOVP5TRDWn3TERwervZhV/3vq3q73TiBZEw34x7ERlzzxAP/NWDp0LPAcEHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693690; c=relaxed/simple;
	bh=7DbW4/aJrHn1nTLmgN/QxGJRygwpkyZ84qf/sjT8AoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLp50YntR2d/uDUYzsbaL84tgoqPOdxNmtI73H18YyGiAW+TvPycwMp0cHuVlgEdgiZY6u/BGUSuSVnWxGbh6sHC5xgh0qCbjgYqqT2ySwzdrKv/bCwyQhNmZH3iinyXBcpsPSyZQt4eGAqFaEWal75ExrxjoiIOuABHcV7y2j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXZ8dt7e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXZ8dt7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703BAC19425;
	Mon, 20 Apr 2026 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776693690;
	bh=7DbW4/aJrHn1nTLmgN/QxGJRygwpkyZ84qf/sjT8AoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LXZ8dt7e12ac5HPZCvafMliPU4bvE2Py/40A5QJSPBvG8F7f/I7WD+7mZfCWNLDEp
	 +2joS3HBro1rEZZP41lHOaiZyr8hkxlY/Y9utIHEzJA2bWj9K5nfWBa2gV8baj8H/j
	 G7d6hsIcgR+Cwxp3oLIXriJIJSQ+gFOOFwyVJ1W7uOcg4YO7DrbTNEJtvXsZCd1wX/
	 AOT1uahst+WOtpumTg2sAsPEBCzoNNTU9wswWWbQw8XqYSRxUWstW20c+WZPf9Xyrk
	 Y7BFLbaOs+RinyR6LGzulTwlR7ugT4g+HnuJ1KYAVMyFgyW+JOpQ3f+xjE2kj+bRa0
	 2Ph2U+O0kq37A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v10 6/8] tracing/fprobe: Fix to unregister ftrace_ops if it is empty on module unloading
Date: Mon, 20 Apr 2026 23:01:27 +0900
Message-ID:  <177669368776.132053.10042301916765771279.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
In-Reply-To:  <177669363667.132053.12454670015890859277.stgit@mhiramat.tok.corp.google.com>
References:  <177669363667.132053.12454670015890859277.stgit@mhiramat.tok.corp.google.com>
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
 Changes in v10:
  - Even if the removed node count is 0 because of the memory allocation
    fails, call __fprobe_f*_unregister() if the number of ftrace_hash_node
    is 0.
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
 kernel/trace/fprobe.c |  224 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 159 insertions(+), 65 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index d0a68a2c5eaf..cc49ebd2a773 100644
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
+	else if (cnt)
+		ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, 1, 0);
+
+	if (!nr_ftrace_fprobes)
+		__fprobe_ftrace_unregister();
+	else if (cnt)
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
+	else if (cnt)
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
@@ -653,16 +749,14 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	} while (node == ERR_PTR(-EAGAIN) && !retry);
 	rhashtable_walk_exit(&iter);
 	/* Remove any ips from hash table(s) */
-	if (alist.index > 0) {
-		fprobe_remove_ips(alist.addrs, alist.index);
-		/*
-		 * If we break rhashtable walk loop except for -EAGAIN, we need
-		 * to restart looping from start for safety. Anyway, this is
-		 * not a hotpath.
-		 */
-		if (retry)
-			goto again;
-	}
+	fprobe_remove_ips(alist.addrs, alist.index);
+	/*
+	 * If we break rhashtable walk loop except for -EAGAIN, we need
+	 * to restart looping from start for safety. Anyway, this is
+	 * not a hotpath.
+	 */
+	if (retry)
+		goto again;
 
 	mutex_unlock(&fprobe_mutex);
 

