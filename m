Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA96638CFE5;
	Sat, 14 Mar 2026 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525348; cv=pass; b=ubQrbmn9LxDSg/ZM+p8QkweL+rIttRvQlNhkEtVkDyuwlNtNcA9U9feQDWBUIdWWN4YVgfW+h4YdKZS9IFbmv4eDhWgIevF89P+89VoXpUm5ex2a9eWAsQpsoytzALl5FQGl8cfzTwWqkO3tAk7ATotkdcng50SLffi4gsKu3+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525348; c=relaxed/simple;
	bh=6I0hpTbxvzM0MrqqhLwejv2QuzQNDU3b1q7ISIjV9Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ku+dqwooghde2pjHpsrKpHTkVoRmQdJA+uBEdmNEHnl9/JoZRnYTRMr+qUCRbzfbIluWF7GZDCJRRw0T8DLosgSkWh07QZChcS4y5iplRmuSKqk9tw+FdNnJI8Tz71H3WJSqorZLSi/uNowz384z0foIFucBPLasibeG9S/1U9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=kjL/FMXf; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="kjL/FMXf"
ARC-Seal: i=1; a=rsa-sha256; t=1773525337; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=lC/ENHuLQGN70aCHNaJpUtvvyNTC2qgabXuoSWEoeuWfoOv1mAT//ufVBGfPr5siD+GbUJMZAdHmFwKkX9kPqCg0JfSkGhaUnPG7vT9AudN6VmaefwAleZs54FTfRnHp3fgTa5EtMmXGaW1L21/5gka4deMZOIeX1QWyAHoVOfQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773525337; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1AD6D9MidV6Fkfxyg/iT9A9sDWNhqE7cnbV+HIFl0WI=; 
	b=X5qtnMWrECxljtGASC4+QLc0DOCiFT+bmveugQk85hqF4TXyTO/YE+UtDEEW1TBoLzlXgxbZh732pGSlViClLibBM6q4n2HgkUTqdmREqa22SzmDg51Rgq/S54I8TEoH5hs9Q3aspyhYxG0mGoVrW+VMl6Fv8RvK5lyLHKxNxwM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773525337;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=1AD6D9MidV6Fkfxyg/iT9A9sDWNhqE7cnbV+HIFl0WI=;
	b=kjL/FMXfPRNOZ9xSkpD+q5i00MzDDZIefmf9I1x7roH7Lmr0Zg3gvbPp//eG487o
	cQ9HeLzqEX45X8wjcaGTrMwxVJkOY9s0BRSw0qfrUEaFW1ZceTwumJofmTfWUo7VByB
	adP0dI1i6Nqm8yTPfSy+c8UKTA4a7gysX0tqUQAQ=
Received: by mx.zoho.eu with SMTPS id 1773525335259810.0485260693058;
	Sat, 14 Mar 2026 22:55:35 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 14/14] bootconfig: add __packed definition to tools/bootconfig shim header
Date: Sat, 14 Mar 2026 21:55:26 +0000
Message-Id: <20260314215526.108651-15-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314215526.108651-1-objecting@objecting.org>
References: <20260314215526.108651-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The tools/bootconfig userspace build includes the main bootconfig.h
via a shim header that defines kernel macros for userspace. Add the
__packed macro so the struct xbc_node declaration works after the
conversion from open-coded __attribute__((__packed__)).

Signed-off-by: Josh Law <objecting@objecting.org>
---
 tools/bootconfig/include/linux/bootconfig.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bootconfig/include/linux/bootconfig.h b/tools/bootconfig/include/linux/bootconfig.h
index 6784296a0692..41c50ab95ba5 100644
--- a/tools/bootconfig/include/linux/bootconfig.h
+++ b/tools/bootconfig/include/linux/bootconfig.h
@@ -48,6 +48,7 @@ static inline char *strim(char *s)
 
 #define __init
 #define __initdata
+#define __packed	__attribute__((__packed__))
 
 #include "../../../../include/linux/bootconfig.h"
 
-- 
2.34.1

