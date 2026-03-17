Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E875257845;
	Tue, 17 Mar 2026 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763890; cv=pass; b=FcrQfwxW4LPd4wNlIINTnLMtKIaPlroT0VIWaEGj5gruhILnc6EKUzKwiq297fbSbyAmQd/JnGkeZLVu37nFaFlSr0TOgxENFVYvefYwHgddHzwI/A11SJ0F2OM1PQc9yFh74qvBEG3O2r9iuWC/luiSp57SRBBQBp/tLYwDDcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763890; c=relaxed/simple;
	bh=3tM5KwMKBZ8z8auFLoGZ8L6+Lizhfgkj6R4OpQaZT/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lFlUHhdR8MrTAp96HN04ZCFdxKj1TUpHV6np5nykI5athY48HYvUExThcJfJg0jOc7unoPM/7gVLlX8kY5h3s/RWijNUCF7iNEIL8j2qYCJY1ZfKjx4Sc2xlpy4zJ1QExZV+tgQR11QImKEMfmCz935QGrC73naDOrczTuEslOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=iaHbks4p; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="iaHbks4p"
ARC-Seal: i=1; a=rsa-sha256; t=1773763761; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=dAO+lMApzCSgIUy8z5Kp7xml8y3W2k5PXDyKO/LlJ07Fp565vWzLRUeqokC97vOC/58AOcjRL3evhoBrEfvtrwolsA3K+8emH+cEUKh2VruRuy4DVLoWOMnLzSE/kI7WbvFXW/+HxhK6rx61Ip1i58K247JJ5QzCvlwtJHKE9Qg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773763761; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3ndLaxyQl6N1oWzpmXGGEl1q/PrhL8WAxqF807UPVJw=; 
	b=lEhVcAYwWAB58UvTrotwsIjiVa5RPRD6ItU24qs9r1+BxZQZ723+iOZJolYmGek+PsQoh+3gwypIJxApvLWiU3jDU8UJ+zrWH0vG5yTGurC8tbVI4xgdkXHV5efVvRqYkl4deMOEPe8pKPpkS7YOoZqlacOHUVuhDZTU86vjNwo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773763761;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=3ndLaxyQl6N1oWzpmXGGEl1q/PrhL8WAxqF807UPVJw=;
	b=iaHbks4pHvVK3Gf94Cy1nx51SegoW/izWACimfk9Y/SbdsV41qd5ne7lE4SbXtI+
	2u/PbsF++eIHwLJVmraZnFonaTfrq+mPAjKUlxjxTUeITE7mI2PtShSlg7s/4JhLst9
	RDhctCbA7R06mpj7pPJc5k0xmiHlYyiF7hMHuXAU=
Received: by mx.zoho.eu with SMTPS id 1773763759823948.8095310048836;
	Tue, 17 Mar 2026 17:09:19 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 04/15] lib/bootconfig: increment xbc_node_num after node init succeeds
Date: Tue, 17 Mar 2026 16:09:05 +0000
Message-Id: <20260317160916.33576-5-objecting@objecting.org>
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
index ca668ead1db6..6b899e24189c 100644
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

