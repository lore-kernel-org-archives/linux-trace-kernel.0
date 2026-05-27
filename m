Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08C1B808;
	Wed, 27 May 2026 02:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779849320; cv=none; b=Lwnz6zDUtarSNJOlQ0/T519kbbBhS0gOjYDSLrQaugJ/C8j/DdKxmtGK47dEH2Z+2wBVvBOWdBH1x/cDLhkcnoE0TXlelD9vT7xuhRMBHQyB/3AveqlMl71dbmq88gyGlMFJM6pHXY7NE/C4rGrZzd0uVy8xaZnZHl7k6ISZXPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779849320; c=relaxed/simple;
	bh=gioviaF52i43l342azWELMOxbLONB8hxIkrimx+QBdc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jn38jfYnF/ntSh5vqij1dVvAeVtAPk0cWl11edAL9nIdLCEZt2vZ0SsgkYnRbgN2kt3+Y6ovT0oT5umAvK3QTyYNqG1rPBMuYUBcXxOoOQUQvnLun7cHmCEI8McWiGpQuS9MC+HZuj7V5MLDF3fzL7l040RjaBrBIeOEicUiAtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: af2c83ee597411f1aa26b74ffac11d73-20260527
X-CID-CACHE: Type:Local,Time:202605271018+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a627bf32-5798-41a4-9491-986fd3378d2e,IP:0,U
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
X-UUID: af2c83ee597411f1aa26b74ffac11d73-20260527
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 115034685; Wed, 27 May 2026 10:35:11 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	pengyu@kylinos.cn
Subject: [PATCH v2] tracing: Point constant hist field type to string literal
Date: Wed, 27 May 2026 10:34:50 +0800
Message-Id: <20260527023450.2137639-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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
