Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313606;
	b=1EYhjcZmvIiA/YIGXk17csiu/S81DaqlmlIe1SqH6O7VtZCwtRrtdgagjanpWFPyV70E
	 LCjBjTHxfOkyeylMBdsStQRUdFz+8/O1nxrhNa/wnaRCsg1MkSFNAuJfHlKQZ94so7Z89
	 zklXca4v4VsAOFucP4gQ0x+MkQINaGrgGda8htZlTqcmdU/eYqAFqAaP9bHA5nzL+ZzJB
	 AHRA1FH/20d/MXDto4k9/wG1/USXelL5QFnNwa4MVdyathrJQNeEtIkcn0S13wf3iAnqB
	 wZqbBA9DU2s87cSHqrD7lQsiQ1uTsk2PRDgDRjxfR4aWczzRBVksbv5f59dNYtUR3Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313606;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=m/zc8VQ5i8OTJTFWtOSXiNvCf+tvwTCGi9I9oRB87AA=;
	b=4WnTVR+zq3M8QFLgwyELiZ9Ib51vb1rd8Z82/k4Vz5DQw4sAnGwQhM5ULCBM0XS6CQxS
	 E84z2HUtu1fZbRuZj2WEAqEH2dQaylEEgpn5N6fGc/WrcZYKemE70DUP081999LvfMM0w
	 wOUmrVqCa8Nmq/Az1LMgDw8mANyY1pCpFMJCOPWJ7J0ewJ1YPTVpcN94QvtX6dkjI8vaK
	 TNUZQjY+OqNFY4wzUOLnsSeGS12Afkn+j8sTH7O8NrZZALKUWbv2kKiq7am8rWmcbHh+X
	 Lb6xgnQWD2WXDbTuU90wbfFGCj/wtIukpanCV+AuKNrwWekpDcTAbOk1AU9waKMtuKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36256606A31C;
	Tue, 10 Nov 2026 12:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36256606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=m/zc8VQ5i8
	OTJTFWtOSXiNvCf+tvwTCGi9I9oRB87AA=; b=JLkws2CXA4Di/uUQ7y6pE1SxLk
	vbBq6evD1YeQDwdhOYLX8aDPH/6b+aafhjq/oNNQgGT8JpM0fDu2xYRufko95YK/
	BZZ4W5XhlyMmKbe30va6P4wPxow/LtN4iSqZuAONegLl45eI8lyzeshG7G3vak0w
	DVKIdOcAHOgyn+cfE=
Received: from LAPTOP-FRMFRHCN.localdomain (unknown [2408:8670:ae1:0:3c71:2a19:707f:720e])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkB2e_5lDfNq4TdoAQ--.50986S2;
	Tue, 10 Nov 2026 20:26:15 +0800 (CST)
From: Haoli Zhang <26031212468@stu.xidian.edu.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+37e1793bdb0061ea3a47@syzkaller.appspotmail.com,
	Haoli Zhang <26031212468@stu.xidian.edu.cn>,
	Jinning Zhang <25031212117@stu.xidian.edu.cn>,
	Bin Yu <byu@xidian.edu.cn>
Subject: [PATCH v2] tracing: ring_buffer: serialize shrink with NMI readers
Date: Tue, 10 Nov 2026 20:26:10 +0800
Message-Id: <20261110122610.655756-1-26031212468@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkB2e_5lDfNq4TdoAQ--.50986S2
X-Coremail-Antispam: 1UD129KBjvJXoW3CFWUZF1xKw4kGr1UuFy3urg_yoWkGFyDpa
	y5KFZ8ta1DXr18Zwn7Cr15AF18tF1DZ3W7CrWxXw13XF47XFnIq34fJF9rCrWYkFW2qr9x
	Zr15Wa4rCr1UXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjNtx3UUUUU==
X-CM-SenderInfo: yswqjiasrskluy6v33wo0lvxldqovvfxof0/1tbiAQUNEWrx4dbSogAAsE

