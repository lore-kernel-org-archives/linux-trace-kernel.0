Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE08E1D90CD
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991711; cv=none; b=V3fCILZtEChalgerrWjxA+TYB8UEXmLYGlsr9iA9mh0gKHRjYnol06Jsp9MVJK6akfdk8RLiUGo0jX7lPNw7TwTZLQ7cWIgOE+5b0K6ic5dYOBksnQoRhqd7DHhSkiTHlpetNvjCRIj8cdgu2L5prVqJeSCyYEPSX+6jA+afVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991711; c=relaxed/simple;
	bh=Ykv+B6Ws+3ZawnRd/HzYoc9HW4KMdz8h/ZZEQiNpapE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QtsFiz6BSUEJFpo2kQQsPQCSrcA90f89XmHVLMJSCtWlUCLyTY24ckB0sTnMvS8X07L0j46OwD8BFchK/FcjxhrmZewSXeiq5UV78/SwtmR6DXnIDyAv957qrX3EHZB2iUt9X99ofWR9c4n9+MG0gaj6CLnU47JDGE8LIVSxHI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MS5M8H8+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MS5M8H8+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43118c9a955so43959025e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Oct 2024 04:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728991707; x=1729596507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=umkvpvpGmqXXb1N/xUA2nnJmAVZqkg7koS/CMIs9ZeU=;
        b=MS5M8H8+agwyOjjHNMvmnD2FYOCHg3c42RBW3NGPshhtTy8Rrapo6GVJGIsW21079x
         MIT0nrOKF1B85DfJu7bqiqIvg3Vv3nGc6EPsfcOIzDqEgT2hPH2qubCdCN5x7v3d6zGH
         mvgYpO7YuoItZAmgpGbTDJZl3daTDyQhdFIudCffN2V6AZJ4BfYl3e8L0nNKZgW2K1ig
         QVGvkyz28PrOduYo1Vb1fysOr1ZzoavvqxZ/sGNwm6WUmkzZadpk3Vomm23T8U7S14++
         SaBEApDTyfNG/M3zI8k9n5APp8LCYyMjNMOTK8VMS3QWziZnuVUUctVQnRdFJynqO4Ll
         vBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728991707; x=1729596507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umkvpvpGmqXXb1N/xUA2nnJmAVZqkg7koS/CMIs9ZeU=;
        b=CDc0Xq5xHWaVv9HYIa1c+rzML6+FrIkFQPjMMoA7UVs4WSifE1OqpNDkXcJ9CcFpoL
         rTrviNcR1wMsi5x857xdKK7bRQqVLt50nzaObPGr6k7ahyW4XQU4fVvG6O7QLQKzTDna
         NAqbRgyLjDhm6XTbOwHZCzMHmXE89lmM6QWUrmkV4qdSkwlg5UK/FkY6DvoLOaBjNo6d
         Z7VTeNqa/SgIIBNV4NzwNSXQora9hu/WiLPgz9zY1D2k4wY9Xy+Rf+OCB3fY1JlWEbZd
         cq26kG1IR/g46shyJPmswj/5XB39jLesVmlbTLmr5yknmuLDzFDF+l4OyFV4JBbRYOoX
         brxQ==
X-Gm-Message-State: AOJu0YwD9hDvkhpJY0zPmnKEy1LmCp66Xsmq0NQ8Kz6V8fgeMTZ4Cu+O
	sudY+p8xJPO2j5sz3ZP/Q1m27hxmbPw9w0AGD2sQygUS3kaxGKW1bS4G4XjhNNY=
X-Google-Smtp-Source: AGHT+IGOWhKq442fRPE2nYPS8ado03xZUPJPQ/X1o7Kck4fytHe19w6PpOdO6ZTutLyv8JiXT/hJbQ==
X-Received: by 2002:a05:600c:1ca6:b0:42c:bd27:4c12 with SMTP id 5b1f17b1804b1-4311ded1fedmr125016875e9.10.1728991706896;
        Tue, 15 Oct 2024 04:28:26 -0700 (PDT)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314a829abbsm100845e9.17.2024.10.15.04.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 04:28:26 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v4] ring-buffer: Limit time with disabled interrupts in rb_check_pages()
