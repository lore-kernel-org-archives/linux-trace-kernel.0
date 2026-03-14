Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831E388E74
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524787; cv=pass; b=t71oEcoGBs9FXMIq+2B8dp3sDzmbPC267ImRnIfioyqpGlRuJ5BArGIYrzuKMq/W7LiIA7R6TkFZz9dKPoR4xRwYbpgRuKxQS5kcRZG8lwyN1iGATJ5OjLOT4R3wdGjVkMLAwGCfECsEYcBnNRzORZz4CvVmq4nrROkPcJIDn+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524787; c=relaxed/simple;
	bh=zi4t+/DJAIIM5IKXISn7PUWm3n4Atoo9xTtBef2wQxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sbuJThayNz1lqLkIqoFyw0sfaziizYBTrb7uE8blw5k3J4YIy4mh0iglVYBW36szAz966SFN+Pv9MlMlyKtW31BavFhLQ3pqvDuwG0C5s0yPOaTGFrKS5nn+v4opoMilIF8OKQBPSBr8NGE/ATC3ixkgv8BlfwDCOukyTnmXDqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=kk5FdPON; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="kk5FdPON"
ARC-Seal: i=1; a=rsa-sha256; t=1773524768; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=AntJOQGpnw00zMFdma772NMbSoVMYA1NFxUdLIeeD1vgjYvsV0mv/TEhEoeMcgFWKuCKBmLPzLiYIdfHW/wlaMb7ITUXlSjtZmfAznaiTTp2eR4Yjkk/OS+rTskCH2PMeMv7SokUwKvvp6K4n0W45ExawkwIh7CUNYr2mGa6lzs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773524768; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=f2OYTYVjLEsrHaVLhk0f1BPPR2x/RSxXyE30GvVS6lQ=; 
	b=dDil81GPa+Qzf02498sG+m6ckyy1p4OtpQQHIpGBeOPp4MXmBvpSPHvKFLBAqjeEO9oMNEqMMgajcN6Nu1ZwGK9Ul2jAFmLDko0XeB0NQ8miJhTls9kRXvlnDg8a3NyfpGwXwP8fC+JJG2L2+Q83vxbrwut46QqBdKSbydiGalc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773524768;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=f2OYTYVjLEsrHaVLhk0f1BPPR2x/RSxXyE30GvVS6lQ=;
	b=kk5FdPONbqUBNf7WKcAxLFiKEXJSb4qmyVhozKzeZQMmzqV0/KmH+Yrr0y0OiM/B
	4/5kcrsy6JGDZaso+r8fYaeF9oUgNbvTCSwIwoaPeb1Qhn3y7fnnoWfKZyMHOfymtga
	s6CRRLwGAnsN2bj6Iy3dSetQmJslEBorR4Gf2F7w=
Received: by mx.zoho.eu with SMTPS id 1773524767163269.0816044695938;
	Sat, 14 Mar 2026 22:46:07 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 15/15] lib/bootconfig: return empty string instead of NULL from xbc_node_get_data()
Date: Sat, 14 Mar 2026 21:45:55 +0000
Message-Id: <20260314214555.96217-16-objecting@objecting.org>
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

xbc_node_get_data() uses WARN_ON (non-fatal) when it detects an
invalid data offset, but returns NULL. Multiple callers pass the
result directly to strlen() or strcmp() without NULL checks, which
would cause a NULL pointer dereference after the non-fatal warning:

  - xbc_node_match_prefix(): strlen(p) on line 197
  - find_match_node(): strcmp(xbc_node_get_data(node), k) on line 644
  - xbc_verify_tree(): strlen(xbc_node_get_data(n)) on lines 832, 853
  - xbc_node_find_next_key_value(): returns NULL to caller on line 404

Return an empty string instead so the WARN_ON remains non-fatal as
intended. The warning backtrace still signals corruption, but the
kernel won't crash in the callers.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 0823491221f4..fae4e6790f34 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -179,14 +179,14 @@ struct xbc_node * __init xbc_node_get_next(struct xbc_node *node)
  * @node: An XBC node.
  *
  * Return the data (which is always a null terminated string) of @node.
- * If the node has invalid data, warn and return NULL.
+ * If the node has invalid data, warn and return an empty string.
  */
 const char * __init xbc_node_get_data(struct xbc_node *node)
 {
 	int offset = node->data & ~XBC_VALUE;
 
 	if (WARN_ON(offset >= xbc_data_size))
-		return NULL;
+		return "";
 
 	return xbc_data + offset;
 }
-- 
2.34.1

