Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C2333263E;
	Wed, 18 Mar 2026 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849576; cv=pass; b=ZkcG6haUE6VzcezzEL247wznNz7ZzE+7cCzIqU8Z6nC4QOhVSPq3WRionVfuI6ykBqCvFur0psSmtXQLGo9L2Sabp/JAPRrQBLF9scZ/8+hjMpIenuI7xqZCzaMG/Isvi6xuXfDVFkgdBYv14BrerH5Yo7dJAqmyD3Hw0tk5j5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849576; c=relaxed/simple;
	bh=8XfWUpdfXEDT8M6ObTzeOjROI4BmQBiHqKqE8eCq18Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hp2mDILi5yhAhUKLQA54rR9JbS6pyMu3FY6RcXPf3L42NQV3QBsMSEhmqllHJRNkm/WD3Rb54AIQqgzc3zfPqsmW9OKiVYoSYMT38D3atE9j7VOPKQ1fhsA/Y+BpMV5+dA+vMRk104Fq4+9Xxo6H83AgzAk/C7dX+NsVKwXvLBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=W6jqcyEn; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="W6jqcyEn"
ARC-Seal: i=1; a=rsa-sha256; t=1773849563; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=IusYMW5Plpql3JGAoARiW0LcCoFWp6F4Iq59dJT+p0KyZnJmoyRL4iOxOGesSqsP4SMvhSbK8OGOi1g1084sq41bMNM35OS91mkctg+m1XbbxiRT78oMUl6A1ziKkEq3oUj0o69iHZiViMWvN5VWM8+cFnX3V+Zpq/iiabqyH6M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773849563; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YuHtW7i85M2bA56G7FOBtaqwGGYTu+FTLl9HM5NlI30=; 
	b=gdmd64H8uRZzE2IAj3FVnbp1Ubn8mnMAaRk9Or9meokSb86IgjKMJSGUU2IKd7YmDejHPDqck+M56NGlky4caJJQ+kOHpQxG5cmTJyVFO6Lm1qooGhtSzWmrLKlW/e+E8b0l7JHUsXQ699I7lffUHX7WHYQEiskIwN24l69NgyY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773849563;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=YuHtW7i85M2bA56G7FOBtaqwGGYTu+FTLl9HM5NlI30=;
	b=W6jqcyEnXN8ps+tGoo72FaN/JuRSRhaxXtwmun+bwy/BIfrGMuFnZFxMbjByHoku
	qFoMTvVSSF3kGwwIl+m9KnAW8L14dCTkfIMxV14FwCOh9OBzTR4WoCCOicVjz29qrN+
	l4vBmYat+uP25pS3eXeznaRNS5pundEyIp5Zne4c=
Received: by mx.zoho.eu with SMTPS id 1773849562573553.0177423595671;
	Wed, 18 Mar 2026 16:59:22 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v8 05/13] lib/bootconfig: drop redundant memset of xbc_nodes
Date: Wed, 18 Mar 2026 15:59:11 +0000
Message-Id: <20260318155919.78168-6-objecting@objecting.org>
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

memblock_alloc() already returns zeroed memory, so the explicit memset
in xbc_init() is redundant. Switch the userspace xbc_alloc_mem() from
malloc() to calloc() so both paths return zeroed memory, and remove
the separate memset call.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 6b899e24189c..69486bd56fea 100644
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

