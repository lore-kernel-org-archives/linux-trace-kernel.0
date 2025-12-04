Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4832F25EF;
	Thu,  4 Dec 2025 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764879516; cv=none; b=eiJ9u7IT6M77DUrEQR43C6Ow7d5VvcGLyjeNgE4AGX0KVEb1GSBwLXuRhsyNTSZS/cecKt05AkS7gBuHmhte8cy84/I74faI3m68tX4sCO5WFXOKpnDE1VRfyPVB19x7WVWxuhYoNEqm6teW6cRO8Eu2WqM25wmFJEX326M4a8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764879516; c=relaxed/simple;
	bh=m01a3N7sCKdndNZkP4mWbWF3+s8UneY6qSCLk4jYhSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Z8ORtDfIcLG0YWX2Ge/D8l4JE7Bz1Hx0uowA41hiyBFOJWf0NmDLrAZJ3C/W1AcXq7D/2QDTY/dASxTxMy7zroB7Fbn5xKjnLWs9HW03ecvfznN8Ru1Gg/QN+DB0GDPuNO4jINAyQFEtZQvAFgTprzNZSoBZA7QzMOtt/CD67ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 048FE58860;
	Thu,  4 Dec 2025 20:18:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 5961420028;
	Thu,  4 Dec 2025 20:18:30 +0000 (UTC)
Date: Thu, 4 Dec 2025 15:19:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Douglas Raillard
 <douglas.raillard@arm.com>
Subject: [PATCH] tracing: Fix fixed array of synthetic event
Message-ID: <20251204151935.5fa30355@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5961420028
X-Stat-Signature: fynj8u4sn3a8e9gmzpn3mgfdkdnqp1rg
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19l2wDywQgfXTsUPJgqk5H1DmE6eC/bUo0=
X-HE-Tag: 1764879510-62474
X-HE-Meta: U2FsdGVkX19wD1rlBb5cbQGvgNlTYFBWwiB0UjXW14BxmOE8bMabY5nureb4a8+wC92jMLqYrp7VzK3i7CWTAnkC7K5z2ipVrQrzr5XfY8C3Inm+nwgc1vBJYCZYMCPxh9F0ce0NX0ZuxavWRQM0YbaNIkSH4VqH6LX0gtxPO9hWwIONjy0Ec+2L36BGYzuC2MpFYG5UIODIPO91JOqCj1U0hz6yqeo9V8Miu9c5iWh5Yoitt9rEcrnPWkyrHJWSupEBRRJLUomIOMoYHp6YCveBgZBNcuWVXbRo32zxbuPahRph5zk67z0abi81kiqYF7yqqBE83C/7Sc9BOWn/QLvHAMbEfmWGQq8HGjn/iMOv0PQKO1KPE40QgEY6/0RtS/aT9TTYm1UIH/881bqVFQ==

From: Steven Rostedt <rostedt@goodmis.org>

The commit 4d38328eb442d ("tracing: Fix synth event printk format for str
fields") replaced "%.*s" with "%s" but missed removing the number size of
the dynamic and static strings. The commit e1a453a57bc7 ("tracing: Do not
add length to print format in synthetic events") fixed the dynamic part
but did not fix the static part. That is, with the commands:

  # echo 's:wake_lat char[] wakee; u64 delta;' >> /sys/kernel/tracing/dynamic_events
  # echo 'hist:keys=pid:ts=common_timestamp.usecs if !(common_flags & 0x18)' > /sys/kernel/tracing/events/sched/sched_waking/trigger
  # echo 'hist:keys=next_pid:delta=common_timestamp.usecs-$ts:onmatch(sched.sched_waking).trace(wake_lat,next_comm,$delta)' > /sys/kernel/tracing/events/sched/sched_switch/trigger

That caused the output of:

          <idle>-0       [001] d..5.   193.428167: wake_lat: wakee=(efault)sshd-sessiondelta=155
    sshd-session-879     [001] d..5.   193.811080: wake_lat: wakee=(efault)kworker/u34:5delta=58
          <idle>-0       [002] d..5.   193.811198: wake_lat: wakee=(efault)bashdelta=91

The commit e1a453a57bc7 fixed the part where the synthetic event had
"char[] wakee". But if one were to replace that with a static size string:

  # echo 's:wake_lat char[16] wakee; u64 delta;' >> /sys/kernel/tracing/dynamic_events

Where "wakee" is defined as "char[16]" and not "char[]" making it a static
size, the code triggered the "(efaul)" again.

Remove the added STR_VAR_LEN_MAX size as the string is still going to be
nul terminated.

Cc: stable@vger.kernel.org
Fixes: e1a453a57bc7 ("tracing: Do not add length to print format in synthetic events")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 2f19bbe73d27..4554c458b78c 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -375,7 +375,6 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 				n_u64++;
 			} else {
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
-						 STR_VAR_LEN_MAX,
 						 (char *)&entry->fields[n_u64].as_u64,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
-- 
2.51.0

