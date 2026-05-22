Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6256247CC81;
	Fri, 22 May 2026 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469831; cv=none; b=uq59ugp6G0NzaB7isYTHCwXxAkbJEeGUDTp3j7R4B/Y7nKF+WxWDrcx4xy/ZrgPBgdPSVs1vP69nyIVUS68Z8go+Cd+8oeeCl3Z3HRIya1sDyVrYBAep0psl+vGpLBYrDMM7NhKVmGZfO2JSHTfDzuTxWGAB9OjDAq1dt/LVKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469831; c=relaxed/simple;
	bh=jnAHd7VnpQBSLiCMLUacaNSUzSc3cnVHjUvtrbBpT14=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=A5KQW1O6BXXQH6YAreOMEsHbNfhz3MvCjCUfPlQrwLxcO92d86gbvOUZpRma2Iu5o0monoIJYbjpK1KjBdN66FzXDDb7bst4FgYCBUFJ1Y85P9Zx/edZncvcwrOMTSJ73o+hA/R15/xnWaXjNeggMT5UitWWNKNDZKQawyOnz98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lt2XdxaC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lt2XdxaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6561F0155F;
	Fri, 22 May 2026 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469828;
	bh=j7ZVqrOZA/VswXjDZOxF1SpO6ZAM5ni/L7wg4dckS4g=;
	h=Date:From:To:Cc:Subject:References;
	b=Lt2XdxaCeSpc+U0GmrD6ddyrokp0Pb+9vHYPRCnuNun6vpDODFKd9SZq7DW9gwub/
	 dFQnoIhGdhFA7FbPSVY6x2RYEIPrht/6DMIOxQBbuKYYjdvoJQWD9+tHY/Dore01pH
	 bm0pamh8USkCrKc/f47NM4uyDervCGJMhi/psuiX2636GuLMImT1tdheke4Gxpa4Fi
	 gne150E+me5k8fXYP4whhChIh2Dv0cQ4Mwu/A1ukpbRjPa+HS+UYlXkPCrnHpZXalx
	 ib4p/JpPzWTopBC4ltgToLwY1kYBa9P62InnBbUoCHfBsfwlxboTNmN8A+oP3LBB37
	 pzkAYDUn0jCsg==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wQTOe-00000006BXs-0aKY;
	Fri, 22 May 2026 13:10:52 -0400
Message-ID: <20260522171052.006276604@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 22 May 2026 13:09:05 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ian Rogers <irogers@google.com>
Subject: [PATCH v21 8/9] ring-buffer: Show persistent buffer dropped events in trace file
References: <20260522170857.263969486@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When the persistent ring buffer is validated on boot up, if a subbuffer is
deemed invalid, it resets the buffer and continues. Currently, these lost
events are not shown in the trace file output.

Have the trace iterator look for subbuffers that have the RB_MISSED_EVENTS
set and set the iter->missed_events flag when it is detected. This will
then have the trace file shows "LOST EVENTS" when it reads across a
subbuffer that was corrupted and invalidated.

For example:

 <...>-1016    [005] ...1.  6230.660403: preempt_disable: caller=__mod_memcg_state+0x1c8/0x200 parent=__mod_memcg_state+0x1c8/0x200
CPU:5 [LOST EVENTS]
 <...>-1016    [005] .....  6230.660673: kmem_cache_alloc: call_site=__anon_vma_prepare+0x1ad/0x1e0 ptr=000000006e40294c name=anon_vma bytes_req=200 bytes_alloc=208 gfp_flags=GFP_KERNEL node=-1 accounted=true

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index db72969aefa9..988915f035c7 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3525,6 +3525,9 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
 	else
 		rb_inc_page(&iter->head_page);
 
+	if (rb_page_commit(iter->head_page) & RB_MISSED_EVENTS)
+		iter->missed_events = -1;
+
 	iter->page_stamp = iter->read_stamp = iter->head_page->page->time_stamp;
 	iter->head = 0;
 	iter->next_event = 0;
@@ -7061,7 +7064,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	struct ring_buffer_event *event;
 	struct buffer_data_page *dpage;
 	struct buffer_page *reader;
-	unsigned long missed_events;
+	long missed_events;
 	unsigned int commit;
 	unsigned int read;
 	u64 save_timestamp;
@@ -7187,6 +7190,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		local_set(&reader->entries, 0);
 		reader->read = 0;
 		data_page->data = dpage;
+		if (!missed_events && rb_data_page_commit(dpage) & RB_MISSED_EVENTS)
+			missed_events = -1;
 
 		/*
 		 * Use the real_end for the data size,
@@ -7204,10 +7209,12 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 * Set a flag in the commit field if we lost events
 	 */
 	if (missed_events) {
-		/* If there is room at the end of the page to save the
+		/*
+		 * If there is room at the end of the page to save the
 		 * missed events, then record it there.
 		 */
-		if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
+		if (missed_events > 0 &&
+		    buffer->subbuf_size - commit >= sizeof(missed_events)) {
 			memcpy(&dpage->data[commit], &missed_events,
 			       sizeof(missed_events));
 			local_add(RB_MISSED_STORED, &dpage->commit);
-- 
2.53.0


