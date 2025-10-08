Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5D217A30A;
	Wed,  8 Oct 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938407; cv=none; b=tOzO6+IIOxMetEmmwcKjqYxQo1bTPZJurQRnMHkp1JieMB+8bXiDQNG+Qhw/f+UNC3WShsPaL3n8SX5qdqv0owQfnexXMomUCDcMR3pxJyTeAEazfaRE8E2m+KKFw17bliUy3TM33Me+MAn+bvXk3N5k8/7fMKjlLs2TuW1GJ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938407; c=relaxed/simple;
	bh=cG8Z++9MqU1jVbQULLbPfduIpRfSzHW5inD0MFvIdF4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tGHeunO6yhNMMd7D4NHPWHev5xPrR/GUg9BFcrP+cInHK5u4q4aZ/pmrOzaVY14O9+FKbtI6b+XP3jdbC97gyAXhiu1Ka3AkFo5Z/5RHe2WQ9UA+oVHkqUJfuFpEFXn7RZ3r0H9racidylnixnKqFACElSvLWvA5RyAdr4p3Npw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 89EAC1A05C1;
	Wed,  8 Oct 2025 15:46:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id CDB9C20023;
	Wed,  8 Oct 2025 15:46:41 +0000 (UTC)
Date: Wed, 8 Oct 2025 11:48:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH] tracing: Fix wakeup tracers on failure of acquiring
 calltime
Message-ID: <20251008114835.027b878a@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: extpgh3ckzhr84gx9ge4fy8t8qi84tqw
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: CDB9C20023
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19G85XyZdYvgWhN3xopgT5MBr2bUI8qRos=
X-HE-Tag: 1759938401-958537
X-HE-Meta: U2FsdGVkX18Iowstsr98tm9Jg+aLRlctIFuDPdiWzToSJQJMkatc8cR5F+Yq712JN1RIHTrKTrk8eBqC7hS6ZKXyTe6ypjnrevjHJ4sS8AkNNWvfjMABB7yYiXZlZxqiFS6z5YRqdqp1TrsxQz0oRzydzyeWbyPTzJWWBXe6prW0uquwMdCDqPdS6/WC8EkmWlUXYv9d24w+3hBstptEAT9qG/tAxSS9GmhUyvQ0mrbG7aaRaKzGGYv+Ha6R8gSZTdm7ZFKmrTBSgj7aQA3rY8E4Sb++D4SIxF20TxHXw0MGm8T+TN96WGSFiY/5QbHxZKeW4hKyLzE9MsgbpmvIkKg6gw/wZCa8cbbOFu2njKT3MPDalR8uwPtxpn9yDDvR2DzKfrL+tERhIZuAOaluug==

From: Steven Rostedt <rostedt@goodmis.org>

The functions wakeup_graph_entry() and wakeup_graph_return() both call
func_prolog_preempt_disable() that will test if the data->disable is
already set and if not, increment it and disable preemption. If it was
set, it returns false and the caller exits.

The caller of this function must decrement the disable counter, but misses
doing so if the calltime fails to be acquired.

Instead of exiting out when calltime is NULL, change the logic to do the
work if it is not NULL and still do the clean up at the end of the
function if it is NULL.

Cc: stable@vger.kernel.org
Fixes: a485ea9e3ef3 ("tracing: Fix irqsoff and wakeup latency tracers when using function graph")
Reported-by: Sasha Levin <sashal@kernel.org>
Closes: https://lore.kernel.org/linux-trace-kernel/20251006175848.1906912-1-sashal@kernel.org/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_sched_wakeup.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index bf1cb80742ae..e3f2e4f56faa 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -138,12 +138,10 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
 		return 0;
 
 	calltime = fgraph_reserve_data(gops->idx, sizeof(*calltime));
-	if (!calltime)
-		return 0;
-
-	*calltime = trace_clock_local();
-
-	ret = __trace_graph_entry(tr, trace, trace_ctx);
+	if (calltime) {
+		*calltime = trace_clock_local();
+		ret = __trace_graph_entry(tr, trace, trace_ctx);
+	}
 	local_dec(&data->disabled);
 	preempt_enable_notrace();
 
@@ -169,12 +167,10 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace,
 	rettime = trace_clock_local();
 
 	calltime = fgraph_retrieve_data(gops->idx, &size);
-	if (!calltime)
-		return;
+	if (calltime)
+		__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
 
-	__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
 	local_dec(&data->disabled);
-
 	preempt_enable_notrace();
 	return;
 }
-- 
2.51.0

