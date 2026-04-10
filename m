Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DEB3E314F;
	Fri, 10 Apr 2026 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841123; cv=none; b=b/i8w1AnD58d560638ltxuGF7mTLEmyZ2OiX5VzRVhn5OqH080Xr792xW+dmeg3Q/zrExJ/RnZxUg9AkjSyNtxVxXKgRgmCv4NrUsui6KX3ESKlTfYGTw3+tu5bVg9HKNbMhsJVEbNlYQMb7412HEaRXZ49D95rAGCKX529KXGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841123; c=relaxed/simple;
	bh=HGnNaiPjP8ZtBLC/bBwOU7J5HGe5OgE6j20D6I08n2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z4rey8TToIUCUuMxz6JNV682bMctcsdKqG8pXBsXe6alZxqre8GVrBel3xii4CGld8mtM2IQr92jNhVd2xDiQZz/T1ccyEaUsh6+MXaVs5tQMQYn/C5hZqjSue+D4H267zrwbXxlcepwh/98uufboHOW3zvHDcC52+jhRvT16Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgEB4D03; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgEB4D03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EACC19421;
	Fri, 10 Apr 2026 17:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775841123;
	bh=HGnNaiPjP8ZtBLC/bBwOU7J5HGe5OgE6j20D6I08n2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OgEB4D03+wU5IhYnWVws37+TmUNnXzQYuHTMbYHOSQQmS8X2cII8ANJ7fDK/H/D1Q
	 a9zor+d35SkO1cUd0DaAr+5nUJnz0uNBGne1uKMJblHg9M8xaG+M3gk7JBdlHUAgdr
	 m7PJvPcbxJ2J4WKgZdBTGbTD+d8pZwA/4L2ECA0lc6rzno16HyR8g3mCN4LRQYO9r5
	 AERWwkUnRptGTZljlbsi63Z6Ck4FtARMcYiNy1q7cTc3Wo/teLZb5CLxvPZDGV7yfM
	 HYFNwecFxf+Uo0WHRSCXi2Y3akaJT8in00rwCDyjyQtXQtK8pX8H4edB5wVfsQyrDB
	 o1ww141P0IULQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] tracing/fprobe: Check the same type fprobe on table as the unregistered one
Date: Sat, 11 Apr 2026 02:11:58 +0900
Message-ID: <177584111887.388483.3432533037945624434.stgit@devnote2>
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

Commit 2c67dc457bc6 ("tracing: fprobe: optimization for entry only case")
introduced a different ftrace_ops for entry-only fprobes.

However, when unregistering an fprobe, the kernel only checks if another
fprobe exists at the same address, without checking which type of fprobe
it is.
If different fprobes are registered at the same address, the same address
will be registered in both fgraph_ops and ftrace_ops, but only one of
them will be deleted when unregistering. (the one removed first will not
be deleted from the ops).

This results in junk entries remaining in either fgraph_ops or ftrace_ops.
For example:
 =======
 cd /sys/kernel/tracing

 # 'Add entry and exit events on the same place'
 echo 'f:event1 vfs_read' >> dynamic_events
 echo 'f:event2 vfs_read%return' >> dynamic_events

 # 'Enable both of them'
 echo 1 > events/fprobes/enable
 cat enabled_functions
vfs_read (2)            ->arch_ftrace_ops_list_func+0x0/0x210

 # 'Disable and remove exit event'
 echo 0 > events/fprobes/event2/enable
 echo -:event2 >> dynamic_events

 # 'Disable and remove all events'
 echo 0 > events/fprobes/enable
 echo > dynamic_events

 # 'Add another event'
 echo 'f:event3 vfs_open%return' > dynamic_events
 cat dynamic_events
f:fprobes/event3 vfs_open%return

 echo 1 > events/fprobes/enable
 cat enabled_functions
vfs_open (1)            tramp: 0xffffffffa0001000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60    subops: {ent:fprobe_fgraph_entry+0x0/0x620 ret:fprobe_return+0x0/0x150}
vfs_read (1)            tramp: 0xffffffffa0001000 (ftrace_graph_func+0x0/0x60) ->ftrace_graph_func+0x0/0x60    subops: {ent:fprobe_fgraph_entry+0x0/0x620 ret:fprobe_return+0x0/0x150}
 =======

As you can see, an entry for the vfs_read remains.

To fix this issue, when unregistering, the kernel should also check if
there is the same type of fprobes still exist at the same address, and
if not, delete its entry from either fgraph_ops or ftrace_ops.

