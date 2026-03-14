Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA62A386C29;
	Sat, 14 Mar 2026 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525344; cv=pass; b=bmefGYXe+LMovMyncax0OU85gv7DimArMNGMQNa3GVptylVq+RiDMeNgKlfrESJE43XLxxQoHpXS7wrtH+Ckbk/xgtoAAqamT4JJwpMke9rYK8st0oo2caIv1txqftPWpaKCc+xyGqeBKesDZM9BI0zXV/FbXseOH2HyXHhbxWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525344; c=relaxed/simple;
	bh=5AnzfG0vkdEgFClTKvrYV4qYqkz7cUXrau3pFlOkbfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QrwVs4AQk4TbtWFCuOZW+FWBEGFUOyeFOlWc58cYrlgiC3Vept5+B0TVY/JSwdszDQbpcMOxFDx18uXP+srxZt8B/0KkblPYDm41r7txz9fbE1rqax5t7hkS00TelGF5h8nShEzeM29ppyI3DHiwl/vIumROQiFjHYH9wnZYluM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Xe8wOgIh; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Xe8wOgIh"
ARC-Seal: i=1; a=rsa-sha256; t=1773525334; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=eGL6L/XdcZVbrI6Ffv6kpsC3DmvKZxaWIvSZa9Mi0E1nVnEt/fCFPlRlhN5LWrvIOrnYYxPI3hwCWgM9I41igFlgWWqkzULY5TuPirvB4nEWJ+jaSZGD0ZQ3SD9avQAED4zTQkalqmV//37od3AJ3+ZPgi42CaY/0IU4nAL2m3o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773525334; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZkP6e7kBnlhV26QlBiganTloqfVRgfHEXYKYC2UlxIQ=; 
	b=R4Qez38gk1nccOfyMV9wkue07VuKA/WN+sqlaP1QENFIKfLu7nqgLUbdlsvwY9yDn+H78s285q9w8oB1OwvKG9ZuOgdgMcSutrhNQI9jccfdIjKchr7KJeLL92qcnv8b2zFVDHXss8EoY0b49qpmKMR2oEqvTl9ufe79+13GoTo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773525334;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ZkP6e7kBnlhV26QlBiganTloqfVRgfHEXYKYC2UlxIQ=;
	b=Xe8wOgIhb9y7oqUFu8IfVLRU6UN7qAXEdKjO90eQhN00aiKGPZ7seU0Q8dhy+W7r
	kvw92m6y7lE2zy5HunvRSgHpBQY6GQz9dASmbNPH7r23uz7zcGYCnbleRZc8V7CYyJE
	KRro9TdQxo/o/BLG3rpJKD5LVbO8L2O1yYsKZaJ8=
Received: by mx.zoho.eu with SMTPS id 1773525332443785.0583921914424;
	Sat, 14 Mar 2026 22:55:32 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 09/14] lib/bootconfig: increment xbc_node_num after node init succeeds
Date: Sat, 14 Mar 2026 21:55:21 +0000
Message-Id: <20260314215526.108651-10-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314215526.108651-1-objecting@objecting.org>
References: <20260314215526.108651-1-objecting@objecting.org>
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

