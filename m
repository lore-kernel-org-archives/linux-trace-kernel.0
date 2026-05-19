Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACCA5B1EB;
	Tue, 19 May 2026 03:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779160532; cv=none; b=RDvRwZwjiXUDqE/zTmGU6DL6dRh/I2ZHCC8pze0yORXpq/OWfVJt7OqwHCPsugBuwxcUO0v/3rv83b7oAumrDjcWAkX2CkZ02tJJZ3LoqZuB5Iv0F1SLFLgrG/zx85sYp/SBAG84Vrj4LoWSYXgQbIDncPhyTFPkPFF8F3acyYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779160532; c=relaxed/simple;
	bh=C8azgnm3PqkmZPQIdjgFsa8wL90OFUUycjyQ/Y9lfBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YNSHOabd8UD0fcFqERCv59eA2d2xwIYGWYDeGmyv70Gph17Uiv9S4IIUtbuwzeLf+e4B85n0LwrEAM8FxqHMg0hiIXRY4EFk2xigZjzsWLak50GhoeIxF/B1cHVEibZRW7CCJAtpexsVh1zDyKKL3QH6jGn5V2oMXj3nwx5pAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f8d17d6e533011f1aa26b74ffac11d73-20260519
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP
	SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ab487929-0c65-48fd-a3dc-c054eef8013a,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:ab487929-0c65-48fd-a3dc-c054eef8013a,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:6080c4dfd751e6dce907510922968c8b,BulkI
	D:2605191115245F2S1L70,BulkQuantity:0,Recheck:0,SF:19|66|72|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f8d17d6e533011f1aa26b74ffac11d73-20260519
X-User: lihongtao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <lihongtao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1343540227; Tue, 19 May 2026 11:15:22 +0800
From: lihongtao <lihongtao@kylinos.cn>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	lihongtao <lihongtao@kylinos.cn>
Subject: [PATCH] tools/bootconfig: Fix null pointer when free buf
Date: Tue, 19 May 2026 11:14:58 +0800
Message-Id: <20260519031458.141050-1-lihongtao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In show_xbc() and delete_xbc(), if load_xbc_from_initrd failed,
the buf may be NULL.

Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Signed-off-by: lihongtao <lihongtao@kylinos.cn>
---
 tools/bootconfig/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index ddabde20585f..417d07a46f92 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -328,7 +328,8 @@ static int show_xbc(const char *path, bool list)
 		xbc_show_compact_tree();
 	ret = 0;
 out:
-	free(buf);
+	if (buf)
+		free(buf);
 
 	return ret;
 }
@@ -360,7 +361,8 @@ static int delete_xbc(const char *path)
 	} /* Ignore if there is no boot config in initrd */
 
 	close(fd);
-	free(buf);
+	if (buf)
+		free(buf);
 
 	return ret;
 }
-- 
2.25.1

