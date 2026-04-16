Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D848B39DBEE;
	Thu, 16 Apr 2026 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334653; cv=none; b=dAK/mHoIoLHKCZNHGA93vrdbxJ9Gs3yCPBqC3JTYSWMm2O3tjUOASqW7AbPuHHb4IZlb82xvHEp5GfdEGpQOv7us3BlU9NQpE43RKLTdMVNClL5+ugnSNSPIuwmbO2zxBkLVvddV+vVNGmCVRr4p4JrAIL2A18opsAHZIQOTf1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334653; c=relaxed/simple;
	bh=Nfd3todE/ayttr2tkh3sPD9Tjk3a7gqq3ycu4KO/QsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7G+SQmCKegOKw0+pVWSKNG7qWCCVxGBFA7Yf/7dXzMa4EmjurI5je7er166Ujt4tzPPkRFUu4yQzlk29dFj52/E08iX9OvUcu7hDw42LLelziVFd0wVZPlmH+v28GTBz3Aw8VXk3sq+iyfoYCMjzBb81NAst78ET6ZclOdibrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsFvF+KE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsFvF+KE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE471C2BCB0;
	Thu, 16 Apr 2026 10:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776334653;
	bh=Nfd3todE/ayttr2tkh3sPD9Tjk3a7gqq3ycu4KO/QsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GsFvF+KEK2nDrnn7YluJDHVQGe2gM9HDCUKxrHRaNfzEUKQ5T2sgwIRZZffsHZI1q
	 U1IvUoNVw/1QqBz4hTDcPSRpsajISBR1hyEvx+CSPgOZXXuNXrog8Nqb/2BekdAjBu
	 kGL+Dj8eX2lawPsskWR7emEZuYAxozhdak7np5rnY9FwJg4ELOKS0VV37OyEr3TaRn
	 WUIi737SjpZ1ob7BUwYu7eBvv4FRl5N9R5VvN4zlL8VJHdCmes+CxaOQW6ouVw8PRQ
	 n+j4KOJmw22C7Mp/oazkxHQMCvAiBZeaYueBdbn6QuQxIoFo9Ga7whxApVzbyHmtdJ
	 v6zbfygOBk1aA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v8 6/8] tracing/fprobe: Fix to unregister ftrace_ops if it is empty on module unloading
Date: Thu, 16 Apr 2026 19:17:31 +0900
Message-ID:  <177633465115.3479617.5433794585008902596.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
In-Reply-To:  <177633460058.3479617.11868368413034643565.stgit@mhiramat.tok.corp.google.com>
References:  <177633460058.3479617.11868368413034643565.stgit@mhiramat.tok.corp.google.com>
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
 kernel/trace/fprobe.c |  211 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 161 insertions(+), 50 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index f2c30587ab26..3c390b90a99f 100644
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
 
@@ -250,7 +250,72 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
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
+	if (!fprobe_graph_registered) {
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
@@ -293,7 +358,12 @@ static struct ftrace_ops fprobe_ftrace_ops = {
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
@@ -305,25 +375,38 @@ static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
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
 
@@ -332,6 +415,40 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
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
@@ -361,8 +478,15 @@ static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace)
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
@@ -380,6 +504,32 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
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
@@ -406,7 +556,10 @@ static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace __maybe_unused)
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
@@ -536,48 +689,6 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
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

