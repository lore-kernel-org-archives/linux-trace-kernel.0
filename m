Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F7035E1B8;
	Tue, 26 May 2026 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789055; cv=none; b=UP0sBkzrX95PBrKXlAbHIvflk2lFg75yszPxDJwOeALZ2iMsf2HRdc3FGx2tjKkeGuz8k1bE5+c4OkJYqAb0fDXA/zs2A7z6rHgKQjF3zD08OcKP9tTmwQUaPYDH762YT5mVYSF55Dh/sJ5LlR/4rsRNvJNqR0U9cd54034sb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789055; c=relaxed/simple;
	bh=dqZqgjSsA80rYKgLC+AtVkFF0wZ5PccNtrK2z1q+DD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=St1f3P5yXqtgGe75F7Lq1ascpldtgd5wsIWtKyTvP4H4r6Irpmn8ktrTwDOPMoLhfvzqmkY6wTbrX3yQIFGZnOqls5n3HJfW9WOWwtlYYzIqSQvjPSB7HiUQAwH9mYb9PIT7fz7cJFnPBS+ONkPxsf4wmMnGWIpa+gjO93TcKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5ee258fa58e811f1aa26b74ffac11d73-20260526
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0424d552-2270-495e-b24b-6870bfc14a81,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:e18074368e9e7c6d6d54ab58eb1677f7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5ee258fa58e811f1aa26b74ffac11d73-20260526
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1056839007; Tue, 26 May 2026 17:50:47 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH] tracing: Fix field_var_str allocation errno
Date: Tue, 26 May 2026 17:50:22 +0800
Message-Id: <20260526095022.1330107-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hist_trigger_elt_data_alloc() returns -EINVAL when the field_var_str
kcalloc() fails. Return -ENOMEM instead, matching the other allocation
failures in the function.

Fixes: c910db943d35 ("tracing: Dynamically allocate the per-elt hist_elt_data array")
Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index eb2c2bc8bc3d..17fe13e12a4f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1680,7 +1680,7 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 	elt_data->field_var_str = kcalloc(n_str, sizeof(char *), GFP_KERNEL);
 	if (!elt_data->field_var_str) {
 		hist_elt_data_free(elt_data);
-		return -EINVAL;
+		return -ENOMEM;
 	}
 	elt_data->n_field_var_str = n_str;
 
-- 
2.43.0
