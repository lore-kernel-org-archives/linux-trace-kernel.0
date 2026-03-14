Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC41331220;
	Sat, 14 Mar 2026 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524895; cv=pass; b=r/LoK6/Jz5frXBYY62xdVSKPlQO7ZI52MqsrLyJDU0PDIHc8RN7W5edRbAghrUPpB4IA2RdM8vGYjGQYto4DbjqWByCts8vApYITqehmGwGhw9W/UTqFhiAlV/cOSbbmnIE74hTE6cC6mWQ0QED4UJPk9BLwHF9Wl98A3pqBYew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524895; c=relaxed/simple;
	bh=MjX+L5BkroUgaRrcSwrGDKK9It5hNznJ9Ds+whNCQGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q9FoEEOLFEgYqu0FVT9KKIl5rIs0jTeVtraSSlo8USqWLssi+/bBl9CwaEJsfG5v8bdbb6yitrAtNxXX4WC+mS8nQ4mnBqkcryue1bfa9Q73CtmUU1lvm4mg3TtzlSUpPmdaCXN09ulZjRVbP/3ZUBWL+fl9jujcdEwDlIhV09A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=n34Z2P0E; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="n34Z2P0E"
ARC-Seal: i=1; a=rsa-sha256; t=1773524765; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=f4do+Nu6iPpGvRctvHPxoL0xUEwgXqzqGwCtt/BE6bv9CMN0GtM0wq3g7cQi/fHZqW93Lqn0FXPGKQenxNgDHli//BK1GnqPOIaJAJ2zNFOL4OT9ybGmY8FGfv0fcbf5HuJY1V8eclc13xiMc06J8dRbfZ5Xm77a0n1FCm17M6c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773524765; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6vqu+catdL+p5SuHEICmEvrCdVO4BKlL3X6/JARWFjI=; 
	b=Ct9UqahVrHCrksJKGrp9fmmjY4+O4mYKoGDQuCJM/uhJ0xVul7i9dxhxW2NA5fe2EY+RQYZx7Mt0cNVN5POMhJGZEe7ouZKvbuj3QwcjnmgCoQdqRdeny1pDXnUbDPVuYO6v+nXWI2+3dvmh4zpZSbY7R+O3HZ/9FLSBXgV4FMo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773524765;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=6vqu+catdL+p5SuHEICmEvrCdVO4BKlL3X6/JARWFjI=;
	b=n34Z2P0EGRZLnOLALcAhD3NUpP4wJ/C7yHfJVHof4kBUVnjPtFBo7eBGnJKolZ98
	W6U10xd+HpPSBVzl4u1UfkTaK2ucmLvREsPQBx+Qc0e4hDxCVpTl+ex95emaIq4nalt
	/r+vThukOQqe+bgv6vsLvH8GU+6fgjLY7NYywEjg=
Received: by mx.zoho.eu with SMTPS id 1773524762373783.2366676984439;
	Sat, 14 Mar 2026 22:46:02 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 07/15] lib/bootconfig: fix inconsistent if/else bracing in __xbc_add_key()
Date: Sat, 14 Mar 2026 21:45:47 +0000
Message-Id: <20260314214555.96217-8-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314214555.96217-1-objecting@objecting.org>
References: <20260314214555.96217-1-objecting@objecting.org>
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

