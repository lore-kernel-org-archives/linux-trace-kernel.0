Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEC4407CD8;
	Wed, 20 May 2026 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303010; cv=none; b=u7c0t3fDo79uqJ+PpaquO6HDhRTTNWubkVWH2rZJucYWAIf80b4zF6zVa4wtBq/GMtDF9hG5TWBKW+yPqjREU4UWGGBhKXx7UuvwczJdjYrb/dXOauSRTsdRjpA7/k9KXF9Bv2hegLanIg41Tx25LwOzPlWmltAW5JiAsXBLPJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303010; c=relaxed/simple;
	bh=+QjRjOIYSxwOhZM9tWkY+qyaunWJj+bbW8RN3AD9sYY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nThzYIDVxEioaQZotUYyDks6P4o3ENPXHrX1uvSTVTcbGzdSyLTIeKd+saJavr5PxmAOzIjAlz2077sqDqyUaTUbfPI6caYxnUKVx7Mb1JCqaSM9l4T5mMeaiAOb9PF414mSdzlNrwsxCkbadwwvfQnpyI0w3Qboc5P6lXkhlmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUnKIgwb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUnKIgwb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B461F0089F;
	Wed, 20 May 2026 18:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302999;
	bh=jygDceG30LUq+hbqus2XeFHvbPtOFQakWAqYsRXmO/k=;
	h=Date:From:To:Cc:Subject:References;
	b=ZUnKIgwbzwLbDGQp78LIep0m697U9ZzxtGobybxEy9rTKWIadU8MllJy0Mp3Ylke9
	 mRphhWEzgjS0io6XVokeEZHWKoDTqacv+bMiEQl7cHZ/sxhEG2SJMBa5xg7IMEj42v
	 LERXYwOKi/wG+HRCSfy1k74hmiEH2FxBHic5dKrFg6LQQ//oNz+JOns8GVknVqui9U
	 sPZaHYNI4syBr2Ed+6mpaURkPIQDJS55DMBVYBJo1b67KdlzlOSfnsH+RkX9KIqoyZ
	 A5C7fiLsGK6yLriDeeEbp792j22VEzFqzjtw80PM94mAiywbRE+VAgxGq3hUUPrwxU
	 kbNnnq1c6C8mw==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wPlzm-00000004qVJ-2UWl;
	Wed, 20 May 2026 14:50:18 -0400
Message-ID: <20260520185018.470465795@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 20 May 2026 14:49:48 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Ian Rogers <irogers@google.com>
Subject: [PATCH v20 10/10] ring-buffer: Show persistent buffer dropped events in trace_pipe file
References: <20260520184938.749337513@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When the persistent ring buffer is validated on boot up, if a subbuffer is
deemed invalid, it resets the buffer and continues. Have the code preserve
the RB_MISSED_EVENTS flag in the commit portion of the subbuffer header
and pass that back so that the trace_pipe file can show the missed events
like the trace file does.

For example:

   <...>-1242    [005] d....  4429.120116: page_fault_user: address=0x7ffaebb6e728 ip=0x7ffaeb9d4960 error_code=0x7
   <...>-1242    [005] .....  4429.120124: mm_page_alloc: page=00000000055254f3 pfn=0x1373bd order=0 migratetype=1 gfp_flags=GFP_HIGHUSER_MOVABLE|__GFP_COMP
   <...>-1242    [005] d..2.  4429.120132: tlb_flush: pages:1 reason:local MM shootdown (3)
CPU:5 [LOST EVENTS]
   <...>-1242    [005] d....  4429.120661: page_fault_user: address=0x55ba7c2d0944 ip=0x55ba7c20cd02 error_code=0x7
   <...>-1242    [005] .....  4429.120669: mm_page_alloc: page=0000000005a02500 pfn=0x12b6e4 order=0 migratetype=1 gfp_flags=GFP_HIGHUSER_MOVABLE|__GFP_COMP
   <...>-1242    [005] d..2.  4429.120680: tlb_flush: pages:1 reason:local MM shootdown (3)

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 57 +++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9cdbee171cdc..f42d2176b92c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5794,6 +5794,7 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	struct buffer_page *reader = NULL;
 	unsigned long overwrite;
 	unsigned long flags;
+	int missed_events = 0;
 	int nr_loops = 0;
 	bool ret;
 
@@ -5894,6 +5895,9 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	if (!ret)
 		goto spin;
 
+	if (rb_page_commit(reader) & RB_MISSED_EVENTS)
+		missed_events = -1;
+
 	if (cpu_buffer->ring_meta)
 		rb_update_meta_reader(cpu_buffer, reader);
 
