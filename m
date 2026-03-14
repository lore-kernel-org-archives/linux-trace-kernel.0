Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72967386434;
	Sat, 14 Mar 2026 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525348; cv=pass; b=A2vk9pKFBxpHIF6PjyodO95ihFGxgkQMn0cWhgK2go5KRPaj9dDaLg9yhjlLxbjDuyZDS9T4LemFYIJ4o1EKDEeJAXyGQgyJ2pw9Xf1PfMtqTPz3blYVzY2aUS7P8TucOB6qInHCAcDOC1EkUSrMKw9cKn4mLxorRX+4Yet1cM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525348; c=relaxed/simple;
	bh=5jHlNQbA4ax5oxWy6TmNNrMnctsyCd5kWbRwYKqDhJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lja/nBhRF0trGogaQtAk3SF0delMD2juqD5gzROhex4BQJFQDl+DumJ4NwjaN5uewuX4uClMPHTUaD5UGXDOo1L7JBMGGECvyb9d07/J52gx2abdSdtgvT4XAVSCbtfW8rXp4QrfcOnRgfAnmT+jBbK2TfLxTCnsjjNPU+60RL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=czDwkkMm; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="czDwkkMm"
ARC-Seal: i=1; a=rsa-sha256; t=1773525335; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=eOdo108LkuqVPV5IF6y/PPCiBf6lNpzFxFU2pqmNP1pqcWzF/CpFEIyNllOcil5Vm4UmPVKZvvMCphSNT5KfIksKUqbE7LVVppNpNaupa9fUemjY9bS6bxu5FxhTb4oXiC5f6yihUKJYjpgkfP6mgMmjcQP4cey/bFCBLb6TsJ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773525335; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RAInAapaPEVVIMyMy0xQq48ym4WbDouBno9PBv2kGos=; 
	b=HkdbvrsrtEtTH2umX6NczFnxPD8fDt65Ohqwyl/k3MkI+u7eCEyPGeOddssnkmxqfORHQ2lfUTpRQvEo/7aPEjWEEb2Vg4Ujidjfkh3dR9+rIKpyledAw8PtH+G+UfVjS9vpT4eD9NSHNzZ9vz6SZTQBZQ1zxYw4IgOYhzES0qc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773525335;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=RAInAapaPEVVIMyMy0xQq48ym4WbDouBno9PBv2kGos=;
	b=czDwkkMmBBtyFrTgPTAeQqxkFZXMnA2SuW7RP7bv80ziIkWJB/xA8Iy1KyZg8QMn
	seH+0wTONj0TFEGrxRwmWhRsUmOOh1E4YkwCfzmZ4uQO9bc/QK+tmO+EsCflmSop1Cf
	YqdAkr1wsioFyFme4TkzrcDPIjoRqM5G6StnRoQ0=
Received: by mx.zoho.eu with SMTPS id 1773525334731728.2655266394097;
	Sat, 14 Mar 2026 22:55:34 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 13/14] lib/bootconfig: replace linux/kernel.h with specific includes
Date: Sat, 14 Mar 2026 21:55:25 +0000
Message-Id: <20260314215526.108651-14-objecting@objecting.org>
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

