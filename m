Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245634DB4F;
	Sun, 15 Mar 2026 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577231; cv=pass; b=QPPaW42IPvvkvNJmH08K8O+swgm6VJz1JWVM3UPg/pjyVQGVXN9qL9F6qowACYrOlsfTYJN3CfSctws7yxjqA5Z1Xkb7MJ9/PpeFiJkYOX3zh5YdRwteMYjock8Y7f2pUEQhyjff744Rl9sxHJRliMoiG++PAlSjumx7/WJ8Tn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577231; c=relaxed/simple;
	bh=43QmyCqjwfaH2eT1ZEPKdFGorS2/96CvQZYCl5EDh84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rYIkLPA6AZHl9Y0uQhbru+tAdmgscyyTXOJRt6NGzafhgurARN8eBuZnkM2xOUJ19NpT30co+C6us3WjfddjTpBNUVzFgKAeg0gTgexZ9oH22c9xgBGtNe7eO09dU3iTy/stYqfQVptI0kzpdHDBigOrDPgeFDk+sE96V0dTwP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=l1yygZ5T; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="l1yygZ5T"
ARC-Seal: i=1; a=rsa-sha256; t=1773577222; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=R+rSJBAhZ6S6x5nKVFHgllzahlcyKeR+CiqjKT4VgO2Oe+PpAY4IXTgS7tw8p7bvlL63RgMkqG3PmciQBd3btW7QlVPEqXSTAVTeh26dAzt35YQ+Ktyq05NZRzshVG4oOLLREk0M40UXCPjy3fgfewDWd7/RCCh6j/7LG0vvN9k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577222; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aQ2JC6gJsIOnVLrttsYiOD8t7/HU2uNkLIv1633cFHI=; 
	b=C6Zs+uvQ3nhbYKbAVSpnIs/p1lTBwzeF01PR5zD/k9NRmFMXS8Tg/TMwi1YiFEOK941ru/gOEwEe+PQi+S9c33DtXAeVghBZfbfcGTluwHvVvuy61FhXHwXsE9TSLXNlDQZWID5LNEkgE83my57Lxq+1LFOzwnJbYUWHCVVtDXM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577222;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=aQ2JC6gJsIOnVLrttsYiOD8t7/HU2uNkLIv1633cFHI=;
	b=l1yygZ5TczN7QUFWC9iTgQuOJ0iw+fAOimZ3Kh+bZzwaRxbnJyPbR0hhIwgckkyw
	Mf+HhDi7A9v/qMIsj1ca38YKm8OUMYdedYVYE3ZpDSmWCejJdszR1Gl8zQnNUObu3mD
	EUX2tLv8IQgj2D1g/XGlmupUqsOhBieuYA79WuHw=
Received: by mx.zoho.eu with SMTPS id 1773577219715212.45021646479506;
	Sun, 15 Mar 2026 13:20:19 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 05/17] lib/bootconfig: increment xbc_node_num after node init succeeds
Date: Sun, 15 Mar 2026 12:20:03 +0000
Message-Id: <20260315122015.55965-6-objecting@objecting.org>
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

