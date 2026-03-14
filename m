Received: from sender-of-o53.zoho.eu (sender-of-o53.zoho.eu [136.143.169.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586AF388E59
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524783; cv=pass; b=Wb5ojhMSd9Fi4VMcGziYpWSzpA34jNqkCEK2QGLMQBYABnYSqwTmEM5rVCkAVzIVnQPBtngQ2G2HuuIEy1/gKEzKHl4vvb7znp2jVQJHUo+oraAESB8M8THOMoGk71Kw0jAwcE95uT3jBnVvGNBkCtlf5UUUvdtZMA3IuGcJwR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524783; c=relaxed/simple;
	bh=5AnzfG0vkdEgFClTKvrYV4qYqkz7cUXrau3pFlOkbfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MCQySrGnSgm2gJ7mvxGeljxPmPkBvEJQww+9cQyJhjmMUVLnWokcWMJFQwOM8pPchwD2C3Eblsbn2XFoHbCHo3rg4Y5FCEbfUl7HLTfjAP7HxOYC6j7gZKj4UhNYIuIjdSbQ5afu6SQkTz+3Ca9sDneDn2mmsmmdEQfV6hUsuZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=oWba+CSd; arc=pass smtp.client-ip=136.143.169.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="oWba+CSd"
ARC-Seal: i=1; a=rsa-sha256; t=1773524766; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=N32MCFhkEK/HSTm1Ou7X2mtlYhvcSoZBgGivvtjCIYu/66iY0wXKn19vl9E/xsJyIbI12/6ZOi658d6ZTrhW1KkxW5mwJ0/uU/YgzXDfAxCEACw6hULPdNtp61In+HPpPEB87Nj/7beQpF2yHUmN2oxXUuK8e9uygL1aMtZaVWk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773524766; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZkP6e7kBnlhV26QlBiganTloqfVRgfHEXYKYC2UlxIQ=; 
	b=VX1vsX9wW49TvareQPU7Obmjd5KIwSHsnspRYMF1VMXpRNu3CySjiJFhCXA+IawL0ChXKPLNaeVwl1Fx6Ni307bvssspE2pSwuO1sz16vSzehI0RHi6i7zkW2lw2fraRuImsFwYoEZsjCzt+IVV+kgRGFI/puT3bHA0bmcY8884=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773524766;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ZkP6e7kBnlhV26QlBiganTloqfVRgfHEXYKYC2UlxIQ=;
	b=oWba+CSd88l6ahshQlzTEgD8rkcJED9k87ZlzqCsgUEWCWGC+q40w5zzeDtKBMpC
	KLkgUTWZOIRDv6KS1RroYzA9H2/iPqqvSy5C08Acec3zyewdn3puyA2No3ZdoeE6Rsv
	7wPjrJilNSMymvVqa1ICWUjcnAL9VxoRh/JjIm5A=
Received: by mx.zoho.eu with SMTPS id 1773524763526571.1415931431779;
	Sat, 14 Mar 2026 22:46:03 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 09/15] lib/bootconfig: increment xbc_node_num after node init succeeds
Date: Sat, 14 Mar 2026 21:45:49 +0000
Message-Id: <20260314214555.96217-10-objecting@objecting.org>
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

