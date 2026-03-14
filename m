Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2701386435;
	Sat, 14 Mar 2026 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527683; cv=pass; b=iYemA3KomXy7ohmFqo+GS/jcrpiUrCykR+Bj18xe8derc1ePGbay9xBkp9uR3MJ/IDpPwuY/eRnmKAD5lg1vPkG81vV2D6vmR2xbNMfTEwz7kCw54DjMMUG7EEjN7N9P6wpzc/PIdbuLgwylQoKo2jCDuMG+u498+6ZJNZU+ng0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527683; c=relaxed/simple;
	bh=5jHlNQbA4ax5oxWy6TmNNrMnctsyCd5kWbRwYKqDhJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KHY4bssp6COq2vvs6Y4LSUheTIARRRRfEPXRiK5pfukxK/pp/MTjupQFQeBCb4glzVDlN68WUoA23D8hbWkGmUE/IY49FNYIvdzWGesjOev0rOaf5NGVWEmsSrgLQMu87WOdwVg7BDN6zFyHilNtr25omUCj2O50d1FPIGGUv4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=S0M0P7Cm; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="S0M0P7Cm"
ARC-Seal: i=1; a=rsa-sha256; t=1773527675; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=PYgQqtNjYshu9yYu9gcKCtGBdv+zrpS5MjUFidazoT6/JNRiPAZ9DNskm0pICbxOWF124SoZWiPRX00tmGm9D2ewQPs0dJIIwN1glVP+6oSecxSxp010aUJ5J4YRJwEAi7cuqVkdWfxbYt+lr/sI1AP3o2rSeqXW1m/jZxTHMWs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773527675; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RAInAapaPEVVIMyMy0xQq48ym4WbDouBno9PBv2kGos=; 
	b=Ut4z5HLpLK1WAPLMI8EdKwi6yJYwiVZqJDFRWETOACvDCd9qjBzZOy0fTs6/4pjlUrPUJADWljO0ddms/8LlXwbdMMafxrBfG/XIueqNXke5a2b9BEgDDygQsTIp2BLoQ6pateuehALai6+MYC2bnaR7ZFAxqNQtiUIarSduFlw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773527675;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=RAInAapaPEVVIMyMy0xQq48ym4WbDouBno9PBv2kGos=;
	b=S0M0P7Cm8FCVGF9PVCo0zM7po8ZbEQl4iKZ8LI1yt9yPdEQ/g4wgZAVQwzuu2LN/
	ETtF/8JFwnt/dhHva+YZexJwHBs7cL2P/eO8Aihw7An0mnZM38Mb8qKTRt+3aO6Tx/s
	vUE8Q0p3jB6ZoSyYnkhdZ+Up58MamMK/pxuS2lp8=
Received: by mx.zoho.eu with SMTPS id 177352767343368.48492945401745;
	Sat, 14 Mar 2026 23:34:33 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 13/17] lib/bootconfig: replace linux/kernel.h with specific includes
Date: Sat, 14 Mar 2026 22:34:21 +0000
Message-Id: <20260314223425.142966-14-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314223425.142966-1-objecting@objecting.org>
References: <20260314223425.142966-1-objecting@objecting.org>
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

