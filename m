Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D6332EDE;
	Tue, 19 May 2026 03:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779160419; cv=none; b=aDQd/bC0AweP0gbCMOdRZ+y11fiq4Weav6L+GLfUlncNvLrsLRSiKNelmipAVrzFNQwDb2BRC8kRWl5NxPXo5+V09nJFLFXZtNg4+vdTOlaegKgrBq1s4vTnWTqIYA2TUCV3pXJLTBZ1bmN4skW9miQ9BJZE1QhDvuq6MCP/8T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779160419; c=relaxed/simple;
	bh=BXWZ/bbcL4wtOL4b0POebl6fejrH7dLnDQgZombireQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P+uaAPDT3bQzVPdZdtAJLbauGsntPmXzu0ITObHw9O2GdM7fgKbwah0Bb96BIEK8dnylw00CWvZpUlZHmraUh6+r4sS8ONRBQs/8pyO5Q5aVuLnt5SLrkccdSsDSuDUuTd9mSbWcbxkCVyKR9KEhucKiBiaHiXjfpXbJWLP7qKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b2ee354e533011f1aa26b74ffac11d73-20260519
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
X-CID-O-INFO: VERSION:1.3.12,REQID:906504a9-2279-44b3-a0e9-62738155f99f,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:906504a9-2279-44b3-a0e9-62738155f99f,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:6089f8972ab102a03a063021fe358b33,BulkI
	D:260519111326URQK6F86,BulkQuantity:0,Recheck:0,SF:19|66|72|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b2ee354e533011f1aa26b74ffac11d73-20260519
X-User: lihongtao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <lihongtao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 224980094; Tue, 19 May 2026 11:13:25 +0800
From: lihongtao <lihongtao@kylinos.cn>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	lihongtao <lihongtao@kylinos.cn>
Subject: [PATCH] tools/bootconfig: Fix buf leaks in apply_xbc
Date: Tue, 19 May 2026 11:12:55 +0800
Message-Id: <20260519031255.139036-1-lihongtao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If data calloc failed, free the buf before return.

Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Signed-off-by: lihongtao <lihongtao@kylinos.cn>
---
 tools/bootconfig/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 643f707b8f1d..ddabde20585f 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -390,8 +390,10 @@ static int apply_xbc(const char *path, const char *xbc_path)
 
 	/* Backup the bootconfig data */
 	data = calloc(size + BOOTCONFIG_ALIGN + BOOTCONFIG_FOOTER_SIZE, 1);
-	if (!data)
+	if (!data) {
+		free(buf);
 		return -ENOMEM;
+	}
 	memcpy(data, buf, size);
 
 	/* Check the data format */
-- 
2.25.1

