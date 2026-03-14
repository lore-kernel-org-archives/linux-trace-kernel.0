Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC96038CFE6;
	Sat, 14 Mar 2026 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525353; cv=pass; b=OqHM6t/vIeo/wbyALHszSTSOx/KyiXGVG1TSrwru5W4tHLDPn2sUZALLANEq+UaBQ/aI9ekRHHanoY9e9EFJBByovMYFn2f3221SQrfVTmvyvt00l1NM9AakxqVORfjxSZBAFCxRe+i/pLJDiisgzwvUR5PbMUn1hlOJLkZL6iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525353; c=relaxed/simple;
	bh=g0gLOzGvGgBaDelQ1nQAH+bFpUg7Z1FFbkCEaYNyQHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=isyEW2wsGJtMARgvDae839x+d8GYGIK/SXylehGwSWLHQuKc9vZ4UHWb9HxuC7H5r2B+tNWRP2oEPuYi5cz1xE2Ya8iZYU9VMfHyWE1Jdw1KC4Xj0hcio+hngddfv29PsdLqtkvUABb+qifS9/e2BAtXn1VcJ0ZbdJ4lhKhMRxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=ZnMJu0fl; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="ZnMJu0fl"
ARC-Seal: i=1; a=rsa-sha256; t=1773525337; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=VQJqe1WzgwipycLrD/3bnLHF1HVUPGlpzWg3uXxDJG9fdCPD8HIvJYBLj4rGYeVqMQ6tqciP3WTu6AvfZhmb3Wb3LxbpVKWQx0Oh66YET1RwDDCuoAsT8fLSPRIf9Pay05W0vsXUOdywkTY9/jqnlK7Gd9VOV7ma5OH9oxQuqmU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773525337; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/qCjNtdUtGuqj2pRl8MUrYP2ntfBCQat1rATubD3gRk=; 
	b=YQ0rE+b8bYX0DUdLeCCLg+TT9nCEdH/4IVzKaVZHnFNrTTzpA6+ahteZ6Y8Sk9YtItUSgN4tkpZ5WOqJG1SUtKT3vzqSxduDRoddaKSVZBZ9gkk+qTSlcpWkDFNfcW3vvPzz16TCeT5tdvEa6gvO1HQSf/A+8Gusogt1e8x7FEc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773525337;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=/qCjNtdUtGuqj2pRl8MUrYP2ntfBCQat1rATubD3gRk=;
	b=ZnMJu0fl8GN3+C7VmpnQyHLOnD4Tw9eP2xDkqmMkoS5zkeDpOE0BGQLdQ/V9E2o8
	DK0tNxSo5Vu/HMC+fLLHsPM8vI1iVHtB5ko5DxDPzPVTMyw3BlG+HE480ldmagxydzs
	CK3zMH6250fItgPQ//UHKB1upM/n19qZM18xJJoQ=
Received: by mx.zoho.eu with SMTPS id 1773525334203484.16421197734496;
	Sat, 14 Mar 2026 22:55:34 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 12/14] bootconfig: constify xbc_calc_checksum() data parameter
Date: Sat, 14 Mar 2026 21:55:24 +0000
Message-Id: <20260314215526.108651-13-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314215526.108651-1-objecting@objecting.org>
References: <20260314215526.108651-1-objecting@objecting.org>
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

