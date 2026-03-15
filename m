Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B454834DCF3;
	Sun, 15 Mar 2026 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577238; cv=pass; b=TT3CyqNFVp1OZHwqWG+S2a+g2XxWcubyyRUCQVoFvJjslVSClDyJmMiKb5RBwbJnx4+KNQcg6EdkE08YoZQAZ40EgWfJDa/5qJ9PTKyf+yuhgvjfBmrRhgStZ6X8JT4gekw7tguxd6sU6YJCGatBPkn8zEp2UKVSCmbrFNaKasY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577238; c=relaxed/simple;
	bh=BT2q2siZTg8dVM/8aVNchawHfLA2jp863lq7U7GCyhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=inj9NnXt4zhs2oBGM9RWtxYxrJCyEpWFEAGTUi575UPNoxH8KMsNnAuHORpvUz0U1KpZsE7PLLOXpoRbROdDS0j9EzOM2TShqx8QPxT6mfx8DtGKXs6baSgLJIkNIyDQgl6+58A5Aq2cNq3Qtt/Lnu6mJNV9YVSDWuUOrmRWa9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=RxVjSEdR; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="RxVjSEdR"
ARC-Seal: i=1; a=rsa-sha256; t=1773577226; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=WEzm7Z1n7BcKjpYygfa6jsvGnD+yIA2y6Itsq8YzubXwFn7Zww0U5ekoxvUj8bqeWLBsAgl49j9tSu7FZ0hmzTDnFSLM3BM6CTYOfkbVt2kVBZ4Ok0cc9S0zjzB4Kxvx4O2vJ69vlFZow/oQSgRFsktv/ysGHl3cQ/L9ElZLx2g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577226; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2W9qWDSpL3vKX3csZlcWzL71BWBE3j2mAMm1BmTvlg8=; 
	b=OqQgi7/6rjKdQ7PNiYMYhZR6Z/n8TDDw2Jf+xLE8dWxg6E+WUr7DS8RPCpRnKXLRH8/5mYrle8zThdLuMNVNj/0Ac+eYaRPjg4Cd9iBvQEziZXE5T48IwFeesR7weTEJa8Jg+IwuQzuiKcptekgWjPi5DkYIsQKHuLbbTrVNJMA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577226;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=2W9qWDSpL3vKX3csZlcWzL71BWBE3j2mAMm1BmTvlg8=;
	b=RxVjSEdR+3xa5yR6lELKHB3ppMMEnlULhQfsd+p/rhL5KzKyEJOZmpQsildW+wKR
	lqzZaE8tealy4WwsGB+pMpE1emaGwqE9PdBsi4ew7iarDiH3OoIQkKi+WeE4g2ahMya
	Q+V32NX0dI0rlMSCdk83VXVAh79jT0Mq3DEYdDdA=
Received: by mx.zoho.eu with SMTPS id 1773577224242256.9249488294723;
	Sun, 15 Mar 2026 13:20:24 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 12/17] lib/bootconfig: fix signed comparison in xbc_node_get_data()
Date: Sun, 15 Mar 2026 12:20:10 +0000
Message-Id: <20260315122015.55965-13-objecting@objecting.org>
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

  lib/bootconfig.c:188:28: warning: comparison of integer expressions
  of different signedness: 'int' and 'size_t' [-Wsign-compare]

The local variable 'offset' is declared as int, but xbc_data_size is
size_t.  Using ~XBC_VALUE as the mask also involves integer promotion
rules that obscure intent.

Change the type to unsigned int and mask with XBC_DATA_MAX (which is
the 15-bit data mask) instead of ~XBC_VALUE, making the expression
self-documenting and eliminating the signed/unsigned comparison.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 182d9d9bc5a6..806a8f038d24 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -183,7 +183,7 @@ struct xbc_node * __init xbc_node_get_next(struct xbc_node *node)
  */
 const char * __init xbc_node_get_data(struct xbc_node *node)
 {
-	int offset = node->data & ~XBC_VALUE;
+	unsigned int offset = node->data & XBC_DATA_MAX;
 
 	if (WARN_ON(offset >= xbc_data_size))
 		return NULL;
-- 
2.34.1