The syzbot report shows a use-after-free in rb_is_reader_page(), reached
from rb_move_tail(), with the freed page released by rb_remove_pages().
Source inspection suggests that a detached reader page can retain a link
into the range removed during a shrink. This patch addresses that possible
stale-link path and coordinates NMI readers with page removal.

When an NMI reader cannot acquire reader_lock, rb_reader_lock() falls back
to reading the ring buffer without the lock. Gate lockless NMI readers
while rb_remove_pages() removes pages. Track readers that entered before
the gate and drain them before changing the page list; new NMI readers that
fail reader_lock while the gate is closed skip that CPU. The gate and
reader-count protocol uses ordering barriers and release/acquire accesses.
Readers that successfully acquire reader_lock remain serialized by it.

The NMI fallback increment of record_disabled is intentionally retained.
The pre-existing fallback comment says an unlocked NMI read may corrupt the
buffer and that recording must remain disabled afterward; the existing
unlock path does not undo that disable. The new nmi_readers counter is
separate: it tracks only the temporary lifetime of the lockless NMI read
and is decremented when that read exits.

During shrink, redirect reader_page->list.prev if it points to a page being
removed. Detect a stale reader_page->list.next as well, and after reconnecting
the ring redirect it to the surviving successor link, including the
transferred head flag. Treat skipped empty-buffer queries as non-empty, and
clear the timestamp output when peek or consume skips the read.

Reported-by: syzbot+37e1793bdb0061ea3a47@syzkaller.appspotmail.com
Closes: https://syzkaller.appspotmail.com/bug?extid=37e1793bdb0061ea3a47
Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>

---
v2:
  - Add NMI-reader gate and ordered reader-count drain.
  - Repair both detached reader-page links when they enter the shrink range.
  - Treat skipped empty queries as non-empty and clear skipped peek/consume timestamps.
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c..f07160e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -522,6 +522,8 @@ struct ring_buffer_per_cpu {
 	int				cpu;
 	atomic_t			record_disabled;
 	atomic_t			resize_disabled;
+	atomic_t			resize_in_progress;
+	atomic_t			nmi_readers;
 	struct trace_buffer		*buffer;
 	raw_spinlock_t			reader_lock;	/* serialize readers */
 	arch_spinlock_t			lock;
@@ -2578,6 +2580,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, unsigned long nr_pages, int
 
 	cpu_buffer->cpu = cpu;
 	cpu_buffer->buffer = buffer;
+	atomic_set(&cpu_buffer->resize_in_progress, 0);
+	atomic_set(&cpu_buffer->nmi_readers, 0);
 	raw_spin_lock_init(&cpu_buffer->reader_lock);
 	lockdep_set_class(&cpu_buffer->reader_lock, buffer->reader_lock_key);
 	cpu_buffer->lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
@@ -3074,10 +3078,18 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 	struct buffer_page *last_page, *first_page;
 	unsigned long nr_removed;
 	unsigned long head_bit;
+	bool reader_page_next_removed;
 	int page_entries;
 
 	head_bit = 0;
+	reader_page_next_removed = false;
 
+	/* Stop lockless NMI readers before unlinking pages. */
+	atomic_set_release(&cpu_buffer->resize_in_progress, 1);
+	/* Pair with the NMI reader's count increment and gate check. */
+	smp_mb();
+	while (atomic_read_acquire(&cpu_buffer->nmi_readers))
+		cpu_relax();
 	raw_spin_lock_irq(&cpu_buffer->reader_lock);
 	atomic_inc(&cpu_buffer->record_disabled);
 	/*
@@ -3106,6 +3118,19 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 	for (nr_removed = 0; nr_removed < nr_pages; nr_removed++) {
 		to_remove = rb_list_head(to_remove)->next;
 		head_bit |= (unsigned long)to_remove & RB_PAGE_HEAD;
+
+		/*
+		 * The reader page is not part of the ring buffer list, so its
+		 * previous pointer may still point to a page being removed.
+		 * rb_is_reader_page() follows this pointer, so redirect it to a
+		 * page that will remain in the ring buffer.
+		 */
+		if (cpu_buffer->reader_page->list.prev == rb_list_head(to_remove))
+			cpu_buffer->reader_page->list.prev = tail_page;
+		/* The detached reader page can also retain a stale forward link. */
+		if (rb_list_head(cpu_buffer->reader_page->list.next) ==
+		    rb_list_head(to_remove))
+			reader_page_next_removed = true;
 	}
 	/* Read iterators need to reset themselves when some pages removed */
 	cpu_buffer->pages_removed += nr_removed;
