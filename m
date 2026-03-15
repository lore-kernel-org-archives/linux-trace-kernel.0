Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA933A00C;
	Sun, 15 Mar 2026 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577231; cv=pass; b=gWdaM4fOQQb4sLkDPhGq0jen2R1S7o9kboSHlmJCz7g7tGr4wO/O3ayu/jKAQPT6FSft7MU5TiJJDjkHksS53hppeJuDRen3bZMU/WvvC4+P2cY28NZbDuSe8hBKwpIh4q956JWQjAczEAYOc0P4Dz396pa9e0YSMwwXAAGJnO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577231; c=relaxed/simple;
	bh=iCD2JlpB8ag31CBi7R2mYEDIs4sJmCdNKOcmF7gEfVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J0HpORH9+HBWwFfKRqORPeeUJMz5SG5IkXAYGUCZNBWB9QJIZ0Yjt2kN7VP4PZyKEYn4nBm0PIFUtVdVP/FGHPP+taKGj7hxvsj+AhL+W5TXQHNgcAvbkr3oWqirUdZM7Tkl0bzFv3l+1cR1BJl/pZovt+y9dIUCjtZyeD5DvG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=H467i46h; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="H467i46h"
ARC-Seal: i=1; a=rsa-sha256; t=1773577220; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=jymvZzXoDyEZTdloEGwHDQdkJHYU2Tap0aRZfdTZTZCx2wWsAgHj9KmSMoOnVyt+MwYdFU9gcixrE8ZWBW7WplleKAyP24CfnW5NNMCKQ9//O5pczbIyDA+IHF66T1i6FFxdTK/KogvikTT6E09d8cmo0rj5KGKADT8gT8XaG6c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577220; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=G6uh6iZrfksZ3Z2lXH4oYMyen9srxA5Ump6/qHwxPjo=; 
	b=JTSq6N/+n5bKFh9G3DTf0sSF79KqLZms01YLtigKsjHYSCNprSTC8dFBlTtHuif4rAwpgLGaO0xEZxxRA8uKvhTRo+jR1V/CJEgWVPSGnPMtEBzeO3xx1g6kasRQkvR2fFXA89JbjWf+9xhKehFl2457XwTo8EeHGsTt5150c9c=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577220;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=G6uh6iZrfksZ3Z2lXH4oYMyen9srxA5Ump6/qHwxPjo=;
	b=H467i46hLkCglMWSD/bVTmWHqXSNnWOStm1Zp/BEiVqjlq7IuF/b8cJgb/qvx+WT
	iIKQuFlj3DdLp1B0RKwFUzmDBwktGyWI40cg7SysXD9jkGdQc40XYJ1dHmxJa5LTtW6
	XHP7df/ufHdZk6stwXJRNeQbh+ioZGxkC0nZBeNE=
Received: by mx.zoho.eu with SMTPS id 1773577217926274.76406481822164;
	Sun, 15 Mar 2026 13:20:17 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 02/17] lib/bootconfig: fix typos, kerneldoc, and inconsistent if/else bracing
Date: Sun, 15 Mar 2026 12:20:00 +0000
Message-Id: <20260315122015.55965-3-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315122015.55965-1-objecting@objecting.org>
References: <20260315122015.55965-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix comment typos ("initiized" -> "initialized" in xbc_root_node(),
"uder" -> "under" in xbc_node_find_next_leaf()), add a missing blank
line before the xbc_get_info() kerneldoc block, and add braces to
if/else blocks where one branch uses braces but the other does not,
per coding-style section 3.1.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 51fd2299ec0f..80de9540245d 100644
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

