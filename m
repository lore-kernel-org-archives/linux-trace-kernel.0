Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6405E38AC7A;
	Sat, 14 Mar 2026 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531237; cv=pass; b=tgjTXp+j4lYA/pqeiaPQVYaovOtv3+PJS53HEGD2esTDNfhEA2SM6zTyKe32Wen1E69z2klzGjve6WhsWD6gE0WCFwmOJnhc4BjaUI7osuSWWhIcx10YcyWZTdjwxB61SifweNmujXZDfuSRJZ447qUtH3Ra+xq3atb5lQ10Zh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531237; c=relaxed/simple;
	bh=Y9mfWQWziz20z1wZlyGCqiydfBbJQNFNO/oywEYrkow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f/7BipYhWphSJY0ocG9UQ0VcMnwwSBs1H/BtFtEuDvQDiC95ICsUAYMrPMhxRf3SJ6i249vWrYOxgXX+NPELIsEFI4IqhGgXAAiMbhXVIMVoc8hZWgfnRhXy5ZKjjry9huXLXVUN5jECLQZVgCm1ZmtXFaS0JXUtAQwda6Grf9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=HU1fmhDi; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="HU1fmhDi"
ARC-Seal: i=1; a=rsa-sha256; t=1773531107; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=W1Qgo+4Lp74LECw8K1Apcvhqkr6wxf7KU/ZkPJ0QjSvsbMq/TyIIuwW8x9j6ZWo4oSyl683boUXhA4nT13QqGnDKJ6nboX5UKMgDPjtibM4R4SkGjGxMSEWsQowyqkCUip/WCFRZb+fj3BSIaQdY1c7bZRcDOkt21oakwbeRBOU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531107; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hXgtMivk2FUkBDZ0ELim05yAd6enb/8iaNS3/idzO40=; 
	b=HeSt+EE2W1y2waarZiw9TWssCv5UNHc4XLYfo/t4qZmMEeUx6MLwgV5RFQGI8yjWGji07xFbSQL4SxsWbkUJtC92aMcjB7me9WZnszC7HcULozTIjeqcV4I57dcWP60KpW/CDsl3n4r5wAXppxzrbICFwtRyCXhm4Fjts/xem/M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531107;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=hXgtMivk2FUkBDZ0ELim05yAd6enb/8iaNS3/idzO40=;
	b=HU1fmhDic8v0jfKGC6SSF9n0NWODSHI1no51QxFS3TUM+rU5OvhMJnX7Eh4AFTBZ
	kUkg92BnKRTxdBsNnrub1T3dKXSMvc7yIvn2DJiRFw0Wy2a2oAueuWLtIJjgaUmBlo7
	YV0fWMZ8ColmZerQJz8VgeOdPAWtrf+iw6hXFoa4=
Received: by mx.zoho.eu with SMTPS id 1773531106259112.30339605381914;
	Sun, 15 Mar 2026 00:31:46 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 01/23] lib/bootconfig: add missing __init annotations to static helpers
Date: Sat, 14 Mar 2026 23:31:22 +0000
Message-Id: <20260314233144.187273-2-objecting@objecting.org>
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

