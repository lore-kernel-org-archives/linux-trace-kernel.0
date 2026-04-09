Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10993B19CC;
	Thu,  9 Apr 2026 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775730959; cv=none; b=AZLtkVldGheoSrp6BrB/TwqNfAuzbN6vdE6jy/8gp6X9o5yD3m2gDNdlnOyBao+P1B6DKPDZJTrz2k4QqnOKagbYEWRcLHBNnJR3jN0zexIUT0UVDOZkR5U6YqnYOia8cyRxTdMLNKbSBu3vCbeHgDAmtPqHNJtSYQ/Bxt/kYDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775730959; c=relaxed/simple;
	bh=jLLIzO0lHDytPt2LFhW/BG1p5Yty3TeWOGHh66KheC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Arr8eQrUoVvG9RtW9dxrxuRcOcpc0x/biKeAacyiLAor3enbmjE5V80f9vzWb+GmAjTwJZ+vzWyfKlOFbijTLAvdSkXdnhWDF9eQEjKnI5IV/Jzx0E4h9WOKDkVR/UzFY6/VlCkzfuVu0JmCG2XC/lcGC8waGptX6n2hd0AiVdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atrARjuu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atrARjuu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947D5C4CEF7;
	Thu,  9 Apr 2026 10:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775730959;
	bh=jLLIzO0lHDytPt2LFhW/BG1p5Yty3TeWOGHh66KheC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atrARjuuAtQKn0hBc10IbDe3rZfVDBKXafRKXf1W2Ao7n5WuRskq2aKMVTOVxm6vJ
	 cLfwMNU1nNuAk+9bXicnC+bR8ZDo3lbeLbEHlREySWy87LJOyR5C6b/lwgNLoe3vzE
	 y3wXzo2KZCvj+XAV/dqSRq1HURatRpoWsVXNAFFqy052ZNB4vkPtWTFSn5WvxzsCWu
	 ZkRJ4Cn5LJChppSwRzqcXSyh20oAMXT4dNSihXE5LLv55dVJW3XqI9E/8SxiEmvVtS
	 wUAiIhOV5Ia1WZTWA/id0JSACw1ndE5gx8VUNSyalc32MJKGpSFio7g8Y7I6/zpIoH
	 omzLoTAJOQesg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] tracing/fprobe: Avoid kcalloc() in rcu_read_lock section
Date: Thu,  9 Apr 2026 19:35:57 +0900
Message-ID:  <177573095696.3666478.4412068539797028855.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
In-Reply-To:  <177573094819.3666478.11900825120958856397.stgit@mhiramat.tok.corp.google.com>
References:  <177573094819.3666478.11900825120958856397.stgit@mhiramat.tok.corp.google.com>
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
 kernel/trace/fprobe.c |   53 ++++++++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 56d145017902..058cf6ef7ebb 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -536,7 +536,7 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
 
 #ifdef CONFIG_MODULES
 
-#define FPROBE_IPS_BATCH_INIT 8
+#define FPROBE_IPS_BATCH_INIT 128
 /* instruction pointer address list */
 struct fprobe_addr_list {
 	int index;
@@ -544,45 +544,21 @@ struct fprobe_addr_list {
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
@@ -591,6 +567,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	struct fprobe_hlist_node *node;
 	struct rhashtable_iter iter;
 	struct module *mod = data;
+	bool retry;
 
 	if (val != MODULE_STATE_GOING)
 		return NOTIFY_DONE;
@@ -600,13 +577,19 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	if (!alist.addrs)
 		return NOTIFY_DONE;
 
+retry:
+	retry = false;
+	alist.index = 0;
 	mutex_lock(&fprobe_mutex);
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
 	} while (node == ERR_PTR(-EAGAIN));
@@ -615,6 +598,8 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	if (alist.index > 0)
 		fprobe_set_ips(alist.addrs, alist.index, 1, 0);
 	mutex_unlock(&fprobe_mutex);
+	if (retry)
+		goto retry;
 
 	kfree(alist.addrs);
 

