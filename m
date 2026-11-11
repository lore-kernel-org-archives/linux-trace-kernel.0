Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390209;
	b=LIjQQmsJICh2wwVzIRHTKsFJebYBlfBFfhm70tmnsAzM7it0s2or+f1z27D6upjtHbs6
	 qzA/kluCIzUOrU15IZ/wz8+WheKb2Vp4AIOiUNq4PA3TmeYnDwjtTQ5KKxyEXWOnkRQXA
	 qr5IDRPkM41xsEwQOLwANZWt6f5SJWXe8r+KZ/R8SZSgvaRaSuMORGftuVvktwFgQJFTi
	 is7s0mh1pCMmlG8GsgM9TT8fZj8nYBX+7SL6H55AfBvoLQZb0i6Q/4GAKQY7RwtIiB/5q
	 3yyX0xJALggC0J2yd8cwcf0sd93L+wrM1acmvo51Xp3l7GwU+wtoToc5ytBsM67krug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390209;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=8m+LWT3dsJ22s2lOX+FPdI7LDB8BSPNdUrrDzj19p9k=;
	b=nPP/2h54bNipw2Y4wLuMeOq4x1DERQ4j5krfjAf1dYeX1E6lECRqTFoS+B8zPZTk63F3
	 3K4tVMTrX4oN76YJUnZ9FmL7YSDUYV4CPs4OqmFf53+wBwkH5JhyKFLi9CkNVvSnpa25M
	 zDJFQZVx/zWQIW4j5e6DMGQGVMghVnomlTa6qDnWKqRqDOlfDIxLNiNxASKuWoFUvqF4n
	 i8FjAC7vUpvR+u825uS3DanE77Qtfdz53n6I+rMEy0i3dyj7v92ly/A6djxGeWeex+nUG
	 Y+pixxrTOvUmmZPKBGJdBxAizbO9fTK15v8LfTY/ykzUK1xQd5j2p6yhowst/IoHDRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F7A606A31C;
	Wed, 11 Nov 2026 09:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8F7A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=8m+LWT3dsJ
	22s2lOX+FPdI7LDB8BSPNdUrrDzj19p9k=; b=RniVeHw0KuaOa5MLRf6VxBt6+w
	X0B+KQDOqH7Uisa7OFhnwEGTAxa7OP1PyvKOJDnKdy523si0mfCtSztPeybqQI3L
	wihIxdD43+IRQMGUD0V16rxhIC9ljfjmre+VgmsO6I6zqV4R0QZGn+ekjz7aCsxn
	my4xCzYbIBv340S7U=
Received: from LAPTOP-FRMFRHCN.localdomain (unknown [240e:457:1010:6360:78ac:e18c:3618:4a0b])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkD2OwGqOPRqtBh3AQ--.23819S2;
	Wed, 11 Nov 2026 17:43:08 +0800 (CST)
From: Haoli Zhang <26031212468@stu.xidian.edu.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	syzbot+37e1793bdb0061ea3a47@syzkaller.appspotmail.com,
	25031212117@stu.xidian.edu.cn,
	byu@xidian.edu.cn,
	Haoli Zhang <26031212468@stu.xidian.edu.cn>
Subject: [PATCH v3] tracing: ring-buffer: serialize shrink with NMI readers
Date: Wed, 11 Nov 2026 17:43:01 +0800
Message-Id: <20261111094301.2213435-1-26031212468@stu.xidian.edu.cn>
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
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:BLQMCkD2OwGqOPRqtBh3AQ--.23819S2
X-Coremail-Antispam: 1UD129KBjvAXoW3CFWUAF1rXw4rJr4DGr1kAFb_yoW8Jr1UGo
	Z3Xw4Sqw1xtryUGFyvkF48XF1UGw17tF9rAF4rCryDZryxAryav3s8Zr1ayFyrXa1fA34Y
	va48XrZrWF4UJFyfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYL7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6IIF6r4fMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUDGYPUUUUU==
