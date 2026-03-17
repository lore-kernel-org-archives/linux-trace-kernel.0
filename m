Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF6E2F6170;
	Tue, 17 Mar 2026 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763782; cv=pass; b=IryvqZv/ilFwS6ff+emaOYolBisGUhAbAXfGxQl62tsYlwG1pDfkNkXBdu9k77AFgs05gxLJBi7RZcFIwhPI2eOWxyzM5uow55rglYBB61hxi/GvSQsKbS8ghp44oZBpGvd87nVFqo25ustasCTodEgKaGVPtQBmuvw2vVtP3Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763782; c=relaxed/simple;
	bh=wv78ftcSG/DocPbKu+mkVk4aNLSvNs5rs+zIciiAp0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kyJjQ3yoZrLgHBezfW2KkPVoMbwcFDrqsFso10z3Js9Ii9VIlDA2yDLhJzgIdLC2bi+WKCJBA1glh6KBfKeBcB/zT7UgwWvYMZxvCIt8zG2crgHmWCDdMXiDS5UDmheWbVA3mwh0HqsQ3D3yQXfnj2gqoMg+2Em8h8Ad3rTnUd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=dej2vRK5; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="dej2vRK5"
ARC-Seal: i=1; a=rsa-sha256; t=1773763759; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=OJcxc7qLHLs8sRYj7Ih3Rh58ym9+gkK8YMS8+wKcxjcfEDXE5a4RL6nJyB7L9JZ6wER3tLHcpI95J0CsRbIvRAsQdp+0Qr7Lq1KO7MuLDlK74l5Ibxsrh0TDOiy2Pxx5PczHDUh0VsGHpPlf0soMp50sLtEz7ZpICdqDSHpEovQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773763759; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=G9gVzURcM86LqCKwgrK/9/RXrE3VSY5wkHPGGwsPo4M=; 
	b=DeUud1AMmMCeDe8d0Ve/yzcqsDsoDRBezwKOIPVsKiLu1a+WOU4j2qKYAjbWl0YOzo7deBRUcnt5W7ULxChYm7O0SVwjCd3QwEplW8s70gaeu2cJemzX4vrwgpyOGCEZx+ThX6PCayRo7HNLrn857cW5Bj3MgfilVJEZQWzIddQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773763759;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=G9gVzURcM86LqCKwgrK/9/RXrE3VSY5wkHPGGwsPo4M=;
	b=dej2vRK5YIolEsvjvaZEXFCAo061jdLT59osDi3RBCgL0YY+y6puAQi9T19mexn7
	jZQPd6B0Z+qoTMIv+grgMYdbcQR+klbRq8atb/9arQeTVB8u3866gdPIPwqBXSvxbWu
	8MOmYHzaBgjCWCfosn2fT28haZhaU1a6IVlRgXfA=
Received: by mx.zoho.eu with SMTPS id 1773763758311344.17738613208166;
	Tue, 17 Mar 2026 17:09:18 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 01/15] lib/bootconfig: clean up comment typos and bracing
Date: Tue, 17 Mar 2026 16:09:02 +0000
Message-Id: <20260317160916.33576-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317160916.33576-1-objecting@objecting.org>
References: <20260317160916.33576-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fixes kerneldoc typos ("initiized" and "uder") and adds a missing blank line.
Also fixes inconsistent if/else bracing in __xbc_add_key() and elsewhere.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index b0ef1e74e98a..d77b6533ac00 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -79,6 +79,7 @@ static inline void xbc_free_mem(void *addr, size_t size, bool early)
 	free(addr);
 }
 #endif
+
 /**
  * xbc_get_info() - Get the information of loaded boot config
  * @node_size: A pointer to store the number of nodes.
@@ -112,7 +113,7 @@ static int __init xbc_parse_error(const char *msg, const char *p)
  * xbc_root_node() - Get the root node of extended boot config
  *
  * Return the address of root node of extended boot config. If the
- * extended boot config is not initiized, return NULL.
+ * extended boot config is not initialized, return NULL.
  */
 struct xbc_node * __init xbc_root_node(void)
 {
@@ -364,7 +365,7 @@ struct xbc_node * __init xbc_node_find_next_leaf(struct xbc_node *root,
 			node = xbc_node_get_parent(node);
 			if (node == root)
 				return NULL;
-			/* User passed a node which is not uder parent */
+			/* User passed a node which is not under parent */
 			if (WARN_ON(!node))
 				return NULL;
 		}
@@ -472,8 +473,9 @@ static struct xbc_node * __init __xbc_add_sibling(char *data, uint32_t flag, boo
 				sib->next = xbc_node_index(node);
 			}
 		}
-	} else
+	} else {
 		xbc_parse_error("Too many nodes", data);
+	}
 
 	return node;
 }
@@ -655,9 +657,9 @@ static int __init __xbc_add_key(char *k)
 	if (unlikely(xbc_node_num == 0))
 		goto add_node;
 
-	if (!last_parent)	/* the first level */
+	if (!last_parent) {	/* the first level */
 		node = find_match_node(xbc_nodes, k);
-	else {
+	} else {
 		child = xbc_node_get_child(last_parent);
 		/* Since the value node is the first child, skip it. */
 		if (child && xbc_node_is_value(child))
@@ -665,9 +667,9 @@ static int __init __xbc_add_key(char *k)
 		node = find_match_node(child, k);
 	}
 
-	if (node)
+	if (node) {
 		last_parent = node;
-	else {
+	} else {
 add_node:
 		node = xbc_add_child(k, XBC_KEY);
 		if (!node)
@@ -991,8 +993,9 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 		if (emsg)
 			*emsg = xbc_err_msg;
 		_xbc_exit(true);
-	} else
+	} else {
 		ret = xbc_node_num;
+	}
 
 	return ret;
 }
-- 
2.34.1

