Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D89038F25A;
	Wed, 15 Jul 2026 01:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784080742; cv=none; b=kL49NXYi7hb6BxWBeT8uDmxSZm18J4WENkNaj0MgdOi0M52pjRQuJmqrCbn2iosMMR11reS6uHY4Ch7X2i3zFfqCD4NhGK2vweIm56y9NzxYu+M3Xbys3XV4i4bdXcSool5O4Uo3tKWcDZ1Fi2JM94B/0aK/TVrRuWmx50ZNtIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784080742; c=relaxed/simple;
	bh=dw86fQDZND8V/5JbBKAZqP8c9B/SUasG9k3q8JOidD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7S1ZbOydAf11W8Uu4gY98wIqKhofrmptcdK/WYt7WBGJHLKig4ThQw6tvRHaM6d3og3r13a+FAyTk1S3J2oVOSVsAsBQpIKKSHDX16phr7mq6wqMcNzJzCCaSlexjnxypEKUNoAdGdD4JoBuqmkuhYjCqG+H2/pThGBq2qhynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b7a146a27ff011f1aa26b74ffac11d73-20260715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7b7fc6a1-8e3a-4701-8add-b2ec0ecd71f6,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:7b7fc6a1-8e3a-4701-8add-b2ec0ecd71f6,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:59a5d877acc2152a1f4d5a4c70db0dea,BulkI
	D:2607150958490UUN1SJ6,BulkQuantity:0,Recheck:0,SF:10|66|78|81|82|102|127|
	865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b7a146a27ff011f1aa26b74ffac11d73-20260715
X-User: liqiang01@kylinos.cn
Received: from cvdaxia.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1919117022; Wed, 15 Jul 2026 09:58:47 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	gmonaco@redhat.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rv: Simplify task monitor slot management
Date: Wed, 15 Jul 2026 09:58:24 +0800
Message-ID: <20260715015825.1413822-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3ea6ffdd144ce4b38d4a198550afed9516777f85.camel@redhat.com>
References: <3ea6ffdd144ce4b38d4a198550afed9516777f85.camel@redhat.com>
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

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
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

