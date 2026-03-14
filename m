Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFBC3845C7;
	Sat, 14 Mar 2026 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525338; cv=pass; b=eJUlB+GaAJmEYuHLzONQg4iK3WBvEdi3BblZvudzNUUB4fdAOPgbUcsKGJ62/Vhq5maIdmGO/Qjv0CaYlpeGTO5henEisbbefPmGHd1TLMQQp2fYpL3C5gzUfF3GKfxPJJgtw6fJQ6nnPVyacFHdm3s8ll63/FcYCX/iC2DgT3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525338; c=relaxed/simple;
	bh=Y9mfWQWziz20z1wZlyGCqiydfBbJQNFNO/oywEYrkow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZKmuqET9jVqGxNAb8HNbG3luQMMv4HiyY9n7aCPDOvJDBegaafI1hB20qZ33psepArlWbbx240qew3fGd26XYa6CswkKgWCSmauDCobRPmm2c30rndWO6IIKNslGtCt6hRQJVRmHdW5aPaKSHltcSkbO89f6MsVQkxy1RamcWj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=VdW/b9qc; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="VdW/b9qc"
ARC-Seal: i=1; a=rsa-sha256; t=1773525330; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=IMtovNCp5+rkaRxH49oXCF+c9OZCAE6KPldnL1QVZvimpySyoiFxxztmfpTdnJN9jZml53pPoaY3SFUilvGlEtaeXsn+m9rROK4yrp+zJWb4g1Jl/a3dK+PDb6eIBmSYevQ7F9L4xtRQms3Cji7GKHenjUo9HxU7pIAe/pirFq8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773525330; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hXgtMivk2FUkBDZ0ELim05yAd6enb/8iaNS3/idzO40=; 
	b=Z3Y6CSQscLrXCVv0vip7xC1Ir0ROY/ZpxgALopcKcZIg8noBqco3V3aDq3CmoK2JDYTihcGMi8zBNWjGWp8yWFwMIp+tqndF5yY7WJiGKmpbqGU0u0t5PdwHoBNE2InDtMSpMOQrs3UjxoYhKijOA6A42wcIpwErh37qYP+XPug=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773525330;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=hXgtMivk2FUkBDZ0ELim05yAd6enb/8iaNS3/idzO40=;
	b=VdW/b9qc+Xe9hGr5J2+n3uxg6LzX+Fw9RiGaD0icX+AcLPQgLNy4n5JfNR8xlSgq
	2rUHlMJPEQzRDOy1xk3hrEaDQQgqIn87NVGuNhnlzyEbvLYnrE9W5vZhkZh5TOdh9/Y
	tlcP22yEmRjpfmOw4jOMZx5W+rA9AD6ssD129Np8=
Received: by mx.zoho.eu with SMTPS id 1773525328099570.7792511772026;
	Sat, 14 Mar 2026 22:55:28 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 01/14] lib/bootconfig: add missing __init annotations to static helpers
Date: Sat, 14 Mar 2026 21:55:13 +0000
Message-Id: <20260314215526.108651-2-objecting@objecting.org>
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

skip_comment() and skip_spaces_until_newline() are static functions
called exclusively from __init code paths but lack the __init
annotation themselves. Add it so their memory can be reclaimed after
init.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index b0ef1e74e98a..51fd2299ec0f 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -509,7 +509,7 @@ static inline __init bool xbc_valid_keyword(char *key)
 	return *key == '\0';
 }
 
-static char *skip_comment(char *p)
+static char __init *skip_comment(char *p)
 {
 	char *ret;
 
@@ -522,7 +522,7 @@ static char *skip_comment(char *p)
 	return ret;
 }
 
-static char *skip_spaces_until_newline(char *p)
+static char __init *skip_spaces_until_newline(char *p)
 {
 	while (isspace(*p) && *p != '\n')
 		p++;
-- 
2.34.1

