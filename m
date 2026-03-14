Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEEB38D010;
	Sat, 14 Mar 2026 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527684; cv=pass; b=u7o/kTtf9Fdzi5xbt+v36v7EKBQD/Xg2H6xUBbuJTrrHMK6UbvhoXA/dtBeTAOdrexQnZUcLtReTD3B0cxKw9gY5vrouNroLHgqmk40iMFMefdzCIeLn1dIIkxoWjfFdQ/qhzeQL2kZ4WweR38Oh5WSIPBnZUgqRZgVJYmH/3ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527684; c=relaxed/simple;
	bh=5AnzfG0vkdEgFClTKvrYV4qYqkz7cUXrau3pFlOkbfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XPzqdct5tmDoKIAqvOBFPADcTGOttNDEBZ1tC8EEBWGftJnVPa7JyMMsefrpXTHUTsnF8Ip104ONpVDrev33NeDde+jhESTZGUCfxtuoPdZiYO2veTy9wynEbzyWMjk2ZJus2d7YyJt+ss8QiBhjt4xdU6Fkjw5EXxqxIQieyB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=F0l+4khf; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="F0l+4khf"
ARC-Seal: i=1; a=rsa-sha256; t=1773527674; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=QbsTvfk9JUmaLbPP9SLIbEYtswqROzqn6Iu1k/OUeRo04audVrxU9LxZ7hWGP7opa1pbf1gkOR9UW2ib7saJQKtac/FRDoTFDs0l0ExpYBpUAKMa13ZVjd7vRZuXXQrNFERLkkYC/76THyREvKRPo1wvHo9sGsO+QJLYpg1l5Bc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773527674; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZkP6e7kBnlhV26QlBiganTloqfVRgfHEXYKYC2UlxIQ=; 
	b=MvYqgV2J/svBDBe3pAETeAvrl7pSH+0AJNb++ab9If88Tvj/6EEvWDFbnwQGtD34I5O+/Cma0y/1wnkDMjhdrm1x/tHLymO5epch2xi9JjmxE7D7SaDMnklQDpsJpvrIUo35O9J4Rzl//aTAYM0inaolX+QCXb5j5lAd4f8ytF8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773527674;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ZkP6e7kBnlhV26QlBiganTloqfVRgfHEXYKYC2UlxIQ=;
	b=F0l+4khflTpwgaWvLLCOCBiAllhK2dbGB5XD9pUGxv3cT4i8dXoctgwIrk5SIH1D
	xtfKUAXBcnSGkFpaJc3EN+064TagBvrda5z9wYoQxqTHxS5tJsCaZ5wDImsAuVfmHgZ
	u+yezBWEBeYYNuUborXvB1JHErIn99UwzPGiT/Fg=
Received: by mx.zoho.eu with SMTPS id 1773527671326675.9968998598603;
	Sat, 14 Mar 2026 23:34:31 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 09/17] lib/bootconfig: increment xbc_node_num after node init succeeds
Date: Sat, 14 Mar 2026 22:34:17 +0000
Message-Id: <20260314223425.142966-10-objecting@objecting.org>
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

Move the xbc_node_num increment to after xbc_init_node() so a failed
init does not leave a partially initialized node counted in the array.

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

