Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C756223336;
	Sat, 14 Mar 2026 23:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529330; cv=pass; b=uFr39IY6o+Be3bvOnsQZAGlq+BKry5ERJjRWH5gOEEk6EAaTDsGhit2IrItr0kBMVC9hDhBOdtkH5k7vytHhIckLMS1YvSUr/6jJzH7y+S7Ek9kuWdAqIUEaqj3/G8nEipjFpKrdwF0Bt5cJJP9b1qaEi9m7Qp3bkcbYS2wiKgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529330; c=relaxed/simple;
	bh=q6VgcWVV8ArVaK6l3wnAuR1kW+gcsKwKbYy06RDfTOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j39h6rHRwvHeQ+HMlixx1IZmNfws+yUn5FlrAEY9cypU6cWc5ShD3VXF6uNxAJIU+Z/M3/GmyIFuTaFtYMMNklNvplVGSXCPG1UyI/+JGLUGNcDNTqNwMP7FZ1sZ3kQkbmNrqSSlfboGj0s37trW3PveTE03R6YtR1H5LzFbVHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=M6Egqu9I; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="M6Egqu9I"
ARC-Seal: i=1; a=rsa-sha256; t=1773529322; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=AkEcVTV98Ed3GIrmMSscUTM+lFecYxM3BaDJYxs7F10nkWla0iRs7ihqJUBMu0LavBzUMIMhUm8xUkA3SsgD5T9UiAC92uldWD/9lMsj2Q3OyN6eyJgO2IZZ//QpTFVW6zoiLBe2vJhKHG8KIP1bW7R6vuk3rit/U4Ys0ZGG89U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529322; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cenrCW3CIGtKFL1Daz+UsPpEa03fH+pNT1DRvVGGbuI=; 
	b=Yl9m8CekUJuPUqJwIpnCyfvCO+akNcwaaN5Er8XaMyC3pq27oMJhAbC5QjgZx3Y9jyNklY61UaXPjOLF6pscaZ0LBLJVFPUCNbGBl7E0DnNaDwO6rTbxouNmzyYGB65TnWJDH7bjM73OmR/+98AEwRd3GdQMCxaXFn1QRtyPZh8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529321;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=cenrCW3CIGtKFL1Daz+UsPpEa03fH+pNT1DRvVGGbuI=;
	b=M6Egqu9IfNRMAEBypfjGE6u221/Km78a8XXCtdW59qvp0rphIEp+802jZ+Iz6nx/
	OLDjIQKkm04qsmJCjTIu9mkrj9L6579mm3OJh39rwo9iyuWOSqNlI7zlutOdKVx04Dl
	XB9JIxwptkUD+dpPwOpYfYWtj2JSAn4WcLrPoq5U=
Received: by mx.zoho.eu with SMTPS id 177352931916774.6656976122191;
	Sun, 15 Mar 2026 00:01:59 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 03/17] lib/bootconfig: fix typo "uder" in xbc_node_find_next_leaf()
Date: Sat, 14 Mar 2026 23:01:41 +0000
Message-Id: <20260314230155.155777-4-objecting@objecting.org>
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

Fix "uder" to "under" in the xbc_node_find_next_leaf() kerneldoc
comment.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 53aedc042f6e..35091617bca5 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -364,7 +364,7 @@ struct xbc_node * __init xbc_node_find_next_leaf(struct xbc_node *root,
 			node = xbc_node_get_parent(node);
 			if (node == root)
 				return NULL;
-			/* User passed a node which is not uder parent */
+			/* User passed a node which is not under parent */
 			if (WARN_ON(!node))
 				return NULL;
 		}
-- 
2.34.1

