Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AB23F074E;
	Wed, 18 Mar 2026 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849576; cv=pass; b=fjvrC4BDv5hNyN7l3EXw+WoePye0NU0eNw0Y/bQpO0dj1B1jDj5vGzsNWCSqWGGefyVH2bGGdoAOGpq1W+8L359kjhrwXyJnWyTTb2VQYdzxgTZTPg6MxD97shRVvqfxL9/Dq6003o5tFHQc9u/vALQ5HUlr22z+TXKanN/h+Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849576; c=relaxed/simple;
	bh=3tM5KwMKBZ8z8auFLoGZ8L6+Lizhfgkj6R4OpQaZT/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uTa4PGFeylXpQJniOdWrkIq3oZDH0gdARsyNmoBfl4lI4HurzU6CMDEottbmP9iIduYd5n+oU2awPjfLOuDZoxLjiN5nlHT/8bNlKAp8fPMVGS0uKu3t6jJOZ0qhA3/5RmkbIUsDQX+hVGTbXJ9c8RlPij9Iqia73C5abhucb8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=g8rnv1xs; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="g8rnv1xs"
ARC-Seal: i=1; a=rsa-sha256; t=1773849564; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=L/dWhKU2rt73GTN8qzcZBg5bS+TRTbvD56OgA53uvZU0U+agEiJKs0o4fnJr2KtylMVMmYlEQLnY/WKOJO7yI946YaspE+b79JokA5MvU+DXVPEXRr1MI0FoMrg+QsrKtmYoEpuOV/aKSMoeKbAJp+DpGx6QBU30i3dozw11+/A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773849564; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3ndLaxyQl6N1oWzpmXGGEl1q/PrhL8WAxqF807UPVJw=; 
	b=UONOB7qGj5KBiaczVIvSfTZ0AZQSz2U+A0KI1tm6WHCRyeGdEyEZg3Fl5inTxCsYZaPDqb1LkpqocGLKIxdL/mmvq9tHTa/hg7s5LB3IVQgV+fLW7AXtfIb6V3B+1wZ822wBw8JF6rjTOr6HZszfcm6a5bI/FakJMVfSyumZ4hA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773849563;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=3ndLaxyQl6N1oWzpmXGGEl1q/PrhL8WAxqF807UPVJw=;
	b=g8rnv1xs6emBViqCt0DsCG8gmnhhI1JWMWQphG6T0InloKUSmZTzbdjk9E1l3BJ6
	6UEdC1lyHbZ/6+KmJ0WPazOA2GbI+C5EpiG8ngftDxVMz0WH5ONDj3qfDrpydhHIFSz
	OJ5ov9/JKHScaRu5idSTsDgfqBgc1lzKrV00WZtg=
Received: by mx.zoho.eu with SMTPS id 1773849562091901.2862068926551;
	Wed, 18 Mar 2026 16:59:22 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v8 04/13] lib/bootconfig: increment xbc_node_num after node init succeeds
Date: Wed, 18 Mar 2026 15:59:10 +0000
Message-Id: <20260318155919.78168-5-objecting@objecting.org>
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

