Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D066396B67
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531140; cv=pass; b=aIHcKP5pVfHFEElPAf87+t2VsIMNRmV4fMfZxKcTB84/ORGVXjdcEnHWVkSG/vNQSEYbQdujZNaM0XYerjP769aYK77gpQ9eEbwebr08gX5em2Zh596Nx23GjsmX31dj6oxlPuhM/lKCzZlw7lAsEvV3EuN2SfJgIxhNN33KZhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531140; c=relaxed/simple;
	bh=VKHopRg8IGdNLejmjRomK8lHiFXp7Lb7z8zk3mjsIxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aIyJMpSoBY/8RhFexrnErN0+3ymJX6BhyzLhKnL4J1j0pTgx/id1KHH5XHKf79912F9kA0aehsg8ZT2dKEfAdprnKulgdePqt2JA97g+wAaNFD9u0AFLUPtcmaSMW4zN9JtArOkciz2Tq0yktxUeCPdruoQQ7daF7beN8eHVsz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=bJJn7jhG; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="bJJn7jhG"
ARC-Seal: i=1; a=rsa-sha256; t=1773531118; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=KFxnMOQLJUNTTWPQKc+viIJVQswKzTkgndeSJNHcMdAO6Rx9jTaIgGLk81vovQP8J/tf1s8DcFLa5bZw5pqAhCP1UzldeiJ4lGyeL4pRF9Cof45O7AhjuZ5Ig1V0R0DVbUoEGB9aXsRMuzrEckd0DTmnx0eJvfjeeOuWd5c/EfM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531118; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=t+zefJeSRi22Rvky/gfXxqncChjmAVugRoXXQsGEHR0=; 
	b=jfIkn1Tlnopnl2ho5PoVT4MtbXl9tjaseqkqbcz/WYcX0CV+elTuaZP70Kr3UJ1nio31ZXukmGTv6YPVCexs9qUCbPaW8reMfGMrmeJ4Vq04/jZ0tAPR65bD/SdxHSZIBzyLAgzIp/Bxskl9GupsSTYcThhDkgSnC/SfeyHCEnA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531118;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=t+zefJeSRi22Rvky/gfXxqncChjmAVugRoXXQsGEHR0=;
	b=bJJn7jhG2wn1MvlGXdOxhFLKTjTdqEXRwXARL3Uw7tMkZiqGt5z6qj4/kmnl33wV
	6Alvn155dFp4QdjO+sbhn/Zl+tTnvkc21RCEUNkAM2bn7Yn1p/9ocqRFDRlDxNaBfof
	zkNXdqKwPiIRkPxFCsuqKT0P911C4KG7E1z0JqlE=
Received: by mx.zoho.eu with SMTPS id 1773531115740323.89994253598684;
	Sun, 15 Mar 2026 00:31:55 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 20/23] lib/bootconfig: narrow offset type in xbc_init_node()
Date: Sat, 14 Mar 2026 23:31:41 +0000
Message-Id: <20260314233144.187273-21-objecting@objecting.org>
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

  lib/bootconfig.c:415:32: warning: conversion to 'long unsigned int'
  from 'long int' may change the sign of the result [-Wsign-conversion]

Pointer subtraction yields ptrdiff_t (signed long), which was stored in
unsigned long.  The offset is immediately checked against XBC_DATA_MAX
(32767) and then truncated to uint16_t, so unsigned int is sufficient.
Add an explicit cast on the subtraction to suppress the sign-conversion
warning.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 995c2ec94cbe..7296df003459 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -412,7 +412,7 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
 
 static int __init xbc_init_node(struct xbc_node *node, char *data, uint16_t flag)
 {
-	unsigned long offset = data - xbc_data;
+	unsigned int offset = (unsigned int)(data - xbc_data);
 
 	if (WARN_ON(offset >= XBC_DATA_MAX))
 		return -EINVAL;
-- 
2.34.1

