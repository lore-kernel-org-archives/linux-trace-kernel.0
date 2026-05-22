Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4E47D936;
	Fri, 22 May 2026 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469832; cv=none; b=ohWM1++SCS1WhNKvM7DNj0xm3VYdZoQa5I111zWy++xruhGjvMFSY2us4CYqOvPmVyKLOtyH2NuwujQe77+tNiFPHQ9aOyhQCBkqny2WmD2VJu/7MWbyWr70Y6VtjE2ocNHVAGQ5ximYsJMEXSp+0g3+6GM9wCyOcOkNLD6VHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469832; c=relaxed/simple;
	bh=1SaGWb6a85ghO7iNg11ZJ4mvZFi15K6dnkGSvo98Ems=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fbihw2cU0q68Vz4XfuTB3Z6C9BkiH///EGOVCarnE+Z1gbsoiRAIZRRrOAaxT3FpCn6c/UGr8YKDYGeatuYZPiwOySqZ6BjIl5k22AzJj/AzCC8TCCog/ZfQc+efBAOdLhaFLtLtpEGDsLSB5jhVDNHdzfKlshL1c7a7tOJVFmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITbWXv/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITbWXv/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CDD1F01560;
	Fri, 22 May 2026 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469828;
	bh=/0Ie7Gn6wjLKfdrHeDIoRVVLzIjB+0dSQgebo77fgEI=;
	h=Date:From:To:Cc:Subject:References;
	b=ITbWXv/8GpsHI3lcNIpnISjZWC/XGY1xKuvAmTCk1+5KFYocN4P/s554BcQg7DJuO
	 N2TDPOEE2cG/f1UTKwXMrg1yZY0V/9tN1S4n8D6RTXV3g2sByrQJV8hzSk8D9VwEaG
	 4b+bPI386S+2cySPAUXflGav5r9l4NX89gPC9IBnvjEFCwprxHl5NATvU8DlrXIoW1
	 +vhmTAY6YqFOGsOqA14jWacnYevR4Aw6PHtEOik94Dtzid5ZUN3UGU6cP6XevLk12H
	 SEHDPhMgH/gusctrUc97+L57n7ByUGxmPdr3F+DEupNGhZloYZy22V2JZ3DqOESxcA
	 /KmghOsHfg2Yg==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wQTOe-00000006BYN-1C5X;
	Fri, 22 May 2026 13:10:52 -0400
Message-ID: <20260522171052.156419479@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 22 May 2026 13:09:06 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ian Rogers <irogers@google.com>
Subject: [PATCH v21 9/9] ring-buffer: Show persistent buffer dropped events in trace_pipe file
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
Changes since v20: https://patch.msgid.link/20260520185018.470465795@kernel.org

- Removed left over printk() (Masami Hiramatsu)

 kernel/trace/ring_buffer.c | 56 +++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 988915f035c7..910f6b3adf74 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5801,6 +5801,7 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	struct buffer_page *reader = NULL;
 	unsigned long overwrite;
 	unsigned long flags;
+	int missed_events = 0;
 	int nr_loops = 0;
 	bool ret;
 
@@ -5901,6 +5902,9 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	if (!ret)
 		goto spin;
 
+	if (rb_page_commit(reader) & RB_MISSED_EVENTS)
+		missed_events = -1;
+
 	if (cpu_buffer->ring_meta)
 		rb_update_meta_reader(cpu_buffer, reader);
 
@@ -5965,6 +5969,8 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 */
 	smp_rmb();
 
+	if (!cpu_buffer->lost_events)
+		cpu_buffer->lost_events = missed_events;
 
 	return reader;
 }
@@ -7066,6 +7072,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	struct buffer_page *reader;
 	long missed_events;
 	unsigned int commit;
+	unsigned int size;
 	unsigned int read;
 	u64 save_timestamp;
 	bool force_memcpy;
@@ -7101,7 +7108,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	event = rb_reader_event(cpu_buffer);
 
 	read = reader->read;
-	commit = rb_page_size(reader);
+	commit = rb_page_commit(reader);
+	size = rb_page_size(reader);
 
 	/* Check if any events were dropped */
 	missed_events = cpu_buffer->lost_events;
@@ -7115,13 +7123,14 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
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
@@ -7130,19 +7139,22 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
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
 
+		if (commit & RB_MISSED_EVENTS)
+			flags = RB_MISSED_EVENTS;
+
 		/* save the current timestamp, since the user will need it */
 		save_timestamp = cpu_buffer->read_stamp;
 
@@ -7154,25 +7166,25 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
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
@@ -7204,7 +7216,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 
 	cpu_buffer->lost_events = 0;
 
-	commit = rb_data_page_commit(dpage);
+	size = rb_data_page_size(dpage);
 	/*
 	 * Set a flag in the commit field if we lost events
 	 */
@@ -7214,11 +7226,11 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
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
@@ -7226,8 +7238,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
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


