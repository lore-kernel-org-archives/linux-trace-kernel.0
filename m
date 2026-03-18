Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F883E8662;
	Wed, 18 Mar 2026 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849575; cv=pass; b=Ggm/+ltEKBXCUS4uyyzeVkRqgnvoGEGCBsyDwQ2s1RvKzYQMPJUdwVF5n6vcQe3syptfmwX9On4wEnKMJgGsreA8Nqn5uZfmXMKWFrbhaqKr2TgKn0BJYcalkd1pTLIrKCVlm8dCzC4nUr8BBKGMhtgtcSHfoGyJvJzEkF5uuDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849575; c=relaxed/simple;
	bh=wv78ftcSG/DocPbKu+mkVk4aNLSvNs5rs+zIciiAp0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fyWji/SUgWbbugkDgGzmkC1LsfXoabDJdE+T1UCzbNWME9xbrsVS7V5eQfl1Owe8RRbK7ieGAVTQS9HIdYA6+J8wvmaK4ADIilJdSbe5hy87rUyoQmvFeTsA2SP9K6c+/Z2Uxic72uKQRWZ/0rX5RgSqzbzufCHrFfFhfiIYka0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=e4fBSA+h; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="e4fBSA+h"
ARC-Seal: i=1; a=rsa-sha256; t=1773849561; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Dnds9mgZjafeGxV/D/g4K5Wdlp1EyvmMz+yfU7ksNz0yadXK1zA/jT3D0PDosqpln4vpP0e+l1YktmRG+WgjOSNVzbzMfNxx81aKU/KMjV2vOPlmNxo2Mzrci7B4RaL5Nyet+5PXV4M/vtin0BGGcf1KWLuavxIhYDW354EhBX0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773849561; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=G9gVzURcM86LqCKwgrK/9/RXrE3VSY5wkHPGGwsPo4M=; 
	b=Dll3SjMmtmDosZ8MYFa5NTe1UTLQ5i/ovUYCeh27W7pB47CQgce6Cq3+gizRrxX8s3bFcEsyQ+2W8j5FRzY/j0xai2m0a6yWyQpFinDPtN8hrOggN/BlotXYT2kV2g47yv8TivlmecjzluAVpq0gg8bYCb+G6aXuKM2Z4Z8RkdY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773849561;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=G9gVzURcM86LqCKwgrK/9/RXrE3VSY5wkHPGGwsPo4M=;
	b=e4fBSA+hwD0U1vBe5xvfTRFGLIz+FfLlYhigwgBHjcptkRN3Lrf1ma4C0jtM6CTR
	wvroHJ9N03Y9Pzb/F/75E0h5WLV4kTGm0Ogl/K+uXX7TS0dCwAjHn47QuVX4WSsovsf
	dhHYM1bdQfP0el4OBSHWAUdrEYWWWyobntI4nIvo=
Received: by mx.zoho.eu with SMTPS id 1773849560627902.4012698322563;
	Wed, 18 Mar 2026 16:59:20 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v8 01/13] lib/bootconfig: clean up comment typos and bracing
Date: Wed, 18 Mar 2026 15:59:07 +0000
Message-Id: <20260318155919.78168-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318155919.78168-1-objecting@objecting.org>
References: <20260318155919.78168-1-objecting@objecting.org>
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

