Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE752F39D7;
	Tue, 17 Mar 2026 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763782; cv=pass; b=qWPC4+BEbcrQsCsfzAm0VyxBGUAm+knQhi29OmUArMrAvBPpxdPWg2B1bUDhHGw2QpWAhbNBy/z2R0Sgk5+ybmzP3KL2CsGauRjSgVmUDfLZn1GkF2a4P6ypBjWczMeSJS+FxarljgghOM547qsPIc3e2e71V7X60qJfstS8WQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763782; c=relaxed/simple;
	bh=7qcTi1Qw1HGoC100WqAdp0msifIJQXAc1FoFoU3K2WI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hUg2OmuIM8GEyjFWDMdGgpY8fFcWM0ia5+rcz1DOZJBkEMrS/eYTe6gG1EuhU+L16U27e3MDJlwZFqaSAG30w17J7wu0kM9hcAmwbpTxRJNIe8Df2cK/WpwgkHZdhxQ4bqXfwzkoB884XDhmnZ53Ii/O57Dh6PSbE0oUggzO+7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=XwtiSIiG; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="XwtiSIiG"
ARC-Seal: i=1; a=rsa-sha256; t=1773763767; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=UFZ9i4mineM8nan9jVZlV9uUfhifTKE4fPVcwHnfeJYmiCjEZA5tci6OS+6fVZJ0RpB2tjuzv4lf11QZDV5+mYeUJsZCsxPxpGIvhm1Ij80w8d+9njPVfS26m/4Sx3q1ZeYBQgoHtGx7QhuLMIgtU9sSoLlpf4UY+0H4XEGow70=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773763767; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yaW4QSTW/xvXliENDpTM5TzxDHmHb/cNBlikwq/chqo=; 
	b=AvhAuJXxSTbUCivfgzgSxOnD8jag5pFpQjUZFN3tGVcKFP065GK2OHny6B1GWkbHfR/PCvYBicmRqgQKhY+tgNP/miPvfQKiVOMePso4h2i6mDZU0sFhpcco3kk9Mxsi3RmTvuoyQgLYf0s0mf0Woyb+bphr7u3PmGhRO5/A/xQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773763767;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=yaW4QSTW/xvXliENDpTM5TzxDHmHb/cNBlikwq/chqo=;
	b=XwtiSIiGoaSzG5su8Uzc6YsXTDijc775NB/uVYMFZLWbCbdl0WsEercQ7atX9zW2
	ksxjHTB2vn2ZAH7ORakBvmdngJUPyt+TBhrvwnA6cika9ghph9jDkN/VBbtulmsNrJO
	5EaCEHlZi9QT23PHSJ9rZXNvD1HeIR6bQj6PzhU8=
Received: by mx.zoho.eu with SMTPS id 1773763765561822.5473913418199;
	Tue, 17 Mar 2026 17:09:25 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 15/15] lib/bootconfig: change xbc_node_index() return type to uint16_t
Date: Tue, 17 Mar 2026 16:09:16 +0000
Message-Id: <20260317160916.33576-16-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317160916.33576-1-objecting@objecting.org>
References: <20260317160916.33576-1-objecting@objecting.org>
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

