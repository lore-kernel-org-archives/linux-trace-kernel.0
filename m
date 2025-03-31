Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C07219A86;
	Mon, 31 Mar 2025 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435349; cv=none; b=u6q75kbTbvCxw9E/Mw+OfPpKKCM6Hcrtdb914o+MYTprxdxfsjvE0zJYahOZwW/AEd8TrOU4Qj58X/EmXpjvaxaie8OWJouKOoRKdDYzbF77mr15Nw/xZXCZPbXnVCqncourjCmTKqT9Q8r45BUw9aTriYs95uOOI4wbNqqAqaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435349; c=relaxed/simple;
	bh=yQOq3ijcsgaMxYFKtUgpeKZ8mf3Gj6j+uhFM2nMXZhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPlCNovo02EMh5Ulo/rLvkxW7eYH7nq668uFAKst5Hj5GCzGb0MLybf6Hmb5zkWg1hw2lJf49ATyGiaUkoXAHDu2OccHi1F5O6wiC6FQl1RwOIbIadCwAWOqTvG61Z8775H+7c/0kRRzuUi5wNM/Suu8YcEhOunY258Nwk4/S14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rioaz8vk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rioaz8vk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252A7C4CEE3;
	Mon, 31 Mar 2025 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743435348;
	bh=yQOq3ijcsgaMxYFKtUgpeKZ8mf3Gj6j+uhFM2nMXZhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rioaz8vkZNdXF9T1FmhfNh5z/DvmbSYRKntVxDloT71HcNkzizVz2rCzCdX5/Ga8h
	 oqOjmNOMSD2jt5S+hY4Bwl4PnayumN0Zs0fb8LyDtXV9nvebk+ZiSkWSykvq8jzffg
	 OGt6WT1jjSz0dXscwliatzS9DPdjMF+VIyeg9sTFxNj8Y31lC7L9Np9StAV4XywgE5
	 KZcfKIG8TP/l5R4AgI42vuT63qnmc91i/+6vC6NNxM+rinK44u6Yybck2a3CLMssE+
	 ROuc+8vNjhIfgdDuw6kqPFq7FSdNlW3MkcwuLUG6oVLbhlE6e1Ly4G1XbCq3L3sYs/
	 HgrsHop5gIeCw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] tracing: fprobe: Cleanup fprobe hash when module unloading
Date: Tue,  1 Apr 2025 00:35:44 +0900
Message-ID: <174343534473.843280.13988101014957210732.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <174343532655.843280.15317319860632975273.stgit@devnote2>
References: <174343532655.843280.15317319860632975273.stgit@devnote2>
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

Cleanup fprobe address hash table on module unloading because the
target symbols will be disappeared when unloading module and not
sure the same symbol is mapped on the same address.

Note that this is at least disables the fprobes if a part of target
symbols on the unloaded modules. Unlike kprobes, fprobe does not
re-enable the probe point by itself. To do that, the caller should
take care register/unregister fprobe when loading/unloading modules.
This simplifies the fprobe state managememt related to the module
loading/unloading.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |  103 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index cb86f90d4b1e..95c6e3473a76 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -89,8 +89,11 @@ static bool delete_fprobe_node(struct fprobe_hlist_node *node)
 {
 	lockdep_assert_held(&fprobe_mutex);
 
-	WRITE_ONCE(node->fp, NULL);
-	hlist_del_rcu(&node->hlist);
+	/* Avoid double deleting */
+	if (READ_ONCE(node->fp) != NULL) {
+		WRITE_ONCE(node->fp, NULL);
+		hlist_del_rcu(&node->hlist);
+	}
 	return !!find_first_fprobe_node(node->addr);
 }
 
@@ -411,6 +414,102 @@ static void fprobe_graph_remove_ips(unsigned long *addrs, int num)
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops, addrs, num, 1, 0);
 }
 
+#ifdef CONFIG_MODULES
+
+#define FPROBE_IPS_BATCH_INIT 8
+/* instruction pointer address list */
+struct fprobe_addr_list {
+	int index;
+	int size;
+	unsigned long *addrs;
+};
+
+static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long addr)
+{
+	unsigned long *addrs;
+
+	if (alist->index >= alist->size)
+		return -ENOMEM;
+
+	alist->addrs[alist->index++] = addr;
+	if (alist->index < alist->size)
+		return 0;
+
+	/* Expand the address list */
+	addrs = kcalloc(alist->size * 2, sizeof(*addrs), GFP_KERNEL);
+	if (!addrs)
+		return -ENOMEM;
+
+	memcpy(addrs, alist->addrs, alist->size * sizeof(*addrs));
+	alist->size *= 2;
+	kfree(alist->addrs);
+	alist->addrs = addrs;
+
+	return 0;
+}
+
+static void fprobe_remove_node_in_module(struct module *mod, struct hlist_head *head,
+					struct fprobe_addr_list *alist)
+{
+	struct fprobe_hlist_node *node;
+	int ret = 0;
+
+	hlist_for_each_entry_rcu(node, head, hlist) {
+		if (!within_module(node->addr, mod))
+			continue;
+		if (delete_fprobe_node(node))
+			continue;
+		/*
+		 * If failed to update alist, just continue to update hlist.
+		 * Therefore, at list user handler will not hit anymore.
+		 */
+		if (!ret)
+			ret = fprobe_addr_list_add(alist, node->addr);
+	}
+}
+
+/* Handle module unloading to manage fprobe_ip_table. */
+static int fprobe_module_callback(struct notifier_block *nb,
+				  unsigned long val, void *data)
+{
+	struct fprobe_addr_list alist = {.size = FPROBE_IPS_BATCH_INIT};
+	struct module *mod = data;
+	int i;
+
+	if (val != MODULE_STATE_GOING)
+		return NOTIFY_DONE;
+
+	alist.addrs = kcalloc(alist.size, sizeof(*alist.addrs), GFP_KERNEL);
+	/* If failed to alloc memory, we can not remove ips from hash. */
+	if (!alist.addrs)
+		return NOTIFY_DONE;
+
+	mutex_lock(&fprobe_mutex);
+	for (i = 0; i < FPROBE_IP_TABLE_SIZE; i++)
+		fprobe_remove_node_in_module(mod, &fprobe_ip_table[i], &alist);
+
+	if (alist.index < alist.size && alist.index > 0)
+		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
+				      alist.addrs, alist.index, 1, 0);
+	mutex_unlock(&fprobe_mutex);
+
+	kfree(alist.addrs);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block fprobe_module_nb = {
+	.notifier_call = fprobe_module_callback,
+	.priority = 0,
+};
+
+static int __init init_fprobe_module(void)
+{
+	return register_module_notifier(&fprobe_module_nb);
+}
+early_initcall(init_fprobe_module);
+#endif
+
 static int symbols_cmp(const void *a, const void *b)
 {
 	const char **str_a = (const char **) a;

