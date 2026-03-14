Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C41938D687
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531133; cv=pass; b=RKb21XEz5SZSvXm6IlcO8dJdM4i/sEhKeEV9NOr3qYq2xcz8TEsnMDLDlpWlbsCq4uUbJ5KGTNcDAe3aMoP2fw0pvfUFKR1yYWVYRrWGneFEeCW3SyKRX9T4ziO4sfLTws3fV1WATP1KpMg2DllUWg38RYWCVCzGTGniclMrmMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531133; c=relaxed/simple;
	bh=g0gLOzGvGgBaDelQ1nQAH+bFpUg7Z1FFbkCEaYNyQHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mLQ8zMdPjiHMVfz32SMgUJuEhK+XBqcomDVc5c5zRSjBJInlZ5KMwYKQfhZI5/bI18yvjKpX1BNUA662AJ+y3vrGkia18rlZ4VU+xMoT34AvCXCD51wLshaDl5WgXFN5FgEMzeZYzxZJ0Nejt7H4YFbVLtc38Wdc+ic7E4ckMpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=jYEOYsV4; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="jYEOYsV4"
ARC-Seal: i=1; a=rsa-sha256; t=1773531114; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=LkQBCURi8M3shwM8QAS/MvzKm48ybOddZwBB4CGDhpwAPXWKkupRaHI7wfOz+4nSyJYdHC/dlWBFpwAZoI16dvABysvsrFCLvSdjIfV88tr6QzTk56dlP9A0W1vTG6fvNaewRWOM2Fw/J4tGYU/Z27JKXbQO3Gwq1dz/olhjqfc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531114; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/qCjNtdUtGuqj2pRl8MUrYP2ntfBCQat1rATubD3gRk=; 
	b=jIVwvGDcztwvG34HACN3aga1jBf3BBMldzU55NSQowZ/0mVvp3hW4abaa0j5QaoAnFRPHRp7U7kAOv85m/9d4R3NTUhkhfnlCoTA2wP+2WAPVS8YhFdrwUi80/bzTMmSfwBKSjVYlFK7r8OlIUXHDU3/ndXUTVndazm3Fjd1xUE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531114;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=/qCjNtdUtGuqj2pRl8MUrYP2ntfBCQat1rATubD3gRk=;
	b=jYEOYsV4HPnf/dPiTM6l7Z+L+q1GzrbbAdhNLjDDiL8KGR5hlY4PCegNRekrDBP3
	XcQkRb0m59wtcspoFjl0qTO/XjiI/rKQLkeJkqK0ZpgtPLCNjln/2F+15GycWlsy0us
	Spey7Kk4ezQtSyUr9pDztr+o8nI682ZexfpFAtIs=
Received: by mx.zoho.eu with SMTPS id 1773531111798991.6404906147902;
	Sun, 15 Mar 2026 00:31:51 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 12/23] bootconfig: constify xbc_calc_checksum() data parameter
Date: Sat, 14 Mar 2026 23:31:33 +0000
Message-Id: <20260314233144.187273-13-objecting@objecting.org>
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

