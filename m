Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE8238839C;
	Sat, 14 Mar 2026 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529333; cv=pass; b=F0QOg77r5t+2SEHqFu+ApIrmWCGVmpOkVdtqcGOccXjdCuZQolBZGXppkzZz9LoSMqtZiCM7EItQA0WytDYalugFvaw6JIBvAFJdNxiAvZiEZn32vKYi6UEJD+wyESduIQyK7q0R3BBtZCViWBfmGGF27Y/YVQT3F9tY0xBZycc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529333; c=relaxed/simple;
	bh=EWCRpZBNHCZU8iztguL/vt47WImiwDpV31hec4mL7Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tjMFgSmBgZlmQaGvbQuVSpKH/IkZGkr88I4YekECnWJ1t6YskvLcfKY2K4/ySdD18FhpoFApk34s3wUbfcDAkiV/429hbHJl+HqiklFkSY7P6wJxTaB6PgcSwQqqgn0nBEipo/9KPURDV3okk2RaqjCZbklMVATHVFChVLQxDuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=JDwhqRb4; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="JDwhqRb4"
ARC-Seal: i=1; a=rsa-sha256; t=1773529324; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=UpnmB//8o+mcEhztJrECb/qi6PThQPaErgzH1PQUiogj0G61J5UcN+Wn38+XSpX37mX0VhzWISrLBeFUiegTwxiTFIr44MO6Fh1lWCVZon2R/0izrylGn8hH55N7l7409ASgsNIk40J8Dm1Fz3jKFiwhxhRtEGQykPUM7EnzjgM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529324; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y3g/gWcuZygcqvX4QpGo9gnBChjnwRu7NCitJ/yvsXM=; 
	b=kbhPU7PGq1tsFrYovpVKD3mNRUjSzBLwbsZX+7/rtvo7CY/e86qc5qy6Gm+FSN5pYewj9Vyp8LdJ9dkwMDc9I77Wvm+1myNXSdObPNQMNLATMwB1JSaydo8FMSywJWwBfr1ltEDAg251JGrriCk/JOpIN8UM0NkojqEHR7RWSmc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529324;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Y3g/gWcuZygcqvX4QpGo9gnBChjnwRu7NCitJ/yvsXM=;
	b=JDwhqRb4C4KYKlR6hvqOvrDeNHKtN3CdDM3JO5AzwVvbI/0bKer60QWNeR3VT+/4
	YIz7YMxFgUDPrwV3K3LXPeevma4kbQAk/0amY44KBlx4KoDF7yv+eno5Mcn6E+gej/v
	Jf+XNJNVPRtaUUH08Stqsfu0iOb/kjmbkqjvW3Rs=
Received: by mx.zoho.eu with SMTPS id 1773529322882862.0718540279187;
	Sun, 15 Mar 2026 00:02:02 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 10/17] lib/bootconfig: drop redundant memset of xbc_nodes
Date: Sat, 14 Mar 2026 23:01:48 +0000
Message-Id: <20260314230155.155777-11-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314230155.155777-1-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
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

