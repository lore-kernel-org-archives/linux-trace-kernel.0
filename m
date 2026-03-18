Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848C43F1669;
	Wed, 18 Mar 2026 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849582; cv=pass; b=uqr+WG+WpfasSbAKO+D+TwpgRP814gPWPTZKt99D3RljDsC5PjhjZRG8vKX2dqeKdmgl/nw1AS8FR7MxSd7qs0Uh2ZYSHmIAzwI/RuWyTTR6NL+jUazw+BSzuSPrzRAuAZkyKDfPuQ+bQxLuHL2f4M4yH3EHtV1n3GE/mwe2ZrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849582; c=relaxed/simple;
	bh=k1J7BK/fpcNNRsuYpLDEr6NUfHMMBv470GcUJe6c/Bk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJokvssE5qnyPIJBG3x029kQD6z9EGBIjKF14BYValiAkq7Sznk2jPw6N5ksfo+1XOqKWDFmAFd7DNg88sYZMj475PVQB22TKNwI6xPC9z6/4DO8SFIjnx3KkovVpqQFs5oE1GChLg9J1XC467K9rC4YnF9w5Ftc1fMYLgYP+78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=NohucEIa; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="NohucEIa"
ARC-Seal: i=1; a=rsa-sha256; t=1773849566; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=clrOktpVdfEgqrAtplYHufBYPKEjE3DsXHFiFSsKig8P17JeRh698rPUIPQuz/u+k+NURhz6UTC5mvatqEKJFwOTQ9so6l05w+CiARAXKPddlhqmUuEB+QgeEo9PrbmhXZJb82E6dbdiDSYuDscv5Q+lGJcXuYd4ZZFJv4tyxek=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773849566; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EX/3umGvgoplaVSbNUVqsuFtykwhUNbV9tqaQFKaobM=; 
	b=cPONFxE5sSpxlOcuBEuXox3opBRCgGOE6s+csa36JdY/GgSi0ZN+KWKnKhsCrhl62U3pSAm5ec6tuOFEccgwRlQz2C3klYLhKJPfN3S/Dd2aOm6Yvz1cwpejIJwBmbulCfCZnEJU9G+D/uexhYZMUTgcXUbwK5YgZ/Aw/HCFUSs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773849566;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=EX/3umGvgoplaVSbNUVqsuFtykwhUNbV9tqaQFKaobM=;
	b=NohucEIa9HvqKwWQTd5FMwhsyV7uW440jq7Mu54cUWHtl1AnCbcDY3x4u3eo8dVl
	AxrMXaona35B8gosJ0bK0+HVx5DB/T2kU/GgokzUUBROiTFg+g7O8PXOghDy3uq+Boz
	kMXrAl/AizMsvzFlxWnleA2Ym3vvYH67BfJvZMrg=
Received: by mx.zoho.eu with SMTPS id 1773849564734867.8074198038827;
	Wed, 18 Mar 2026 16:59:24 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v8 09/13] lib/bootconfig: fix signed comparison in xbc_node_get_data()
Date: Wed, 18 Mar 2026 15:59:15 +0000
Message-Id: <20260318155919.78168-10-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318155919.78168-1-objecting@objecting.org>
References: <20260318155919.78168-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

  lib/bootconfig.c:188:28: warning: comparison of integer expressions
  of different signedness: 'int' and 'size_t' [-Wsign-compare]

The local variable 'offset' is declared as int, but xbc_data_size is
size_t.  Change the type to size_t to match and eliminate the warning.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index ecc4e8d93547..dd639046912c 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -183,7 +183,7 @@ struct xbc_node * __init xbc_node_get_next(struct xbc_node *node)
  */
 const char * __init xbc_node_get_data(struct xbc_node *node)
 {
-	int offset = node->data & ~XBC_VALUE;
+	size_t offset = node->data & ~XBC_VALUE;
 
 	if (WARN_ON(offset >= xbc_data_size))
 		return NULL;
-- 
2.34.1

