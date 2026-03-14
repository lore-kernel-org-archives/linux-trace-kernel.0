Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7B03914EE
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531136; cv=pass; b=e5U7M51T+HtxeTpUHNXsMpNt1+g7FK8MqwY81N67jMtHLWCbStdB/9Oh39nxh2gzUlhjmFYxz2ZaQJMKUTQ2UomyROGsTnH8HRClEg6dekbon2ONEdcqvAl9mD1PjPKZ1roNkDo1/mDKRmszabKiX9zVN+rCiwY1yKrEH9GME8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531136; c=relaxed/simple;
	bh=DRP0bkR7bPm24iP6Lzhg3tEJBN+s2+Bet778OjDqUXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KPEcj/bBGgzx3yzcI6gZ0Tot+tl3tRmq7uclhRYl36ikFMLS27I1qjJNeqJlL9iPvTa8NghK5DSIRmGvKxkQigwmw2/h4r9pnaKCY4owY92FPEUy3ZFQoAxfc4VU/IW0rycfUWhf1Z2XGRzVtPx5O7OIMkeVHUdXL3efCOGO6ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=YWHtNSm+; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="YWHtNSm+"
ARC-Seal: i=1; a=rsa-sha256; t=1773531110; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=WcKQFweUWijBt2SvRxM8QRXyWrikxHh4ZMSGo/dhMW1TP56KZKklnBwK2GlwgDz066zwby6vmwIkeTWxGSify5cdGN/bexzEzZyZqElpWaNxIEKWFqf0hyWDdI6Gmv3S3CDE942H60HLoL/fTXo3M615Ta7jBNedEKbgdEC28OE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531110; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Xeupn9cKPxiPKbISrjkPHMR3deW24vI0PqVo9Jq/DYc=; 
	b=hyEldJbxHhQj5WNDqTZSHgiQYBVclqURR5ykH3ohP0T/4GyHUJwCE9Q8WljR972bosnaz/H6BxLR2RsdOVjZu2ReAMyH3Ox3j5GtwSkRB0nKcwzbB1J3Ooy+Xmh/5ut1L4SWCvE6/ZBYVlS6S8p+/BGvFKK0fXeJy15KL0YA0Rc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531110;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Xeupn9cKPxiPKbISrjkPHMR3deW24vI0PqVo9Jq/DYc=;
	b=YWHtNSm+vJ7glu7RIRgIS6SCSRj1mTkgCAiFT1Wgtg+9pqKBLOAnRVbyzo4DTQjO
	yfnwZz3b41fplv/xzgDPlwD75WsFJUDseYhquxdcKRstbGwzzVpDZQ7Xld+prbUN8eL
	Ivd4ah2CrjwQ+XY9Q+INGGSDfBzRooRyhP0h3RqI=
Received: by mx.zoho.eu with SMTPS id 1773531108799283.4619488222643;
	Sun, 15 Mar 2026 00:31:48 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 06/23] lib/bootconfig: narrow flag parameter type from uint32_t to uint16_t
Date: Sat, 14 Mar 2026 23:31:27 +0000
Message-Id: <20260314233144.187273-7-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314233144.187273-1-objecting@objecting.org>
References: <20260314233144.187273-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The flag parameter in the node creation helpers only ever carries
XBC_KEY (0) or XBC_VALUE (0x8000), both of which fit in uint16_t.
Using uint16_t matches the width of xbc_node.data where the flag is
ultimately stored.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 45db51bc9cc7..34bdc2d13881 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -408,7 +408,7 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
 
 /* XBC parse and tree build */
 
-static int __init xbc_init_node(struct xbc_node *node, char *data, uint32_t flag)
+static int __init xbc_init_node(struct xbc_node *node, char *data, uint16_t flag)
 {
 	unsigned long offset = data - xbc_data;
 
@@ -422,7 +422,7 @@ static int __init xbc_init_node(struct xbc_node *node, char *data, uint32_t flag
 	return 0;
 }
 
-static struct xbc_node * __init xbc_add_node(char *data, uint32_t flag)
+static struct xbc_node * __init xbc_add_node(char *data, uint16_t flag)
 {
 	struct xbc_node *node;
 
@@ -452,7 +452,7 @@ static inline __init struct xbc_node *xbc_last_child(struct xbc_node *node)
 	return node;
 }
 
-static struct xbc_node * __init __xbc_add_sibling(char *data, uint32_t flag, bool head)
+static struct xbc_node * __init __xbc_add_sibling(char *data, uint16_t flag, bool head)
 {
 	struct xbc_node *sib, *node = xbc_add_node(data, flag);
 
@@ -480,17 +480,17 @@ static struct xbc_node * __init __xbc_add_sibling(char *data, uint32_t flag, boo
 	return node;
 }
 
-static inline struct xbc_node * __init xbc_add_sibling(char *data, uint32_t flag)
+static inline struct xbc_node * __init xbc_add_sibling(char *data, uint16_t flag)
 {
 	return __xbc_add_sibling(data, flag, false);
 }
 
-static inline struct xbc_node * __init xbc_add_head_sibling(char *data, uint32_t flag)
+static inline struct xbc_node * __init xbc_add_head_sibling(char *data, uint16_t flag)
 {
 	return __xbc_add_sibling(data, flag, true);
 }
 
-static inline __init struct xbc_node *xbc_add_child(char *data, uint32_t flag)
+static inline __init struct xbc_node *xbc_add_child(char *data, uint16_t flag)
 {
 	struct xbc_node *node = xbc_add_sibling(data, flag);
 
-- 
2.34.1

