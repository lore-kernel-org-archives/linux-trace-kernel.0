Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B7212B94;
	Tue, 17 Mar 2026 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763781; cv=pass; b=nOvMgKWJJ4XnMeD22hbVthrfkaG2DEEFwM7l/V0p8r9sc9yPyMz35Z4so6nVtT95UJX7wanbsrGuaYKv4M6pcoA9cDXVz49hvAqUF7UYSr6Hp7Jqx5Et663BcHCHaeaRDYPYrpzmuIfeuUm3Hc2zGklVv/enG/619Hu+Q3z9Op4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763781; c=relaxed/simple;
	bh=5DrGSXMEeIUOEdbJ9WiMaf2PnGRbNPGketohz92imfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RytWsj9mf2pDvDQvoYR8NtjUEIUALRgynyeOscSUUvqTNfxh3YgJsFtxmr590WWKhE7eRL0PW7nMtoMKxwXQ1DaAVvGzQ+7h+OhfkwqmQLNAGzxZBVLmvTcSvfy0CB03iWZhX8THUShGLhhTioh1osK++YkWFo+u10SctKj7yDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=ieSRB2gr; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="ieSRB2gr"
ARC-Seal: i=1; a=rsa-sha256; t=1773763766; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=kBavarqmOAbpMRVYZ9t7UM9v/eLaGFP8K15FyyXt3zvs/AWBJ1Fvt2d0AC/Z/nnGCwsOw32xmTL0JqVjn4qP2afv0j3INDoVP2BgK/79jlBwZ+n+Hlo0j2JT9rqSyzoI/kZpcIlW+6T8no43yDysKJ7YFsW+We4I+iA+Fs5nByI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773763766; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3izM0F1cOHEJuEmqlhbjziddkmwLfk1V+4E7AazdxMQ=; 
	b=AXLiDdMIh1I4o+yuJ8HH+E5mkZ6GmeK9B6f9Gxez4ywoRTUhAIeaDHz++MaFo8JVh4QDi7/1a+Q5ygGKvHx3WkJp1GB3ioGuYANA+gTISIqi73tzeKfB38rkbtF2BqUv85JrzV8eAqf3CwFfnCKwjS47a5EVw6JFqVLU3igbKQI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773763765;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=3izM0F1cOHEJuEmqlhbjziddkmwLfk1V+4E7AazdxMQ=;
	b=ieSRB2gr5hYNEtjlojwgz2ry9h5dxDR9SAoNpto1grKwgjf4htrBUrZ7bOPrYtwF
	vfZByo+ROuqOlbwsjInyKG+Grme1B5RtTF6MwTlPB+lKwvHETOA+EuswFrbpWybJxzR
	00wA6013u8ldMK8otKRQLcRR1U4vrksIlpwNrJ/w=
Received: by mx.zoho.eu with SMTPS id 17737637640031020.3670628719038;
	Tue, 17 Mar 2026 17:09:24 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 12/15] lib/bootconfig: use size_t for strlen result in xbc_node_match_prefix()
Date: Tue, 17 Mar 2026 16:09:13 +0000
Message-Id: <20260317160916.33576-13-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317160916.33576-1-objecting@objecting.org>
References: <20260317160916.33576-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

  lib/bootconfig.c:198:19: warning: conversion from 'size_t' to 'int'
  may change value [-Wconversion]
  lib/bootconfig.c:200:33: warning: conversion to '__kernel_size_t'
  from 'int' may change the sign of the result [-Wsign-conversion]

strlen() returns size_t but the result was stored in an int.  The value
is then passed back to strncmp() which expects size_t, causing a second
sign-conversion warning on the round-trip.  Use size_t throughout to
match the API types.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index dd639046912c..3c5b6ad32a54 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -195,7 +195,7 @@ static bool __init
 xbc_node_match_prefix(struct xbc_node *node, const char **prefix)
 {
 	const char *p = xbc_node_get_data(node);
-	int len = strlen(p);
+	size_t len = strlen(p);
 
 	if (strncmp(*prefix, p, len))
 		return false;
-- 
2.34.1

