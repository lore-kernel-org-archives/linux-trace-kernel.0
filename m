Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4639183A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531139; cv=pass; b=M3oRSIqwoxerD97reu/XQOSzAPXi30VbsBYzE7J254IYehE+mYQOqpaf9UT4dkyxPA1aO8XJj2A84aU7fdOjRxDDQxG7lSEx+OQnm0/h70GEHHcVfKgYCfRgY7TVLHUsbVXvKAetV2c6BZpiPv2N8Hz2IIGCUBLhzrCclNJw2AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531139; c=relaxed/simple;
	bh=JDJDCRXv0WDR5QTOFLbH+ZVs0fEY0qu7uRZpAINLGYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQck6l08fjvzgqYAoLc7u8jZN1bXBRgTTd3E+NJYqxBwkXUS1cMIMRYAibiucs9+HkL1uJnubTiVn7+rUN+sHRsKG4CfuPXRCCG/M+VVNnv+mzHlT9xRmTgDMHv4hy8uJNdF4ESVb5gJOAPCiuShEhdcdU2tYkpybHwSdGUkjpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=J00uUaCr; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="J00uUaCr"
ARC-Seal: i=1; a=rsa-sha256; t=1773531117; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=X74onS2N+hvrNYCQcabNBM4s/T35fat5L774Sq7TF4MXJZVwHwHplL4NIr2GpcdCSHI3VOCgnD0aj6Xu6G1Ih+LKvWOMppD0K/j+YWm3jUqwI9Hv8Tg1IjdBuwpoNzTTBuYbcK/aIFqgyTHLU94Nh1emKYt0S2xPYrxhM50I9vM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531117; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=c0YHvSlmLDD7UQSPU1JDzf6Bfaf0j0xk6wf6t7LSyAU=; 
	b=Za4Z8evndBxCMV/y1kxt43u4JFfXSf+O8BgplTJ0v3fWfPaW6sPuyB+jzOjxL60BRcqMYLcKUrpviYVGk6A5TUWaAFMsgHu3+gGJ/ZHZn983PscaTfTW/oFJWmDZ/T7GVxYk5ZKpOddRWhn1nJutFz68ol2wimJI4JvZz9hWk5M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531117;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=c0YHvSlmLDD7UQSPU1JDzf6Bfaf0j0xk6wf6t7LSyAU=;
	b=J00uUaCrC7xHAq9HhYiJZuEYfX6PVXKsFutnNAR6eKLBwCfouAfkOOa8ahJkcSa4
	WMD1bz6JcPQqfLX43hKVyQ2mmw4EL7tc/A3LPHyAtWGEgXqKjcFoB8VUa7AGVgSiAFu
	4s5x7IcTu6J6SFVrsHTvZghOyl9t1PWxP3SOWypA=
Received: by mx.zoho.eu with SMTPS id 1773531115243700.8454415412016;
	Sun, 15 Mar 2026 00:31:55 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 19/23] lib/bootconfig: use size_t for strlen result in xbc_node_match_prefix()
Date: Sat, 14 Mar 2026 23:31:40 +0000
Message-Id: <20260314233144.187273-20-objecting@objecting.org>
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

  lib/bootconfig.c:198:19: warning: conversion from 'size_t' to 'int'
  may change value [-Wconversion]
  lib/bootconfig.c:200:33: warning: conversion to '__kernel_size_t'
  from 'int' may change the sign of the result [-Wsign-conversion]

strlen() returns size_t but the result was stored in an int.  The value
is then passed back to strncmp() which expects size_t, causing a second
sign-conversion warning on the round-trip.  Use size_t throughout to
match the API types.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 806a8f038d24..995c2ec94cbe 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -195,7 +195,7 @@ static bool __init
 xbc_node_match_prefix(struct xbc_node *node, const char **prefix)
 {
 	const char *p = xbc_node_get_data(node);
-	int len = strlen(p);
+	size_t len = strlen(p);
 
 	if (strncmp(*prefix, p, len))
 		return false;
-- 
2.34.1

