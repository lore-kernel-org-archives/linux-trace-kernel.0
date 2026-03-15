Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3834CFD7;
	Sun, 15 Mar 2026 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577231; cv=pass; b=mla8mOsgZBSsT8xpKfAMSbUC6/O7lMzeZF085Zf3dDuvOt/emZ1rzK5YcvfygvM4GgA03IDlglvG0m2g5EucgWS9pEcSyz90izMCu/ICbKRgDjunzhU0xJBCTlDZ6nBUZKvhkpCFpDGHq8vv+1fFuXyDzZE0EW7u+ArsSpvRcjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577231; c=relaxed/simple;
	bh=z4qpI5K5VuCGCL+LIB0Pg02CYIyxZaHnByIH+LUn4eI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WfVS6BssVDGEHx7p+u9zig+JUzNwLVURDOW0aTEgYCG5cflyyGiZa9XQaNnDLVPAmQqRQtmSf9tXT7fSfnlYIS36Ae2aBWXlqQ47A0vhK9twFLw6PZGdWzc0M+HlIIbvLEQkaJ/BPMU2UEyFk/CTt8s0aK2VAsyy0/5rgrOWgX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=bAKKp1pA; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="bAKKp1pA"
ARC-Seal: i=1; a=rsa-sha256; t=1773577222; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZLL0MBYLINXGLTDIPAFtSn1U66S0h8YpBN7YOPRTDzJr0LsecGfKU20hoF6qW6CJPeXB4flr7QxMFB97pxho0GyJFSrCAZLfjg0Vln6/5QEjSCW7I/f3NBusFKDZSQ2aBZTsiQr2Ck+3xUBKZYWYOJuF51B5E7lp2ESJyr8yTFg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577222; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=stHVeUHtUkhvr3p0PGGWk2OqvHsyK4X6A5Msa7FZmRI=; 
	b=MXOFEic8tltWtDaGbb5XVqgdeofWCWWX/N23XVJnftu+zFx9WvIWr9KuPs2po0yuQAgRwZv01Q0uiAlnuncTd/Tm0b/KXQPgpk/trzubZbGfST0x5uLBmhgX+Uvl/GGN8kG0sCUFKi03OaxXBDOxjWMa6GIZarNwdJNZkD1zw9k=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577222;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=stHVeUHtUkhvr3p0PGGWk2OqvHsyK4X6A5Msa7FZmRI=;
	b=bAKKp1pACWI20c0PqIr9zYQOcIna+bZMCwei2e0s609Za54pYmu+aXCweQq2+agK
	BJa7P61wSHZXLA/qL4o7L+Gr2MWFcHnNi1nyRV7Mp8WtPEzMbmNmTPnHhxu3V7PX39k
	KfvIPvPqKaMDnUqv5roH7vd/3THop89QzTvxK7Bs=
Received: by mx.zoho.eu with SMTPS id 177357722137437.60846912355282;
	Sun, 15 Mar 2026 13:20:21 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 07/17] bootconfig: constify xbc_calc_checksum() data parameter
Date: Sun, 15 Mar 2026 12:20:05 +0000
Message-Id: <20260315122015.55965-8-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315122015.55965-1-objecting@objecting.org>
References: <20260315122015.55965-1-objecting@objecting.org>
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

