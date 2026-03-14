Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9D396B9A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531140; cv=pass; b=Bi5AFghzPHl0cgePNkFJCwMFUbJQE8dcLeaxXwT8GKFXfwFoarogxwBHJshUbdEkWMPtUYNAR3NuNqdaTdcGFPaHOPWmwT/7bbjPkTbvvN8+KGEz/2xtIMbrr89MmjfOxpDbvYUfCwFW7VDp4rLzsfYbqrj551ff2ZtuqfbSg84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531140; c=relaxed/simple;
	bh=J0dWEtL7oD28UFrLKGwL9fzqAkzoGMhBDWffJqXgq8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sANxtjz4I+HX+MRBVi6iHu3W8Ut2/UUi5ExFy6QJNVro4V8l3U0ZHiPvWCEHzFM4Ohg4tQCHAq0zS2MZ6kNF03nWMTg5P3tMeSOLOtgFwwqaTYxPJySG9M1B0LiwjHYM4YWfnQIJLG9KBqqhonN+4n+D03WQ6v4qCA3GFS5TbTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=LwN4SzHE; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="LwN4SzHE"
ARC-Seal: i=1; a=rsa-sha256; t=1773531117; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Y59CRj85uieu5ha7og1uwtWkwRrjqPtWuBRn0WcY2fDaLGhZxPAFEg+LqJhOsz9ByrG+GmfZxTAs663/+pqtiNZpPVJ+Ea8clGNRu6mST07a8SlRXlFBnokVjrCRw8ClH5aOK8MUbkXAcr5qJL9DRDPENGpX32QOVkROkNHCbwc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531117; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DAmDK/t7v3VayM2/oeJKOAUQv25rBNApZIKdk5FaALE=; 
	b=KYnE/9XFnfq0mpqBqFOSbscNdELQlngHN3Z5jfBmOsHdbG51ChfFi1LvhkBSgw2awo7r63TBpyEPTys45ynBQZypnxC/Wlb2a3ZjsAAzvNSowlku1I4cK3AT+Gt3ZuKwF1FxAOnQ+uOX7Jyu0vfRsNmUOw2xr/D7cb8k6Hep8zQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531117;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=DAmDK/t7v3VayM2/oeJKOAUQv25rBNApZIKdk5FaALE=;
	b=LwN4SzHEx0m7IRO4Kq22JrAxGzEGyHkB2SLlJAqIRtao1pFQjwUWRLetfOFlzuMz
	cWT+cZBMUvuWb8aK5pnYdNk3OgkfRtnlz40BCy+8rBPjSB7TbVhyuwxwhrRrOYjPuJV
	wcu9SCgoWaEoDikKIcR8V1nhT7HXUtz8mGECfgT8=
Received: by mx.zoho.eu with SMTPS id 1773531116233231.17178676526726;
	Sun, 15 Mar 2026 00:31:56 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 21/23] lib/bootconfig: use size_t for key length tracking in xbc_verify_tree()
Date: Sat, 14 Mar 2026 23:31:42 +0000
Message-Id: <20260314233144.187273-22-objecting@objecting.org>
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

  lib/bootconfig.c:839:24: warning: conversion from 'size_t' to 'int'
  may change value [-Wconversion]
  lib/bootconfig.c:860:32: warning: conversion from 'size_t' to 'int'
  may change value [-Wconversion]
  lib/bootconfig.c:860:29: warning: conversion to 'size_t' from 'int'
  may change the sign of the result [-Wsign-conversion]

The key length variables len and wlen accumulate strlen() results but
were declared as int, causing truncation and sign-conversion warnings.
Change both to size_t to match the strlen() return type and avoid
mixed-sign arithmetic.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 7296df003459..e318b236e728 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -803,7 +803,8 @@ static int __init xbc_close_brace(char **k, char *n)
 
 static int __init xbc_verify_tree(void)
 {
-	int i, depth, len, wlen;
+	int i, depth;
+	size_t len, wlen;
 	struct xbc_node *n, *m;
 
 	/* Brace closing */
-- 
2.34.1

