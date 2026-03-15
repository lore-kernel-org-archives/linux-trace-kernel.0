Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075F634DB77;
	Sun, 15 Mar 2026 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577234; cv=pass; b=dymugRBkJVp8rlhFPSb3jOa6kjpN3VKtKbyTFZ/a4WM2Ebr6z4mfud3v6hk5qL0ytw/Nk+zeJ3OsndtEHM7ta3O8G1w8ZskuDPq+fw2OAIzzheerfGnyW5y5Aq6UbE8RPesM/I9fnapomv+fmpriDnmVuKOT4mSjD1WfawQOUQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577234; c=relaxed/simple;
	bh=5jHlNQbA4ax5oxWy6TmNNrMnctsyCd5kWbRwYKqDhJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mOZjtH4pX7rNzZPnetKbphlFWuv+GA7dl8PTuiLd+oX/LQgHsw/zwRa0gcGWYLqDd21nazpNA+61l7kVONkPbHr3MSoWn707BevUoeloCdW/FgP/KqJs4QHkhExSDhJj1oMGalclQMDu4rvkCWDdzj71Ss8TKj4Fn9g2vOPITsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=KeIlqgeK; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="KeIlqgeK"
ARC-Seal: i=1; a=rsa-sha256; t=1773577224; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=fzJop3IvxFk1OHMw1VZZurYKhK5fo2L2XO1dOYAp7YHxvIeWG78jbcJFG9j1Z4XxXw69idatmOQPw/3WrkePbxQjdZ56unjMvtyWFwsG2HuTl76sT6//1mOo54muvMRFpS0L2lQ0KQg2eYK9DQS4XsWaueRgj+hC5A5eRDQs5Ts=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577224; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RAInAapaPEVVIMyMy0xQq48ym4WbDouBno9PBv2kGos=; 
	b=MdqFV7ImHGL1pnYA+cQKayZBKHot66lxsBr8YN6RrRK5JcAZVEfPmQoSHvxrYHWOVI9OWmabe5gXYj1AW4KhwFJNfP+yetZ05v6C5H0917qzmt0AWXcyvpIbLibjqItuOrDfc5FBD/5rc0+0BJIMKiyAfD273LEu0suWfQEBuAE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577224;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=RAInAapaPEVVIMyMy0xQq48ym4WbDouBno9PBv2kGos=;
	b=KeIlqgeKkJXZbsFJeKYsJFiXMe782hjM0bv+rznNId4PLlfxctfdv94eQ3BHCoG7
	y5toZjv9lR9vvLcWpWHtyafVBlRRqrwFGNaHv7QpUv6MCX2ts0nAouRwQWK9AqRQIQA
	rpamLmoUESFwUxoJBKCTftceSuW2BVr8aMYyK0g8=
Received: by mx.zoho.eu with SMTPS id 1773577221934891.1839683517646;
	Sun, 15 Mar 2026 13:20:21 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 08/17] lib/bootconfig: replace linux/kernel.h with specific includes
Date: Sun, 15 Mar 2026 12:20:06 +0000
Message-Id: <20260315122015.55965-9-objecting@objecting.org>
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

