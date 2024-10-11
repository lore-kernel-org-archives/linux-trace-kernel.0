Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404ED16F27E;
	Fri, 11 Oct 2024 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660522; cv=none; b=sQq+r8BUh6f83NAIuVI11+cmo3XpLC2q4tkBhWn2K+6UCE66pVvoD5JCLArmuPA9D4V5CoR4JFit0PNd9mzql0AVXjiOFBIheVUxiiSPxYWvsGx1A2hX2xD6FGUKHSkaOt1P9GzEm0YLwI5qItav7emBbUj+yyVwWaKRieWXRLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660522; c=relaxed/simple;
	bh=qPzl/EHoC5JnTiITbzwlGp/NFQGcfPSkb0S5T3wqoy8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aOEz9eWz1H2CL+ftwyKcvkVjUeIFtcfJqmUH3aL3CKg4ZQtzCDpPvzC4bdvhyMCKK5Saxv0BWNOWzmZ18DZUIfPhgpwgdx1C7+Pa0wDc4NC6xYKNzczN9sLUeQe/f1i2ZLuWD/8A1fl18KcdOLAnC1S0HJCHaWIhnf4dtja6kwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE11C4CEC3;
	Fri, 11 Oct 2024 15:28:41 +0000 (UTC)
Date: Fri, 11 Oct 2024 11:28:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] ring-buffer: Synchronize ring_buffer_subbuf_order_set()
 with rb_check_pages()
Message-ID: <20241011112850.17212b25@gandalf.local.home>
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

The rb_check_pages() scans the ring buffer sub buffers to make sure they
are valid after an update. But locks are released during the update to not
hold preemption for too long.

The ring_buffer_subbuf_order_set() updates the counter used by
rb_check_pages() without any locks. But it also updates the pages. Even
though it is likely that the buffer->mutex is enough to protect this, but
since rb_check_pages() uses the cpu_buffer->reader_lock for
synchronization, take that lock as well when updating the pages and
counter in ring_buffer_subbuf_order_set().

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Note, this is based on top of:

  https://lore.kernel.org/linux-trace-kernel/20240715145141.5528-1-petr.pavlu@suse.com/

 kernel/trace/ring_buffer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 696d422d5b35..0672df07b599 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6774,6 +6774,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	}
 
 	for_each_buffer_cpu(buffer, cpu) {
+		unsigned long flags;
 
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			continue;
@@ -6800,11 +6801,15 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 						     struct buffer_page, list);
 		list_del_init(&cpu_buffer->reader_page->list);
 
+		/* Synchronize with rb_check_pages() */
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
 		/* The cpu_buffer pages are a link list with no head */
 		cpu_buffer->pages = cpu_buffer->new_pages.next;
 		cpu_buffer->new_pages.next->prev = cpu_buffer->new_pages.prev;
 		cpu_buffer->new_pages.prev->next = cpu_buffer->new_pages.next;
 		cpu_buffer->cnt++;
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 		/* Clear the new_pages list */
 		INIT_LIST_HEAD(&cpu_buffer->new_pages);
-- 
2.45.2

