Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B2238839D;
	Sat, 14 Mar 2026 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525344; cv=pass; b=kxgvGNe4emVH12Ir0LMYrAMDq+yGqe5tkAFjulkVerstkKveeiO44c6JwrrsQfCk/pVYddBcbpSU41UrUyhQYxXVihZm06PiQTq85onPYVKrnavVTrFZOKvjZQsJtJPdTasH0W4onv1VBpTWDS2F5kQYrhA13VE6EvrM3/IiOXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525344; c=relaxed/simple;
	bh=EWCRpZBNHCZU8iztguL/vt47WImiwDpV31hec4mL7Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZtQbhopd615Zr4x9wzM1ckx/8ojjcrbno7t+fEZ1HtwqcVlHs3YxfXyFf6a5nRCzSjZNcseQ5fm90S5Mt+FXTfQI4FpPiSocIDgy6mNgNGq5sED6oW4PYv15m/92SiEbEt1llRlGwsOcBv1pmCVo8UsSoX5FycY5evv2j5xh2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=A03VPcAc; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="A03VPcAc"
ARC-Seal: i=1; a=rsa-sha256; t=1773525336; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=C6qF1SDZXcdClZOCbWTC1ON6CmmPw9UletI+6T9hw+VDiJViilQM+HmS7HJZOlxDBevxPfDNUZtIWC8nLHdes+IlBzXk3vSXt9TwZONMOyMudFXaXnpTqsh+eant7IjFbcYkjG+38Xh60tU6zUv018eJ59MLxlc0w4J2pMwhHpY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773525336; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y3g/gWcuZygcqvX4QpGo9gnBChjnwRu7NCitJ/yvsXM=; 
	b=Z2MeT+0jZmA6lzkwFCMjE1kPVWqkJjOsfMUx+rfSKA2V3ONHyA4N03YXWOLadnvqoRCZ17J2lDn61mlGV0eNBlLo76xIog+sKFCcgOvxHKDS5bC1OyT4MCrl7Z5bXq5s3VAwD8VvBDeeQOlQiqucd7w1ho9AYDNuAxo/QbKGY60=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773525336;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Y3g/gWcuZygcqvX4QpGo9gnBChjnwRu7NCitJ/yvsXM=;
	b=A03VPcAcRoO88teheNaTYhqX/cT7inYqTrA4xpYnjFB9PL91UkpeoKKrnQJox3g/
	W1xDM0qY2M2i8LF5/UXCEIPCqdryFalmhy+89v5uLFAVEqABWU1WfIIysmCstM6l3yu
	yUCU50Cjer8ja1wcGjESTh+Vc2XA/4Vlb23mx/U4=
Received: by mx.zoho.eu with SMTPS id 1773525333115306.628767021615;
	Sat, 14 Mar 2026 22:55:33 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 10/14] lib/bootconfig: drop redundant memset of xbc_nodes
Date: Sat, 14 Mar 2026 21:55:22 +0000
Message-Id: <20260314215526.108651-11-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314215526.108651-1-objecting@objecting.org>
References: <20260314215526.108651-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

memblock_alloc() already returns zeroed memory, so the explicit memset
in xbc_init() is redundant. Switch the userspace xbc_alloc_mem() from
malloc() to calloc() so both paths return zeroed memory, and remove
the separate memset call.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 06e8a79ab472..fe1053043752 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -71,7 +71,7 @@ static inline void __init xbc_free_mem(void *addr, size_t size, bool early)
 
 static inline void *xbc_alloc_mem(size_t size)
 {
-	return malloc(size);
+	return calloc(1, size);
 }
 
 static inline void xbc_free_mem(void *addr, size_t size, bool early)
@@ -982,7 +982,6 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 		_xbc_exit(true);
 		return -ENOMEM;
 	}
-	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
 
 	ret = xbc_parse_tree();
 	if (!ret)
-- 
2.34.1