X-CM-SenderInfo: yswqjiasrskluy6v33wo0lvxldqovvfxof0/1tbiAQUOEWrzM1bTOQAAsN

The syzbot report shows a use-after-free in rb_is_reader_page(), reached
from rb_move_tail(), with the freed page released by rb_remove_pages().
Source inspection suggests that a detached reader page can retain a link
into the range removed during a shrink. This patch addresses that possible
stale-link path and coordinates NMI readers with page removal.

When an NMI reader cannot acquire reader_lock, rb_reader_lock() falls back
to reading the ring buffer without the lock. Gate lockless NMI readers
while rb_remove_pages() removes pages. Drain readers that entered before
the gate before changing the page list. New NMI readers that cannot acquire
reader_lock while the gate is closed skip that CPU. Readers that acquire=0D
reader_lock remain serialized by it. The drain loop calls cond_resched()=0D
while waiting for readers to exit.

During shrink, redirect reader_page->list.prev if it points to a page being
removed. Also detect a stale reader_page->list.next and redirect it after
reconnecting the ring to the surviving successor link, including the
transferred head flag.

When an NMI reader skips a CPU while resize_in_progress is set, treat that
CPU buffer as empty in the empty-query helpers. This lets ftrace_dump_one()
make progress instead of retrying forever when peek/consume also skip the b=
uffer. Entries on a skipped CPU may be omitted from the dump.=0D
Clear event on every consume retry. Cache whether it is padding
before unlocking. This avoids reading event fields after unlock.
Clear timestamps on skipped peek and consume operations.

The NMI fallback increment of record_disabled is intentionally retained.
The existing fallback comment says an unlocked NMI read may corrupt the
buffer and that recording must remain disabled afterward; the existing
unlock path does not undo that disable. The nmi_readers counter is separate
and tracks only the temporary lifetime of a lockless NMI read.

Fixes: 83f40318dab0 ("ring-buffer: Make removal of ring buffer pages atomic=
")
Reported-by: syzbot+37e1793bdb0061ea3a47@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D37e1793bdb0061ea3a47
Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>

---
v3:
  - Treat skipped empty-buffer queries as empty so NMI trace dumps can prog=
ress.
  - Clear the event pointer before each consume retry.
  - Cache padding retry decisions before dropping reader protection.=0D
  - Document that dumps may omit records from CPUs skipped while the gate i=
s set.
  - Call cond_resched() while draining NMI readers in the shrink slow path.
  - Add the Fixes tag.
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c..9e52506 100644
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
@@ -2578,6 +2580,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, u=
nsigned long nr_pages, int
=20
 	cpu_buffer->cpu =3D cpu;
 	cpu_buffer->buffer =3D buffer;
+	atomic_set(&cpu_buffer->resize_in_progress, 0);
+	atomic_set(&cpu_buffer->nmi_readers, 0);
 	raw_spin_lock_init(&cpu_buffer->reader_lock);
 	lockdep_set_class(&cpu_buffer->reader_lock, buffer->reader_lock_key);
 	cpu_buffer->lock =3D (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
@@ -3074,10 +3078,18 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buf=
fer, unsigned long nr_pages)
 	struct buffer_page *last_page, *first_page;
 	unsigned long nr_removed;
 	unsigned long head_bit;
+	bool reader_page_next_removed;
 	int page_entries;
=20
 	head_bit =3D 0;
+	reader_page_next_removed =3D false;
=20
+	/* Stop lockless NMI readers before unlinking pages. */
+	atomic_set_release(&cpu_buffer->resize_in_progress, 1);
+	/* Pair with the NMI reader's count increment and gate check. */
+	smp_mb();
+	while (atomic_read_acquire(&cpu_buffer->nmi_readers))
+		cond_resched();
 	raw_spin_lock_irq(&cpu_buffer->reader_lock);
 	atomic_inc(&cpu_buffer->record_disabled);
 	/*
@@ -3106,6 +3118,19 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buff=
er, unsigned long nr_pages)
 	for (nr_removed =3D 0; nr_removed < nr_pages; nr_removed++) {
 		to_remove =3D rb_list_head(to_remove)->next;
 		head_bit |=3D (unsigned long)to_remove & RB_PAGE_HEAD;
+
+		/*
+		 * The reader page is not part of the ring buffer list, so its
+		 * previous pointer may still point to a page being removed.
+		 * rb_is_reader_page() follows this pointer, so redirect it to a
+		 * page that will remain in the ring buffer.
+		 */
+		if (cpu_buffer->reader_page->list.prev =3D=3D rb_list_head(to_remove))
+			cpu_buffer->reader_page->list.prev =3D tail_page;
+		/* The detached reader page can also retain a stale forward link. */
+		if (rb_list_head(cpu_buffer->reader_page->list.next) =3D=3D
+		    rb_list_head(to_remove))
+			reader_page_next_removed =3D true;
 	}
 	/* Read iterators need to reset themselves when some pages removed */
 	cpu_buffer->pages_removed +=3D nr_removed;
