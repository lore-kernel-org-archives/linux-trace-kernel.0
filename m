Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8B03F20E8;
	Wed, 18 Mar 2026 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849585; cv=pass; b=JU7mJKAHaOaqKHPZkxAMFaSTa7HGQtYeUpRzKYimKWx0NURkEfh3EOCG/EtJr2/TKfQV4+scPOcGRR/ueq5sEajOZFMmZqyR13vl9wTEAhGgNmFjQbCKvp9lt7P+2bA+eLfIwP7wHMSY/cb2vddf2BGCw3BBr3w5QkEYRwxDVMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849585; c=relaxed/simple;
	bh=7qcTi1Qw1HGoC100WqAdp0msifIJQXAc1FoFoU3K2WI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vA+rPj9+URjg07lRHn7+BSN+8tmzCmvIaCmerdnApOnFj98Z2y/mEV4w25emI9Mb6m6u+FH3JtJ9ztmCGBVF9iiHWwyBpL5QjDvmUWHB0C6t6PEWZiiaH0pLBmI8NJ4h1vdiDtynMZpmhgm0Qi6eEyAtsNHQ89OTXFel+3br8hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=kaOcrLmr; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="kaOcrLmr"
ARC-Seal: i=1; a=rsa-sha256; t=1773849568; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=U6YqkMO+FnPF8KmFZa519CwFE+1m+T1dvMysN8PoJTCPFAluR/wD9wKJMXBAB0hC9Nu60w+RHYLi5/56x55V9M+Ac2hBZbkKfsXsUMClWGt6jcmZLLuopAN1ZyHXctwzsElrJCxYlmLWoyqbDD4Wd/Hs/eHhMPUQMbglnGnYrxo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773849568; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yaW4QSTW/xvXliENDpTM5TzxDHmHb/cNBlikwq/chqo=; 
	b=Q8xcSNZv5JqMFwcFu6qcIiBuMl2sWY2KCKxW9P83Flijr0VOIZN7Y7BihCz1PuvzhY6I/jcFFqx7aVey31oOWE6LBAizCDx/o6Wxd6vKVTWd9jseFHqc2SiVJqakeiYUbA0D/4cTt8RlZEcg2KqWM3MPARI2Cs5UOB/JEjLnHt8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773849568;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=yaW4QSTW/xvXliENDpTM5TzxDHmHb/cNBlikwq/chqo=;
	b=kaOcrLmrqguSO6pma79TwDko4XHccY9CSEGSRsRO7j5g5D6sIYAAU2sriI5IhkBl
	0ljUBrmf8Imj2BokgcItChxhZ8Lz98zNJisNhEgn6e86ktHn5AS6i2/qejGP4zjX2vv
	99DXFcnB0sm5/+j5WlX3/z08e2kvuh5Y53pgtNVs=
Received: by mx.zoho.eu with SMTPS id 1773849566739722.7590972969375;
	Wed, 18 Mar 2026 16:59:26 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v8 13/13] lib/bootconfig: change xbc_node_index() return type to uint16_t
Date: Wed, 18 Mar 2026 15:59:19 +0000
Message-Id: <20260318155919.78168-14-objecting@objecting.org>
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

  lib/bootconfig.c:136:21: warning: conversion from 'long int' to
  'int' may change value [-Wconversion]
  lib/bootconfig.c:308:33: warning: conversion from 'int' to 'uint16_t'
  may change value [-Wconversion]
  lib/bootconfig.c:467:37: warning: conversion from 'int' to 'uint16_t'
  may change value [-Wconversion]
  lib/bootconfig.c:469:40: warning: conversion from 'int' to 'uint16_t'
  may change value [-Wconversion]
  lib/bootconfig.c:472:54: warning: conversion from 'int' to 'uint16_t'
  may change value [-Wconversion]
  lib/bootconfig.c:476:45: warning: conversion from 'int' to 'uint16_t'
  may change value [-Wconversion]

xbc_node_index() returns the position of a node in the xbc_nodes array,
which has at most XBC_NODE_MAX (8192) entries, well within uint16_t
range.  Every caller stores the result in a uint16_t field (node->parent,
node->child, node->next, or the keys[] array in compose_key_after), so
the int return type causes narrowing warnings at all six call sites.

Change the return type to uint16_t and add an explicit cast on the
pointer subtraction to match the storage width and eliminate the
warnings.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 include/linux/bootconfig.h | 2 +-
 lib/bootconfig.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 23a96c5edcf3..692a5acc2ffc 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -66,7 +66,7 @@ struct xbc_node {
 
 /* Node tree access raw APIs */
 struct xbc_node * __init xbc_root_node(void);
-int __init xbc_node_index(struct xbc_node *node);
+uint16_t __init xbc_node_index(struct xbc_node *node);
 struct xbc_node * __init xbc_node_get_parent(struct xbc_node *node);
 struct xbc_node * __init xbc_node_get_child(struct xbc_node *node);
 struct xbc_node * __init xbc_node_get_next(struct xbc_node *node);
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 272d9427e879..57f07e33868e 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -131,9 +131,9 @@ struct xbc_node * __init xbc_root_node(void)
  *
  * Return the index number of @node in XBC node list.
  */
-int __init xbc_node_index(struct xbc_node *node)
+uint16_t __init xbc_node_index(struct xbc_node *node)
 {
-	return node - &xbc_nodes[0];
+	return (uint16_t)(node - &xbc_nodes[0]);
 }
 
 /**
-- 
2.34.1