Fixes: 2c67dc457bc6 ("tracing: fprobe: optimization for entry only case")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |   82 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 799332f865f8..2cac2252f78f 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -92,11 +92,8 @@ static int insert_fprobe_node(struct fprobe_hlist_node *node, struct fprobe *fp)
 	return ret;
 }
 
-/* Return true if there are synonims */
-static bool delete_fprobe_node(struct fprobe_hlist_node *node)
+static void delete_fprobe_node(struct fprobe_hlist_node *node)
 {
-	bool ret;
-
 	lockdep_assert_held(&fprobe_mutex);
 
 	/* Avoid double deleting and non-inserted nodes */
@@ -105,13 +102,6 @@ static bool delete_fprobe_node(struct fprobe_hlist_node *node)
 		rhltable_remove(&fprobe_ip_table, &node->hlist,
 				fprobe_rht_params);
 	}
-
-	rcu_read_lock();
-	ret = !!rhltable_lookup(&fprobe_ip_table, &node->addr,
-				fprobe_rht_params);
-	rcu_read_unlock();
-
-	return ret;
 }
 
 /* Check existence of the fprobe */
@@ -345,6 +335,32 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 	return !fp->exit_handler;
 }
 
+static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace)
+{
+	struct rhlist_head *head, *pos;
+	struct fprobe_hlist_node *node;
+	struct fprobe *fp;
+
+	guard(rcu)();
+	head = rhltable_lookup(&fprobe_ip_table, &ip,
+				fprobe_rht_params);
+	if (!head)
+		return false;
+	/* We have to check the same type on the list. */
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
+		if (node->addr != ip)
+			break;
+		fp = READ_ONCE(node->fp);
+		if (likely(fp)) {
+			if ((!ftrace && fp->exit_handler) ||
+			    (ftrace && !fp->exit_handler))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 #ifdef CONFIG_MODULES
 static void fprobe_remove_ips(unsigned long *ips, unsigned int cnt)
 {
@@ -367,6 +383,29 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 	return false;
 }
 
+static bool fprobe_exists_on_hash(unsigned long ip, bool ftrace __maybe_unused)
+{
+	struct rhlist_head *head, *pos;
+	struct fprobe_hlist_node *node;
+	struct fprobe *fp;
+
+	guard(rcu)();
+	head = rhltable_lookup(&fprobe_ip_table, &ip,
+				fprobe_rht_params);
+	if (!head)
+		return false;
+	/* We only need to check fp is there. */
+	rhl_for_each_entry_rcu(node, pos, head, hlist) {
+		if (node->addr != ip)
+			break;
+		fp = READ_ONCE(node->fp);
+		if (likely(fp))
+			return true;
+	}
+
+	return false;
+}
+
 #ifdef CONFIG_MODULES
 static void fprobe_remove_ips(unsigned long *ips, unsigned int cnt)
 {
@@ -555,15 +594,22 @@ struct fprobe_addr_list {
 static int fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
 					 struct fprobe_addr_list *alist)
 {
+	lockdep_assert_in_rcu_read_lock();
+
 	if (!within_module(node->addr, mod))
 		return 0;
 
-	if (delete_fprobe_node(node))
-		return 0;
+	delete_fprobe_node(node);
+	/*
+	 * Don't care the type here, because all fprobes on the same
+	 * address must be removed eventually.
+	 */
+	if (!rhltable_lookup(&fprobe_ip_table, &node->addr, fprobe_rht_params)) {
+		alist->addrs[alist->index++] = node->addr;
+		if (alist->index == alist->size)
+			return -ENOSPC;
+	}
 
-	alist->addrs[alist->index++] = node->addr;
-	if (alist->index == alist->size)
-		return -ENOSPC;
 	return 0;
 }
 
@@ -915,7 +961,9 @@ static int unregister_fprobe_nolock(struct fprobe *fp)
 	/* Remove non-synonim ips from table and hash */
 	count = 0;
 	for (i = 0; i < hlist_array->size; i++) {
-		if (!delete_fprobe_node(&hlist_array->array[i]))
+		delete_fprobe_node(&hlist_array->array[i]);
+		if (!fprobe_exists_on_hash(hlist_array->array[i].addr,
+					   fprobe_is_ftrace(fp)))
 			addrs[count++] = hlist_array->array[i].addr;
 	}
 	del_fprobe_hash(fp);

