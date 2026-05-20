Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1BE408029;
	Wed, 20 May 2026 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303010; cv=none; b=asSWNLcvno7ND8ZXA0aQIDXB20Z4VqpUHp+1tuMoctq0o1TIlzUj1yVg08PbZtnVzpZ+zOLibKoXA68YT5sXg2qZ2MBheQU7I4ns2hSGu7cDovdd5vJbTmQ7PkmJscxQiZjRr7FTSktw/qDlZ4X6vB5GVlf7JjiQE3ki8Pe5mMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303010; c=relaxed/simple;
	bh=4LM7UGpkPPAdz6wFC2u10s6cEMpiVQpG/yXlU12QIHI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=culWmPvp/TxC6/gkI8vkqqU7GjScwKlrTfl4ULCve6Z3+YpZZujBYMXMGGvLv8dHO7Ea4ylzzUMiNLrp5dIXr4iyOXUpuIhbvskNNV1tBBM4F2bucfqroAUT2Qn/iZc91IM7RwB5hk5Zu0dtseCJSzeDJ/4x7iUiTCRBFR8r55k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6tz7FKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6tz7FKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73531F0089D;
	Wed, 20 May 2026 18:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302998;
	bh=m8JZiNzYpcke5wsPufmn0LZJyXNKSLN47iJA5IjJPlI=;
	h=Date:From:To:Cc:Subject:References;
	b=b6tz7FKfpQ6eIeRfi2LmNsw3fbufCTqu9CYOaxONdYd8oieH63AN3rqY8rOS7h+H2
	 lsZQo7WeftJp1tKUEESdpiIZoG7Og67Dj8d8U8aXiDVDm3F3fIgn4zKszD/jReSAqc
	 evCXWn8ssbfMnmtCuddV68d4x7BKdSd6FDbkx8qb8ni4Ziwa0fPlhqM1BWVAggYY5w
	 yJzQBKSIik4ceCtDyNHbwoDRdwRi9S0crRTyungwtr2zSJVqWth7YvEBE4NMcNmSkK
	 C8/iLAGjsfbu+juzDX+vQ9QQB/oJ+AGoXoqoazXxBDKoY31F8gGolKHB4Xz9rva9UN
	 M+UOiwnrq9jJA==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wPlzm-00000004qUn-1tUc;
	Wed, 20 May 2026 14:50:18 -0400
Message-ID: <20260520185018.332045380@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 20 May 2026 14:49:47 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Ian Rogers <irogers@google.com>
Subject: [PATCH v20 09/10] ring-buffer: Show persistent buffer dropped events in trace file
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
 kernel/trace/ring_buffer.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ae5c645b59c9..9cdbee171cdc 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3518,6 +3518,9 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
 	else
 		rb_inc_page(&iter->head_page);
 
+	if (rb_page_commit(iter->head_page) & RB_MISSED_EVENTS)
+		iter->missed_events = -1;
+
 	iter->page_stamp = iter->read_stamp = iter->head_page->page->time_stamp;
 	iter->head = 0;
 	iter->next_event = 0;
@@ -5579,6 +5582,7 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 	iter->head_page = cpu_buffer->reader_page;
 	iter->head = cpu_buffer->reader_page->read;
 	iter->next_event = iter->head;
+	iter->missed_events = 0;
 
 	iter->cache_reader_page = iter->head_page;
 	iter->cache_read = cpu_buffer->read;
@@ -7053,7 +7057,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	struct ring_buffer_event *event;
 	struct buffer_data_page *dpage;
 	struct buffer_page *reader;
-	unsigned long missed_events;
+	long missed_events;
 	unsigned int commit;
 	unsigned int read;
 	u64 save_timestamp;
@@ -7179,6 +7183,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		local_set(&reader->entries, 0);
 		reader->read = 0;
 		data_page->data = dpage;
+		if (!missed_events && rb_data_page_commit(dpage) & RB_MISSED_EVENTS)
+			missed_events = -1;
 
 		/*
 		 * Use the real_end for the data size,
@@ -7196,10 +7202,12 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
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