@@ -3119,6 +3144,9 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 	 */
 	tail_page->next = (struct list_head *)((unsigned long)next_page |
 						head_bit);
+	/* Keep the detached reader page's forward link off removed pages too. */
+	if (reader_page_next_removed)
+		cpu_buffer->reader_page->list.next = tail_page->next;
 	next_page = rb_list_head(next_page);
 	next_page->prev = tail_page;
 
@@ -3134,6 +3162,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 	/* pages are removed, resume tracing and then free the pages */
 	atomic_dec(&cpu_buffer->record_disabled);
 	raw_spin_unlock_irq(&cpu_buffer->reader_lock);
+	atomic_set_release(&cpu_buffer->resize_in_progress, 0);
 
 	RB_WARN_ON(cpu_buffer, list_empty(cpu_buffer->pages));
 
@@ -6293,11 +6322,18 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_iter_peek);
 
-static inline bool rb_reader_lock(struct ring_buffer_per_cpu *cpu_buffer)
+enum rb_reader_lock_state {
+	RB_READER_LOCKED,
+	RB_READER_NMI,
+	RB_READER_SKIP,
+};
+
+static inline enum rb_reader_lock_state
+rb_reader_lock(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	if (likely(!in_nmi())) {
 		raw_spin_lock(&cpu_buffer->reader_lock);
-		return true;
+		return RB_READER_LOCKED;
 	}
 
 	/*
@@ -6310,18 +6346,35 @@ static inline bool rb_reader_lock(struct ring_buffer_per_cpu *cpu_buffer)
 	 * Reading from NMI is a oneshot deal.
 	 */
 	if (raw_spin_trylock(&cpu_buffer->reader_lock))
-		return true;
+		return RB_READER_LOCKED;
+
+	/*
+	 * A resize cannot wait for an NMI that interrupted the CPU doing the
+	 * resize. Track lockless NMI readers so page removal can stop new ones
+	 * and wait for existing readers before changing the page list.
+	 */
+	atomic_inc(&cpu_buffer->nmi_readers);
+	/* Pair with the resize gate before deciding to read without the lock. */
+	smp_mb__after_atomic();
+	if (atomic_read_acquire(&cpu_buffer->resize_in_progress)) {
+		atomic_dec_return_release(&cpu_buffer->nmi_readers);
+		return RB_READER_SKIP;
+	}
 
 	/* Continue without locking, but disable the ring buffer */
 	atomic_inc(&cpu_buffer->record_disabled);
-	return false;
+
+	return RB_READER_NMI;
 }
 
 static inline void
