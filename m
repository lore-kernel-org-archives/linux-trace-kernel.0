Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB4D30B535;
	Sat, 14 Mar 2026 23:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529331; cv=pass; b=YplT1LgAO9nMg7gi/g5FzOCsaLaJPJ6yXwfhDjBPgDGY19gb+h2g9UMtYz/h5FcGf49wN0mnKtz5mMWChosVIo6ZfA0gWeiBUew4m50+Kr7xcGGW5xuseXCy3i6KM5U9GIUBY4bWSaIMI9jwIrZhPd8bfa7c1i9V24BI/09GSH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529331; c=relaxed/simple;
	bh=DRP0bkR7bPm24iP6Lzhg3tEJBN+s2+Bet778OjDqUXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aFRjGR9u8HADHDWRInEs7/k2s0rEfwEHGo0fpQlRfKjtcl9kLFsBu404rr2uqXUpzub2VGyJywzPC13TXWoO2l/UnTLsYdja0tUvAmG0SipeJdElAd1iK08Fca2yA29Endb1n/fHKk2bfP6k+ki+kTcMx6YRmN1cOUZAKIsm38U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Cln2clnI; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Cln2clnI"
ARC-Seal: i=1; a=rsa-sha256; t=1773529322; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Fd1Kl23pa4fJNl1sDGkoX3eTVa7tJf5q6CJQ/TSwe+Tcn1kb1JOeAe8sh/JbJfR8yhpBmipwVrle8S2lQwIVGWfdEOSM01jJDS2r7eUuG9N34isOc3sqyveVw6MUZRh9x1u934O3xAQzAq0n83mHlZ06ilUovxkfKlyLVBnWwNU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529322; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Xeupn9cKPxiPKbISrjkPHMR3deW24vI0PqVo9Jq/DYc=; 
	b=MBxLulm57y1ow3bBBEZO/VOacjuZh+HxR66kDTdKVTNZdDywZ1mDx6F4hlbHojQ598Uy2xb6zPJLhdYLA1Kit6hCwEGMhgOMHHlT4B3ks0ne3r9SYeYKwOT3Adrk90tIRHk4CLavJaWNrEPzMUexdimpS/i5eKtB1+kc5zB8lRw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529322;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Xeupn9cKPxiPKbISrjkPHMR3deW24vI0PqVo9Jq/DYc=;
	b=Cln2clnIqtHuH/Egd57Cgq3UV02tjM9ARoe9mvCtb/Rw4VruWuBXdJt7jRqHHK7r
	9Ix7ZYb1PsNmDngrv5D97T93XZAUnlsLy9g9ZryR4mUTMtMOKJxjtl++2lIedpcuebB
	5GaBi8Q6/C1+XyeSdRH5Ku3+PalbVRJvWxwKOGzM=
Received: by mx.zoho.eu with SMTPS id 1773529320720670.3223273420932;
	Sun, 15 Mar 2026 00:02:00 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 06/17] lib/bootconfig: narrow flag parameter type from uint32_t to uint16_t
Date: Sat, 14 Mar 2026 23:01:44 +0000
Message-Id: <20260314230155.155777-7-objecting@objecting.org>
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

The flag parameter in the node creation helpers only ever carries
XBC_KEY (0) or XBC_VALUE (0x8000), both of which fit in uint16_t.
Using uint16_t matches the width of xbc_node.data where the flag is
ultimately stored.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 45db51bc9cc7..34bdc2d13881 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -408,7 +408,7 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
 
 /* XBC parse and tree build */
 
-static int __init xbc_init_node(struct xbc_node *node, char *data, uint32_t flag)
+static int __init xbc_init_node(struct xbc_node *node, char *data, uint16_t flag)
 {
 	unsigned long offset = data - xbc_data;
 
@@ -422,7 +422,7 @@ static int __init xbc_init_node(struct xbc_node *node, char *data, uint32_t flag
 	return 0;
 }
 
-static struct xbc_node * __init xbc_add_node(char *data, uint32_t flag)
+static struct xbc_node * __init xbc_add_node(char *data, uint16_t flag)
 {
 	struct xbc_node *node;
 
@@ -452,7 +452,7 @@ static inline __init struct xbc_node *xbc_last_child(struct xbc_node *node)
 	return node;
 }
 
-static struct xbc_node * __init __xbc_add_sibling(char *data, uint32_t flag, bool head)
+static struct xbc_node * __init __xbc_add_sibling(char *data, uint16_t flag, bool head)
 {
 	struct xbc_node *sib, *node = xbc_add_node(data, flag);
 
@@ -480,17 +480,17 @@ static struct xbc_node * __init __xbc_add_sibling(char *data, uint32_t flag, boo
 	return node;
 }
 
-static inline struct xbc_node * __init xbc_add_sibling(char *data, uint32_t flag)
+static inline struct xbc_node * __init xbc_add_sibling(char *data, uint16_t flag)
 {
 	return __xbc_add_sibling(data, flag, false);
 }
 
-static inline struct xbc_node * __init xbc_add_head_sibling(char *data, uint32_t flag)
+static inline struct xbc_node * __init xbc_add_head_sibling(char *data, uint16_t flag)
 {
 	return __xbc_add_sibling(data, flag, true);
 }
 
-static inline __init struct xbc_node *xbc_add_child(char *data, uint32_t flag)
+static inline __init struct xbc_node *xbc_add_child(char *data, uint16_t flag)
 {
 	struct xbc_node *node = xbc_add_sibling(data, flag);
 
-- 
2.34.1

