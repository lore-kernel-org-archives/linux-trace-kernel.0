Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A06138C2CB;
	Sat, 14 Mar 2026 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527682; cv=pass; b=ZvvJnnCgWbLJnphHa1UVG7BmTYqoU+eQcjkMyTfUJNEOPvu9+cOZ4rLJ1TPqaukHUMKFjxM740G5PVbq6kSNSivm4Ei8x4yB0TC34S+eGdHoWxnoTn6ttoBhzGQ5sXjVLNhA0cw+OQMVk/kGy37jGmsNF7sDEF2fbAnA/iPKcfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527682; c=relaxed/simple;
	bh=g0gLOzGvGgBaDelQ1nQAH+bFpUg7Z1FFbkCEaYNyQHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B2Y/muagMu8qrC5AYpGpxlWZGNl1B03V0VM2DLxm7UkIHxJ007x2Wm9rbxOBP3DUqO+pKAGc0ER6mZO1EYI/SEdHgu7InVF1A6wAwVJI7GTPfflG07bOAJa5Ztf6HCiTbk64D6zpSabZwe5tEjKbFCUYyeD5mWu/ZElHk5Xmxk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=PsPLy1ay; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="PsPLy1ay"
ARC-Seal: i=1; a=rsa-sha256; t=1773527674; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=HGVn34mySdNeBKaoQVyiwU2aftE6z0iZQPhKUGvLbzxfM9nylB1+pzNEwao5WryiKiYput42jZvgxP6nYGNkhqFLdOqpZZWyZkIIpk/ZkUH5+2b1QtyyRdntkBX6y9QUTtmvM89wVA9dNGs94AzyQRhJ+CRcRvS0RWFgtT/suGk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773527674; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/qCjNtdUtGuqj2pRl8MUrYP2ntfBCQat1rATubD3gRk=; 
	b=DVOTapKHUAr2/IlsS1gdgPHhX6c+wLBvgQBIMBYimVKSx4vMgbujHNf68xdfHboGi3kYuKVgEpQQ+s/oCUxZ4IIZcOiAt49jhv731wApmq0ou151T3hX1H1SNcvc3i12mDTg11NjoZIfDL32JyoM962Jrrl0aW3r7AVng4YKDXg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773527674;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=/qCjNtdUtGuqj2pRl8MUrYP2ntfBCQat1rATubD3gRk=;
	b=PsPLy1ayPpEbeQdzQVaKPReUkcVVN052YiXYoOnlBazaLmG8nxQ+5Dvi67vS6IiX
	NRgJ92OzSCpX40BBuzsJIssAwQL9FplMp6UuEcUHTAIp9tcXBeOu+g/jEDcbNfZ3b/X
	ItdRJLsbrs/I4MbdlnBuJ1+u/5BjXyTF+BSJH/MU=
Received: by mx.zoho.eu with SMTPS id 1773527672913396.42157960141435;
	Sat, 14 Mar 2026 23:34:32 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 12/17] bootconfig: constify xbc_calc_checksum() data parameter
Date: Sat, 14 Mar 2026 22:34:20 +0000
Message-Id: <20260314223425.142966-13-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314223425.142966-1-objecting@objecting.org>
References: <20260314223425.142966-1-objecting@objecting.org>
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

