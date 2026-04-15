Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08202288CB;
	Wed, 15 Apr 2026 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247748; cv=none; b=SuKl+YNxi02AF0cz8xzncnBXd0Dk1sAArZF7i0MPhy0tEmvhFMLIJ60PT4hGy1i1C1dtnEpd3xouFcmcNQ/llGDumQjAfa1NVbe9gPEKcF3JTm7DsCPQKixOjz+7l6wD3ggwFqKsBPbWPB/QpD+MEC5vhc3pnFvNp3CRo67BY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247748; c=relaxed/simple;
	bh=mnYd09qAmaj7dYWhLmi8/ZAR5RiHiWstovDXsHiPbkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asFTZGYAvQfpqT1Mjf03KGZy68JyXa1ZTIg12Sw4G7u1VjgO3SVjdlJciiOBxQrfpxDByK3HKwKkxOOiXgTRAm44M3hN3u2F5EMA7rIatsZMIuzAaXIa3ieUsqpnnVkmWb2dERBFzNCm8TrE9XFLqYx11j0uG+Rnawqj8eTF8Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3x5/Zcn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3x5/Zcn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589E3C19424;
	Wed, 15 Apr 2026 10:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247748;
	bh=mnYd09qAmaj7dYWhLmi8/ZAR5RiHiWstovDXsHiPbkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f3x5/ZcnlbL78K3Y1jw9RlyZOLdOBHC2IxvPD1dA97NPP9e9ynZ0gd9PAvq9D+WIY
	 rlWNnawKRX9MuQKXtOwpeBlWR5jJuplQ17G2RfGuJESVicVPSMAHLzHQG06JHdBEzY
	 DX1DA98xALpwO7qcF2DMKKbBqpTpnLI+S2ieLaGaRoQBbfFo9Qpi8UxMcXITZNCqT/
	 fUAsgSg05NFLpegP354jnNFSvcolMuYlvopmEXCdIFskow4I/ZpJiCIEoohCMcySJ2
	 OyadKG7T3JIF6iqrE/Y15MAkKFYBM+yh/L9qwFIK/wdIAZ+mfoUxb2Rolof4ngNg2g
	 8XjBBMHU4tLyg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 4/6] tracing/fprobe: Avoid kcalloc() in rcu_read_lock section
Date: Wed, 15 Apr 2026 19:09:05 +0900
Message-ID:  <177624774567.2407691.4607367874855149551.stgit@mhiramat.tok.corp.google.com>
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
 Changes in v6:
  - Retry outside rhltable_walk_enter/exit() again.
 Changes in v5:
  - Skip updating ftrace_ops when fails to allocate memory in module
    unloading.
 Changes in v4:
  - fix a build error typo in case of CONFIG_DYNAMIC_FTRACE=n.
 Changes in v3:
  - Retry inside rhltable_walk_enter/exit().
  - Rename fprobe_set_ips() to fprobe_remove_ips().
  - Rename 'retry' label to 'again'.
---
 kernel/trace/fprobe.c |   92 ++++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 47 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index c58e41b2da8e..0df8e003e88e 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -343,11 +343,10 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
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
@@ -366,10 +365,9 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
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
@@ -543,7 +541,7 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
 
 #ifdef CONFIG_MODULES
 
-#define FPROBE_IPS_BATCH_INIT 8
+#define FPROBE_IPS_BATCH_INIT 128
 /* instruction pointer address list */
 struct fprobe_addr_list {
 	int index;
@@ -551,45 +549,24 @@ struct fprobe_addr_list {
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
+	/* If no address list is available, we can't track this address. */
+	if (!alist->addrs)
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
@@ -598,29 +575,50 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	struct fprobe_hlist_node *node;
 	struct rhashtable_iter iter;
 	struct module *mod = data;
+	bool retry;
 
 	if (val != MODULE_STATE_GOING)
 		return NOTIFY_DONE;
 
 	alist.addrs = kcalloc(alist.size, sizeof(*alist.addrs), GFP_KERNEL);
-	/* If failed to alloc memory, we can not remove ips from hash. */
-	if (!alist.addrs)
-		return NOTIFY_DONE;
+	/*
+	 * If failed to alloc memory, ftrace_ops will not be able to remove ips from
+	 * hash, but we can still remove nodes from fprobe_ip_table, so we can avoid
+	 * the potential wrong callback. So just print a warning here and try to
+	 * continue without address list.
+	 */
+	WARN_ONCE(!alist.addrs,
+		"Failed to allocate memory for fprobe_addr_list, ftrace_ops will not be updated");
 
 	mutex_lock(&fprobe_mutex);
+again:
+	retry = false;
+	alist.index = 0;
 	rhltable_walk_enter(&fprobe_ip_table, &iter);
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
+	} while (node == ERR_PTR(-EAGAIN) && !retry);
 	rhashtable_walk_exit(&iter);
+	/* Remove any ips from hash table(s) */
+	if (alist.index > 0) {
+		fprobe_remove_ips(alist.addrs, alist.index);
+		/*
+		 * If we break rhashtable walk loop except for -EAGAIN, we need
+		 * to restart looping from start for safety. Anyway, this is
+		 * not a hotpath.
+		 */
+		if (retry)
+			goto again;
+	}
 
-	if (alist.index > 0)
-		fprobe_set_ips(alist.addrs, alist.index, 1, 0);
 	mutex_unlock(&fprobe_mutex);
 
 	kfree(alist.addrs);

