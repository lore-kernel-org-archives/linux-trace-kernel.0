Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED9D3E277C;
	Fri, 10 Apr 2026 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841114; cv=none; b=KL9Sx23khPPPgUtkHOW679W3QTEHSw022L06nehrWE9L/yjK+yGWoxYTIqkMJPTLarovKAGuDGiHuyoY0XRdfrf0zPGKe9RQAu8REa1aXzCcWXkYGyWKEJbyKWm5wpm4jlCCj0Ooq13HcR9ZFWDOGdC6iVJx22bWXleBZKbU0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841114; c=relaxed/simple;
	bh=sMvywU0Ew7ALrP1iCBRTav3iZxiHo74useCiIoc4G+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRQQQmnIwrNwHxBaiRyhppU3LoAgM4UkcKiOnTftQg9I/2AHOLgTv8zekbF+O2/1pAwoDXxgclfofTuUzs8+FRo3vpLWPfc3eL33oby/dCV75D3Lrc3yK3ejXvZwKLKnyffjy+XTdwBr/Bob0nyAI/PeemRPk6OEgE1uLiy88IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tndNPwGo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tndNPwGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809FAC19421;
	Fri, 10 Apr 2026 17:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775841113;
	bh=sMvywU0Ew7ALrP1iCBRTav3iZxiHo74useCiIoc4G+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tndNPwGo1qcWy5sEAW4z99Ud7+CB942OcnuRGRAOMjhnJRbRrNbQXR/RiJhVpSewP
	 ezFbl8liTWpcghDbNccC4M18EY6qsTKACUn0MxN4RczYGwzvyGSUjnnr+VRVixDi5g
	 fAksKx9h0UVNYQ7GDBw0GhVkg/ds+NgGFMvG7bv28Wg7gwIcpM3O6NcGeUe//lJlAB
	 Oo9X/9JubCQlztVcTpB84ODkUm4Q15rTXofEqh3v9SSubhtpgZMj9F/VF9euGfiYY1
	 jfEOc584pNqomnUlZQ8BBDWzjPG8k0KkhLvH8zc6U25FyqN4U+7zaAyqPNhzq+ALZi
	 sVF3tOhYxDXoA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] tracing/fprobe: Avoid kcalloc() in rcu_read_lock section
Date: Sat, 11 Apr 2026 02:11:48 +0900
Message-ID: <177584110853.388483.637011075513179835.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <177584108931.388483.11311214679686745474.stgit@devnote2>
References: <177584108931.388483.11311214679686745474.stgit@devnote2>
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

fprobe_remove_node_in_module() is called under RCU read locked, but
this invokes kcalloc() if there are more than 8 fprobes installed
on the module. Sashiko warns it because kcalloc() can sleep [1].

 [1] https://sashiko.dev/#/patchset/177552432201.853249.5125045538812833325.stgit%40mhiramat.tok.corp.google.com

To fix this issue, expand the batch size to 128 and do not expand
the fprobe_addr_list, but just cancel walking on fprobe_ip_table,
update fgraph/ftrace_ops and retry the loop again.

Fixes: 0de4c70d04a4 ("tracing: fprobe: use rhltable for fprobe_ip_table")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v4:
  - fix a build error typo in case of CONFIG_DYNAMIC_FTRACE=n.
 Changes in v3:
  - Retry inside rhltable_walk_enter/exit().
  - Rename fprobe_set_ips() to fprobe_remove_ips().
  - Rename 'retry' label to 'again'.
---
 kernel/trace/fprobe.c |   75 ++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index a7c0d5f9016b..799332f865f8 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -346,11 +346,10 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 }
 
 #ifdef CONFIG_MODULES
-static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
-			   int reset)
+static void fprobe_remove_ips(unsigned long *ips, unsigned int cnt)
 {
-	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
-	ftrace_set_filter_ips(&fprobe_ftrace_ops, ips, cnt, remove, reset);
+	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, 1, 0);
+	ftrace_set_filter_ips(&fprobe_ftrace_ops, ips, cnt, 1, 0);
 }
 #endif
 #else
