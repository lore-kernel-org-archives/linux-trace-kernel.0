Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB15D17B506;
	Tue, 10 Sep 2024 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951662; cv=none; b=TD9oaIL9aMt6ogIqDeP/a3KY7Q8jMM07eni0xNyq5I9T0GfA6fsH2fcuGRFxSL95kzG7nAdaOK25FkNs/L6uqyrfZbQ/8YdXiGMt3yYs+BMh3+8QP42KoVib+qwtm6Rnix20OiWPI4ZwdULHtZ3+4/HlhH8OhNJaoMIbmeed/mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951662; c=relaxed/simple;
	bh=OQrZI+jQ0wIZJiunn9L2ldEBbCDnEmcZEOeTVCcPijI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tOKDZfKVhWBoA8LjlapIm2XNmfec+NhJBKvQDeRg3ZktLlyG7pi/TGyVBJK462DU6ejDZz9sOHiNuOUdAZO2pwAx7vWS+Rlp/KJzAVsiQm3Y2WHvm/C/2gONv6Oeng9y1QtYzRJ4F3woAb8dLV1f9D4HybPDJlNk+6mpOEelRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5f4b7e706f4211efa216b1d71e6e1362-20240910
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-CACHE: Type:Local,Time:202409101457+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:7c4f4666-ef47-4aba-916b-d81418a0b8c2,IP:5,U
	RL:0,TC:0,Content:-5,EDM:-30,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-35
X-CID-INFO: VERSION:1.1.38,REQID:7c4f4666-ef47-4aba-916b-d81418a0b8c2,IP:5,URL
	:0,TC:0,Content:-5,EDM:-30,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GN8D19FE,ACTI
	ON:release,TS:-35
X-CID-META: VersionHash:82c5f88,CLOUDID:d55b189e65b8e9df4f94f80e2aab265b,BulkI
	D:240910145742MXI17UF7,BulkQuantity:0,Recheck:0,SF:66|25|17|19|45|102,TC:n
	il,Content:0,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 5f4b7e706f4211efa216b1d71e6e1362-20240910
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(111.48.58.10)] by mailgw.kylinos.cn
	(envelope-from <yaolu@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1416523776; Tue, 10 Sep 2024 15:00:32 +0800
From: Lu Yao <yaolu@kylinos.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] tracing/timerlat: Move mutex interface_lock declaration outside CONFIG_TIMERLAT_TRACER
Date: Tue, 10 Sep 2024 15:00:25 +0800
Message-Id: <20240910070025.132633-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix compile error without CONFIG_TIMERLAT_TRACER:

../kernel/trace/trace_osnoise.c: In function ‘osnoise_sleep’:
../kernel/trace/trace_osnoise.c:1631:14: error: ‘interface_lock’ undeclared (first use in this function); did you mean ‘trace_clock’?
 1631 |  mutex_lock(&interface_lock);
      |              ^~~~~~~~~~~~~~
      |              trace_clock

Fixes: e6a53481da29 ("tracing/timerlat: Only clear timer if a kthread exists")
Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 kernel/trace/trace_osnoise.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index bbe47781617e..7e75c1214b36 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -228,6 +228,11 @@ static inline struct osnoise_variables *this_cpu_osn_var(void)
 	return this_cpu_ptr(&per_cpu_osnoise_var);
 }
 
+/*
+ * Protect the interface.
+ */
+static struct mutex interface_lock;
+
 #ifdef CONFIG_TIMERLAT_TRACER
 /*
  * Runtime information for the timer mode.
@@ -252,11 +257,6 @@ static inline struct timerlat_variables *this_cpu_tmr_var(void)
 	return this_cpu_ptr(&per_cpu_timerlat_var);
 }
 
-/*
- * Protect the interface.
- */
-static struct mutex interface_lock;
-
 /*
  * tlat_var_reset - Reset the values of the given timerlat_variables
  */
-- 
2.25.1

