Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF138836A;
	Sat, 14 Mar 2026 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529333; cv=pass; b=LKky6ooUyGX03c9gkGXfuuWBjiE/wwsyS3rkKC/dRTPO+3QVnoi1NgqAWyzdV8OjCK0goQQMH8yRZ5TsrACHwlgujaiEFlgpXPc65ussUMy5d9daeoZd5YsDHlhp7JRQiglNXI3u9nhegD/iWrUeb3MgaE4SiP0KxE30aY+bCdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529333; c=relaxed/simple;
	bh=2jZFhcm65pVh1my7aFVnxTPWIZ+otcDP9/Gf4KWRft0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKE9gcu8v5+t2PqMbcnzZpe7UClyV3+89cn1QoOtddOQqO0XQjWnn53DC4OuZutrolQ2LoRlOpzhI6XrWgTfapUu8jgvptqNhwbF8dbZobDu1W6Nh3brmCyN62Pza5ohPCRxKpInSYXR6oU8UP9+s/mYpGnHfyKACM92LacpKKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=T0R7oGpg; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="T0R7oGpg"
ARC-Seal: i=1; a=rsa-sha256; t=1773529322; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=XrG81q+g0QZvOOqpitVL7TQopFW/ZzxxzfxXCpWDUTKWmMRlDkeRV0g2W1pKJFb5GLWOVgBamJR3K5VQF7kXsB7e09xnIkbOVPxUzPpIGlMEDcuqIUDiVKYV1Qwr7SliddmcVAHMy2P6uU7zIw5wdowI3OWudDVQiDoqYK1F5nA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529322; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2lprVVDRD4lH3M3PsJ+R627NsZ/o1XOLdXFW/LZVSKM=; 
	b=hmS8LtrjGtjvjNkKCIkJfsqlAXDAqhRMR6Uv7/N3o0YemfWP9jND5m63QMqjsIix8apc6iUTFVXloCFEqhmaDnnt38UuWodXu1EJkwlof6L9QUoksQ38eUjWfKAqfzuzBVBei3b3N1yQVxEnGy/H9p0kY3GEX4LKeYjQoYDvZvc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529322;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=2lprVVDRD4lH3M3PsJ+R627NsZ/o1XOLdXFW/LZVSKM=;
	b=T0R7oGpgM3E1avt0Dl8eKkZ/mohgnlJZB+55Q308bP1E70LFQ5Pmwffai7sF+ynD
	0AGFGob/X+miQj+KUBq60dKp3y3xl3tNvLQ7n70WGWCHYna12iPz++NIIgc5z7kRumO
	vrHCbQd2R0W2bOV6HGc6dd9AV/g6qTurgvk9hwJM=
Received: by mx.zoho.eu with SMTPS id 1773529319712962.2648996757065;
	Sun, 15 Mar 2026 00:01:59 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 04/17] lib/bootconfig: add blank line before xbc_get_info() kerneldoc
Date: Sat, 14 Mar 2026 23:01:42 +0000
Message-Id: <20260314230155.155777-5-objecting@objecting.org>
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

Add the missing blank line between xbc_free_mem() and the
xbc_get_info() kerneldoc block so that documentation parsers do not
associate the comment with the wrong function.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 35091617bca5..e955d2f7e7ca 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -79,6 +79,7 @@ static inline void xbc_free_mem(void *addr, size_t size, bool early)
 	free(addr);
 }
 #endif
+
 /**
  * xbc_get_info() - Get the information of loaded boot config
  * @node_size: A pointer to store the number of nodes.
-- 
2.34.1

