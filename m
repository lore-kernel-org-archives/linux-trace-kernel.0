Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E9B37B03B;
	Sat, 14 Mar 2026 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527679; cv=pass; b=A4cxPRXDj9dxgxK/kHzoRL0h5Hfv6/3i4m/lZBnnTCb3m8Pgq1viQ8c/yCTQTDPIaBae888Uwj6Xk9rePDmgbCG8uPKxL4VIF9ACrhlF80/RK1Bb5jq8DS6BKkE8BYtwp2ItdwO9ZPWssNrL3XTo0IqQmyMUqed1dHKX/gx6bak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527679; c=relaxed/simple;
	bh=UvLyNGwexYo2cn8ocKvKWmvyhLSh4vWkr9PLO2DssME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pvfx+KDXQpsmLUk55a77QWriDKieGqEWQ0va77ip8Z9OETq037rbQJigHtFkNGmJUS5D5D20XgOhkK/+Dez1SmXjqx/QvFDkCgboq62TG8UuBRDl576OkFkwwUbdWfjK1nEIYIU8niK74Q6JeGcJY81/pl5S+89a/u/YYyOSvak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=AC/FymD7; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="AC/FymD7"
ARC-Seal: i=1; a=rsa-sha256; t=1773527670; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=JIqBTv+SDVLxUQmlH7iSGHzThzpFPsp3LcU/U2lZUx0sdw4D0YXAsLRuIrl/O8fghn6643OTKVq0o9RrOOUS+1hLE4WP4aoUgea1Pf0guOL7KQwh1denzeUM5g7E/yrshNwShzSirElC2QFS/xLLu9MG2+WVWMDTPXYF0PL+VBE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773527670; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cBOmSVZK/tdF2G9FHoUjRcgfEXBwIZcdPH0TEKRTIUc=; 
	b=DXonhSLta013tueNyz4610CT1rXaOxIgy/T8AAW5/OmfcGepmIRDkBSQl5Xwu6kQ2wnmuVyWPDCOF8qdqQtnaUK9OGY56kqHQ2nyz4DzRAtsopRAFXZR9tJk28JCHhzYW54l2Jm7prySL0rULu81OWMTSPJKMq9Sxebw1S9mtJc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773527670;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=cBOmSVZK/tdF2G9FHoUjRcgfEXBwIZcdPH0TEKRTIUc=;
	b=AC/FymD79nKr5SrThmeYmq885sVfwzLR9OlFGJeTli5jHnMvR96PCt/xjFP36T8N
	4y4Uu7+zaXZwhYTWa1NwVHVK48WnjObIjivc1B8sAvs8YgpepTSjJF4DUCPp9HcG3lt
	Ihrh3+0Kx56ejZ/OR1GorTXIqm3GiKoEp+zUCyME=
Received: by mx.zoho.eu with SMTPS id 1773527668034625.9864923958036;
	Sat, 14 Mar 2026 23:34:28 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 03/17] lib/bootconfig: fix typo "uder" in xbc_node_find_next_leaf()
Date: Sat, 14 Mar 2026 22:34:11 +0000
Message-Id: <20260314223425.142966-4-objecting@objecting.org>
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

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 53aedc042f6e..35091617bca5 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -364,7 +364,7 @@ struct xbc_node * __init xbc_node_find_next_leaf(struct xbc_node *root,
 			node = xbc_node_get_parent(node);
 			if (node == root)
 				return NULL;
-			/* User passed a node which is not uder parent */
+			/* User passed a node which is not under parent */
 			if (WARN_ON(!node))
 				return NULL;
 		}
-- 
2.34.1