Date: Tue, 15 Oct 2024 13:27:46 +0200
Message-ID: <20241015112810.27203-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function rb_check_pages() validates the integrity of a specified
per-CPU tracing ring buffer. It does so by traversing the underlying
linked list and checking its next and prev links.

To guarantee that the list isn't modified during the check, a caller
typically needs to take cpu_buffer->reader_lock. This prevents the check
from running concurrently, for example, with a potential reader which
can make the list temporarily inconsistent when swapping its old reader
page into the buffer.

A problem with this approach is that the time when interrupts are
disabled is non-deterministic, dependent on the ring buffer size. This
particularly affects PREEMPT_RT because the reader_lock is a raw
spinlock which doesn't become sleepable on PREEMPT_RT kernels.

Modify the check so it still attempts to traverse the entire list, but
gives up the reader_lock between checking individual pages. Introduce
for this purpose a new variable ring_buffer_per_cpu.cnt which is bumped
any time the list is modified. The value is used by rb_check_pages() to
detect such a change and restart the check.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---

This is a follow-up to the discussion about improving this check [1].

Changes since v3 [2]:
* Base the patch on top of "[PATCH v2] ring-buffer: Fix reader locking when
  changing the sub buffer order" [3].

Changes since v2 [4]:
* Call the new generation variable as ring_buffer_per_cpu.cnt.

Changes since v1 [5]:
* Correct the case when rb_check_pages() is invoked concurrently with
  the resize code which modifies the list. Introduce
  ring_buffer_per_cpu.pages_era for this purpose.

[1] https://lore.kernel.org/linux-trace-kernel/20240517134008.24529-1-petr.pavlu@suse.com/
[2] https://lore.kernel.org/linux-trace-kernel/20240715145141.5528-1-petr.pavlu@suse.com/
[3] https://lore.kernel.org/linux-trace-kernel/20241015112440.26987-1-petr.pavlu@suse.com/
[4] https://lore.kernel.org/linux-trace-kernel/20240703075314.23511-1-petr.pavlu@suse.com/
[5] https://lore.kernel.org/linux-trace-kernel/20240621150956.24814-1-petr.pavlu@suse.com/

 kernel/trace/ring_buffer.c | 98 ++++++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3ea4f7bb1837..adde95400ab4 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -482,6 +482,8 @@ struct ring_buffer_per_cpu {
 	unsigned long			nr_pages;
 	unsigned int			current_context;
 	struct list_head		*pages;
+	/* pages generation counter, incremented when the list changes */
+	unsigned long			cnt;
 	struct buffer_page		*head_page;	/* read from head */
 	struct buffer_page		*tail_page;	/* write to tail */
 	struct buffer_page		*commit_page;	/* committed pages */
@@ -1475,40 +1477,87 @@ static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
 	RB_WARN_ON(cpu_buffer, val & RB_FLAG_MASK);
 }
 
+static bool rb_check_links(struct ring_buffer_per_cpu *cpu_buffer,
+			   struct list_head *list)
+{
+	if (RB_WARN_ON(cpu_buffer,
+		       rb_list_head(rb_list_head(list->next)->prev) != list))
+		return false;
+
+	if (RB_WARN_ON(cpu_buffer,
+		       rb_list_head(rb_list_head(list->prev)->next) != list))
+		return false;
+
+	return true;
+}
+
 /**
  * rb_check_pages - integrity check of buffer pages
  * @cpu_buffer: CPU buffer with pages to test
  *
  * As a safety measure we check to make sure the data pages have not
  * been corrupted.
- *
- * Callers of this function need to guarantee that the list of pages doesn't get
- * modified during the check. In particular, if it's possible that the function
- * is invoked with concurrent readers which can swap in a new reader page then
- * the caller should take cpu_buffer->reader_lock.
  */
 static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	struct list_head *head = rb_list_head(cpu_buffer->pages);
-	struct list_head *tmp;
+	struct list_head *head, *tmp;
+	unsigned long buffer_cnt;
+	unsigned long flags;
+	int nr_loops = 0;
 