@@ -369,10 +368,9 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 }
 
 #ifdef CONFIG_MODULES
-static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
-			   int reset)
+static void fprobe_remove_ips(unsigned long *ips, unsigned int cnt)
 {
-	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
+	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, 1, 0);
 }
 #endif
 #endif /* !CONFIG_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
@@ -546,7 +544,7 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
 
 #ifdef CONFIG_MODULES
 
-#define FPROBE_IPS_BATCH_INIT 8
+#define FPROBE_IPS_BATCH_INIT 128
 /* instruction pointer address list */
 struct fprobe_addr_list {
 	int index;
@@ -554,45 +552,21 @@ struct fprobe_addr_list {
 	unsigned long *addrs;
 };
 
-static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long addr)
+static int fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
+					 struct fprobe_addr_list *alist)
 {
-	unsigned long *addrs;
-
-	/* Previously we failed to expand the list. */
-	if (alist->index == alist->size)
-		return -ENOSPC;
-
-	alist->addrs[alist->index++] = addr;
-	if (alist->index < alist->size)
+	if (!within_module(node->addr, mod))
 		return 0;
 
-	/* Expand the address list */
-	addrs = kcalloc(alist->size * 2, sizeof(*addrs), GFP_KERNEL);
-	if (!addrs)
-		return -ENOMEM;
-
-	memcpy(addrs, alist->addrs, alist->size * sizeof(*addrs));
-	alist->size *= 2;
-	kfree(alist->addrs);
-	alist->addrs = addrs;
+	if (delete_fprobe_node(node))
+		return 0;
 
+	alist->addrs[alist->index++] = node->addr;
+	if (alist->index == alist->size)
+		return -ENOSPC;
 	return 0;
 }
 
-static void fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
-					 struct fprobe_addr_list *alist)
-{
-	if (!within_module(node->addr, mod))
-		return;
-	if (delete_fprobe_node(node))
-		return;
-	/*
-	 * If failed to update alist, just continue to update hlist.
-	 * Therefore, at list user handler will not hit anymore.
-	 */
-	fprobe_addr_list_add(alist, node->addr);
-}
-
 /* Handle module unloading to manage fprobe_ip_table. */
 static int fprobe_module_callback(struct notifier_block *nb,
 				  unsigned long val, void *data)
@@ -601,6 +575,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	struct fprobe_hlist_node *node;
 	struct rhashtable_iter iter;
 	struct module *mod = data;
+	bool retry;
 
 	if (val != MODULE_STATE_GOING)
 		return NOTIFY_DONE;
@@ -612,18 +587,28 @@ static int fprobe_module_callback(struct notifier_block *nb,
 
 	mutex_lock(&fprobe_mutex);
 	rhltable_walk_enter(&fprobe_ip_table, &iter);
+again:
+	retry = false;
+	alist.index = 0;
 	do {
 		rhashtable_walk_start(&iter);
 
 		while ((node = rhashtable_walk_next(&iter)) && !IS_ERR(node))
-			fprobe_remove_node_in_module(mod, node, &alist);
+			if (fprobe_remove_node_in_module(mod, node, &alist) < 0) {
+				retry = true;
+				break;
+			}
 
 		rhashtable_walk_stop(&iter);
-	} while (node == ERR_PTR(-EAGAIN));
-	rhashtable_walk_exit(&iter);
+	} while (node == ERR_PTR(-EAGAIN) && !retry);
+	/* Remove any ips from hash table(s) */
+	if (alist.index > 0) {
+		fprobe_remove_ips(alist.addrs, alist.index);
+		if (retry)
+			goto again;
+	}
 
-	if (alist.index > 0)
-		fprobe_set_ips(alist.addrs, alist.index, 1, 0);
+	rhashtable_walk_exit(&iter);
 	mutex_unlock(&fprobe_mutex);
 
 	kfree(alist.addrs);

