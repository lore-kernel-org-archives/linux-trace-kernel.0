Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7780B38758C;
	Sat, 14 Mar 2026 21:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524780; cv=pass; b=akAjWtc+KYA7/p7OOJqxmN+VfAVQqaYxqKyjcs7pJ2vaPaIJanYBQLjj37TtdJOhmC8jo2tfN9Nf9Q890GOLLgXOO99texQpVDBinY8d+o2Oe4xfPmrVA+0xSG07WVs5rArr9qbOYIkt48oUeynoHqb7+8zRW4471Cb8pXUicYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524780; c=relaxed/simple;
	bh=EWCRpZBNHCZU8iztguL/vt47WImiwDpV31hec4mL7Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qmw+yfeB1OGH8SLnRrBAbwEO+Ez9FpIWwaLHxPBXoIhXAMU7Us0w7CTQacBXneTgbWm84jHf3X2FkRtT6qP4UkYaZV9sRwR9XRPwsNJbw9E3QGSBniIla19zFrqv7y4WVgXFT5g+lkjBxZGjLdEThAsIAbYPRBDSeYtSC9iicc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=N3asMWgb; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="N3asMWgb"
ARC-Seal: i=1; a=rsa-sha256; t=1773524765; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=XzDrZqO6KsCkC9iprvw6oHAyoyp7QXsPI15h+UVrVcpUR+pYr6vZlAyXDhoe67YEd73nlaI2SyrXgI9VDqOgcMZbKQ09frqUWbRztoGIwzmICH6R+StRofyWKj0MULCaRk2My6jSxOtDpV+xpejUDBuyg4v63DXmV8CnIWJS990=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773524765; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y3g/gWcuZygcqvX4QpGo9gnBChjnwRu7NCitJ/yvsXM=; 
	b=P9f2l044hJ447Unr/it6Pt+8XCKzd71mii7ihJS6wP7u2PtMjSOnD6wbAegRcWCEO0WLkec85fDagIDpMiZmSGG1fusAoAbyftDmFmQ0q2yqfvLB2t0ydHsWDhjemMrNf4B42SU5pAq9cywfmQ55yAKNLxfhbNWqV9yIT/QxTEM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773524765;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Y3g/gWcuZygcqvX4QpGo9gnBChjnwRu7NCitJ/yvsXM=;
	b=N3asMWgbylSi4XzumSzq7ur7uPDKaNHkJbdovaaaYNgUcT8Syce85MYsBp5a76uI
	nXP1l7ZYHyk0O80JBrCA/fzEB1TkKAOMw6CaUQtHmhRr0YuSqwjQe7anccqLcaBL7hG
	LqqiNU40DjnIHtl5FVoDd6prOdHyaabGrpW4ZbcI=
Received: by mx.zoho.eu with SMTPS id 1773524764082419.1804522832923;
	Sat, 14 Mar 2026 22:46:04 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 10/15] lib/bootconfig: drop redundant memset of xbc_nodes
Date: Sat, 14 Mar 2026 21:45:50 +0000
Message-Id: <20260314214555.96217-11-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314214555.96217-1-objecting@objecting.org>
References: <20260314214555.96217-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

memblock_alloc() already returns zeroed memory, so the explicit memset
in xbc_init() is redundant. Switch the userspace xbc_alloc_mem() from
malloc() to calloc() so both paths return zeroed memory, and remove
the separate memset call.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 06e8a79ab472..fe1053043752 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -71,7 +71,7 @@ static inline void __init xbc_free_mem(void *addr, size_t size, bool early)
 
 static inline void *xbc_alloc_mem(size_t size)
 {
-	return malloc(size);
+	return calloc(1, size);
 }
 
 static inline void xbc_free_mem(void *addr, size_t size, bool early)
@@ -982,7 +982,6 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 		_xbc_exit(true);
 		return -ENOMEM;
 	}
-	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
 
 	ret = xbc_parse_tree();
 	if (!ret)
-- 
2.34.1

