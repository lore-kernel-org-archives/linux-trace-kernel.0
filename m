Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789938758E;
	Sat, 14 Mar 2026 21:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524780; cv=pass; b=tvl/BSz1NOQM4DXMi/BOXs2A65MMfX7JcU50Kiiw+gw3cxHx7L9WVnz83pHh8oP2zNCpmm3yhf0U4Ewivkm0Bjyqp8Yd9o9XZSd1ymKvrZOqOiIhZoxNp2KMFLP7g3EBwqXkL0bfU1QdhX+RBeJOzXaoBE3i8rsFzPUA1Ojmwn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524780; c=relaxed/simple;
	bh=g0gLOzGvGgBaDelQ1nQAH+bFpUg7Z1FFbkCEaYNyQHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9fXIz14jO5xBKtxZez5vQklkOrEQhewWkILdI6ZYwfojbdZ0oM4rUmbppBIXLLWfh9pqRNx5f4EZHPVsxsmXImwRC/1tJK96GmJvj99nTOntdfzLkOLzSr0iU23Hk02w0Ny0d4vvY8urFWMmfKzqvz+1ivt46A97F3Cpbwy6sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=YdXVVKR4; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="YdXVVKR4"
ARC-Seal: i=1; a=rsa-sha256; t=1773524767; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=bKtLt7izo+AsAEgsF7alxRYQmmws1n72Mf5KDx9pAyls+pq0+0XVDVkktqZL4dCB9BpdHvgjr5kfaZCu5sWFSYRXQDGwO+Dp9yBVgZmlO/rmbKgLKGArvo8diHNma3isz1v0NYeMK3HJC2M9+03Nd/BM0JPI2gdy3dXYvag0iso=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773524767; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/qCjNtdUtGuqj2pRl8MUrYP2ntfBCQat1rATubD3gRk=; 
	b=jLa6UJ8gdELDhJmsDLujw1Warvd6uFQe4Sv2/3QnWkpY0g/16T9nnmTm/0ypUgUv12uLnzx08/jERKWN+qvyqxPRKybAT2AngUzQnNUc9oVNTCflb3V3OskNEbEyqGuKarjIgI9N/K7tYtHjS3UUTa7p6qnfH/EzNygwOO30VEw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773524767;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=/qCjNtdUtGuqj2pRl8MUrYP2ntfBCQat1rATubD3gRk=;
	b=YdXVVKR46Ku7L0Pod15rOju8cKjLkM/oJzfcWCDqp30BnPLIraJIsX027ChwJNzC
	e9q18JouG0chwBxPA0o0mYmvgeuPQWR3OJ6nCZMV0rzDK2DbQ2p2mkLgy38vHbV5uHf
	4vdBVhJxGW0+OxYMhMtGZoTlWCsHgPP8BhqHcoI4=
Received: by mx.zoho.eu with SMTPS id 1773524765216912.3233082346866;
	Sat, 14 Mar 2026 22:46:05 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 12/15] bootconfig: constify xbc_calc_checksum() data parameter
Date: Sat, 14 Mar 2026 21:45:52 +0000
Message-Id: <20260314214555.96217-13-objecting@objecting.org>
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

xbc_calc_checksum() only reads the data buffer, so mark the parameter
as const void * and the internal pointer as const unsigned char *.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 include/linux/bootconfig.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index c37e0096c4f1..d78c2b62debf 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -36,9 +36,9 @@ bool __init cmdline_has_extra_options(void);
  * The checksum will be used with the BOOTCONFIG_MAGIC and the size for
  * embedding the bootconfig in the initrd image.
  */
-static inline __init uint32_t xbc_calc_checksum(void *data, uint32_t size)
+static inline __init uint32_t xbc_calc_checksum(const void *data, uint32_t size)
 {
-	unsigned char *p = data;
+	const unsigned char *p = data;
 	uint32_t ret = 0;
 
 	while (size--)
-- 
2.34.1

