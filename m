Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B193F2113;
	Wed, 18 Mar 2026 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849578; cv=pass; b=eDq3A8KPOd9mjo3uTrCbA1TeF9LLDk4Jaaln+xrFoUTqRR0xkSxcIQtXk+3r2Pz2aHV+OZndCnYkNmSnSpGaO+PMYBVi/qFoVQlMwClzjhk+DkEmOJ8aCNbZylOLHKQ3hd+OmD3wlG1QQ6COC9yssLwQdXkqjlL4WeTr6jo5nmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849578; c=relaxed/simple;
	bh=vGHAAnRSmfkKeoZIkPxL389Ha8SG4InW5EOp9WN4bv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q/XgYW7CDtuRFsw0uzV1v2sumMQ1pxfI/683I76lQo55xYV7Cg0cbX+DmBASLyUW6bqVNjo9BL4Ld4Ue7pnyvz7Gw++yiXuuxEdEZfon8g+cY21SOk9+IU4snBOoW3kCvwF9lhPUcAPpuxMKytdk0IE3+PZClSxZfYYAxGy8KE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=GUJh20ed; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="GUJh20ed"
ARC-Seal: i=1; a=rsa-sha256; t=1773849566; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=bgL/f1tc9WArj9HMdaujO+9ForTKykAbuSG331VnEn+jcTlWmxbe5YgcXYAQdAhih6k50TfpzbaO73+T9A3NVRgE5M3zFASznFkPS0cnHGRfTSFI4WFnzvQiAZmirnNt7/5P+ZDGXxyuiW8fvM1bv7XlVtuyGPJDR8oWDmap5ig=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773849566; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=45wJib0hzF/G0lzrOyItS1blgCsEV6Gatl0MqE00PSc=; 
	b=IFAoql6ANsFXey+WzeWp45nQiL6Sg08i01SkQWezD9qjq0f9vZJq8r7DBvAub8LnrmnP1WzUWs5X81YtZC5kDqPgnXsq53B3wp8cQ8dDhIDUcIKyyIkV/BgxKyPcyjvIGFg5Ba3NONkWyYIK8vY4mY2GwXQAmtWNc2IwqyREQ7g=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773849566;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=45wJib0hzF/G0lzrOyItS1blgCsEV6Gatl0MqE00PSc=;
	b=GUJh20edLKflThhVohw8JcgffUiPtsRRSmgrJY9Axez8e5+TbBH09h+M6oU6fw2Y
	pJrSySYnEb6YyqGUIjMzeXIvPEhOE8F8M7ZegTVUCKUf1FtnM5aHyPnFydSJRXpHIAT
	KUaboQwgxUYP3Io2TYdwKpJFc7u6Z+tzfKjeNCqI=
Received: by mx.zoho.eu with SMTPS id 1773849563709264.90298413838354;
	Wed, 18 Mar 2026 16:59:23 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v8 07/13] lib/bootconfig: replace linux/kernel.h with specific includes
Date: Wed, 18 Mar 2026 15:59:13 +0000
Message-Id: <20260318155919.78168-8-objecting@objecting.org>
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

linux/kernel.h is a legacy catch-all header. Replace it with the
specific headers actually needed: linux/cache.h for SMP_CACHE_BYTES,
linux/compiler.h for unlikely(), and linux/sprintf.h for snprintf().

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 69486bd56fea..d7e2395b7e83 100644
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

