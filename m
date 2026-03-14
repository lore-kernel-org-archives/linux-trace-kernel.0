Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711ED3909B7
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531135; cv=pass; b=gpzb8kSixaHKOr+jaFUJd4Ka1VcL++Z3nEWbB3YAJpmncuTyFiRmJpgt1QYxrKtZ++Oqx+9kNrWvqswPmjcLcBT373CbEg2d04Ogo5pDFrnV8+eaIkQjEwL60rx9Y0qrPww4yviCc01tOoEP8E5Z5gBNnY9B2VZ+9+St5kVnobU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531135; c=relaxed/simple;
	bh=6DWvwelCofWZTafeeOC+MPe/vsgZVKorf3Yjc7Dvl8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBjYCH4Lh9qzujJGRc7ccT0uQRWqxoIqQjnPybOmnA9SbuJdGCkg29NfTJ7wrmZUnkVzyWrAYmJL6gEIpEVcuGBSRZ/ugdo6bzG8pw+kLbkFRUvrIHoIi25Dw4ZmMM4auAzaE1wl44ybgB68ufLB7/NPjOh36y80jdqNdGN3+wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=b6537lRX; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="b6537lRX"
ARC-Seal: i=1; a=rsa-sha256; t=1773531108; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=NrnPBRS29Dg1Fmre3ddEbUumSpv2yg9nJ02qmwoLFlieGwUrvaA6FiNP8Q5M8sWzJ578NAtCBqN0cXv+opSV6LrEa11SuSnX8XMy+BEw3C6on1vOB4Hig6s5BMnouvdRocd8k1Kk68pvU2nA+hOK73B8LGMoO5ip4v4vmzrHc5M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531108; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bDLriIlREU+xzs0R4GJSCt1A+bp79GDxd2ijzRVDE9o=; 
	b=B8uSMbqfd1ALEtERkQVd6ufQv1Ac3z1IW49yfC6RNHOfm1eKH0ZV8MTn1BalsTfX9OidwzAEdU9Dc9SllwpOLx91FQUndc9Pj7StvOL7KJTCn8QNRV3DIKMwBRlm8TBPi1HJlGTmbMuZJp4eJa1lD4jibAVRCWfifMWSRYRdYEo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531108;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=bDLriIlREU+xzs0R4GJSCt1A+bp79GDxd2ijzRVDE9o=;
	b=b6537lRXpSuiNh5apOfy31XZP9taATTxqzLmoH7KfC+sIvx4aTUo2E3LDXKhNYrP
	A8th9R13+jy5HtMIWujJgKAYFANw7d63XPFBNaplVlMLgjO7HdW/anQtjeh8dkvwG+u
	Nvx1MqrPibL896Y/ZLwNLvZOx7mqfU8LafzpiXcw=
Received: by mx.zoho.eu with SMTPS id 1773531106802632.4046790401114;
	Sun, 15 Mar 2026 00:31:46 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 02/23] lib/bootconfig: fix typo "initiized" in xbc_root_node() kerneldoc
Date: Sat, 14 Mar 2026 23:31:23 +0000
Message-Id: <20260314233144.187273-3-objecting@objecting.org>
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