@@ -3119,6 +3144,9 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffe=
r, unsigned long nr_pages)
 	 */
 	tail_page->next =3D (struct list_head *)((unsigned long)next_page |
 						head_bit);
+	/* Keep the detached reader page's forward link off removed pages too. */
+	if (reader_page_next_removed)
+		cpu_buffer->reader_page->list.next =3D tail_page->next;
 	next_page =3D rb_list_head(next_page);
 	next_page->prev =3D tail_page;
=20
@@ -3134,6 +3162,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffe=
r, unsigned long nr_pages)
 	/* pages are removed, resume tracing and then free the pages */
 	atomic_dec(&cpu_buffer->record_disabled);
 	raw_spin_unlock_irq(&cpu_buffer->reader_lock);
+	atomic_set_release(&cpu_buffer->resize_in_progress, 0);
=20
 	RB_WARN_ON(cpu_buffer, list_empty(cpu_buffer->pages));
=20
@@ -6293,11 +6322,18 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_iter_peek);
=20
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
=20
 	/*
@@ -6310,18 +6346,35 @@ static inline bool rb_reader_lock(struct ring_buffe=
r_per_cpu *cpu_buffer)
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
=20
 	/* Continue without locking, but disable the ring buffer */
 	atomic_inc(&cpu_buffer->record_disabled);
-	return false;
+
+	return RB_READER_NMI;
 }
=20
 static inline void
-rb_reader_unlock(struct ring_buffer_per_cpu *cpu_buffer, bool locked)
+rb_reader_unlock(struct ring_buffer_per_cpu *cpu_buffer,
+		 enum rb_reader_lock_state state)
 {
-	if (likely(locked))
+	if (likely(state =3D=3D RB_READER_LOCKED))
 		raw_spin_unlock(&cpu_buffer->reader_lock);
+	else if (state =3D=3D RB_READER_NMI)
+		atomic_dec_return_release(&cpu_buffer->nmi_readers);
 }
=20
 /**
@@ -6341,21 +6394,30 @@ ring_buffer_peek(struct trace_buffer *buffer, int c=
pu, u64 *ts,
 	struct ring_buffer_per_cpu *cpu_buffer =3D buffer->buffers[cpu];
 	struct ring_buffer_event *event;
 	unsigned long flags;
-	bool dolock;
+	enum rb_reader_lock_state state;
+	bool retry;
=20
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return NULL;
=20
  again:
+	retry =3D false;
 	local_irq_save(flags);
-	dolock =3D rb_reader_lock(cpu_buffer);
-	event =3D rb_buffer_peek(cpu_buffer, ts, lost_events);
-	if (event && event->type_len =3D=3D RINGBUF_TYPE_PADDING)
+	state =3D rb_reader_lock(cpu_buffer);
+	if (state =3D=3D RB_READER_SKIP) {
+		if (ts)
+			*ts =3D 0;
+		event =3D NULL;
+	} else {
+		event =3D rb_buffer_peek(cpu_buffer, ts, lost_events);
+	}
+	retry =3D event && event->type_len =3D=3D RINGBUF_TYPE_PADDING;
+	if (retry)
 		rb_advance_reader(cpu_buffer);
-	rb_reader_unlock(cpu_buffer, dolock);
+	rb_reader_unlock(cpu_buffer, state);
 	local_irq_restore(flags);
=20
-	if (event && event->type_len =3D=3D RINGBUF_TYPE_PADDING)
+	if (retry)
 		goto again;
=20
 	return event;
@@ -6416,9 +6478,12 @@ ring_buffer_consume(struct trace_buffer *buffer, int=
 cpu, u64 *ts,
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event =3D NULL;
 	unsigned long flags;
-	bool dolock;
+	enum rb_reader_lock_state state;
+	bool retry;
=20
  again:
+	retry =3D false;
+	event =3D NULL;
 	/* might be called in atomic */
 	preempt_disable();
