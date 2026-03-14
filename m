Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C342772D;
	Sat, 14 Mar 2026 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529329; cv=pass; b=rZD5ql+KpRTXA7iFk/lqvZIc054f4Vc0OFJCQGgWe9XZFA4fUTc+wroX0RhYWatbYnnsFGUMIZbWZlXiyvcPVlblQj+yz2V2aw5AV+evxLzV0/EYJAWipMs3vz5HUS6Cep7raLl6mm4Yb7QWJOVI0licCoeDxNPsnPMKlFqfvvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529329; c=relaxed/simple;
	bh=Y9mfWQWziz20z1wZlyGCqiydfBbJQNFNO/oywEYrkow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K7HVlZN/Lx/Efb04qQ2iVnhjSSH1FJqDDN2fBVF5tySHTwXw/Ir0tNKGKU0fFEtDl5y4oIhMruUsYdu7ewsPfjYKS1hk5hyGiKK/MyOre5NFXMaogDUIWpMM5bGjCTwPzE71jz4dMiWHeLXWR40oLNCfB8GUEjvF9gXOuJTiT5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=BEy7D9OT; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="BEy7D9OT"
ARC-Seal: i=1; a=rsa-sha256; t=1773529321; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=aspFmIyVsQtEg0NZJS4T7szKsIFxvL4aWndl21Iy1wmx4dLC2MsIf3u8oYKeLT9C95kvxyjpPJfTTX2e/ObrnJwZzER933Hns/scoZZBAlzptzQ6z1lwcbTpSaM/xd0SCJVVVXZdQ5zlETFgvBeVwkGKk0b0Kn0EAHmX6v2GKPs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529321; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hXgtMivk2FUkBDZ0ELim05yAd6enb/8iaNS3/idzO40=; 
	b=jlXiTaxdh++CnHp38vrUNhMs9bGwpOIufJgZ1Nit97RnMvTCVm8qMg0LA2eGX7DST3Vh/5/5f7bFW0UThWV7/t1D6SSoZkwv+Uwerm6DelzxO7ihP2WwTWeBQUO5UnFmxR3sy+GtwV1BeHVYtkPDb8eOCaO3+GM5BgS4oFpP9Bs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529321;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=hXgtMivk2FUkBDZ0ELim05yAd6enb/8iaNS3/idzO40=;
	b=BEy7D9OT+KoM/dlj+piOkf14jMDZHGAFd6B+qDse/HDF4DM3jPBsP0qjJsbJ7mTG
	3AvlFzrWqj65zAKg7LRZxh5lWuuA4Igr200PyrPjpezzu81LmaD2FcYcf7ODc7ecyDV
	qnuWhMKTqda1IvbLLkOnRXacMUftMQ1sRW6TyQ1o=
Received: by mx.zoho.eu with SMTPS id 1773529318007979.0384381529594;
	Sun, 15 Mar 2026 00:01:58 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 01/17] lib/bootconfig: add missing __init annotations to static helpers
Date: Sat, 14 Mar 2026 23:01:39 +0000
Message-Id: <20260314230155.155777-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314230155.155777-1-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
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

