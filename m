Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3251D38AC65
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531133; cv=pass; b=Fi41leWCA9d3LiYkX6ydVr09WRqa4htqOaTv2wQF4GPVrcRFhiv6gUvJqyFgmvMYNpIFf27PPscxEuZTNhpBMJMgcrvWt3jx3OlxT0Q79OxPrBbtmukvro3KPoNton0PAoyjdP0guoJX/7Tz9pfWv5fMuiuD2nySn3IxSi00SBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531133; c=relaxed/simple;
	bh=5jHlNQbA4ax5oxWy6TmNNrMnctsyCd5kWbRwYKqDhJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IxgK8Qo2TVQfCCPK+1ACvVdo/l3wgr3eXuIqVtCKDz4YBXuJ17seb/6OOADNi+uofY5FiMzuwJeFHAMjlVGVG8GBUNwKq4+bk6/V1sXUaSyUbQ/zxOuRH2/i1c0+3krlrQ55w09zTtUAPgVIHIWI+jC9jNM1jXRg99Z4AOzhE0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=V7LsRD3K; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="V7LsRD3K"
ARC-Seal: i=1; a=rsa-sha256; t=1773531113; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=NCpRS/rr3da9nU2ULvTx75NcGWZp1DToft61+WibyuPjNU2plIaA+0CzXWP/i7zOw9rrHsfIoFqlrk5PrqYWjyJaG41DjvyE3soYzBgJPfHX3BJqlsDcvNCorGzHpjjrDomfcK2k3AoqR5EhNd+U5H08JBBu0R19Px8I3sCBabk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531113; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RAInAapaPEVVIMyMy0xQq48ym4WbDouBno9PBv2kGos=; 
	b=LcY9EJD08xu4Ppp3rs3LhBvmn8JE+TYYTtLOVMvdi7U/pLd/V1QaTWykGIEv7uAJtEHH+VvLfdqgaT7FBtUW32u4lXAYtwQf3sIvEtfZdNic4YtjA1vHLJ0ojuML7XdJMTF5Mc54F4qsWhevs4GccuuXV3YpisHrsxS2+MpHBc4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531113;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=RAInAapaPEVVIMyMy0xQq48ym4WbDouBno9PBv2kGos=;
	b=V7LsRD3K3Axr+Tmo2CUeEkIxjIf72KLanRHbMyVV7P3D5aUtYcQB0JQuPlo9wVUV
	4/AiypghK8ioBAji/LldrqWb8P/xx7ukxFHec6WmiuPj275uqz3SwLUlmYK+xquEgFv
	3IpbOKbpeG/FKX21rHDIUmTy4BSYnA5+TXSYa9ps=
Received: by mx.zoho.eu with SMTPS id 1773531112291582.2193221121778;
	Sun, 15 Mar 2026 00:31:52 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 13/23] lib/bootconfig: replace linux/kernel.h with specific includes
Date: Sat, 14 Mar 2026 23:31:34 +0000
Message-Id: <20260314233144.187273-14-objecting@objecting.org>
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

linux/kernel.h is a legacy catch-all header. Replace it with the
specific headers actually needed: linux/cache.h for SMP_CACHE_BYTES,
linux/compiler.h for unlikely(), and linux/sprintf.h for snprintf().

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index fe1053043752..0823491221f4 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -17,7 +17,9 @@
 #include <linux/bug.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
-#include <linux/kernel.h>
+#include <linux/cache.h>
+#include <linux/compiler.h>
+#include <linux/sprintf.h>
 #include <linux/memblock.h>
 #include <linux/string.h>
 
-- 
2.34.1

