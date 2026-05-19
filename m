Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E25935A3A9;
	Tue, 19 May 2026 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178598; cv=none; b=pf/S1N3Ou9nK8w1wBqgTdjGHq+QEN/q16VomqXBnHwJCLP17g3RzG+K6qOAG+Zil3DLGLeipA9DTl7/oi3ohyHWet/cm1NV0y8YNgBmusxDFNfw0T+BE+u+D+8IKQ3yo+x+AdvF25mc3c+1CxnSs3SbPRTbjGX2oBt3prSh8X4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178598; c=relaxed/simple;
	bh=LbiDu1XQ/bPZB9yMhI47PTrhSvkskvRL+2WVn/5x5tI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P9KlKZOacdIW+zmwymmfH0TRCvSQ+iy1bIqYL9X+BGU0hZMbIWaElrzCZqZ0jmsemIJf1rwnRuzpDrs3tVrJRjuQHogIVPJn/ahF0X+JPwXZbyv6zl3YaQSWh0n0ee2ryyVUeJsVAH3Ovx6Vba305SmdDW+jbeYhNRKJSDyS5Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 09d63cec535b11f1aa26b74ffac11d73-20260519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8506e2dc-76c9-492d-b00f-1791d6268cbe,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:761895192d4c9428a15f4c4b9656ad32,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|16|5
	0,EDM:1,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 09d63cec535b11f1aa26b74ffac11d73-20260519
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1848596145; Tue, 19 May 2026 16:16:29 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH] tracing/branch: Use pr_warn() instead of printk(KERN_WARNING)
Date: Tue, 19 May 2026 16:16:20 +0800
Message-Id: <20260519081620.3874441-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use pr_warn() instead of printk(KERN_WARNING ...) for the branch tracer
warning messages.

Keep the message text unchanged. The change only removes the open-coded
log level from these warnings.

Signed-off-by: Yu Peng <pengyu@kylinos.cn>
 kernel/trace/trace_branch.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index d1564db95a8f5..d8e97ad798f07 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -181,8 +181,7 @@ __init static int init_branch_tracer(void)
 
 	ret = register_trace_event(&trace_branch_event);
 	if (!ret) {
-		printk(KERN_WARNING "Warning: could not register "
-				    "branch events\n");
+		pr_warn("Warning: could not register branch events\n");
 		return 1;
 	}
 	return register_tracer(&branch_trace);
@@ -374,8 +373,7 @@ __init static int init_annotated_branch_stats(void)
 
 	ret = register_stat_tracer(&annotated_branch_stats);
 	if (ret) {
-		printk(KERN_WARNING "Warning: could not register "
-				    "annotated branches stats\n");
+		pr_warn("Warning: could not register annotated branches stats\n");
 		return ret;
 	}
 	return 0;
@@ -439,8 +437,7 @@ __init static int all_annotated_branch_stats(void)
 
 	ret = register_stat_tracer(&all_branch_stats);
 	if (ret) {
-		printk(KERN_WARNING "Warning: could not register "
-				    "all branches stats\n");
+		pr_warn("Warning: could not register all branches stats\n");
 		return ret;
 	}
 	return 0;
-- 
2.43.0
