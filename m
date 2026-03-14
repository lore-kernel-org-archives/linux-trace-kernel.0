Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53638A73B;
	Sat, 14 Mar 2026 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529334; cv=pass; b=a0N9cT1s15tZmRNZAreEoYtvuEVRXo3XmHp/dwIlyGawqgnH+c1KDl7fMzAlYhyPTQ2PcCub9wjbfe7pBIULDLnkFE35NbP78lv9AfpS5smDtXFaOLhI3bt9j6L+T/v/ext6Ou5IYHwc/Px9BqVJdMgeUdCrLtl12dmqaMoUhbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529334; c=relaxed/simple;
	bh=g0gLOzGvGgBaDelQ1nQAH+bFpUg7Z1FFbkCEaYNyQHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/RD9OWqBh+gYQBAZaIQYtEIm9oBLV+SepcwfiS4mT5vc/DHUV3vLb9UStg3i4TG6gYIy5dAleZJ73gFoM+hVgMbGX2omQj9VkoOGu5e/3D0QGC0rI6hMm54ZeJJJ48Pa5hhpllCr6pkWPk6HlXlw0NrVJbQWraQetv5uREr+kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=TgtnwPSE; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="TgtnwPSE"
ARC-Seal: i=1; a=rsa-sha256; t=1773529326; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=LVmd4T9/wEhNcmbXNcwu2t0jjcRn6Yn+p20zhYNeDQujIgOolwtzoSIENhjvh1qYisYrN8eCq8Pq+B1jvU4b3AeeF8v+a5QXDYo7mRxRhm8pCZXs4HvhZqwaQBdkd847aoX2Q2yCA0f8pCKijkiUoSTCV1y3QBT2tPU0hZSirIk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529326; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/qCjNtdUtGuqj2pRl8MUrYP2ntfBCQat1rATubD3gRk=; 
	b=B9PCn8odiAWviXZfkwc7S88OzxemVlSLtuJ/MRpNJqOvYGvxhF0BgLduiKrXzfOrpfolmOsoIaSlKKIRq27mzs7a1AG1Hfj6IvgyV4YmalNpxVjse8xHqg3hxnB9Hu5GPusB1qhfySMQHPsWHI7mBnEORjuAA+GUzz12fhk+y1Q=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529326;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=/qCjNtdUtGuqj2pRl8MUrYP2ntfBCQat1rATubD3gRk=;
	b=TgtnwPSEZqM5UtJcSt+VfvbT7MMpcCr+J8FZwMK/HLhWxeXM2qO82vPS8CFvh8QN
	0RZbbM7CbwZBOxxyx0i3eB4vVl4h3SsQcYTfvZwzqtCr3Tpm3xfGzyY3YUcb7AYRbYH
	T8gQmVkFfTZDuVhHjung4K7HvysDoWFlaM/sax8M=
Received: by mx.zoho.eu with SMTPS id 1773529323996483.49049098865214;
	Sun, 15 Mar 2026 00:02:03 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 12/17] bootconfig: constify xbc_calc_checksum() data parameter
Date: Sat, 14 Mar 2026 23:01:50 +0000
Message-Id: <20260314230155.155777-13-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314230155.155777-1-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
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

