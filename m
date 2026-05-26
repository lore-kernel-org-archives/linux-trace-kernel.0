Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D3C3D813C;
	Tue, 26 May 2026 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789079; cv=none; b=NOM/keRPXsg2oDwssnJKUVIjmCFb6QcfcngrZVF+JrXcBamdNCdNil6RCpj1FPbbPwAeP0tNN5muiu3xnHtSW5pj7HEoyyz7Dr48txtQM289V4Ihpn7L6nR6jLmaXj9rd7oo+j4nsZ0q7EhXut7WDakEJlf+JmpmG7TtNepEqNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789079; c=relaxed/simple;
	bh=wzvI6xUsg+g7RTvIeZ2fZ/W1LuC/69lq5KuZMRJxvb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kg6sefiTBsDhdGeSKdJEWla7KzlsC+aDB53FgvjNPPCgUJ+B69jV4Reu7PRqLLOzgCdKZwW07dEoJE55ivbDy+yuRgWq3c9JUfK6Y5dfU7af/fO+oqEKpABkVuOqAnf9bZ3p757RHunVj1pYVUG2A1zznyKGOxE7Mif8No+4WJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6c7b043058e811f1aa26b74ffac11d73-20260526
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b84de531-b634-43b8-b22f-8bb1e36a7d9b,IP:0,U
	RL:0,TC:0,Content:51,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:76
X-CID-META: VersionHash:e7bac3a,CLOUDID:377fa0e7948bdfe796e63b931a8c4da7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:4|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6c7b043058e811f1aa26b74ffac11d73-20260526
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1633687139; Tue, 26 May 2026 17:51:10 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH] tracing: Use kstrdup_const() for constant hist field type
Date: Tue, 26 May 2026 17:51:05 +0800
Message-Id: <20260526095105.1330810-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HIST_FIELD_FL_CONST path duplicates the literal "u64" type with
kstrdup(), then releases it through kfree_const().

Use kstrdup_const() instead, avoiding the allocation for a .rodata string
while keeping the matching free helper.

Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index eb2c2bc8bc3d..6ffe9f4720a0 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1992,7 +1992,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	if (flags & HIST_FIELD_FL_CONST) {
 		hist_field->fn_num = HIST_FIELD_FN_CONST;
 		hist_field->size = sizeof(u64);
-		hist_field->type = kstrdup("u64", GFP_KERNEL);
+		hist_field->type = kstrdup_const("u64", GFP_KERNEL);
 		if (!hist_field->type)
 			goto free;
 		goto out;
-- 
2.43.0
