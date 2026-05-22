Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6874547CC85;
	Fri, 22 May 2026 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469831; cv=none; b=CeTGQjDNzj52uczFg/oFC1R4fN0isTMj2Taz7bLriARmLTie/She0GT5+eGdeAiiGs7RtL3Rd8YFYOMtibRSBS3vLjgX1aJeebHmBEhF+a/gXemTMngT5eoJeR/+inp/ed4ZkjrFq3ZoXf2lwsqAVPifmeK5wFh6W3XJkFXh1NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469831; c=relaxed/simple;
	bh=4hDtoKIZAtY272PDaYKJYtyzT/JMsiV8sbECswEFrJs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Sf9HfaWnc3sKgMl5GjJp5/SFbYxG0dv1Imxsi6OQtCRW3mAcq3RUjVSWyddTBWwaeKTvmpbLDe4RpMHkJt2A6AGzCQlHAaCGZagc8FpfDTAnLD6NfGRYkQ8HSKgqFxI7uGWSxnlRvX2OlmPSIVgRapeEdrrck4Pghynss3MHZPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAWS6qIj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAWS6qIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8F71F00ADF;
	Fri, 22 May 2026 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469828;
	bh=h0X8WxcyLLSRlhqx7GQ6lKAxgGcIFThxnWQfh7WPsIg=;
	h=Date:From:To:Cc:Subject:References;
	b=BAWS6qIj48+hxkKZj8Blsl+TzlACD1wSEum/nUZSaqVs7SQFnGVmkyZMLB4S57LnJ
	 Kuxb3/Q2yOGYeQG2AKLLz5jgl+Pd0j/EkvIr3mGVr89pQAw8CKIJSkItb+9Kf8gaKP
	 Y9x8N9y+XYLDLjxDkYYN1UrxT1ZPqO/mwH5Rw98v4sy4zC4SbTIvBv7JrbYDd7wyNV
	 FjtWmdKUUGczocyMuu37nB3DG6LKALZva/9b0cSO/zOaRYLlS1YotPWwzkzFT9JpvZ
	 6sSu6ZZuCy5CPQQ3dmR2fWkh69sPGaqLNYVQjgeRj7CcGD6LIVMmLBOAiX4qqUpDGC
	 bnCp6oLQFADZA==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wQTOd-00000006BXN-49Am;
	Fri, 22 May 2026 13:10:51 -0400
Message-ID: <20260522171051.860780286@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 22 May 2026 13:09:04 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ian Rogers <irogers@google.com>
Subject: [PATCH v21 7/9] ring-buffer: Have dropped subbuffers be persistent across reboots
References: <20260522170857.263969486@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When the persistent ring buffer detects a corrupted subbuffer, it will
zero its size and report dropped pages in the dmesg, then it continues
normally.

But if a reboot happens without clearing or restarting tracing on the
persistent ring buffer, the next boot will show no pages are dropped.

If the persistent ring buffer is still the same, then it should still
report dropped pages so the user knows that the buffer has missing events.

Add the RB_MISSED_EVENTS flag to the commit value of the subbuffer so that
the next boot will still show that pages were dropped.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fd4a8dc5484e..db72969aefa9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1915,7 +1915,7 @@ static int __rb_validate_buffer(struct buffer_page *bpage, int cpu,
 	 * Even after clearing these bits, a commit value greater than the
 	 * subbuf_size is considered invalid.
 	 */
-	tail = rb_data_page_size(dpage);
+	tail = rb_data_page_commit(dpage);
 	if (tail <= meta->subbuf_size - BUF_PAGE_HDR_SIZE)
 		ret = rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
 	else
@@ -1929,7 +1929,7 @@ static int __rb_validate_buffer(struct buffer_page *bpage, int cpu,
 	 */
 	if (ret < 0 || (prev_ts && prev_ts > ts) || (next_ts && ts > next_ts)) {
 		local_set(&bpage->entries, 0);
-		local_set(&dpage->commit, 0);
+		local_set(&dpage->commit, RB_MISSED_EVENTS);
 		dpage->time_stamp = prev_ts ? prev_ts : next_ts;
 		ret = -1;
 	} else {
@@ -3451,7 +3451,7 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	 * is a mb(), which will synchronize with the rmb here.
 	 * (see rb_tail_page_update() and __rb_reserve_next())
 	 */
-	commit = rb_page_commit(iter_head_page);
+	commit = rb_page_size(iter_head_page);
 	smp_rmb();
 
 	/* An event needs to be at least 8 bytes in size */
@@ -3480,7 +3480,7 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 
 	/* Make sure the page didn't change since we read this */
 	if (iter->page_stamp != iter_head_page->page->time_stamp ||
-	    commit > rb_page_commit(iter_head_page))
+	    commit > rb_page_size(iter_head_page))
 		goto reset;
 
 	iter->next_event = iter->head + length;
@@ -5651,7 +5651,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 	 * (see rb_tail_page_update())
 	 */
 	smp_rmb();
-	commit = rb_page_commit(commit_page);
+	commit = rb_page_size(commit_page);
 	/* We want to make sure that the commit page doesn't change */
 	smp_rmb();
 
@@ -5844,6 +5844,7 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 */
 	local_set(&cpu_buffer->reader_page->write, 0);
 	local_set(&cpu_buffer->reader_page->entries, 0);
+	rb_init_data_page(cpu_buffer->reader_page->page);
 	cpu_buffer->reader_page->real_end = 0;
 
  spin:
-- 
2.53.0


