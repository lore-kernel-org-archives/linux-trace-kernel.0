Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2392FB0A3;
	Tue, 17 Mar 2026 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763893; cv=pass; b=dkHvn9pPQJwZy+uFDRfXHg/AXW1M0nH2K2DS5Mv4wyi7BofJD8V6M+v/Wv8ZufgOrz4VGz8CZe/wUl+SF6E+6204ryBqueVrP3PVYPjVEYNo0Y0ErFC/OyDYdQJqO/GlVmWHYmVlXRa7BWeKs8LxWNYJSxV5oBg47nSPwoYr4OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763893; c=relaxed/simple;
	bh=8XfWUpdfXEDT8M6ObTzeOjROI4BmQBiHqKqE8eCq18Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dfPBXTzCq1YiwqsXiQkaD+WdjSFMM9MLDQi4HohT6+pedSdlpfyUwI13FejAmgFxzFUZ7gRuNYDIKjjvBo+9KHosCPIMb8J5vyZ4J2hkWZg3qSQ1qA6mxDPhWfLr9CB/n//llroZPZJdYAboO350wSaE6q2ORg4LYaHFJifFZC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=c/bwk5w/; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="c/bwk5w/"
ARC-Seal: i=1; a=rsa-sha256; t=1773763761; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Q+sAeuJ0jbsS2tNOMkMOLEcT8g75s0KGnFuYoeeJXGy66t30H5U/POzWAxYnw8DLNFDfcVDuCRrrgRHof+UK2/tFjNDOViWkwFAacLWDDOphyvPbQzJ8a/DLyaJbMeW/Y0DvQq6tXgZ/TbuVLSZE0WPt3OEXr23zXrnHwX6IdIY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773763761; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YuHtW7i85M2bA56G7FOBtaqwGGYTu+FTLl9HM5NlI30=; 
	b=C/ODz/m12XFPbr5B8Mp51KluftIDsWWqDYunkRLmrFAmW6u8M6OVt/9xnR9I0qE8BiNntmo+9WQIMMpu1RPpSk1uxQu28//FAhwhH2RlhtuYtZwwd1kWkuASMnXpS4Iio6/u0Gmhy+M9JQluUO7rQ5uOYQz3jMoI0dEplSn7b1U=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773763761;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=YuHtW7i85M2bA56G7FOBtaqwGGYTu+FTLl9HM5NlI30=;
	b=c/bwk5w/qiG3EGWJJjyiruECfx2Fb5RaXRTxSmlcTZXZEraJw5cyfI+c3jba7zb9
	xUZIwIutrhk875iucyzhQ3eHvSFJmyH93yPXr5tw/Le0+ItRf0/DBRiOnF1w9W/5fS0
	vH1QKH2eg6LLeJrzy9c7mMytC8dAW1lAARpaRDHw=
Received: by mx.zoho.eu with SMTPS id 1773763760325916.8822714944906;
	Tue, 17 Mar 2026 17:09:20 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 05/15] lib/bootconfig: drop redundant memset of xbc_nodes
Date: Tue, 17 Mar 2026 16:09:06 +0000
Message-Id: <20260317160916.33576-6-objecting@objecting.org>
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

