Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F7E3921D8
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531137; cv=pass; b=tDtSoajupWMcnvKbx/IaV9xR4gOQBblk1jQfoWVd7xMsoSsuxeGTnNn2A9wJ5D0CR8w/XX7MGszgFXzkEp0klRATg4IAhttYiBSIFVK+atFMCnnKslvPpxc+3DwCQUzw8ViFwnaLfinodETZ96AAmHwgaMts0IQrjTcEwLlWcy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531137; c=relaxed/simple;
	bh=43QmyCqjwfaH2eT1ZEPKdFGorS2/96CvQZYCl5EDh84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k0BZ3dTB39oxVyTwToI7WqDFEjL0Hhn8Eh2DFUr7x/DLpVkriei88wHpAb5utnY/xDRYyB/C/bD6bejYerVUM8IEAtbytadJDh6oRfI22Jf6wJcRZQ3VAxJFB1FTIEEbqcQi6mjcjgr7wT3aPFTdLlndC6FrP50t/UKRXLOzX+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Qo83bWZf; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Qo83bWZf"
ARC-Seal: i=1; a=rsa-sha256; t=1773531111; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=TpceQrG+krriAPhMezAyQggA2hvWcFfBtoiAK4L14v1Uz+seeq38DXcJisI5haqTRz4yOvzY46BtF050WmRcNKHMoENoiTHOlIrBRzzik9QcgPxHOcW4o9a7PWNrS0XeCVIjJUtXxFJX9jjVtwowcZ94xfPwm/VLT5tgYDloevo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531111; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aQ2JC6gJsIOnVLrttsYiOD8t7/HU2uNkLIv1633cFHI=; 
	b=An0rN8aysCKT7kaCjoF8Or6Dy+X5tnTASkGrbdsSR5L3Wcp89dSNuFYloAw5wQ3lWxQolh9OZdIrV+baqKYZZvd8XhfWU8emCCp0qUhlc0U8zoVQj718RApo6b+P9yTVSudi+lfuW1Zozdpu/5ZV+W43vZL+35TkwSDOQZSNFnU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531111;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=aQ2JC6gJsIOnVLrttsYiOD8t7/HU2uNkLIv1633cFHI=;
	b=Qo83bWZfaFBr6K7VS+AcoEI+cJiaGC7zl6wAmj9WrsHMlXXyitkCT5iPAtlfWNv8
	za072yGVNEuoeUgaAbQ8xsqap2RHUdgP/LJRjZIdulHQ27hURPwaKPxDY/VrMWCmS+j
	Bwz7qgHhzHfA6dughX6jr8GYPs7jBAePYclWUqvU=
Received: by mx.zoho.eu with SMTPS id 1773531110269803.3104059146178;
	Sun, 15 Mar 2026 00:31:50 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 09/23] lib/bootconfig: increment xbc_node_num after node init succeeds
Date: Sat, 14 Mar 2026 23:31:30 +0000
Message-Id: <20260314233144.187273-10-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314233144.187273-1-objecting@objecting.org>
References: <20260314233144.187273-1-objecting@objecting.org>
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

