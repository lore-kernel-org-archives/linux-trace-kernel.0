Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689693932FE
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531138; cv=pass; b=G/dsuqsrimT2CAbY1GtYxMvbQ8wL+yzShO7kkXfTitxksysY1vSvlthL4EoDH3bqxp5Lc/8LJkclpX2MZ54fQ72Yzz/14sQghpDCFdRMKVq3TLZNOTWS7JPbPxt2RIhEakaUy6+n7zoBuibLdL3ZE6L1o/357BFmBDpujWhRn8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531138; c=relaxed/simple;
	bh=Tcy477qCr4zjwSxEbmUVpzCk/GlV5mimINv1mxGanLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=db4GbbeBKfoh5/4rVWhKiJUoEom0Fl49X10nclloNHuwim8JJEPyzLWoL8wGU5LxlhjjFCVV7QQ1P/rkQb0HsfcKD2D6Xn3xGCw3MHmq4+s9fJYsjbN0iMMc12AenoN/hDCENwmwDUtqgaFe3SQug0deLhpXHGoB0qGaklQUuIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Tvl7aQKa; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Tvl7aQKa"
ARC-Seal: i=1; a=rsa-sha256; t=1773531112; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=BWCY2u756rJWEOZyey3b6FFQ48O/FoAVZbiMTpOP88FXBPHoN+zFK/GHMv123jBoPkFzoNzXI8Rr6YEKOweQiY5nHE/Nq+/DBt+sD/n7/SWkiZDiONohcWsjeEcKIumSZJHUcAni6Oe9AsjWz2QZtFAsJ3N/pXvC8bN0IY0lDxQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531112; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6J4Zdammh5fpr6R0/8dSlFL0Tel9zMDt6j0TaDyyePc=; 
	b=U6rnsuoTX04iSYlDJf9t87WxG+ms86Al17zev76256/i0A0Cf02947gMkag5vUzPp7CZvSFXOLVY3vuEHBLSIWPiZIh/pldPk2tLk3TCZo/7hroJGLmNerEihNr9nRfYIO6dArI/1eyKBErENXuQBikFf2tqBvxCwE8maJPY1pk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531112;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=6J4Zdammh5fpr6R0/8dSlFL0Tel9zMDt6j0TaDyyePc=;
	b=Tvl7aQKa722gMcZYpTrz+6FHU9vlmyO7gnavXYRyvsOoLiTXxuDJIDbd/Q574NkP
	Q3wgNWgEw2gN36sSBV/Wrd2iUXKL/R+rHRVLblJGLnxoFpGQvemps0yymlNPdhV5Oja
	q7ci6leQ3wbh+30xgpmqc+0Nk5UhtvVV+FehRGBU=
Received: by mx.zoho.eu with SMTPS id 1773531109785703.4886853322048;
	Sun, 15 Mar 2026 00:31:49 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 08/23] lib/bootconfig: fix off-by-one in xbc_verify_tree() next node check
Date: Sat, 14 Mar 2026 23:31:29 +0000
Message-Id: <20260314233144.187273-9-objecting@objecting.org>
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
index 58d6ae297280..56fbedc9e725 100644
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

