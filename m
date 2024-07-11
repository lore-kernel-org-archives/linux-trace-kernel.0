Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95A15B0F0;
	Thu, 11 Jul 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696051; cv=none; b=KyUQAUU1CmreE0NTj1Xx0uJKHFzO+hWCRjHBTd1H5rWg6n5qHzGJJyXUrcuobSHcatSRP1piTyeUM2jTPSGXyyWoQg76AlXlAcsy0SLFsDToW+k5NKBBL6+K7e6IBQq6e5oDW1BdHQ7DgeSRSmn+2jS9vK2JexuTTsZDS4anj4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696051; c=relaxed/simple;
	bh=nf9OJKCU1+T+PW3uEaHa/oMWagtwoT8LK4SH6ZDVVn4=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ii8sTCHxQS6YbgAkb44S4fqRwuOtweFEgpchi0qFb+PgAKeb08WHpBHlxuBr4MzxVyfj6K0N8jL/3YOApHUJxw6M/KHYIzqFEbHogSOAqhHlqMcWwnfHJjcgov46DCmnnKdANKH4SDXqt6l2a+dBDGtrlvnkPudF6guolmnBkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pIYoSkuG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pIYoSkuG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=sauT9IQp+lYdD7ir99ipRaTNhTpKArZ3iIMwq8bpAT8=; b=pIYoSkuGCeGYIdMvoUZ2X5zTQW
	VJN06xf/AsY2N+6fFwfab8OnR8ZeRCcrxM28RDAA13JmSgxFitOvJaCVt/o/uc304ghe1pZkNF8CO
	IF84HqbhFLmQLtRheE88k84Kt7P2bWZJLJ9ADsc1HnqdI5LZvQ06ucIVl1+028bUp25zUZ1Xb/nzh
	98LA82KFwKUiZJ+LKWzf6AmOQiyJBFnQVXFsbaB/MGOm4baztVUnjlbPpiCFXtVL9bXB+Wfx77T9O
	Urj51FyPUDD0dFNqEQhZ6WpLIfa3ZVT2hfOHo2eacG0aue3hmyy5A45m08wQna9tKCPByVNDC+dF4
	4ZgkfSAA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRrdz-0000000Ax6S-23mQ;
	Thu, 11 Jul 2024 11:07:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id BC9F7300E46; Thu, 11 Jul 2024 13:07:22 +0200 (CEST)
Message-Id: <20240711110400.529465037@infradead.org>
User-Agent: quilt/0.65
Date: Thu, 11 Jul 2024 13:02:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 andrii@kernel.org,
 oleg@redhat.com
Cc: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 peterz@infradead.org,
 rostedt@goodmis.org,
 mhiramat@kernel.org,
 jolsa@kernel.org,
 clm@meta.com,
 paulmck@kernel.org
Subject: [PATCH v2 03/11] rbtree: Provide rb_find_rcu() / rb_find_add_rcu()
References: <20240711110235.098009979@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Much like latch_tree, add two RCU methods for the regular RB-tree,
which can be used in conjunction with a seqcount to provide lockless
lookups.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/rbtree.h |   67 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -245,6 +245,42 @@ rb_find_add(struct rb_node *node, struct
 }
 
 /**
+ * rb_find_add_rcu() - find equivalent @node in @tree, or add @node
+ * @node: node to look-for / insert
+ * @tree: tree to search / modify
+ * @cmp: operator defining the node order
+ *
+ * Adds a Store-Release for link_node.
+ *
+ * Returns the rb_node matching @node, or NULL when no match is found and @node
+ * is inserted.
+ */
+static __always_inline struct rb_node *
+rb_find_add_rcu(struct rb_node *node, struct rb_root *tree,
+		int (*cmp)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+	int c;
+
+	while (*link) {
+		parent = *link;
+		c = cmp(node, parent);
+
+		if (c < 0)
+			link = &parent->rb_left;
+		else if (c > 0)
+			link = &parent->rb_right;
+		else
+			return parent;
+	}
+
+	rb_link_node_rcu(node, parent, link);
+	rb_insert_color(node, tree);
+	return NULL;
+}
+
+/**
  * rb_find() - find @key in tree @tree
  * @key: key to match
  * @tree: tree to search
@@ -268,6 +304,37 @@ rb_find(const void *key, const struct rb
 		else
 			return node;
 	}
+
+	return NULL;
+}
+
+/**
+ * rb_find_rcu() - find @key in tree @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining the node order
+ *
+ * Notably, tree descent vs concurrent tree rotations is unsound and can result
+ * in false-negatives.
+ *
+ * Returns the rb_node matching @key or NULL.
+ */
+static __always_inline struct rb_node *
+rb_find_rcu(const void *key, const struct rb_root *tree,
+	    int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+
+	while (node) {
+		int c = cmp(key, node);
+
+		if (c < 0)
+			node = rcu_dereference_raw(node->rb_left);
+		else if (c > 0)
+			node = rcu_dereference_raw(node->rb_right);
+		else
+			return node;
+	}
 
 	return NULL;
 }