-	if (RB_WARN_ON(cpu_buffer,
-			rb_list_head(rb_list_head(head->next)->prev) != head))
+	/*
+	 * Walk the linked list underpinning the ring buffer and validate all
+	 * its next and prev links.
+	 *
+	 * The check acquires the reader_lock to avoid concurrent processing
+	 * with code that could be modifying the list. However, the lock cannot
+	 * be held for the entire duration of the walk, as this would make the
+	 * time when interrupts are disabled non-deterministic, dependent on the
+	 * ring buffer size. Therefore, the code releases and re-acquires the
+	 * lock after checking each page. The ring_buffer_per_cpu.cnt variable
+	 * is then used to detect if the list was modified while the lock was
+	 * not held, in which case the check needs to be restarted.
+	 *
+	 * The code attempts to perform the check at most three times before
+	 * giving up. This is acceptable because this is only a self-validation
+	 * to detect problems early on. In practice, the list modification
+	 * operations are fairly spaced, and so this check typically succeeds at
+	 * most on the second try.
+	 */
+again:
+	if (++nr_loops > 3)
 		return;
 
-	if (RB_WARN_ON(cpu_buffer,
-			rb_list_head(rb_list_head(head->prev)->next) != head))
-		return;
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	head = rb_list_head(cpu_buffer->pages);
+	if (!rb_check_links(cpu_buffer, head))
+		goto out_locked;
+	buffer_cnt = cpu_buffer->cnt;
+	tmp = head;
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
-	for (tmp = rb_list_head(head->next); tmp != head; tmp = rb_list_head(tmp->next)) {
-		if (RB_WARN_ON(cpu_buffer,
-				rb_list_head(rb_list_head(tmp->next)->prev) != tmp))
-			return;
+	while (true) {
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
-		if (RB_WARN_ON(cpu_buffer,
-				rb_list_head(rb_list_head(tmp->prev)->next) != tmp))
-			return;
+		if (buffer_cnt != cpu_buffer->cnt) {
+			/* The list was updated, try again. */
+			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+			goto again;
+		}
+
+		tmp = rb_list_head(tmp->next);
+		if (tmp == head)
+			/* The iteration circled back, all is done. */
+			goto out_locked;
+
+		if (!rb_check_links(cpu_buffer, tmp))
+			goto out_locked;
+
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	}
+
+out_locked:
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 }
 
 /*
@@ -2535,6 +2584,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 
 	/* make sure pages points to a valid page in the ring buffer */
 	cpu_buffer->pages = next_page;
+	cpu_buffer->cnt++;
 
 	/* update head page */
 	if (head_bit)
@@ -2641,6 +2691,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 			 * pointer to point to end of list
 			 */
 			head_page->prev = last_page;
+			cpu_buffer->cnt++;
 			success = true;
 			break;
 		}
@@ -2876,12 +2927,8 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		 */
 		synchronize_rcu();
 		for_each_buffer_cpu(buffer, cpu) {
-			unsigned long flags;
-
 			cpu_buffer = buffer->buffers[cpu];
-			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 			rb_check_pages(cpu_buffer);
-			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 		}
 		atomic_dec(&buffer->record_disabled);
 	}
@@ -5299,6 +5346,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	rb_list_head(reader->list.next)->prev = &cpu_buffer->reader_page->list;
 	rb_inc_page(&cpu_buffer->head_page);
 
+	cpu_buffer->cnt++;
 	local_inc(&cpu_buffer->pages_read);
 
 	/* Finally update the reader page to the new head */
@@ -5838,12 +5886,9 @@ void
 ring_buffer_read_finish(struct ring_buffer_iter *iter)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
-	unsigned long flags;
 
 	/* Use this opportunity to check the integrity of the ring buffer. */
-	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 	rb_check_pages(cpu_buffer);
-	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 	atomic_dec(&cpu_buffer->resize_disabled);
 	kfree(iter->event);
@@ -6760,6 +6805,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		/* Install the new pages, remove the head from the list */
 		cpu_buffer->pages = cpu_buffer->new_pages.next;
 		list_del_init(&cpu_buffer->new_pages);
+		cpu_buffer->cnt++;
 
 		cpu_buffer->head_page
 			= list_entry(cpu_buffer->pages, struct buffer_page, list);

base-commit: eca631b8fe808748d7585059c4307005ca5c5820
prerequisite-patch-id: 6462690c54da2e31f7d7a9f405f550e52d4fb5c8
-- 
2.43.0

