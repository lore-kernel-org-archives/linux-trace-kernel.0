Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8182F39C2;
	Wed,  3 Jun 2026 06:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467970; cv=none; b=Igg0dP3Wj1aD2NNykFKyiAAiM51cAL2AbIKWVKdLUVxud6nIxuHmf9Ps+za5gcHkXFMzSakrn8mWVMPBh8rTAVianezRrOO6Bl2CHAL96umn44+R3Xc41tWoKu+cyfSKqFO8ECbdT1F9jRPphXxcaFlfbwdDLCnW+FNNpmxOQBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467970; c=relaxed/simple;
	bh=7O4x1qTT5TYkCtCWdc91u83tqzbXep9F0HDQFpXr21k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FwzzmTr6H0o4cylr8rxZBCh7bQhw08KfAPmazEhwX288tRLQnILJbAFkUMiI3k4uuDcyyr4fSzPfo4MLJnCIFKulPgUU/KIpKyObO6HuHhFr/Ccdzr9GFbKcSjmX1iK5I2V1tOHxuzM0khjPnqZ4Bo6EoTTItYVXLORI953Szqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 173fdce25f1511f1aa26b74ffac11d73-20260603
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:30dc7aad-22cb-4b62-bdb2-7a95ea4ec2d5,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:806ba312e9027b674ad1eb83e8ddf680,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 173fdce25f1511f1aa26b74ffac11d73-20260603
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 745034279; Wed, 03 Jun 2026 14:26:01 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH 2/2] tracing/synthetic: Free type string on error path
Date: Wed,  3 Jun 2026 14:25:33 +0800
Message-Id: <20260603062533.1096320-2-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260603062533.1096320-1-pengyu@kylinos.cn>
References: <20260603062533.1096320-1-pengyu@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_synth_field() builds a "__data_loc ..." type string before
assigning it to field->type. If the seq_buf check fails, the common
cleanup cannot free the temporary string. Free it before leaving.

Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
 kernel/trace/trace_events_synth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index cdd5b93328358..dc15658a887cb 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -839,8 +839,10 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 			seq_buf_puts(&s, "__data_loc ");
 			seq_buf_puts(&s, field->type);
 
-			if (WARN_ON_ONCE(!seq_buf_buffer_left(&s)))
+			if (WARN_ON_ONCE(!seq_buf_buffer_left(&s))) {
+				kfree(type);
 				goto free;
+			}
 			s.buffer[s.len] = '\0';
 
 			kfree(field->type);
-- 
2.43.0

