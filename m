Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755EA404BC8;
	Tue, 14 Jul 2026 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018034; cv=none; b=H7oDvR/fGXu2r/9lLN5/FISvKI81JqXP+r4ANg3VYQ+yAoIt9/1nSIF6I5noanI9Wx5G+nrvtfSwPtcoQmMkf6daZjLJZCsGhjJ2DGkFWANRXYZoEoncuYf/27jLfuPgPwjkpiZJY8akA+FMKurDsMwZbzd5Aohu/COo6+tDMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018034; c=relaxed/simple;
	bh=Cxy20tj3JUoWvSyBh/c1+oRGZvLaXjtTpyN+eU+tha8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBPRJfxDNMs64li7dQ6LGIq1w6MWor5EGn0Wq0blTmwQhfQsVZ+n/8LTQJ9RzCahoQPS7NR7cWh3o51Cw4Q8Nq2GpyQdzoI7b7Gb0Irsx+eskAblD3hxdob5v2HVgnor6u7vka6KmrTPlfwe3d+bO/8jNJv2hdlgRpGxPKyqI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b6813fda7f5e11f1aa26b74ffac11d73-20260714
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED
	SA_LOWREP, SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9b9e8955-104f-4a4e-b6e9-b3e5a81d6272,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:9b9e8955-104f-4a4e-b6e9-b3e5a81d6272,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:a73a9433bf98bacb2a859372d63d5416,BulkI
	D:26071416334129L1ZJSS,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|865|89
	8,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b6813fda7f5e11f1aa26b74ffac11d73-20260714
X-User: liqiang01@kylinos.cn
Received: from cvdaxia.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 748304050; Tue, 14 Jul 2026 16:33:39 +0800
From: liqiang <liqiang01@kylinos.cn>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	gmonaco@redhat.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	liqiang <liqiang01@kylinos.cn>
Subject: [PATCH] rv: Simplify task monitor slot management
Date: Tue, 14 Jul 2026 16:33:15 +0800
Message-ID: <20260714083315.1371676-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The slot array already tracks allocation and task_monitor_count
duplicates that state. On an invalid second release, the old code
warns but still decrements the counter, corrupting later allocations.

Use the slot array as the sole source of truth. Return after warning
about an unused slot, and return -EBUSY when no slot is free.

Signed-off-by: liqiang <liqiang01@kylinos.cn>
---
 kernel/trace/rv/rv.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index ee4e68102f17..187d87d5991c 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -164,7 +164,6 @@ struct dentry *get_monitors_root(void)
  */
 LIST_HEAD(rv_monitors_list);
 
-static int task_monitor_count;
 static bool task_monitor_slots[CONFIG_RV_PER_TASK_MONITORS];
 
 int rv_get_task_monitor_slot(void)
@@ -173,21 +172,14 @@ int rv_get_task_monitor_slot(void)
 
 	lockdep_assert_held(&rv_interface_lock);
 
-	if (task_monitor_count == CONFIG_RV_PER_TASK_MONITORS)
-		return -EBUSY;
-
-	task_monitor_count++;
-
 	for (i = 0; i < CONFIG_RV_PER_TASK_MONITORS; i++) {
-		if (task_monitor_slots[i] == false) {
+		if (!task_monitor_slots[i]) {
 			task_monitor_slots[i] = true;
 			return i;
 		}
 	}
 
-	WARN_ONCE(1, "RV task_monitor_count and slots are out of sync\n");
-
-	return -EINVAL;
+	return -EBUSY;
 }
 
 void rv_put_task_monitor_slot(int slot)
@@ -199,10 +191,10 @@ void rv_put_task_monitor_slot(int slot)
 		return;
 	}
 
-	WARN_ONCE(!task_monitor_slots[slot], "RV releasing unused task_monitor_slots: %d\n",
-		  slot);
+	if (WARN_ONCE(!task_monitor_slots[slot],
+		      "RV releasing unused task monitor slot: %d\n", slot))
+		return;
 
-	task_monitor_count--;
 	task_monitor_slots[slot] = false;
 }
 
-- 
2.43.0

