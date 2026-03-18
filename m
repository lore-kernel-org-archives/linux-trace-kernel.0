Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826F37AA7D;
	Wed, 18 Mar 2026 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849578; cv=pass; b=jMO2j8vvDjxqa5qXV64eyPx/TygE+szWBtHkaW1zEAb+0TvwPAFVUo5oSI7ZZx7A2AQcwmPdBAWbho9PwnP/53h0RFcM2GlSFEprIYjwa6mZH/kqE0RT5pbuXJNievLRs5N6iQrPu71w2owCOEWwG8NjLmOhtsCBHyDeDVl2yDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849578; c=relaxed/simple;
	bh=37+w50eN12giG1sxYBeLrwDs7oYHGhVLDIPSz3ka60s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N9y7yvgFsRjOb2Q2NGmebe1tDXW44QwolcnuY1mEJyq/k5r2C20+OnDb2sTTgenC/F+ajZsp0ji0N0Eyj/QRn8bt25I5ofT8JPoH0T0pQ1brN3qBvdm+MuIRdx7LkyvaiFgjE+cPXVFpfV6y8zPr4+CAnsTvYsAkZOs2j90Pp+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=lstcYk2J; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="lstcYk2J"
ARC-Seal: i=1; a=rsa-sha256; t=1773849563; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=lSOtl9pufybga/2n4wl0D4uFGTC6MBBTwuwznDoNQRV0fy658HrZStEM6vjzAnqHAvRrxBQYlIWDSrPY8mgUCLqvo094efV/iuV7mvAyJ4gT1Tk3Q95rreyTFlyX5wLzCzkL8Cq+R/i/t1chTDd1ioby9t0oi+0oTgf+gV5d3V0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773849563; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pnvNz087SDFsoszDGu38Bu2rd0bClNbasbpeXh64ZgY=; 
	b=jtqu5klUtSlQRtCmip0zv8fFy7PBkjD74rfl1YUcvLuOFtQNbhkQuvYF8JaOZo3s1oDzoKBkWoxu6q4tJxX8AueqJDpraahoddV4eajp5yeOWceiyENJsITj6rXxK50ES/WNyS777KKcQwTREs6qRJ5K+uCk5eLkKb2Vg6fCR3I=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773849563;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=pnvNz087SDFsoszDGu38Bu2rd0bClNbasbpeXh64ZgY=;
	b=lstcYk2J6V/vM1s8PP15ST3GkK6zbXH94R8lGifm3gNtjCjsi9dAdBcbvGbVKyB8
	/Wo/R3G6fh3Wl6ImjFxXmxVO9h90NV292TyUpFGlw6mBm77s3WGYWiyclUUsG8jDLq2
	9lhhgjdStBZP5K5vJZxiPKMQiQLOwpMz1SisS3m0=
Received: by mx.zoho.eu with SMTPS id 1773849561598528.7915120494015;
	Wed, 18 Mar 2026 16:59:21 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v8 03/13] lib/bootconfig: fix off-by-one in xbc_verify_tree() next node check
Date: Wed, 18 Mar 2026 15:59:09 +0000
Message-Id: <20260318155919.78168-4-objecting@objecting.org>
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

Valid node indices are 0 to xbc_node_num-1, so a next value equal to
xbc_node_num is out of bounds.  Use >= instead of > to catch this.

A malformed or corrupt bootconfig could pass tree verification with
an out-of-bounds next index.  On subsequent tree traversal at boot
time, xbc_node_get_next() would return a pointer past the allocated
xbc_nodes array, causing an out-of-bounds read of kernel memory.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index d69ec95d6062..ca668ead1db6 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -816,7 +816,7 @@ static int __init xbc_verify_tree(void)
 	}
 
 	for (i = 0; i < xbc_node_num; i++) {
-		if (xbc_nodes[i].next > xbc_node_num) {
+		if (xbc_nodes[i].next >= xbc_node_num) {
 			return xbc_parse_error("No closing brace",
 				xbc_node_get_data(xbc_nodes + i));
 		}
-- 
2.34.1

