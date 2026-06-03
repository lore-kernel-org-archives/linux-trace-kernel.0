Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB313F8ED2;
	Wed,  3 Jun 2026 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467965; cv=none; b=KkV7psgPKqWezaKSipX1erJuKIf0RfZF5mURS+5NK8glPGJuSPOcqZ2rK/r4AX/5HSLW9aSgEg+vLezlOLNrdE3RGaqBt0MD52Mu3P2M206ahdH/gPT6Jpl1+A+zNCZ+Losx6UauqNsDzif78mILYjiKvCG2BDL69VkK1EC2RfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467965; c=relaxed/simple;
	bh=4fqA3B8PN9MU+jxTKjVPTRw/Rm08xIF69j0CAUVVblI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GLS0oxrjiKfoV/IsTlqSKrBQ0iFM5Y6aQU/T95SzMYoqCU4MaP+Lm3EZFrOQT2pinuIVS4XmmkvPBOHH5u4x6cmPPVViydmVbi+5NDrAgPIY3eHwGuofKBDZD7yhjjWM1mI/FVvFziHKdnI3rBprex+RapczIFXXcqo7nIN+ORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1507b90e5f1511f1aa26b74ffac11d73-20260603
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:bbb54f4f-a5b5-475f-bbca-7b00d0c48118,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:0c667e0a315a56a8cf9b340a38d1fd7f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1507b90e5f1511f1aa26b74ffac11d73-20260603
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1046869951; Wed, 03 Jun 2026 14:25:57 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH 1/2] tracing/synthetic: Free pending field on error path
Date: Wed,  3 Jun 2026 14:25:32 +0800
Message-Id: <20260603062533.1096320-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some __create_synth_event() error paths run after parse_synth_field() 
succeeds but before the field is stored in fields[]. The common cleanup 
then misses the field. Free it before freeing argv.

Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
 kernel/trace/trace_events_synth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e6871230bde96..cdd5b93328358 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1446,13 +1446,13 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 			if (cmd_version > 1 && n_fields_this_loop >= 1) {
 				synth_err(SYNTH_ERR_INVALID_CMD, errpos(field_str));
 				ret = -EINVAL;
-				goto err_free_arg;
+				goto err_free_field;
 			}
 
 			if (n_fields == SYNTH_FIELDS_MAX) {
 				synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
 				ret = -EINVAL;
-				goto err_free_arg;
+				goto err_free_field;
 			}
 			fields[n_fields++] = field;
 
@@ -1491,6 +1491,8 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 	kfree(saved_fields);
 
 	return ret;
+ err_free_field:
+	free_synth_field(field);
  err_free_arg:
 	argv_free(argv);
  err:
-- 
2.43.0

