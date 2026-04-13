Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F443AB271;
	Mon, 13 Apr 2026 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069599; cv=none; b=JIdgLB/m3qfq0RWE2jEvCiwvxGWraAf1D7dNswVvxw1W4oqZFC/CVdMR6xFS+2pvHbR5XpfjBfCWAwnrJJ6dRIHrhXXq+LfDFyBomAdEzAWdS2KQAqzVy5OVDQYTqmHhi71VCSvZoqxTs0lfZEiLG6BR422vp1Ax+jnGVmz9yqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069599; c=relaxed/simple;
	bh=q2p6Urce9GMFfNXtX2/9C/Xdoad61fnHAfOix50SLQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcPYaoU4CcPugfkcLTUeGDUGOqxF6EdEEojAlDKGb82ejBg7eaKdYSJDKJbX8uC4HPNxQCBGBWHecu57FUEd1uY0N+IKVphu9C1MPuD1V9gFtH+wmQ976v3nPxHmKLIAv5J0M9E1/zKQQjr0s/sbqa8zBdh705OWn6qiTGxEKhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcaP7zPZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcaP7zPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C89C116C6;
	Mon, 13 Apr 2026 08:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776069599;
	bh=q2p6Urce9GMFfNXtX2/9C/Xdoad61fnHAfOix50SLQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcaP7zPZKmpouNYetBeCue0JZPohrMMqftblW2SX0NQjM9+gB9jGM2YXV95vtwSBF
	 LwsTgJ1tUl7ic+o5g6GbSS/SD2A4lB1hIN1GaJcFyeJheWJCRCRdOEyRTmajvXF9tl
	 QZ60wy56kqAGX8e23NKBKgRLZwhBWOOyrpZrI4M9tUp7eC34ABtRtSY/Wi3kHbno13
	 eZ7G1NCOaJZanEArJXtxP+DKvTejJm3xBd6MPoHv4uh0AkakY2uU3EdHvrUO9k6Vwi
	 ZJalpA1WH4a/31Sz/eQVqyPJsGLEIiNzmDJSnm0M6+rY7mAHGUocKIcMGQOGbEYbGt
	 7YDo5Lo+jObtg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] tracing/fprobe: Check the same type fprobe on table as the unregistered one
Date: Mon, 13 Apr 2026 17:39:54 +0900
Message-ID: <177606959485.929411.16337975722137102756.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <177606956628.929411.17392736689322577701.stgit@devnote2>
References: <177606956628.929411.17392736689322577701.stgit@devnote2>
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
 kernel/trace/fprobe.c |   85 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index b5ce98d2ea96..19c5b65ed5fb 100644
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
@@ -555,18 +594,25 @@ struct fprobe_addr_list {
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
 	/* If no address list is available, we can't track this address. */
 	if (!alist->addrs)
 		return 0;
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
 
@@ -924,10 +970,9 @@ static int unregister_fprobe_nolock(struct fprobe *fp, bool force)
 	/* Remove non-synonim ips from table and hash */
 	count = 0;
 	for (i = 0; i < hlist_array->size; i++) {
-		if (delete_fprobe_node(&hlist_array->array[i]))
-			continue;
-
-		if (addrs)
+		delete_fprobe_node(&hlist_array->array[i]);
+		if (addrs && !fprobe_exists_on_hash(hlist_array->array[i].addr,
+						    fprobe_is_ftrace(fp)))
 			addrs[count++] = hlist_array->array[i].addr;
 	}
 	del_fprobe_hash(fp);

