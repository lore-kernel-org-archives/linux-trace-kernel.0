Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3B0355026;
	Sun, 15 Mar 2026 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577249; cv=pass; b=PqOD3fch/d3ljaAuvAXW9v2qksJ7K6JK7prMt1MwbebM3evcz999miuFrghh6A5WljVAfdoPQIUrZrSUmY7l8oPDwD9YRJVmze/Dl8W8IFAnoDmJ0av8CLKjeCFIhc8H3PpmclpXo/LUEa5mrAM5o/Bek/fEAZijAEA13EDq9lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577249; c=relaxed/simple;
	bh=VKHopRg8IGdNLejmjRomK8lHiFXp7Lb7z8zk3mjsIxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PMpASOj28XNOOc2+efcz8otOOuUBoT/WXzFahVv6lTb+QZbrKkv06ZX1bwY5BMiAhlU5yM8NO0bkerHdyzY5RmPLimyc7d+M7o8d2cMtTNsygDexrD618F69XN2CvitpueSfUQFzPcQfPQWIKWEPLJ6NpGUEs29nv1qJXfiHWMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=hCWmi3nN; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="hCWmi3nN"
ARC-Seal: i=1; a=rsa-sha256; t=1773577228; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=b3oT+w3ML/Gvp+fen2cr+MJQJp24um+vl1K+GkZqMb1fOAQlpX2uYzb4YHSlQ8ltHjnWLxXmtiPyEumEXL7ZZbBFkhv2nO9vyI0StYSW24LX2j+mfFsNQXx+4lIKFghb1huZHoCF4DPqSKUTqqfsc7QKfkQAC3oOGeLt94uozws=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577228; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=t+zefJeSRi22Rvky/gfXxqncChjmAVugRoXXQsGEHR0=; 
	b=WAKPKlnCWFSFQb94XKeyWNG99Qy42FqErYlJbmJgawGydxoBHxHBOK5qy6kJhR1EYuWWewivWbYnrmqWL/xA67E4Hxx85gVPsqTaGBz3F+rKfm13dqz3DZwQinGBnUHTl4tVqseff8YWPm6PVDAPGBrcXIN79EMkKaL0bQRE6FI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577228;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=t+zefJeSRi22Rvky/gfXxqncChjmAVugRoXXQsGEHR0=;
	b=hCWmi3nNl36KZ8MNp5PFeC1T83gFF2O8UC7/uaBuBG0PWn0nDCa8XUP0pohbn3Tb
	3Y8EK5cf6J6KAEVezydCt0lcIMU7V3kz1F4Z9oYRjxTJ9g3rlGv8Mo3YmIgDcbBhhYr
	JgBlpwNjb2WAntYTBFtj1yQVRCI9COn/7NEwPtlU=
Received: by mx.zoho.eu with SMTPS id 1773577225379866.8544584576808;
	Sun, 15 Mar 2026 13:20:25 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 14/17] lib/bootconfig: narrow offset type in xbc_init_node()
Date: Sun, 15 Mar 2026 12:20:12 +0000
Message-Id: <20260315122015.55965-15-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315122015.55965-1-objecting@objecting.org>
References: <20260315122015.55965-1-objecting@objecting.org>
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

