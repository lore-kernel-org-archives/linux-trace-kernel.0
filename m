Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EEB3E0C44;
	Tue, 19 May 2026 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179669; cv=none; b=LsWsaf+AVudSVcmsvioUbKD7d1snbOfCM5Gj8Ys20pt+qbl84klxKRQmN9H/5KbV+htSnIGwpJz4z2Ei6W2qCKsa/YX5D8l0J3OdhJBgQcHMrVF/w+kpTtIBTfwojGB0WFu7Wd+GS6bFTZIYliMrkBq5un0tzsqpL1x4TF4NFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179669; c=relaxed/simple;
	bh=aGm1daHc6UTVMt5lJ3xDp8MadiAYEw+6TCSXQ91v2ik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rue37j8/WkNy6CZhgkhRQhjEVhYJkPXpj74Zzocy3CBmmljY5YQSJvo6EVVDJ+w4uTWj4LkhIT9Z94DVqrs0XOGVlRU4h3kQICEeX8gOTdaLcX934Y9/37w5IYeTPCHJuLX8hxe9NUl495/Oglz+lcncQ8xZs4j0pGJRtTbkdTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 864427ce535d11f1aa26b74ffac11d73-20260519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8c425427-e475-4b94-8b50-8b9b90ec0538,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:e8d12160ce2cfd3aa68a9b66744c0bfd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 864427ce535d11f1aa26b74ffac11d73-20260519
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 977456710; Tue, 19 May 2026 16:34:17 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH] tracing: Use krealloc_array() for trace option array growth
Date: Tue, 19 May 2026 16:34:09 +0800
Message-Id: <20260519083409.3885032-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use krealloc_array() when growing tr->topts instead of open-coding the
size calculation in krealloc().

This makes the resize path use the helper intended for array allocations
and avoids manual multiplication of the element count and element size.

Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6eb4d3097a4d5..bde22d693d2e4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7928,8 +7928,8 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer,
 	if (!topts)
 		return 0;
 
-	tr_topts = krealloc(tr->topts, sizeof(*tr->topts) * (tr->nr_topts + 1),
-			    GFP_KERNEL);
+	tr_topts = krealloc_array(tr->topts, tr->nr_topts + 1, sizeof(*tr->topts),
+				  GFP_KERNEL);
 	if (!tr_topts) {
 		kfree(topts);
 		return -ENOMEM;
-- 
2.43.0