-rb_reader_unlock(struct ring_buffer_per_cpu *cpu_buffer, bool locked)
+rb_reader_unlock(struct ring_buffer_per_cpu *cpu_buffer,
+		 enum rb_reader_lock_state state)
 {
-	if (likely(locked))
+	if (likely(state == RB_READER_LOCKED))
 		raw_spin_unlock(&cpu_buffer->reader_lock);
+	else if (state == RB_READER_NMI)
+		atomic_dec_return_release(&cpu_buffer->nmi_readers);
 }
 
 /**
@@ -6341,18 +6394,24 @@ ring_buffer_peek(struct trace_buffer *buffer, int cpu, u64 *ts,
 	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
 	struct ring_buffer_event *event;
 	unsigned long flags;
-	bool dolock;
+	enum rb_reader_lock_state state;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return NULL;
 
  again:
 	local_irq_save(flags);
-	dolock = rb_reader_lock(cpu_buffer);
-	event = rb_buffer_peek(cpu_buffer, ts, lost_events);
+	state = rb_reader_lock(cpu_buffer);
+	if (state == RB_READER_SKIP) {
+		if (ts)
+			*ts = 0;
+		event = NULL;
+	} else {
+		event = rb_buffer_peek(cpu_buffer, ts, lost_events);
+	}
 	if (event && event->type_len == RINGBUF_TYPE_PADDING)
 		rb_advance_reader(cpu_buffer);
-	rb_reader_unlock(cpu_buffer, dolock);
+	rb_reader_unlock(cpu_buffer, state);
 	local_irq_restore(flags);
 
 	if (event && event->type_len == RINGBUF_TYPE_PADDING)
@@ -6416,7 +6475,7 @@ ring_buffer_consume(struct trace_buffer *buffer, int cpu, u64 *ts,
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event = NULL;
 	unsigned long flags;
-	bool dolock;
+	enum rb_reader_lock_state state;
 
  again:
 	/* might be called in atomic */
@@ -6427,15 +6486,18 @@ ring_buffer_consume(struct trace_buffer *buffer, int cpu, u64 *ts,
 
 	cpu_buffer = buffer->buffers[cpu];
 	local_irq_save(flags);
-	dolock = rb_reader_lock(cpu_buffer);
+	state = rb_reader_lock(cpu_buffer);
 
-	event = rb_buffer_peek(cpu_buffer, ts, lost_events);
+	if (state != RB_READER_SKIP)
+		event = rb_buffer_peek(cpu_buffer, ts, lost_events);
+	else if (ts)
+		*ts = 0;
 	if (event) {
 		cpu_buffer->lost_events = 0;
 		rb_advance_reader(cpu_buffer);
 	}
 
-	rb_reader_unlock(cpu_buffer, dolock);
+	rb_reader_unlock(cpu_buffer, state);
 	local_irq_restore(flags);
 
  out:
@@ -6843,7 +6905,7 @@ bool ring_buffer_empty(struct trace_buffer *buffer)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long flags;
-	bool dolock;
+	enum rb_reader_lock_state state;
 	bool ret;
 	int cpu;
 
@@ -6851,9 +6913,10 @@ bool ring_buffer_empty(struct trace_buffer *buffer)
 	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
 		local_irq_save(flags);
-		dolock = rb_reader_lock(cpu_buffer);
-		ret = rb_per_cpu_empty(cpu_buffer);
-		rb_reader_unlock(cpu_buffer, dolock);
+		state = rb_reader_lock(cpu_buffer);
+		ret = state == RB_READER_SKIP ? false :
+			rb_per_cpu_empty(cpu_buffer);
+		rb_reader_unlock(cpu_buffer, state);
 		local_irq_restore(flags);
 
 		if (!ret)
@@ -6873,7 +6936,7 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long flags;
-	bool dolock;
+	enum rb_reader_lock_state state;
 	bool ret;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
@@ -6881,9 +6944,10 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
 
 	cpu_buffer = buffer->buffers[cpu];
 	local_irq_save(flags);
-	dolock = rb_reader_lock(cpu_buffer);
-	ret = rb_per_cpu_empty(cpu_buffer);
-	rb_reader_unlock(cpu_buffer, dolock);
+	state = rb_reader_lock(cpu_buffer);
+	ret = state == RB_READER_SKIP ? false :
+		rb_per_cpu_empty(cpu_buffer);
+	rb_reader_unlock(cpu_buffer, state);
 	local_irq_restore(flags);
 
 	return ret;

