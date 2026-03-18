Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907A3F0AAC;
	Wed, 18 Mar 2026 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849577; cv=pass; b=iqL7/7e27rP9xNPLD+ZFK8HXv9LNE5EookMuL40kL1/IOzz+ARTFhqicYYori9Vfdt0MyaoLfcVL4sp3pstoDHhiQS8FRUKrmTWOTJgXRAuOmXFPl8LSEJ9cq1gF5qJ4p2V1HajS6lxRIX0dyt8OtKG/qDdTJFJFMCs1KK1xbWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849577; c=relaxed/simple;
	bh=z4qpI5K5VuCGCL+LIB0Pg02CYIyxZaHnByIH+LUn4eI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RuwALx6ATpnV6nYkktE//N/zQbXvRNPDfib/aM6cOn8Vm01vDaycf9StcHPFlxQbcGsFbg+n1kutiOPdi8wllOX15nNmiY+R8PSmeEu0ojr3ilFxFaDEMkMLoHVq2CeH974gTRHE583DDJ8savrXRz2zO+fUxGsUu1PR4MnlT/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=XoTl95G/; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="XoTl95G/"
ARC-Seal: i=1; a=rsa-sha256; t=1773849565; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=YV4PPsLt3M3pZfxpwh+Ni6HOwJKYjZpjzcfTXiyDCfCioiPtQJgKa2J9NrnYjsBZqPmCuZ70BRVx9lUiHl9tdyYlmw+T/dSPlNQDZLEA66T9mJb2CKZpsh96GUKeiQNLudamYAuCfF8aVaCyLpViY2dSkI49+hEdATbC5QjKS9c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773849565; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=stHVeUHtUkhvr3p0PGGWk2OqvHsyK4X6A5Msa7FZmRI=; 
	b=ZT50xOhVOOjNgkVZI5YXx9E8e4eizbK28iLQMHQKV9HBBtzKmgbYsO2W9Wd2HUuz0QexFO1Ku4+nj44RmL3n7pOYL1KTpjhywohlO3KdL0Qvy+KKFktju26E4gAExqmbX588XzWfxpUS9NbJf/80750jfTIPrswUcZbPRdBDQPQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773849565;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=stHVeUHtUkhvr3p0PGGWk2OqvHsyK4X6A5Msa7FZmRI=;
	b=XoTl95G/RL4Xv83/B6lzYQwV66FHd19G3BH6fTF4izGjAkmcCIHr8JUWQ4smzAKN
	fFkzgvx3TXJXD25W1NKQrRUqS1/gsykiMxKupNVxnqkKhbjssA5MoHIkvtsT7fP6k3a
	cjKQnIXkkkHh+BFmMT9a6wmUs5YPrmPIDtNat95s=
Received: by mx.zoho.eu with SMTPS id 1773849563077967.2568130209273;
	Wed, 18 Mar 2026 16:59:23 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v8 06/13] bootconfig: constify xbc_calc_checksum() data parameter
Date: Wed, 18 Mar 2026 15:59:12 +0000
Message-Id: <20260318155919.78168-7-objecting@objecting.org>
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

xbc_calc_checksum() only reads the data buffer, so mark the parameter
as const void * and the internal pointer as const unsigned char *.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 include/linux/bootconfig.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 25df9260d206..23a96c5edcf3 100644
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

