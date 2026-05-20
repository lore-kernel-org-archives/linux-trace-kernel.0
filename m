Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F4405C4C;
	Wed, 20 May 2026 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303006; cv=none; b=Sd7uApHdyseKLZsRVWTqcn9Clgjrt8oBnMVfFI8YsyL6P2VCV9nkXz3yw3Ux93FpiICt5Ufsp5eyKNe7wFNSm5BBg82amtSQfPcNA4soTJFaN8RtbFaZwaDkwWKEK6kl4qRGGADByVEi2hIFv4EXPzPWrmOjYSg8tSnkRK9qANw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303006; c=relaxed/simple;
	bh=orwZGuCKw0NsE3QkTxl6aFwhdSbPRfB9i4ivuNAhiNk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sz3pOJgeCV8Qj/kI5yw3SkAUiKX/Bown1ujPx70ogVDmrKizsMAqp3hXZrTahUJmeGkmlMXbpkZ1ilxkSxjBvv7HWRf/fPs+8WlPRxcoCe1YdnfdJr5J5TXUlBWRsS7ljMSNVwjWqsE6l4OCa5Nf7U5lTVVL2iM8HwN7AhbLcPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHfe4zHI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHfe4zHI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DCF1F00894;
	Wed, 20 May 2026 18:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779302998;
	bh=aj+Fvwl35GqnHrspv/MiQnGTGssIabZz3jXzeH8ZwbA=;
	h=Date:From:To:Cc:Subject:References;
	b=FHfe4zHIOs+543bn85sA5+iUkZ32595ia2NQQf70mHTCAPok8+5Eb9ShJWgjV43+U
	 S266ltOEshcWLeva3fT8oPTdqC980XaiL0jJUKHwxrbGFX1gnEauL+q2iep3v24rXE
	 qhZ5YRHmzpkAVgW6I6vUkfVJna9FI5UjkjZEAiZ9lIwGA2pj3/QrtxGOsyXhrwNqRt
	 r1WSM00jZbIRFJYTqyIfeec5Xlj+xTZTI/BGXJKi8ltshf7PWOnN69Sjkx0cPnRifJ
	 J1PAx2Bmodsxv5H/bA1qJnMU73th/HzTzNpdhzI2XtkWe5cYVTakrqVrHfve6YMsL7
	 j1JLjAlDhctTQ==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wPlzm-00000004qUI-1Jth;
	Wed, 20 May 2026 14:50:18 -0400
Message-ID: <20260520185018.193087991@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 20 May 2026 14:49:46 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Ian Rogers <irogers@google.com>
Subject: [PATCH v20 08/10] ring-buffer: Have dropped subbuffers be persistent across reboots
References: <20260520184938.749337513@kernel.org>
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

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bda53a2d2159..ae5c645b59c9 100644
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
@@ -3444,7 +3444,7 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	 * is a mb(), which will synchronize with the rmb here.
 	 * (see rb_tail_page_update() and __rb_reserve_next())
 	 */
-	commit = rb_page_commit(iter_head_page);
+	commit = rb_page_size(iter_head_page);
 	smp_rmb();
 
 	/* An event needs to be at least 8 bytes in size */
@@ -3473,7 +3473,7 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 
 	/* Make sure the page didn't change since we read this */
 	if (iter->page_stamp != iter_head_page->page->time_stamp ||
-	    commit > rb_page_commit(iter_head_page))
+	    commit > rb_page_size(iter_head_page))
 		goto reset;
 
 	iter->next_event = iter->head + length;
@@ -5643,7 +5643,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 	 * (see rb_tail_page_update())
 	 */
 	smp_rmb();
-	commit = rb_page_commit(commit_page);
+	commit = rb_page_size(commit_page);
 	/* We want to make sure that the commit page doesn't change */
 	smp_rmb();
 
@@ -5836,6 +5836,7 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 */
 	local_set(&cpu_buffer->reader_page->write, 0);
 	local_set(&cpu_buffer->reader_page->entries, 0);
+	rb_init_data_page(cpu_buffer->reader_page->page);
 	cpu_buffer->reader_page->real_end = 0;
 
  spin:
-- 
2.53.0


