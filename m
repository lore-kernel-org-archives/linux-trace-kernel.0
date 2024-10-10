Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AC226AC1;
	Thu, 10 Oct 2024 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728604723; cv=none; b=OlrtC+CGuTwzwVN2vxkxpPGOmYDFC2BduNgwzqsQWcfcEF6YskfqWBpceQca10QTnawez8v6tTYYOCSI3RxWdXL7Q+q2Qc11nKBHbGxxvn5dqluCThArfX4gYlBGEXGkuKYP47f+dNAg+VDWYvIS2TJUZmyPFi1Mi6gKVOp6qiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728604723; c=relaxed/simple;
	bh=ZCD3Hg84HzhJgXYNeIt3BZVDla+T/v78Hd9ZSUC4gLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n0ww2T7dtTDguyvkYSmhlIaJWADP+qdvW+VC7i91FI2/r7HPugZe/ETKKO7IBvtoVAZzDIK6AZbQ/owuFzirUOf6sCAv1FnaROsiRFofc4BTLJbgyP+MsMe+HYceq0akSx/lsQktgz/62JoIOMGDYdQosd7iSiFs+twEfqi1VGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD64CC4CEC5;
	Thu, 10 Oct 2024 23:58:41 +0000 (UTC)
Date: Thu, 10 Oct 2024 19:58:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] ring-buffer: Have the buffer update counter be atomic
Message-ID: <20241010195849.2f77cc3f@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

In order to prevent any subtle races with the buffer update counter,
change it to an atomic_t. Also, since atomic_t is 32 bits, move its
location in the ring_buffer_per_cpu structure next to "current_context" as
that too is only 32 bits (making 64 bit alignment).

The counter is only used to detect that the buffer has been updated when
the buffer verifier check is being done. It's not really that important
that it's atomic or not. But since the updates to the counter are never in
the fast path, having it be consistent isn't a bad thing.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Note, this is based on top of:

  https://lore.kernel.org/linux-trace-kernel/20240715145141.5528-1-petr.pavlu@suse.com/

 kernel/trace/ring_buffer.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a6a1c26ea2e3..bbf7f68f9af2 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -481,9 +481,9 @@ struct ring_buffer_per_cpu {
 	struct buffer_data_page		*free_page;
 	unsigned long			nr_pages;
 	unsigned int			current_context;
-	struct list_head		*pages;
 	/* pages generation counter, incremented when the list changes */
-	unsigned long			cnt;
+	atomic_t			cnt;
+	struct list_head		*pages;
 	struct buffer_page		*head_page;	/* read from head */
 	struct buffer_page		*tail_page;	/* write to tail */
 	struct buffer_page		*commit_page;	/* committed pages */
@@ -1532,7 +1532,7 @@ static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 	head = rb_list_head(cpu_buffer->pages);
 	if (!rb_check_links(cpu_buffer, head))
 		goto out_locked;
-	buffer_cnt = cpu_buffer->cnt;
+	buffer_cnt = atomic_read(&cpu_buffer->cnt);
 	tmp = head;
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 		return;
@@ -1540,7 +1540,7 @@ static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 	while (true) {
 		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
-		if (buffer_cnt != cpu_buffer->cnt) {
+		if (buffer_cnt != atomic_read(&cpu_buffer->cnt)) {
 			/* The list was updated, try again. */
 			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 			goto again;
@@ -2585,7 +2585,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 
 	/* make sure pages points to a valid page in the ring buffer */
 	cpu_buffer->pages = next_page;
-	cpu_buffer->cnt++;
+	atomic_inc(&cpu_buffer->cnt);
 
 	/* update head page */
 	if (head_bit)
@@ -2692,7 +2692,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 			 * pointer to point to end of list
 			 */
 			head_page->prev = last_page;
-			cpu_buffer->cnt++;
+			atomic_inc(&cpu_buffer->cnt);
 			success = true;
 			break;
 		}
@@ -5347,7 +5347,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	rb_list_head(reader->list.next)->prev = &cpu_buffer->reader_page->list;
 	rb_inc_page(&cpu_buffer->head_page);
 
-	cpu_buffer->cnt++;
+	atomic_inc(&cpu_buffer->cnt);
 	local_inc(&cpu_buffer->pages_read);
 
 	/* Finally update the reader page to the new head */
@@ -6804,7 +6804,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		cpu_buffer->pages = cpu_buffer->new_pages.next;
 		cpu_buffer->new_pages.next->prev = cpu_buffer->new_pages.prev;
 		cpu_buffer->new_pages.prev->next = cpu_buffer->new_pages.next;
-		cpu_buffer->cnt++;
+		atomic_inc(&cpu_buffer->cnt);
 
 		/* Clear the new_pages list */
 		INIT_LIST_HEAD(&cpu_buffer->new_pages);
-- 
2.45.2

