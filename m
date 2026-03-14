Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0601738A734
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531133; cv=pass; b=bMIols71pUBj49F+WcgqNUgq+uWWeWh5TMAKJ0fTZepg0pPrdlFPTyYzhLDXxsG9xQw0lyYqhLikQRHL4vXIVF56Hjv8/jAP12eQd6E/wTCWyj/OLQp7Rk+oxM9z/AiBzYjYvBnh/O6hDnsPgaJF6C9UlpBzeb2aoi9slz5inY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531133; c=relaxed/simple;
	bh=q6VgcWVV8ArVaK6l3wnAuR1kW+gcsKwKbYy06RDfTOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/NtTYlFdIdu9525pyOmVh1iE2Uzm2z4Z0EjtvBfJZJOAmXJgClSJKzZeQ838GpuISpfBkQwm5Crf++uwDDzEGuqopM1ulmTbCdn5/wNGWp6SMbhYHnbF8y8DXaln0yYfCNw2kXAx8w4wN9foQlnEjULyfi2LjtZ+p2RJiRvFYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=mJkuWQQI; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="mJkuWQQI"
ARC-Seal: i=1; a=rsa-sha256; t=1773531109; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=fnnkA9pc5dGPtxeAeTGq1iQYemP8+M0M9PMyN0XtiHd4Af02frDlyBek+hid5bWupJVd1EnlYVuz/t/bgK/kpQ1LVtcJdAvSAiR28/EsV+ibnYz14bIyV/xfw+N6ftnZ75lRd95zuyPbGhJRwe8yKb2n5JBVkx4eTCh+2swccSY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531109; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cenrCW3CIGtKFL1Daz+UsPpEa03fH+pNT1DRvVGGbuI=; 
	b=YdNjBlw3gzKuNKv1zbwyQKIumkpHMd95e8tIDcsbmlgwaN70+do+kkqPq2W2jCTr8txi7TwbhqbCstZxXhPbVauJ+aYASNttzSVw4UDqv1FhoYzbS3vJnyegywHS6b94ciLlB+NrrYJFYYeG4sUGObwRJulIraORQclRQm+uhj4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531109;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=cenrCW3CIGtKFL1Daz+UsPpEa03fH+pNT1DRvVGGbuI=;
	b=mJkuWQQIaD6lEqY4urh8HuX24S3nenrvJ1FtG6pCVKW3rGZMDgi2xtejaLuwzUxB
	f/c+4ACBFWDt0bLXuqx0AXyXPl/gVtpPRo3W8frN3I8CaKKgJrJww1lM5Kn9b8UdaVe
	K2CfSs3RH4qkz/itHOxXZVfVrsUAhmgXaWfa/AnA=
Received: by mx.zoho.eu with SMTPS id 1773531107328536.1014627594224;
	Sun, 15 Mar 2026 00:31:47 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 03/23] lib/bootconfig: fix typo "uder" in xbc_node_find_next_leaf()
Date: Sat, 14 Mar 2026 23:31:24 +0000
Message-Id: <20260314233144.187273-4-objecting@objecting.org>
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