@@ -5958,6 +5962,8 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 */
 	smp_rmb();
 
+	if (!cpu_buffer->lost_events)
+		cpu_buffer->lost_events = missed_events;
 
 	return reader;
 }
@@ -7059,6 +7065,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	struct buffer_page *reader;
 	long missed_events;
 	unsigned int commit;
+	unsigned int size;
 	unsigned int read;
 	u64 save_timestamp;
 	bool force_memcpy;
@@ -7094,7 +7101,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	event = rb_reader_event(cpu_buffer);
 
 	read = reader->read;
-	commit = rb_page_size(reader);
+	commit = rb_page_commit(reader);
+	size = rb_page_size(reader);
 
 	/* Check if any events were dropped */
 	missed_events = cpu_buffer->lost_events;
@@ -7108,13 +7116,14 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	 * we must copy the data from the page to the buffer.
 	 * Otherwise, we can simply swap the page with the one passed in.
 	 */
-	if (read || (len < (commit - read)) ||
+	if (read || (len < (size - read)) ||
 	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
 	    force_memcpy) {
 		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
 		unsigned int rpos = read;
 		unsigned int pos = 0;
-		unsigned int size;
+		unsigned int event_size;
+		unsigned int flags = 0;
 
 		/*
 		 * If a full page is expected, this can still be returned
@@ -7123,19 +7132,23 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		 * the reader page.
 		 */
 		if (full &&
-		    (!read || (len < (commit - read)) ||
+		    (!read || (len < (size - read)) ||
 		     cpu_buffer->reader_page == cpu_buffer->commit_page))
 			return -1;
 
-		if (len > (commit - read))
-			len = (commit - read);
+		if (len > (size - read))
+			len = (size - read);
 
 		/* Always keep the time extend and data together */
-		size = rb_event_ts_length(event);
+		event_size = rb_event_ts_length(event);
 
-		if (len < size)
+		if (len < event_size)
 			return -1;
 
+		if (commit & RB_MISSED_EVENTS) {
+			printk("MISSED\n");
+			flags = RB_MISSED_EVENTS; }
+
 		/* save the current timestamp, since the user will need it */
 		save_timestamp = cpu_buffer->read_stamp;
 
@@ -7147,25 +7160,25 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 			 * one or two events.
 			 * We have already ensured there's enough space if this
 			 * is a time extend. */
-			size = rb_event_length(event);
-			memcpy(dpage->data + pos, rpage->data + rpos, size);
+			event_size = rb_event_length(event);
+			memcpy(dpage->data + pos, rpage->data + rpos, event_size);
 
-			len -= size;
+			len -= event_size;
 
 			rb_advance_reader(cpu_buffer);
 			rpos = reader->read;
-			pos += size;
+			pos += event_size;
 
-			if (rpos >= commit)
+			if (rpos >= event_size)
 				break;
 
 			event = rb_reader_event(cpu_buffer);
 			/* Always keep the time extend and data together */
-			size = rb_event_ts_length(event);
-		} while (len >= size);
+			event_size = rb_event_ts_length(event);
+		} while (len >= event_size);
 
 		/* update dpage */
-		local_set(&dpage->commit, pos);
+		local_set(&dpage->commit, pos | flags);
 		dpage->time_stamp = save_timestamp;
 
 		/* we copied everything to the beginning */
@@ -7197,7 +7210,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 
 	cpu_buffer->lost_events = 0;
 
-	commit = rb_data_page_commit(dpage);
+	size = rb_data_page_size(dpage);
 	/*
 	 * Set a flag in the commit field if we lost events
 	 */
@@ -7207,11 +7220,11 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		 * missed events, then record it there.
 		 */
 		if (missed_events > 0 &&
-		    buffer->subbuf_size - commit >= sizeof(missed_events)) {
-			memcpy(&dpage->data[commit], &missed_events,
+		    buffer->subbuf_size - size >= sizeof(missed_events)) {
+			memcpy(&dpage->data[size], &missed_events,
 			       sizeof(missed_events));
 			local_add(RB_MISSED_STORED, &dpage->commit);
-			commit += sizeof(missed_events);
+			size += sizeof(missed_events);
 		}
 		local_add(RB_MISSED_EVENTS, &dpage->commit);
 	}
@@ -7219,8 +7232,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/*
 	 * This page may be off to user land. Zero it out here.
 	 */
-	if (commit < buffer->subbuf_size)
-		memset(&dpage->data[commit], 0, buffer->subbuf_size - commit);
+	if (size < buffer->subbuf_size)
+		memset(&dpage->data[size], 0, buffer->subbuf_size - size);
 
 	return read;
 }
-- 
2.53.0


