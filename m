Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E42175A6A;
	Sat, 14 Mar 2026 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529331; cv=pass; b=DXoxiS88KCAdX9Yll+kmDcsHN+pxFGq8L3my3+vl2oAKdJKHdZ9i31J6n5+g3y5xnKsHLmIys0eivNLpT98SL965P4scFoC6kCoaElDHA/hhBsiOKZNp2Il7bMtC32rCE5LbB65iyRLJFWuqUyLyW509CKQSOeqQHuJUJ8lzkdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529331; c=relaxed/simple;
	bh=6DWvwelCofWZTafeeOC+MPe/vsgZVKorf3Yjc7Dvl8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=adINWc/yeOw9sQ11lNoI4/cqwgk7r9LeSZ56xEE/uL3PjqvSMizcWJ8YVDBW7zR03SFb0jbJhPOrf2dQcjv0NjuOuRzyMK7HJHvomMQ0xXYgh2A/Ev8mnUz/3jDwiQf/NiJs1rUL23XFtWOLZkyk6xSKtnYHTkzQUVud6C7htbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=eGIp7clc; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="eGIp7clc"
ARC-Seal: i=1; a=rsa-sha256; t=1773529320; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=cdQuZSsnQehCEqCXwa5Q6jxH9RyZCTqYcAFVbA6d9gtIoZXYLib49+PpyD11xs8mvEZHUjwForUYSGA72XMXYhBFSoXnmYIxKkrdkcy5x0v6BrYqQ6AJSPU2hdxHqao3tAjV/OmezVoZuyuSj4WP87V5RChrCkM7gQvgmLEI9G8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529320; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bDLriIlREU+xzs0R4GJSCt1A+bp79GDxd2ijzRVDE9o=; 
	b=H4QjbZrbso5DpOH7RLWCXFHZIsHOO4JaZSgYKElGrpa74LGCU+kCzcKJtZKJanH7jeWeQd++nzPJ/ZIDk6T4fV6p0aUs4JvwP6GclrZ3es7a7h5/h+Pxy392mkZ6Lnz/DAP7y9lTzl1RdqENEs2t7LXk1ouIL9o3yLXiCOlPypg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529320;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=bDLriIlREU+xzs0R4GJSCt1A+bp79GDxd2ijzRVDE9o=;
	b=eGIp7clcf7Vq+shJ9uz0+uhR/McMM9xWap/oZZDSTQO/dmoZaFH8emOdQ0IF//bm
	fny3CSfzsRwLkyj/sx7zvztpRDN4S6a7lSeXZvPsbplcg2VYCfIBOlpS0FbiWbQtf0R
	6OS+b2QXfCXdRkxDXZGDKjd186JZq6/4YXOoNqDA=
Received: by mx.zoho.eu with SMTPS id 1773529318635755.976375872085;
	Sun, 15 Mar 2026 00:01:58 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 02/17] lib/bootconfig: fix typo "initiized" in xbc_root_node() kerneldoc
Date: Sat, 14 Mar 2026 23:01:40 +0000
Message-Id: <20260314230155.155777-3-objecting@objecting.org>
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

Fix "initiized" to "initialized" in the xbc_root_node() kerneldoc
comment.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 51fd2299ec0f..53aedc042f6e 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -112,7 +112,7 @@ static int __init xbc_parse_error(const char *msg, const char *p)
  * xbc_root_node() - Get the root node of extended boot config
  *
  * Return the address of root node of extended boot config. If the
- * extended boot config is not initiized, return NULL.
+ * extended boot config is not initialized, return NULL.
  */
 struct xbc_node * __init xbc_root_node(void)
 {
-- 
2.34.1

