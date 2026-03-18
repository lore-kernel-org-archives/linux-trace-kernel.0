Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416CE241CB7;
	Wed, 18 Mar 2026 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773874493; cv=none; b=PL7bjFoeWsOEdl4v+U4btkAbnsDRavWAcdi39t4ZCQvIlo8AbfWyRYqzHxV+5EqB967mIqPXzhg8mYeNiN1GLYTVOg3cv4eIgNpRtDrN69WyPSD1nmn8NacbB5S1yXJALM7X+6bg3wLkKDb3XE7CNcQJ8rnvbyDuOt353i1bBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773874493; c=relaxed/simple;
	bh=qtUykCdaYiKQ3x6/bhVS4hawksePbWWSKam/S2vR708=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kGFydvnSGOcVnGmZf7Bth8C+Vf+XWu2YHI3gn3Vw/2u6JTg6kqydGA7NWY/JWqiJm5FvB6vmusvvqRk0LhVg3xHavvF2pfAdYf4+KEfuOsvoJ7Ry55vJucU9YwI0TL1viFpk+QA8bVjqVDSrdLrAqx4bXOXZKjlyUU5jZpu8i+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 1056F5685F;
	Wed, 18 Mar 2026 22:54:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 7578920028;
	Wed, 18 Mar 2026 22:54:43 +0000 (UTC)
Date: Wed, 18 Mar 2026 18:55:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH] tracing: Fix trace_marker copy link list updates
Message-ID: <20260318185512.1b6c7db4@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 7578920028
X-Stat-Signature: 4f6pa7ydd49ygf6zd9d5omxrooxzs61j
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Rqj1dYoUKfaBQGwHgBzcn9qftkQgfJwA=
X-HE-Tag: 1773874483-703529
X-HE-Meta: U2FsdGVkX198RuA+S38daQ6wiMi7JL1nw9A+Cgz6m7MUmyFcjACxvV5dviSiqjI96pxI1kcaAnqDtQSWSI6q97/w7DmikfubMMWn2IdNRt0fch3llGBQHhTlKm18OfVPyf4BFel+sHkSZAcblufiuyJWoZ5V6Pai23PjkUdj+j8K5QeQ4qqDecPOP/1UpwJLWO64oqX85NgV5VIWJXcgGaG8jnsdE8FQR6PXO/3rgtnB3MzreRgTfN+HtjGkekmUXPLptOc6kal7NJOzNsFlgZqGVa6IIdDWgbfaVUrZ4s9PqaWk1QqKWn6vuAmBV938d8U6DZUFW8r+qaXuWRsNcnBTynPb1Lt1tkXQNs1N/gtOKAC0xosG29GsEpKs1vj08fj7ZwG4h7n74g6zMXdXlQ==

From: Steven Rostedt <rostedt@goodmis.org>

When the "copy_trace_marker" option is enabled for an instance, anything
written into /sys/kernel/tracing/trace_marker is also copied into that
instances buffer. When the option is set, that instance's trace_array
descriptor is added to the marker_copies link list. This list is protected
by RCU, as all iterations uses an RCU protected list traversal.

When the instance is deleted, all the flags that were enabled are cleared.
This also clears the copy_trace_marker flag and removes the trace_array
descriptor from the list.

The issue is after the flags are called, a direct call to
update_marker_trace() is performed to clear the flag. This function
returns true if the state of the flag changed and false otherwise. If it
returns true here, synchronize_rcu() is called to make sure all readers
see that its removed from the list.

But since the flag was already cleared, the state does not change and the
synchronization is never called, leaving a possible UAF bug.

Move the clearing of all flags below the updating of the copy_trace_marker
option which then makes sure the synchronization is performed.

Also use the flag for checking the state in update_marker_trace() instead
of looking at if the list is empty.

Cc: stable@vger.kernel.org
Fixes: 7b382efd5e8a ("tracing: Allow the top level trace_marker to write into another instances")
Reported-by: Sasha Levin <sashal@kernel.org>
Closes: https://lore.kernel.org/all/20260225133122.237275-1-sashal@kernel.org/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bb4a62f4b953..a626211ceb9a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -555,7 +555,7 @@ static bool update_marker_trace(struct trace_array *tr, int enabled)
 	lockdep_assert_held(&event_mutex);
 
 	if (enabled) {
-		if (!list_empty(&tr->marker_list))
+		if (tr->trace_flags & TRACE_ITER(COPY_MARKER))
 			return false;
 
 		list_add_rcu(&tr->marker_list, &marker_copies);
@@ -563,10 +563,10 @@ static bool update_marker_trace(struct trace_array *tr, int enabled)
 		return true;
 	}
 
-	if (list_empty(&tr->marker_list))
+	if (!(tr->trace_flags & TRACE_ITER(COPY_MARKER)))
 		return false;
 
-	list_del_init(&tr->marker_list);
+	list_del_rcu(&tr->marker_list);
 	tr->trace_flags &= ~TRACE_ITER(COPY_MARKER);
 	return true;
 }
@@ -9761,18 +9761,19 @@ static int __remove_instance(struct trace_array *tr)
 
 	list_del(&tr->list);
 
-	/* Disable all the flags that were enabled coming in */
-	for (i = 0; i < TRACE_FLAGS_MAX_SIZE; i++) {
-		if ((1ULL << i) & ZEROED_TRACE_FLAGS)
-			set_tracer_flag(tr, 1ULL << i, 0);
-	}
-
 	if (printk_trace == tr)
 		update_printk_trace(&global_trace);
 
+	/* Must be done before disabling all the flags */
 	if (update_marker_trace(tr, 0))
 		synchronize_rcu();
 
+	/* Disable all the flags that were enabled coming in */
+	for (i = 0; i < TRACE_FLAGS_MAX_SIZE; i++) {
+		if ((1ULL << i) & ZEROED_TRACE_FLAGS)
+			set_tracer_flag(tr, 1ULL << i, 0);
+	}
+
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);
-- 
2.51.0

