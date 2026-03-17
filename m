Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78892257845;
	Tue, 17 Mar 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763784; cv=pass; b=VIkr/0rZeh7vgJhMrDfLsV/bfsr/1PumDFCk5exEQiCdIcGvfq1OB8wXZOubcPGaMudMdc17+oEA/iGhyb0siNHSsMHs+DcEx8jyPZascucUxu0RcJR+MjarcKkLsDZYiE3S0EuuP+AKmr7R19KPgcslyUeYC2pJdtz0Ofdf+xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763784; c=relaxed/simple;
	bh=37+w50eN12giG1sxYBeLrwDs7oYHGhVLDIPSz3ka60s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EyIH2d3bAvmG3FLzZU3z94VDkGpkV5sgLl3yfRz9cB/FtQQVoSclLbPeLMwbobvdNA5CtAGQFdRpzL1xiAvCW+6+3DhihSC9UjbGah3t9QH+Pit2FtpQTxm9/KbovXonaWjvRDSCfzaeI6DirMrul+6F/cPqVe1eZWZsqNdU6BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=DKoB/x8a; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="DKoB/x8a"
ARC-Seal: i=1; a=rsa-sha256; t=1773763762; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=J/dHrJ+hU0Pbx354VF3pNimtQ2Uc8XycWTmqrPTToCooDd6DmvoXrgJvhmP5pQyX8Y6FY6hWttRHzTzDihyQmMft09ATxE18hoD1pBIg7G1UZ4t17k5dEyYWrxL8G12Rno5tQVW8hxNFoo2sc3+mJVxw2zTw+hSEQvZDhLaoo9Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773763762; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pnvNz087SDFsoszDGu38Bu2rd0bClNbasbpeXh64ZgY=; 
	b=XJaDqHeazOnuj5Yw98KasoY/6YD09ZKeRYU7OOoXGgGbfVa6PXkx1D6jzgqyXybuJI3cuTOa+lwd53IJ2qld0uALeFRR1Uex+TRhGloAeObG0wrEwNm17p38mxTCvks/gM2Z41D135d8HDFZJwKar46iLwJfaZsEy0kCipFkS5g=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773763762;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=pnvNz087SDFsoszDGu38Bu2rd0bClNbasbpeXh64ZgY=;
	b=DKoB/x8a3bNCoQ9YsE8YuZx4A9dakwaUOl3XX/NmlQ2/LMCQU15bHQRaJxfpdW1W
	E3hUwikIY8QZkf70xpSutewryf3Ozx0BBT5p/egKSABLq16HGULrGjUQTZYNcHQo/pZ
	tCGr3Mx7bblSgt6wNa+BpDndF6EflVcldsFdIge8=
Received: by mx.zoho.eu with SMTPS id 177376375930191.03908404729896;
	Tue, 17 Mar 2026 17:09:19 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 03/15] lib/bootconfig: fix off-by-one in xbc_verify_tree() next node check
Date: Tue, 17 Mar 2026 16:09:04 +0000
Message-Id: <20260317160916.33576-4-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317160916.33576-1-objecting@objecting.org>
References: <20260317160916.33576-1-objecting@objecting.org>
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

