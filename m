Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751039023C;
	Sat, 14 Mar 2026 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529337; cv=pass; b=uVS5juNtUFH3mDErrDJxxLJRtTNyAZcAYsf8rUOV4204XRmyNUA18nfoKTAx62dAz1PZDIgmE16ZARwfv7Mcy6TPTWinQyEdn4BanDpgZ02R/nuOl60Rued7Cpv0/3AMp3xOrpvnMTdAzRLNKOkJxhTSkoTy2uAq+7w67Q968ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529337; c=relaxed/simple;
	bh=os0B7i8CIWcvtr1f+9MFrDH43djYT4PHUh8qcbGqh3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PBLVLxUnNRdrvYTFGrMWF6fFVWqaxEhy5/4gP4nGRoLJv91c1C9/EX9vA6a9e5FQ7y1fuB1qlvXT23u2wAWSGzNXg+JYoAWUga6I5K3eYvVfA3QUi0mk9rCWe31ZViRWMCb2p6bxITDiqnoKZW/JMNn1sqtOU2reaxw/FHR9TqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=HNj4wx6x; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="HNj4wx6x"
ARC-Seal: i=1; a=rsa-sha256; t=1773529324; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=C81DB/upk4QuKQDzdY1n73CLqi9LHme8nIGWCvxHGYjDHCl81rxayXWZci9QbpTTxABxsoFu+5ojdLrukV2IvXPGdgNfDm1bIFPUgooaqr+C4s0ZCDe7bkO9B9id/npamobT7/oPWrXyftfGJ8N18QQqcPRj+UGS9+qtlG3S05Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529324; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bT0v2u+9Dqz/pWmeHK/egM9RCBp55B7VxPnClMaL4Oc=; 
	b=Vr1xMR/RIDe4EPCSbPSqnLYV3VpmnLKsnPvN30t3YQIOKbKiy1FYm6PeM7cD9OF0eRifpGj5k99524/XNnBIz0DxMFIyknsVbEvG6EaG2MMS6pdSGAdyAI+MOTnUtsYdxHuzVRAn/cUULiYaZNdsMZKar4b5QAcggkyQS7SCYco=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529324;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=bT0v2u+9Dqz/pWmeHK/egM9RCBp55B7VxPnClMaL4Oc=;
	b=HNj4wx6xCVEfRy4VNc/ep8uyG2xfE8fbGZQNreY1SniH5SGa5AmghrjrkIi7ZFF2
	/vMBDZHDXPhCOJMsRkg8LcCSBpsdEEWLAHBJJKUmnzcdVVOjdproMCNrqTFOxMSfZVh
	BBnXNn0SEaxyADyxSma9J/FfGrQjaTQhYz0iVKpA=
Received: by mx.zoho.eu with SMTPS id 1773529321222628.2460852042352;
	Sun, 15 Mar 2026 00:02:01 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 07/17] lib/bootconfig: fix inconsistent if/else bracing in __xbc_add_key()
Date: Sat, 14 Mar 2026 23:01:45 +0000
Message-Id: <20260314230155.155777-8-objecting@objecting.org>
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

When one branch of a conditional uses braces, both branches should
use them per coding-style section 3.1.  Add the missing braces to
the if/else blocks in __xbc_add_key().

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 34bdc2d13881..58d6ae297280 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -657,9 +657,9 @@ static int __init __xbc_add_key(char *k)
 	if (unlikely(xbc_node_num == 0))
 		goto add_node;
 
-	if (!last_parent)	/* the first level */
+	if (!last_parent) {	/* the first level */
 		node = find_match_node(xbc_nodes, k);
-	else {
+	} else {
 		child = xbc_node_get_child(last_parent);
 		/* Since the value node is the first child, skip it. */
 		if (child && xbc_node_is_value(child))
@@ -667,9 +667,9 @@ static int __init __xbc_add_key(char *k)
 		node = find_match_node(child, k);
 	}
 
-	if (node)
+	if (node) {
 		last_parent = node;
-	else {
+	} else {
 add_node:
 		node = xbc_add_child(k, XBC_KEY);
 		if (!node)
-- 
2.34.1

