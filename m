Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D90A345CA5;
	Wed, 15 Apr 2026 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247764; cv=none; b=KlX0bkkEQnzhYZxBA0hD//ZpBX1Rdo7BraqZJmqb88Npfgz+yNuSnuHmuTA1wx0cRqe6hPn6fAHtdXJzukaWFsPtv4qRc7zDEqtOXZZpbFL0Sizo4NFJMuSl3kE8txxZToImnMmiMQV7suCrgG2ZhKlMvVuaROuzS6kyBBfeS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247764; c=relaxed/simple;
	bh=A6kqK+GlVusk8buhMSCmQFw5rBo1+ztzcU/d1/28lbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yyk9uoiSQgxlQahImah/2NCWGGSn02F/Nv2hZp/88ezzju6qqCaBwk6hhiziy9ecyRt9+v8/9Sh7sa5auV6AAoW9QbdB9j63fDNTaTBi2MBaW+llnNY0mGecQojeqzquIklaVwSbm1c0lTSCHHYnfwlO9ig92UgYi4/+qJKaczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojcwFdo/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojcwFdo/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2F0C19424;
	Wed, 15 Apr 2026 10:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247764;
	bh=A6kqK+GlVusk8buhMSCmQFw5rBo1+ztzcU/d1/28lbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ojcwFdo/K8TB+KhX4hZf1OoEswQFlp8vU1y9Nd+L5EWL+5y6cbWGKPTUxWQGyMzle
	 4Uqi+U64/KKIwGC7ixoDn4vUvIJl8kcJO9FsetTvmvqSoGuSm4QgsRlXtuPuxyeWzY
	 D2I0Do3aPGExVtGC7go9FrYAMOxDTTOZROOxg4HLewGcYP1kOaQHyYu9dtXmvysx/P
	 QLSSbamVladAillmSC5SpAAw68Ecc57TNJ2Bi+bLe2xa717b5PvN4AATHRgIRFAfSd
	 ovpkkHdFC0dOUUfp2dSzI8N41x6ilJFmeSlwfiTMpSG7dVjvANpCwsjFP0jeM6pm1B
	 zGk+4zBtWQehw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 6/6] tracing/fprobe: Fix to unregister ftrace_ops if it is empty on module unloading
Date: Wed, 15 Apr 2026 19:09:21 +0900
Message-ID:  <177624776142.2407691.5687670949567786266.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
In-Reply-To:  <177624771150.2407691.15764846647014540969.stgit@mhiramat.tok.corp.google.com>
References:  <177624771150.2407691.15764846647014540969.stgit@mhiramat.tok.corp.google.com>
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
 Changes in v7:
  - Fix to split checking whether ftrace_ops is registered from
    the number of registered fprobes, because ftrace_ops can be
    unregistered in module unloading.
 Changes in v6:
  - Newly added.
---
 kernel/trace/fprobe.c |  214 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 165 insertions(+), 49 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 8a5601bf2330..3e3df2e13c06 100644
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
 
@@ -250,7 +250,74 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
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
+/* Number of fgraph fprobes */
+static int fprobe_graph_active;
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
+	if (!fprobe_graph_active) {
+		if (WARN_ON_ONCE(fprobe_graph_registered))
+			return -EINVAL;
+		ret = register_ftrace_graph(&fprobe_graph_ops);
+		if (WARN_ON_ONCE(ret)) {
+			ftrace_free_filter(&fprobe_graph_ops.ops);
+			return ret;
+		}
+		fprobe_graph_registered = true;
+	}
+	fprobe_graph_active++;
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
+	if (!fprobe_graph_active)
+		return;
+
+	fprobe_graph_active--;
+	if (!fprobe_graph_active)
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
@@ -293,7 +360,12 @@ static struct ftrace_ops fprobe_ftrace_ops = {
 	.func	= fprobe_ftrace_entry,
 	.flags	= FTRACE_OPS_FL_SAVE_ARGS,
 };
+/* Number of fgraph fprobes */
 static int fprobe_ftrace_active;
+/* Number of ftrace fprobe nodes */
+static int nr_ftrace_fprobes;
+/* Is fprobe_ftrace_ops registered? */
+static bool fprobe_ftrace_registered;
 
 static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
 {
@@ -306,24 +378,40 @@ static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
 		return ret;
 
 	if (!fprobe_ftrace_active) {
+		if (WARN_ON_ONCE(fprobe_ftrace_registered))
+			return -EINVAL;
+
 		ret = register_ftrace_function(&fprobe_ftrace_ops);
 		if (ret) {
 			ftrace_free_filter(&fprobe_ftrace_ops);
 			return ret;
 		}
+		fprobe_ftrace_registered = true;
 	}
 	fprobe_ftrace_active++;
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
 
+	if (!fprobe_ftrace_active)
+		return;
+
 	fprobe_ftrace_active--;
 	if (!fprobe_ftrace_active)
-		unregister_ftrace_function(&fprobe_ftrace_ops);
-	if (num)
+		__fprobe_ftrace_unregister();
+	else if (num)
 		ftrace_set_filter_ips(&fprobe_ftrace_ops, addrs, num, 1, 0);
 }
 
@@ -332,6 +420,40 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
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
@@ -361,8 +483,15 @@ static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace)
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
@@ -380,6 +509,32 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
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
@@ -406,7 +561,10 @@ static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace __maybe_unused)
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
@@ -536,48 +694,6 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
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
-	if (!fprobe_graph_active)
-		unregister_ftrace_graph(&fprobe_graph_ops);
-
-	if (num)
-		ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
-}
-
 #ifdef CONFIG_MODULES
 
 #define FPROBE_IPS_BATCH_INIT 128

