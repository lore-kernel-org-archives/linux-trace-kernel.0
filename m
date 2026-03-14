Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FC139183A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531137; cv=pass; b=bLSQUI6dMRixBxHx+Nj3PXLbPZqViI0vcyEeIbhkO7/pNYHDrYl78oeivBx2XyMjCR96wz9fgMIewbinLLE7APPicB2G+HvrBS2QVbobkGtD7tlfnxN+hUW57adrCiVNRr/cJ8idZF7V08APsMjIqJzt8Sipn7+kSzhMy0qotnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531137; c=relaxed/simple;
	bh=2jZFhcm65pVh1my7aFVnxTPWIZ+otcDP9/Gf4KWRft0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=debLpb2abDqT1NmIJNtllf4Odr2pn074yL/QLCPD+5yFz7ddWRGnEM8kvQeeH/0l7srulOK8a2azYkJCi5D9T9rI5Jx3PRAk6lZiLR28DhTH3QodQKW+0gQz/qy0DEGjjsgAlJlD8TWyMGajPmcUAWZ/rJQPYAaFqFmXi2npzas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=LmYHNEDz; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="LmYHNEDz"
ARC-Seal: i=1; a=rsa-sha256; t=1773531110; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=fPTShrVEZFH01B1Yi2nFL/ch8aF6L3O3HRTYprGCeCbZ4+bB8y6K6POdWDFERD9s3c4GjKS6vJn7C/3KJ7kv4ZQvssbHiggbhZvzZLVwt9F84X9/aSmPqMotfWBnvGpLEvpEf2REwnHRGRYvvsuPHo3p0dnUC0hpWq2D4MQ1/iw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531110; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2lprVVDRD4lH3M3PsJ+R627NsZ/o1XOLdXFW/LZVSKM=; 
	b=OuQ3AqNAuPBN43fOEdqHaalb0+9Zyg5Ocz27WvcpCyEvPekTrSsBh1/uk6EJuyWOGd8TrJh1TLm21H8AumNUBmBBukoaulMYOiyN4cV6wktLAdF7isiOL75wKGxpIyUcmTYf9q+CPyo2g+P6Mgnom3441joPnw8tpil7nn3Y96c=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531110;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=2lprVVDRD4lH3M3PsJ+R627NsZ/o1XOLdXFW/LZVSKM=;
	b=LmYHNEDz7yc/FGbmG8jfJy85KZpp233pIL6UjCLUwUxplyT632GnQfbCQwkdMMGd
	Q8CohF+0s1JfD0/HIkI+FU7j8/HFvknxEJDlRewH6xlGn71yi5WcfXgYgYua5PYOGXt
	a0XAEMm5E78YT9ZLvSHKcH3wCW2/mDY8WaJmf+ac=
Received: by mx.zoho.eu with SMTPS id 1773531107838857.2882704036346;
	Sun, 15 Mar 2026 00:31:47 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 04/23] lib/bootconfig: add blank line before xbc_get_info() kerneldoc
Date: Sat, 14 Mar 2026 23:31:25 +0000
Message-Id: <20260314233144.187273-5-objecting@objecting.org>
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

Add the missing blank line between xbc_free_mem() and the
xbc_get_info() kerneldoc block so that documentation parsers do not
associate the comment with the wrong function.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 35091617bca5..e955d2f7e7ca 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -79,6 +79,7 @@ static inline void xbc_free_mem(void *addr, size_t size, bool early)
 	free(addr);
 }
 #endif
+
 /**
  * xbc_get_info() - Get the information of loaded boot config
  * @node_size: A pointer to store the number of nodes.
-- 
2.34.1

