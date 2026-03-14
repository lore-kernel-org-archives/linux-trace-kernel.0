Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD47386566;
	Sat, 14 Mar 2026 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529333; cv=pass; b=dQbDfZUbIuao+tzb7kC1hW8CabibVhmfmomrlo5I/TGeTpRy7faW5nANWP2C1s8/oYVftzMkjcHsdTypPLwiacK8gJAT0mLyLSgD6Wm+PZxcJwSsfrUjOsVjsfsYlWziwimMYRQIVtC3byouBubKNsvR1kZUhO/S3BUeS9X4uCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529333; c=relaxed/simple;
	bh=Tcy477qCr4zjwSxEbmUVpzCk/GlV5mimINv1mxGanLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+oA+wb5R5hBsWOwZcivuLp6WpWPcsqpaADZxOfvLXxhn/dGzdHosU7e0xWFcq1Oad8WTQpiufZawN7SKxDcpuVM36+X8+vQ2bJ/MTcdjt+l78mXSQUz/MyIfBAxmPnCPahtKKCXQHVjjpxTNdL+HSF7VxxJkoj1uIV1BDQtryA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=J4vV9r30; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="J4vV9r30"
ARC-Seal: i=1; a=rsa-sha256; t=1773529324; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=IoMYccxo81TLHOSoZoeq1P6WtkdBitZHNr/+gOJctEsDHlIesGSBcXlARLA4NiwVM/N4nBIsyzj6Rlq/Sg7BVVAa7VC7UHdOVW6WY/H+YjB7KUgdtVdsO2MLq9tey4v+pxJRxpl6/wVw4McJfg9cBv6H4Qq8aWwjH5KcnlRTRWI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529324; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6J4Zdammh5fpr6R0/8dSlFL0Tel9zMDt6j0TaDyyePc=; 
	b=a+mxImwFr27tdtIMqqW43OvCC1SQyYZD9l4kdndkD+WlJ2xFdnS+bYZFds5kMorurqvcFwMRgEHJxC5KysP/J94teDsaQwjvj7XiBuvQTiOuSuC5alsJqQBs3PXoHnkyMBaqhFkAwPEr641usFC3tcxYpx+HjefDm+hLh9DNriw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529324;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=6J4Zdammh5fpr6R0/8dSlFL0Tel9zMDt6j0TaDyyePc=;
	b=J4vV9r3044qW6Q5VvRJvBYhv3WXuGZMaumNDWBqq5G/WfhZGaEhrYqMVhtyVo63g
	n4gXZ6GzIW6gNW9NES2Rqi5PJb4/xBx2iIO9LixGIw7r2NuiMIo0KVE23Owcqg9yZFF
	K7P5mHLTMoySwRw2IXSzlp3799Ob+sRt2rgBJwTI=
Received: by mx.zoho.eu with SMTPS id 1773529321739979.8573451577365;
	Sun, 15 Mar 2026 00:02:01 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 08/17] lib/bootconfig: fix off-by-one in xbc_verify_tree() next node check
Date: Sat, 14 Mar 2026 23:01:46 +0000
Message-Id: <20260314230155.155777-9-objecting@objecting.org>
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

