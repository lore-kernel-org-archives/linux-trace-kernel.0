Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97CC271464;
	Wed, 27 May 2026 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779848336; cv=none; b=nJH1ML8viIhi3YcliWY+OS39rOGbhd6yg5hOhSIXTOJ+YLwFNh3QmAcExfg5sA1Xx4SJt2G5cZaX5J+HO2wqFbB2UhCNewP0nQLKwVosjMi+cbQ9YvrWWIjOYVRcEbxNVSyOJZibe4j6ULXteL3eHw9iY8v7vfAoguqbdgT7mo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779848336; c=relaxed/simple;
	bh=gioviaF52i43l342azWELMOxbLONB8hxIkrimx+QBdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bziihKwp1Dg4ny84n/aw6EqDeGmhNoKHfevp3g0O/z6hfN9voxNqkGUNM3gnfJbv5qfcEH4eNDccAYsdEYKoyGRD6FWGuI86pRceHCGfWrYl8aDMp3RxfHEIHHkxCc5ZJ1Ebfb5uZB3iK45iLJsMC0mP2dZUe38uppR1G6SDAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 644e8b30597211f1aa26b74ffac11d73-20260527
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8c3ea90c-39e0-44fd-b4a4-09d15fb33b79,IP:0,U
	RL:0,TC:0,Content:59,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:39
X-CID-META: VersionHash:e7bac3a,CLOUDID:93a97902f4f0d81729d01d9320d7a210,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:4|1
	5|50,EDM:1,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 644e8b30597211f1aa26b74ffac11d73-20260527
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 220625801; Wed, 27 May 2026 10:18:46 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	pengyu@kylinos.cn
Subject: [PATCH v2] tracing: Point constant hist field type to string literal
Date: Wed, 27 May 2026 10:18:27 +0800
Message-Id: <20260527021827.2123529-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260526215033.78fdac7f@fedora>
References: <20260526215033.78fdac7f@fedora>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HIST_FIELD_FL_CONST path uses the fixed "u64" type string.

Point hist_field->type directly to the string literal, matching the
HIST_FIELD_FL_HITCOUNT path. The release path already uses kfree_const(),
so no duplication is needed.

Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
Changes in v2:
- Point hist_field->type directly to "u64" as suggested.

 kernel/trace/trace_events_hist.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index eb2c2bc8bc3d5..b50f2bd5ff771 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1992,9 +1992,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	if (flags & HIST_FIELD_FL_CONST) {
 		hist_field->fn_num = HIST_FIELD_FN_CONST;
 		hist_field->size = sizeof(u64);
-		hist_field->type = kstrdup("u64", GFP_KERNEL);
-		if (!hist_field->type)
-			goto free;
+		hist_field->type = "u64";
 		goto out;
 	}
 
-- 
2.43.0
