Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59141389441;
	Sat, 14 Mar 2026 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529334; cv=pass; b=BayargRGCA+Xvak9HyW38A4jj6gGRxhqth2PiAH43PgiK7na+dQyyAbuMmN9SzvVRPY7pbscaR2CaYwMxOxj26RbLJX6/62pQTBmw6RAv8Ijv3QXxb51I/0Axw140tVS6cO1W9dQ7KfUaRAbbzAEj4RpGEoBXjgut8JMm2+M6+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529334; c=relaxed/simple;
	bh=43QmyCqjwfaH2eT1ZEPKdFGorS2/96CvQZYCl5EDh84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pu2DUVEI2raWq7m+zhObqDGUZfT05V/xDoaYYAsOl30dqGsVk/mSmbuToqTSxmjd46AIpbuyhFVhcf43PLhWycZ7WB138KRK3Vkq9d7vhlJ8yLYmTk/e6SMi6DZlN7l5DLDzZtCeIrg07C1xES8agMJVmx2qCPWXp6YjsXV9Dvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Z4t7AMtZ; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Z4t7AMtZ"
ARC-Seal: i=1; a=rsa-sha256; t=1773529325; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=SHz/fxRiI70pFMpzCbf5d53hqNzXU5oTIFxfpRxoXOr5oaTyir36shOfMd5dfia+zhnV2pJBGRwaZ6KciX0TATt0ve0zd6McXBtoXUm6io/Hkvuh7i3jheJ71UIkSVLPD0hrgtwlhSjSZr4zBAx19dr/k7DGlFaRWeKUArf42Bs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529325; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aQ2JC6gJsIOnVLrttsYiOD8t7/HU2uNkLIv1633cFHI=; 
	b=PXUJq1NsmfpkWTy9KqbzRHGagdAFTVRCYoiVkKKC1beTQiIzNucofcEGch7pxMG1G51myAwAnziwSUJ/mgpiM20PEvklJ3dEbZ4Uhs7Vhs9CHIsM/e6XK+yVImPQTputoT2iYRPGluwP3T82rTzV04pmKNc0KUGeeR+DF2q45MA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529325;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=aQ2JC6gJsIOnVLrttsYiOD8t7/HU2uNkLIv1633cFHI=;
	b=Z4t7AMtZFtgso6iee2nWrJqQdFIKvWB8LYRIkjbwvdcIp+jdNbSezi9JQCTSJWEb
	04rKjsK2CEHiZwndfvyFRGhqmMXFyZuNDP9q2osAEbwlWY2BOFRxTrBZQZikbSorTPF
	g16ysxSU8yfGiSVP8zKX2wzDvfHN/NMmtARNeDMo=
Received: by mx.zoho.eu with SMTPS id 1773529322325236.76599477816933;
	Sun, 15 Mar 2026 00:02:02 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 09/17] lib/bootconfig: increment xbc_node_num after node init succeeds
Date: Sat, 14 Mar 2026 23:01:47 +0000
Message-Id: <20260314230155.155777-10-objecting@objecting.org>
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

Move the xbc_node_num increment to after xbc_init_node() so a failed
init does not leave a partially initialized node counted in the array.

If xbc_init_node() fails on a data offset at the boundary of a
maximum-size bootconfig, the pre-incremented count causes subsequent
tree verification and traversal to consider the uninitialized node as
valid, potentially leading to an out-of-bounds read or unpredictable
boot behavior.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 56fbedc9e725..06e8a79ab472 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -429,9 +429,10 @@ static struct xbc_node * __init xbc_add_node(char *data, uint16_t flag)
 	if (xbc_node_num == XBC_NODE_MAX)
 		return NULL;
 
-	node = &xbc_nodes[xbc_node_num++];
+	node = &xbc_nodes[xbc_node_num];
 	if (xbc_init_node(node, data, flag) < 0)
 		return NULL;
+	xbc_node_num++;
 
 	return node;
 }
-- 
2.34.1

