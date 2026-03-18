Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677083E5569;
	Wed, 18 Mar 2026 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849581; cv=pass; b=VkNwyQvXsuZ6MACl82Ry/lae88o28kGQTDJ1SN37+EsccwLw5dPCgWf2pXDfAyEUu6CaQ7uDFS9SNh9CNmuhLZad4YtRNOEjzP+cxX9Y0mNizJ9dpsN9k9/FKdaZ4rF8sRbH0OvmDYHUuU6qxUCXaQXxbOEnPasH6uQF3Qfyfy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849581; c=relaxed/simple;
	bh=DUCDFOLJ57qkCNI68sXQsO7UVxK28h+iRY+VtUQMUrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aXPWOOfQGuoZivF48rccv4f3Oa1WWq7+PKi7PBXy0C6DOMVXcIK457P5aSR2bf233Yt6ah7Nkz3vJTG9hg8wypbo+n/2cvX5++HJ5IELdqXk8oXfhRZLBUNUIJ3oY/hFe8fxz+j4rKXpnh5WnEde/eFmHXHH/8lSbhsIknPyHtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=YZwAac9C; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="YZwAac9C"
ARC-Seal: i=1; a=rsa-sha256; t=1773849568; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=N5GPS+0PKNYXeGzXHgLaojTCzUva8DzNnIEu6RI4FVqw6Wynn1xL0y8gwY8VGTo/ObnrvTC228TP+5umjYTotvMj4c60Pu3OoK6HJDv62zqjWzb+GJDFqf5t61t76L+w5SysvPnsXPzpTd87Ry/8dAYH/accDYShF8IPQjoLhi4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773849568; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rp+wuVlETQfmLgKmv7tEFfJBknrCQ1YXaGdK0CbMPg4=; 
	b=aj7cwpZKzqfm+BLx+Z2EGS7Ru0LFKUHIduxPp/v61yxCTfbKZHyWne4vhR19z8DrRRo7DTUJtJmzWgfP7bJU0/3wpFK2HYfX/OfUKJWzYmEB3jGfKv6TW63+rvnNvxA6vrv90pF7oyI/uxI7JbfHFKsHuaR2GYe8tmzAkiuEMrc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773849568;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=rp+wuVlETQfmLgKmv7tEFfJBknrCQ1YXaGdK0CbMPg4=;
	b=YZwAac9Ch2zp67ZlU0JRrBBBfGloVk2SBufayXsYuAbl7AmNZMOVOHIMs95/Rypw
	Zs2g4LcdLe+0884AzHhLbFVc5ymM2hcUj8KSoKmK8v8qkClLl/T9b8LEDNFsnWv1/Wi
	TSPpIGxeWEmA1klKtJL1PYlYZ2e9XNeOmBvZycoc=
Received: by mx.zoho.eu with SMTPS id 1773849565739879.7747357765327;
	Wed, 18 Mar 2026 16:59:25 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v8 11/13] lib/bootconfig: use signed type for offset in xbc_init_node()
Date: Wed, 18 Mar 2026 15:59:17 +0000
Message-Id: <20260318155919.78168-12-objecting@objecting.org>
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

  lib/bootconfig.c:415:32: warning: conversion to 'long unsigned int'
  from 'long int' may change the sign of the result [-Wsign-conversion]

Pointer subtraction yields ptrdiff_t (signed), which was stored in
unsigned long.  The original unsigned type implicitly caught a negative
offset (data < xbc_data) because the wrapped value would exceed
XBC_DATA_MAX.  Make this intent explicit by using a signed long and
adding an offset < 0 check to the WARN_ON condition.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 3c5b6ad32a54..119c3d429c1f 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -412,9 +412,9 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
 
 static int __init xbc_init_node(struct xbc_node *node, char *data, uint16_t flag)
 {
-	unsigned long offset = data - xbc_data;
+	long offset = data - xbc_data;
 
-	if (WARN_ON(offset >= XBC_DATA_MAX))
+	if (WARN_ON(offset < 0 || offset >= XBC_DATA_MAX))
 		return -EINVAL;
 
 	node->data = (uint16_t)offset | flag;
-- 
2.34.1