=20
@@ -6427,21 +6492,25 @@ ring_buffer_consume(struct trace_buffer *buffer, in=
t cpu, u64 *ts,
=20
 	cpu_buffer =3D buffer->buffers[cpu];
 	local_irq_save(flags);
-	dolock =3D rb_reader_lock(cpu_buffer);
+	state =3D rb_reader_lock(cpu_buffer);
=20
-	event =3D rb_buffer_peek(cpu_buffer, ts, lost_events);
+	if (state !=3D RB_READER_SKIP)
+		event =3D rb_buffer_peek(cpu_buffer, ts, lost_events);
+	else if (ts)
+		*ts =3D 0;
+	retry =3D event && event->type_len =3D=3D RINGBUF_TYPE_PADDING;
 	if (event) {
 		cpu_buffer->lost_events =3D 0;
 		rb_advance_reader(cpu_buffer);
 	}
=20
-	rb_reader_unlock(cpu_buffer, dolock);
+	rb_reader_unlock(cpu_buffer, state);
 	local_irq_restore(flags);
=20
  out:
 	preempt_enable();
=20
-	if (event && event->type_len =3D=3D RINGBUF_TYPE_PADDING)
+	if (retry)
 		goto again;
=20
 	return event;
@@ -6843,7 +6912,7 @@ bool ring_buffer_empty(struct trace_buffer *buffer)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long flags;
-	bool dolock;
+	enum rb_reader_lock_state state;
 	bool ret;
 	int cpu;
=20
@@ -6851,9 +6920,10 @@ bool ring_buffer_empty(struct trace_buffer *buffer)
 	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer =3D buffer->buffers[cpu];
 		local_irq_save(flags);
-		dolock =3D rb_reader_lock(cpu_buffer);
-		ret =3D rb_per_cpu_empty(cpu_buffer);
-		rb_reader_unlock(cpu_buffer, dolock);
+		state =3D rb_reader_lock(cpu_buffer);
+		/* Do not make an NMI dumper spin on a buffer being resized. */
+		ret =3D state =3D=3D RB_READER_SKIP || rb_per_cpu_empty(cpu_buffer);
+		rb_reader_unlock(cpu_buffer, state);
 		local_irq_restore(flags);
=20
 		if (!ret)
@@ -6873,7 +6943,7 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffe=
r, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long flags;
-	bool dolock;
+	enum rb_reader_lock_state state;
 	bool ret;
=20
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
@@ -6881,9 +6951,10 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buff=
er, int cpu)
=20
 	cpu_buffer =3D buffer->buffers[cpu];
 	local_irq_save(flags);
-	dolock =3D rb_reader_lock(cpu_buffer);
-	ret =3D rb_per_cpu_empty(cpu_buffer);
-	rb_reader_unlock(cpu_buffer, dolock);
+	state =3D rb_reader_lock(cpu_buffer);
+	/* Do not make an NMI dumper spin on a buffer being resized. */
+	ret =3D state =3D=3D RB_READER_SKIP || rb_per_cpu_empty(cpu_buffer);
+	rb_reader_unlock(cpu_buffer, state);
 	local_irq_restore(flags);
=20
 	return ret;

