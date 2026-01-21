Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F349219E;
	Wed, 21 Jan 2026 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006335; cv=none; b=YRcBnZBr4UuDMzQKhf2MpHr28WCkFs1krkzMIIVqPlSdI/BDtznz3b68IqZ6hdUj7eSV0HMNW7kBg/OJTSo+uxWY0oUzNQfjxHn0Ut00Av0J0+aArIRIaRxC9r6xUWmpL4XHpdZSdENUrd7uX2kCMHcFooM19axO6mrcMNsn+nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006335; c=relaxed/simple;
	bh=ShtMKOY4KOQDoekNG10NvMp5cmAqFVG21CIFFlLQWiY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=moeneJ8tAXgk+ArlTSmsfaEBhMehQykpYwuR8Olls2CKn9UXU/4rqJuHuu1CZ07oFR9WojYWyWYfPvKsGjxFuVN3tQ5YCQaBf5MqG2DKuAe5ZqNfsgnjsTVqVWGBS0SQsxXfl2MAPEjSSFzNFkhGmbkwTJV0Ms7gJ3yEfJp2mPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id D906BD29A1;
	Wed, 21 Jan 2026 14:38:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 372B22000D;
	Wed, 21 Jan 2026 14:38:40 +0000 (UTC)
Date: Wed, 21 Jan 2026 09:38:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] tracing: Disable trace_printk buffer on warning too
Message-ID: <20260121093858.5c5d7e7b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 372B22000D
X-Stat-Signature: 9ijb3qgm89bjhi4drunxuod9kt3ke5wk
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1821Op9BYIGIJnWcdebjvR9A2/CCrtZgLo=
X-HE-Tag: 1769006320-491014
X-HE-Meta: U2FsdGVkX19RkS2raoq6VjImjelmcBWh9dEhsnchbaz5Czuh6VJiB187+AaO4g6934BETjdaba18PTzePprC22Wds5AP+3AIvrndK3BHQE2chaBCkNBBKbuHXR48IsRZFdvAmZ5Bf+ijuoJHUL/JrRJ7J+Er+ivCTHZz7XNiC798gxqR5KXUQWhXCoZQcifa1Vi8p30DDi/gj278DQ9X2eJsAWDM6Med0jUF0tBHQwr0uKdQvQAjAnQBUZBko9dQEv3tnUy8BNS1XH83mTuUqcstEneWb3HN7dVG/7fhCMXT81s96q0lFjC4Ds0GhUVhxEjpmLw1YxAJkPP6DX9LyGHbyOgbX0tq0DeuG5kpgTTXae5nx8aAUdNXba94yWmD

From: Steven Rostedt <rostedt@goodmis.org>

When /proc/sys/kernel/traceoff_on_warning is set to 1, the top level
tracing buffer is disabled when a warning happens. This is very useful
when debugging and want the tracing buffer to stop taking new data when a
warning triggers keeping the events that lead up to the warning from being
overwritten.

Now that there is also a persistent ring buffer and an option to have
trace_printk go to that buffer, the same holds true for that buffer. A
warning could happen just before a crash but still write enough events to
lose the events that lead up to the first warning that was the reason for
the crash.

When /proc/sys/kernel/traceoff_on_warning is set to 1 and a warning is
triggered, not only disable the top level tracing buffer, but also disable
the buffer that trace_printk()s are written to.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index baec63134ab6..1be88395421c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1666,9 +1666,18 @@ EXPORT_SYMBOL_GPL(tracing_off);
 void disable_trace_on_warning(void)
 {
 	if (__disable_trace_on_warning) {
+		struct trace_array *tr = READ_ONCE(printk_trace);
+
 		trace_array_printk_buf(global_trace.array_buffer.buffer, _THIS_IP_,
 			"Disabling tracing due to warning\n");
 		tracing_off();
+
+		/* Disable trace_printk() buffer too */
+		if (tr != &global_trace) {
+			trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_,
+					       "Disabling tracing due to warning\n");
+			tracer_tracing_off(tr);
+		}
 	}
 }
 
-- 
2.51.0

