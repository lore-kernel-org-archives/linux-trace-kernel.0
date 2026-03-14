Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAEB3845DB;
	Sat, 14 Mar 2026 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524776; cv=pass; b=VKjLddGjgwyeUGpMrhFhwDft1odcqrYX7A+Ilr7EQRyDs74jldvz7rNOuvQECbNRDXUbvABnZDAUIVIqh16SsJUDYeQwfm5nG5R6WHzWQMZXp5Or7rrS1ZqnpxyfORCWqrETuT/jSVZ4nto2DECpLkVa57Atj0XbAF9Jb7Cu0z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524776; c=relaxed/simple;
	bh=UvLyNGwexYo2cn8ocKvKWmvyhLSh4vWkr9PLO2DssME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q+2x/I3ZMqa9eSVYBOZmDtM8XFPhrWi5i6K8JjStHkMHQY/cPUGvGWAZjtnD/tmKQMpgmILwntJRpd0ajpmKaJt+IM7LnD2Ou9G5b9I+J+A/2tXDVgdfTNFsdY5BrZN3xUP13A40X3jWiebrHLi/rGrqSGV5JR9W8poBhFa7vTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=OCEAeCgy; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="OCEAeCgy"
ARC-Seal: i=1; a=rsa-sha256; t=1773524760; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=GzYI//ZYCk4l2nzAmFq2H6e26sUAjiE07b5xjPWk7u5H5kuUhpjGV8imm3GEP0rkUM/ciXFkCBH4OLmzoRhTdp/VwszwMBxApmZab7F/B5+u2wQnvPVi/9MgHnOUnLLj3saxHYj8Sre/cAcX+iGpQzM/HVf+DsLaxNIwREVVQr4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773524760; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cBOmSVZK/tdF2G9FHoUjRcgfEXBwIZcdPH0TEKRTIUc=; 
	b=gL5ODOhzZ6FSo0RyZxIIcEy7HrVjOs3BsAsMKuUu91BuEBD8YYSYp9yEFj7d4k9gHqm4O4GJRDDAYu2NvNC454v2qgnNCW50UVbBZstEAuMMlO61SBB2Cbeq1+dd6Yv0UuNT+IiHTLJUqDtioOtlibVsBkZg/pUYQPN523ZJfXE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773524760;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=cBOmSVZK/tdF2G9FHoUjRcgfEXBwIZcdPH0TEKRTIUc=;
	b=OCEAeCgyHRvQZGC5cSApMVRClc9QB9BWR8jvQTZWAI7/JflNSwXT2h4lP/4+hjTD
	lAKnSVNPsMzaEV6X6Je9uB0axZp5Q9eYZpMYC0YDBH5/JubjZ09dRUPUL9nWXUdYn6f
	jROkqeSYkUhtEbN44LDkU4egk7+itp3MmvRFIFCs=
Received: by mx.zoho.eu with SMTPS id 1773524759263252.44955296371552;
	Sat, 14 Mar 2026 22:45:59 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 03/15] lib/bootconfig: fix typo "uder" in xbc_node_find_next_leaf()
Date: Sat, 14 Mar 2026 21:45:43 +0000
Message-Id: <20260314214555.96217-4-objecting@objecting.org>
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
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 53aedc042f6e..35091617bca5 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -364,7 +364,7 @@ struct xbc_node * __init xbc_node_find_next_leaf(struct xbc_node *root,
 			node = xbc_node_get_parent(node);
 			if (node == root)
 				return NULL;
-			/* User passed a node which is not uder parent */
+			/* User passed a node which is not under parent */
 			if (WARN_ON(!node))
 				return NULL;
 		}
-- 
2.34.1

