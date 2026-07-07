Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69432FFDE1;
	Tue,  7 Jul 2026 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430676; cv=none; b=WRIIMIMZaKMHusKlUVUQPzxEYDUej6NOkpQNEhHBQQUcdAVHVhgMO0nkUSGiU7Lt6nJtlDdZXMTqIKyCJCVOKXQJLluUqfMDh19QIE5U6sfYuvz/4kJ6pHOuYX+z5c6+ZLzdTxYciYyPnW05ZVjXYoJo4ZDmTuY0xjZDqCh6TCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430676; c=relaxed/simple;
	bh=u2JiIXOcSAy20Kkpi1FIeaFJw87kSvAUAcFsSQ42tok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C1XPqjMogvdwZQU31Yrq0gxNUK1Jzzv51xOD/BfCG6TM7+TPIUrIfnJXpnFyAOQi791XQzguIsBclm1xw1JAm+k+R3oexv+7Mtfvx0LUiVPvXc0Z4D4DNhp+1eOjnx2uQBCZh+wTGf8MiSeEPUVq0zuyvxxMvaO9/QXjW9LgwzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2cdc83547a0711f1aa26b74ffac11d73-20260707
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8f847a35-e74a-47c0-b306-d46a26789a6f,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:684e66c1beba86db05315929da9284c1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2cdc83547a0711f1aa26b74ffac11d73-20260707
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 352142666; Tue, 07 Jul 2026 21:24:26 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH v2] tracing/synthetic: Free type string on error path
Date: Tue,  7 Jul 2026 21:24:17 +0800
Message-Id: <20260707132417.2193412-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_synth_field() builds a "__data_loc ..." type string before
assigning it to field->type. If the seq_buf check fails, the temporary
string is not owned by field and is leaked. Free it before leaving.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
Changes in v2:
- Use __free(kfree) and no_free_ptr() as suggested by Steven.

 kernel/trace/trace_events_synth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e6871230bde96..ad2e70258291b 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -828,7 +828,7 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 	} else if (size == 0) {
 		if (synth_field_is_string(field->type) ||
 		    synth_field_is_stack(field->type)) {
-			char *type;
+			char *type __free(kfree) = NULL;
 
 			len = sizeof("__data_loc ") + strlen(field->type) + 1;
 			type = kzalloc(len, GFP_KERNEL);
@@ -844,7 +844,7 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 			s.buffer[s.len] = '\0';
 
 			kfree(field->type);
-			field->type = type;
+			field->type = no_free_ptr(type);
 
 			field->is_dynamic = true;
 			size = sizeof(u64);
-- 
2.43.0
