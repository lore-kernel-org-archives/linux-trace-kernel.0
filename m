Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3868A38C2D2;
	Sat, 14 Mar 2026 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527682; cv=pass; b=FT5sBLJeDKOGQnm1+zWO3uBqnif1u8uDYYPwVwc5zsA0rmsTrZoB4UuAO23yi3fWuDFoK/Gg5pG6YhvP35t24bqfp5de1raTYdHBWrMULhtNeoud/nzOwtFiRg5AqOuqdNp/5iRWqImiAR36jHaMJeYgGRzRPftyxzg++XrKW5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527682; c=relaxed/simple;
	bh=EWCRpZBNHCZU8iztguL/vt47WImiwDpV31hec4mL7Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQ8ZIQy5uqEzxVfBKeAifo3ewy4dZYVp0IwIgLO5LloMOhAQlp1RgWMcbNPY43/oX1vPs/HKwedfiy/lfI5hdtHQ5bGYu2ptREuuDUMWcLcMtgsv/6J23kxGO+Bv4Hux2gmpnaVre9o723o+2TfdOYxf2Cd/gl/UBeIL6fuPdwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=dTuzt+f1; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="dTuzt+f1"
ARC-Seal: i=1; a=rsa-sha256; t=1773527673; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=KvtHFjb7gnEwrCuo4KC/aV4jjeFgGdSuNHF80LKoFxoUiqr2zre40NIG2yoMOmfpWqDOHKu1cx2ajSIS9dvHGYntxMg7I5NM4B1IbGu/B33Z8vNKTZJAdwdVCjng+lcrAKvC65JnAScersMtl+GpfBxQARlk3Dx6b1mcaM9dFEM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773527673; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y3g/gWcuZygcqvX4QpGo9gnBChjnwRu7NCitJ/yvsXM=; 
	b=WLyvAdaNsQwRt+mkwPGTo5Jhr8R73poZRYJP3Kkn0ccOxHNQ3ZhdOnQIpuZItpyZxNazPnjv8tKJ1cLVpWbpj0tB5QWT7iJPGkzagi14R2rpjGvRO+NCGsEvtFHwze3D5+LgMGYTre9MwXL8npslSfBHwhH8XwSkXjWi5u2aqQM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773527673;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Y3g/gWcuZygcqvX4QpGo9gnBChjnwRu7NCitJ/yvsXM=;
	b=dTuzt+f1UQOXUdTKRtr4Ox+8yZG7PDeKfHTNyIO7ydL4v6w0cLeF6msJG5UTdIO7
	hhwavKBC6QZw8269pxfZGv8NXu5zPVyfiJyu22RHQ7adVVdNVQROUezwi0MW9vZODR8
	WKOW6Im5D9eZALMnj2/0qgf438TK9Y8r47Kb3ki4=
Received: by mx.zoho.eu with SMTPS id 1773527671841275.953282250141;
	Sat, 14 Mar 2026 23:34:31 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 10/17] lib/bootconfig: drop redundant memset of xbc_nodes
Date: Sat, 14 Mar 2026 22:34:18 +0000
Message-Id: <20260314223425.142966-11-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314223425.142966-1-objecting@objecting.org>
References: <20260314223425.142966-1-objecting@objecting.org>
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

