Received: from sender-of-o53.zoho.eu (sender-of-o53.zoho.eu [136.143.169.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85D838737E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524788; cv=pass; b=quO6gknmSVrkOOEUgY0JlvHG8e5ZdHC9fa0UGvLYUpX+NvcVxVHnv7iu8yscWro1Lmj4OK1x/cU91QmPUEjYD1vBKs/Fad7mmvseSWMRrOEk7GRICK4rFAFSqGSaOb98gTOKdwhaAAtveC+iatIe774Y1Y/5YcT/hX3nCfvUjp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524788; c=relaxed/simple;
	bh=5jHlNQbA4ax5oxWy6TmNNrMnctsyCd5kWbRwYKqDhJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N6S4m4q5OPT1wLiKzBLqOnupyHOMwH6XwI81R0hPBEFjaWxRz4fiLIKroZ5IEs7MD3/+Lw3zr8Hc+Ky1Afi2Si+Fb64gPl1K1gDy3V48AQ/8IdioWHRRi08hHc3swRYx2U5IKqcNPwNYr8mNDJPrGm5v8mChWbyQ0O5DJ7IhME4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=PhDKTk65; arc=pass smtp.client-ip=136.143.169.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="PhDKTk65"
ARC-Seal: i=1; a=rsa-sha256; t=1773524768; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=JMSsjQncB7GohxpNEAOsx649si4o54twz+duLWHrbPKkRHMDEzWYOvQODE7zmmnRmmKChHgmTz7KCqtb/YBRwAob/+fRiDUpZp1uEheHjss2gje6Nv1RrhVBnbS4Jqz57+BsV96gaKC5ikVhQyPQm4qf8/80oLdefVCLUxfBXsQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773524768; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RAInAapaPEVVIMyMy0xQq48ym4WbDouBno9PBv2kGos=; 
	b=MPevvqTNDa8eOHY8iH7hdV0tKa3vNBBaIbiZMmn+G+CiNYcSAQOitM29zG1U77oXk7oQFdcYlvpme6GvMWhiFtvaDZfBFOJfsHcODvIZhJiWw6/3GzhrOcyYsgIq12VztmdqADWlMpKK8FG6Xow+U31hDii0F3LRfCwPBkUsdjk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773524768;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=RAInAapaPEVVIMyMy0xQq48ym4WbDouBno9PBv2kGos=;
	b=PhDKTk65NSkEyTW6nOcx/dCqVPggxcIjjWJS3jeTZ45dLE6rx61CS+rHii1dC6TT
	ZPtfcHxiti8TNqVFHkMoFz35Rwg8XB0z3j1H4Ns/VrM6kTDNCnnGsauaERA9xVx0eMM
	26tWa+rXPTrQts8JKklDrDCyT+sbwJg+cvj+LnTo=
Received: by mx.zoho.eu with SMTPS id 1773524766014303.04632553709996;
	Sat, 14 Mar 2026 22:46:06 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 13/15] lib/bootconfig: replace linux/kernel.h with specific includes
Date: Sat, 14 Mar 2026 21:45:53 +0000
Message-Id: <20260314214555.96217-14-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314214555.96217-1-objecting@objecting.org>
References: <20260314214555.96217-1-objecting@objecting.org>
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

