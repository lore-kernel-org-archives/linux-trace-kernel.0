Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F44A280CE7;
	Wed,  7 May 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629685; cv=none; b=fTyMa1/NRBf/ZStIpbWn5/BhGHY9MMH/JZOb9+zwvFsjGLdZNOSArgsyP4rprTNatZfQDEUzAjicyzLyxgiFfbI84DhCHixU4DxmKecJWV9gw1DWlOniLYUAG04SSXcrFn8y5WLzTg2TaP3/2YXgwZCU/hd/dplXE4p1YrlxTdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629685; c=relaxed/simple;
	bh=Zb/lfoSuBbKPbSZ/G/4eL07FT372hBGNiyY++BYN92g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=G0ImFHTTAdLu1m+LmT6DH+3K3XYKkU8Dm4s1CnhNyuFGzkmgnTin5poM/fwwNZpF6FqgqiZv+4xhrNaLxhScfu3GXKKEWkJc1rGoTDWsHYX4jdNywtShc0zXmvyj0e63O6iaXx0bA+8R4H/QlDN5TJ2yrZd4+DEtOnWwFJW5vLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C740C4CEEE;
	Wed,  7 May 2025 14:54:45 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uCgAi-00000001qAT-0Ply;
	Wed, 07 May 2025 10:54:56 -0400
Message-ID: <20250507145455.944453325@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 07 May 2025 10:53:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>,
 Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH 2/3] tracing: Fix error handling in event_trigger_parse()
References: <20250507145305.730136036@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Miaoqian Lin <linmq006@gmail.com>

According to trigger_data_alloc() doc, trigger_data_free() should be
used to free an event_trigger_data object. This fixes a mismatch introduced
when kzalloc was replaced with trigger_data_alloc without updating
the corresponding deallocation calls.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Link: https://lore.kernel.org/20250318112737.4174-1-linmq006@gmail.com
Fixes: e1f187d09e11 ("tracing: Have existing event_command.parse() implementations use helpers")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
[ SDR: Changed event_trigger_alloc/free() to trigger_data_alloc/free() ]
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index dac3344ee345..c316badc608b 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -995,7 +995,7 @@ event_trigger_parse(struct event_command *cmd_ops,
 
 	if (remove) {
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
-		kfree(trigger_data);
+		trigger_data_free(trigger_data);
 		ret = 0;
 		goto out;
 	}
@@ -1022,7 +1022,7 @@ event_trigger_parse(struct event_command *cmd_ops,
 
  out_free:
 	event_trigger_reset_filter(cmd_ops, trigger_data);
-	kfree(trigger_data);
+	trigger_data_free(trigger_data);
 	goto out;
 }
 
-- 
2.47.2


