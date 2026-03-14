Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B13914E6
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531136; cv=pass; b=ITvypjEglaPY05QTBhMYNgPHNbWQM1B89qqGdLclsJOFK5EcaxrAJz53Ik+0HPFkG2S9MijqXuih0NExl/HsCqV4w5W/xDc5mLNNRd/tilaf7Ha0NoKjd7ydqG3qrpy0g/+BG6C0ZmfBem0F22ctnnIQQiqX4JM8xdn48oiGqPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531136; c=relaxed/simple;
	bh=EWCRpZBNHCZU8iztguL/vt47WImiwDpV31hec4mL7Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=imabOUhyy+A3gYIVZHcJlGj3T4HQN5TKL3aDQ/rPLD55MZqPgigoCa10l6h5KqOF96KczhGyUtp/YhldnafZoLix+qzTKbJ+hca6qoa8SuSHag3AB2yymWJHGBfKgJYHdPIFFCwvIm5qUoUEPkKu/qfD+zsPHeql3Vti0e2y44Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=jzd05A+y; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="jzd05A+y"
ARC-Seal: i=1; a=rsa-sha256; t=1773531112; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=h+jfA8RKb/1u06doJpxSqRQj4qnmHsYlHaBakczmZOFCZZ3sxm5ufUiwin8F8RSbfPtxccCJIGoZXf/BAUHVZMVh0tFjEgjWX2tvZ0YN7MX8xDQOpY2sSBXnlZiUoHTwpHSLYFe7GrkT12FmxWB+dH5yier1iDFGya7JVEX14y0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531112; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y3g/gWcuZygcqvX4QpGo9gnBChjnwRu7NCitJ/yvsXM=; 
	b=gb/RAkniRpBE+KFJ8n64OHLTqJQ9uvb4mIs1Ca7IIvAShosECXX1/1h4qqVD+Heof10nQnPHjnE5VD0CW0zS/EVFsfJ4U28LFJaamH1uwbIsUXWlwc2AJrEDYZARoaPQ1syNCq3bES9uGUPW/ynCC9m7clKwfghZJqRu4tEn/e8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531112;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Y3g/gWcuZygcqvX4QpGo9gnBChjnwRu7NCitJ/yvsXM=;
	b=jzd05A+yZrWf3ZhXra07dSt8C2iEksG3IOauAmdB4CQUxUfNaCzVnsVobvGwLr5v
	U1EL2fowdh3Q3axXbjs30oa6qjaKtFPmo8FzpUPC6UCtr2oFmSI4Yq9wlADNCPFkFPL
	wrUyBllngJqxyxmvzR0erTIFMtzortzINmQ+lNlY=
Received: by mx.zoho.eu with SMTPS id 1773531110764519.5091208133796;
	Sun, 15 Mar 2026 00:31:50 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 10/23] lib/bootconfig: drop redundant memset of xbc_nodes
Date: Sat, 14 Mar 2026 23:31:31 +0000
Message-Id: <20260314233144.187273-11-objecting@objecting.org>
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

