Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E7205AA5;
	Fri, 14 Feb 2025 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739517217; cv=none; b=rq6K4O8zKSNlIviD8XUAvAg5YDKbwWmOV9vL1v1MqNM20WYkSpVo1eR+i7s9GHokIUYvPd4h0UG18laK5ydq4tCJVoSLvBCGfq+Z1ohbw02+kE6F/axfiF5k2dJ+0/yuW+8YpLbLughsbLfthd4UZB4vxq7bly7Lfe60oCn73s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739517217; c=relaxed/simple;
	bh=BXHxz6vpDM+aKgbE5JyTc5kr4mxtYTclK1Es/s7hpDE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jze5YGucHn5rsPBWO2dGOE916C/kYDi3LIKf6MRnZpto0wnYHMpcdwWorUZ1yezlEaBdB8VQzAXMmvf02WLCR84sUV9asap+PHC9Li1y+I4kajs+VioQ0z3Zoj+wmHTrZsCNMic2iz2IsDB1r1egxRnW5hMWnpyw4H/kiZADyHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAm56ohW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAm56ohW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1018AC4CEDD;
	Fri, 14 Feb 2025 07:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739517216;
	bh=BXHxz6vpDM+aKgbE5JyTc5kr4mxtYTclK1Es/s7hpDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iAm56ohWeBDn0lKw2i7pGayZXL2CFbouYTBCqgM9u88FzJcGS6Zsv2drMaCT7zCLM
	 1aW0FQ6KV3faBlGM+KXdaEjNPFBne7yFznK24Sw0pB288Y3Tt0yZfaTnxHueUWvYRj
	 C+rxhdobzAlrHlSt0AyB/2XtAMYakp/ykzodJwqV0VP0CJ1Lx8oIqc5dD3f5JuoKfc
	 F+mUyP75iR1gnmM3SuQe0g93mE+giz1J6iuJ3Vm9CQLW2pmJigtGPKtFew5WFpiy7E
	 n9IDiAuLWPXn9dvu5SKqcPRSq4P2hWz2JWRi7ihga4wFuM47YUV0lQ32HP7ckstCTd
	 59UHrub/tcBuw==
Date: Fri, 14 Feb 2025 16:13:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] tracing: Do not allow mmap() of persistent ring buffer
Message-Id: <20250214161332.8797b20f09e068c33f872698@kernel.org>
In-Reply-To: <20250213212147.6511b235@gandalf.local.home>
References: <20250213180737.061871ae@gandalf.local.home>
	<20250214110722.7eaf35b42c4858e6b74500f7@kernel.org>
	<20250213212147.6511b235@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 21:21:47 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 14 Feb 2025 11:07:22 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > This may be good for fixing crash short term but may not allow us to read the
> > subbufs which is read right before crash. Can we also add an option to reset
> > the read pointer in the previous boot for the persistent ring buffer?
> 
> I'm not sure what you mean here.
> 
> Note, this is just for mmapping the buffers. Currently we never tried it as
> if we did, it would have crashed. But this does not affect normal reads.

But reading buffer via mmap() is already supported. Can we read all pages,
which had been read by trace_pipe_raw in previous boot, again on this boot?

Anyway, I made another patch to fix it to allow mmap() on persistent ring
buffer here. I thought I can get the phys_addr from struct vm_area, but
it could not for vmap()'d area. So this stores the phys_addr in trace_buffer.

Thanks,

commit d1d703d1db64c13146542612f7fd4dd85904f682
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Date:   Fri Feb 14 15:38:12 2025 +0900

    tracing: Fix to allow mmap() on persistent ring buffer
    
    The kernel crashes when mmap() the persistent ring buffer (per-cpu
     trace_pipe_raw) as below;
    
    [   68.539135] ------------[ cut here ]------------
    [   68.540126] kernel BUG at arch/x86/mm/physaddr.c:28!
    [   68.541178] Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
    [   68.542259] CPU: 6 UID: 0 PID: 115 Comm: mmap Not tainted 6.14.0-rc2 #14
    [   68.543473] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    [   68.545649] RIP: 0010:__phys_addr+0x56/0x60
    [   68.546608] Code: 89 c2 48 d3 ea 48 85 d2 75 1f c3 cc cc cc cc cc 48 81 f9 00 00 00 20 73 13 48 03 0d d4 66 1c 01 48 89 c8 c3 cc cc cc cc cc 90 <0f> 0b 90 0f 0b 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90
    [   68.550479] RSP: 0018:ffffc900018639f0 EFLAGS: 00010202
    [   68.551364] RAX: 0000408000001000 RBX: ffff888004111000 RCX: 0000000000000028
    [   68.552609] RDX: 0000000000000040 RSI: ffff88800737a000 RDI: ffffc90000001000
    [   68.553768] RBP: 000000000000027c R08: 0000000000000dc0 R09: 00000000ffffffff
    [   68.555177] R10: ffffffff816002ea R11: 0000000000000000 R12: ffff88800737a000
    [   68.556376] R13: 0000000000000000 R14: ffffea0000000000 R15: 0000000000000001
    [   68.557550] FS:  000055558036a400(0000) GS:ffff88807db80000(0000) knlGS:0000000000000000
    [   68.558963] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [   68.559970] CR2: 00007f73a9e96b74 CR3: 0000000005e2a000 CR4: 00000000000006b0
    [   68.561354] Call Trace:
    [   68.562077]  <TASK>
    [   68.562657]  ? __die_body+0x6a/0xb0
    [   68.563385]  ? die+0xa4/0xd0
    [   68.563956]  ? do_trap+0xa6/0x170
    [   68.564727]  ? __phys_addr+0x56/0x60
    [   68.565547]  ? do_error_trap+0xc7/0x120
    [   68.566385]  ? __phys_addr+0x56/0x60
    [   68.567170]  ? handle_invalid_op+0x2c/0x40
    [   68.568025]  ? __phys_addr+0x56/0x60
    [   68.568801]  ? exc_invalid_op+0x39/0x50
    [   68.569576]  ? asm_exc_invalid_op+0x1a/0x20
    [   68.570329]  ? __create_object+0x3a/0xf0
    [   68.571120]  ? __phys_addr+0x56/0x60
    [   68.571858]  __rb_map_vma+0x280/0x320
    [   68.572544]  ? _raw_spin_unlock_irqrestore+0x40/0x60
    [   68.573356]  ring_buffer_map+0x25a/0x340
    [   68.573989]  tracing_buffers_mmap+0x8a/0xe0
    [   68.574702]  mmap_region+0x898/0xd30
    [   68.575369]  do_mmap+0x4ac/0x5e0
    [   68.575920]  ? down_write_killable+0xb5/0xf0
    [   68.576610]  vm_mmap_pgoff+0xc4/0x1a0
    [   68.577218]  ksys_mmap_pgoff+0x181/0x200
    [   68.577848]  do_syscall_64+0xec/0x1d0
    [   68.578448]  ? exc_page_fault+0x92/0x110
    [   68.579092]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
    
    Since the persistent ring buffer is mapping reserve memory in vmap area,
    it can not use virt_to_page(). But we can use the offset of each subbuf
    pages from the physical start address of reserve memory for identifying
    PFN because reserve memory is mapped linearly.
    
    Cc: stable@vger.kernel.org
    Fixes: e645535a954ad ("tracing: Add option to use memmapped memory for trace boot instance")
    Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 17fbb7855295..2d0902e3d194 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -92,6 +92,7 @@ __ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *k
 struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flags,
 					       int order, unsigned long start,
 					       unsigned long range_size,
+					       phys_addr_t phys_addr,
 					       struct lock_class_key *key);
 
 bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, long *text,
@@ -113,11 +114,11 @@ bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, long *text,
  * traced by ftrace, it can produce lockdep warnings. We need to keep each
  * ring buffer's lock class separate.
  */
-#define ring_buffer_alloc_range(size, flags, order, start, range_size)	\
+#define ring_buffer_alloc_range(size, flags, order, start, range_size, phys_addr)	\
 ({									\
 	static struct lock_class_key __key;				\
 	__ring_buffer_alloc_range((size), (flags), (order), (start),	\
-				  (range_size), &__key);		\
+				  (range_size), (phys_addr), &__key);	\
 })
 
 typedef bool (*ring_buffer_cond_fn)(void *data);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b8e0ae15ca5b..cb2380aadbdf 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -549,6 +549,7 @@ struct trace_buffer {
 
 	unsigned long			range_addr_start;
 	unsigned long			range_addr_end;
+	phys_addr_t			range_addr_phys;
 
 	long				last_text_delta;
 	long				last_data_delta;
@@ -2290,6 +2291,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 int order, unsigned long start,
 					 unsigned long end,
+					 phys_addr_t phys_start,
 					 struct lock_class_key *key)
 {
 	struct trace_buffer *buffer;
@@ -2370,6 +2372,7 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		nr_pages--;
 		buffer->range_addr_start = start;
 		buffer->range_addr_end = end;
+		buffer->range_addr_phys = phys_start;
 
 		rb_range_meta_init(buffer, nr_pages);
 	} else {
@@ -2424,7 +2427,7 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 					struct lock_class_key *key)
 {
 	/* Default buffer page size - one system page */
-	return alloc_buffer(size, flags, 0, 0, 0,key);
+	return alloc_buffer(size, flags, 0, 0, 0, 0, key);
 
 }
 EXPORT_SYMBOL_GPL(__ring_buffer_alloc);
@@ -2446,9 +2449,10 @@ EXPORT_SYMBOL_GPL(__ring_buffer_alloc);
 struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flags,
 					       int order, unsigned long start,
 					       unsigned long range_size,
+					       phys_addr_t phys_start,
 					       struct lock_class_key *key)
 {
-	return alloc_buffer(size, flags, order, start, start + range_size, key);
+	return alloc_buffer(size, flags, order, start, start + range_size, phys_start, key);
 }
 
 /**
@@ -6966,10 +6970,11 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
 static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 			struct vm_area_struct *vma)
 {
-	unsigned long nr_subbufs, nr_pages, nr_vma_pages, pgoff = vma->vm_pgoff;
+	unsigned long nr_subbufs, nr_pages, nr_vma_pages, base, pgoff = vma->vm_pgoff;
 	unsigned int subbuf_pages, subbuf_order;
 	struct page **pages;
 	int p = 0, s = 0;
+	phys_addr_t pa;
 	int err;
 
 	/* Refuse MP_PRIVATE or writable mappings */
@@ -7032,6 +7037,8 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 		s += pgoff / subbuf_pages;
 	}
 
+	pa = cpu_buffer->buffer->range_addr_phys;
+	base = cpu_buffer->buffer->range_addr_start;
 	while (p < nr_pages) {
 		struct page *page;
 		int off = 0;
@@ -7041,7 +7048,10 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 			goto out;
 		}
 
-		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+		if (pa)
+			page = pfn_to_page((pa + cpu_buffer->subbuf_ids[s] - base) >> PAGE_SHIFT);
+		else
+			page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
 
 		for (; off < (1 << (subbuf_order)); off++, page++) {
 			if (p >= nr_pages)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1496a5ac33ae..5c87a4fa601a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9210,7 +9210,8 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 	if (tr->range_addr_start && tr->range_addr_size) {
 		buf->buffer = ring_buffer_alloc_range(size, rb_flags, 0,
 						      tr->range_addr_start,
-						      tr->range_addr_size);
+						      tr->range_addr_size,
+						      tr->range_addr_phys);
 
 		ring_buffer_last_boot_delta(buf->buffer,
 					    &tr->text_delta, &tr->data_delta);
@@ -9364,7 +9365,8 @@ static int trace_array_create_dir(struct trace_array *tr)
 static struct trace_array *
 trace_array_create_systems(const char *name, const char *systems,
 			   unsigned long range_addr_start,
-			   unsigned long range_addr_size)
+			   unsigned long range_addr_size,
+			   phys_addr_t range_addr_phys)
 {
 	struct trace_array *tr;
 	int ret;
@@ -9393,6 +9395,7 @@ trace_array_create_systems(const char *name, const char *systems,
 	/* Only for boot up memory mapped ring buffers */
 	tr->range_addr_start = range_addr_start;
 	tr->range_addr_size = range_addr_size;
+	tr->range_addr_phys = range_addr_phys;
 
 	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
 
@@ -9455,7 +9458,7 @@ trace_array_create_systems(const char *name, const char *systems,
 
 static struct trace_array *trace_array_create(const char *name)
 {
-	return trace_array_create_systems(name, NULL, 0, 0);
+	return trace_array_create_systems(name, NULL, 0, 0, 0);
 }
 
 static int instance_mkdir(const char *name)
@@ -9533,7 +9536,7 @@ struct trace_array *trace_array_get_by_name(const char *name, const char *system
 		}
 	}
 
-	tr = trace_array_create_systems(name, systems, 0, 0);
+	tr = trace_array_create_systems(name, systems, 0, 0, 0);
 
 	if (IS_ERR(tr))
 		tr = NULL;
@@ -10443,7 +10446,7 @@ __init static void enable_instances(void)
 				do_allocate_snapshot(name);
 		}
 
-		tr = trace_array_create_systems(name, NULL, addr, size);
+		tr = trace_array_create_systems(name, NULL, addr, size, start);
 		if (IS_ERR(tr)) {
 			pr_warn("Tracing: Failed to create instance buffer %s\n", curr_str);
 			continue;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9c21ba45b7af..7a7db029915f 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -348,6 +348,7 @@ struct trace_array {
 	unsigned int		mapped;
 	unsigned long		range_addr_start;
 	unsigned long		range_addr_size;
+	phys_addr_t		range_addr_phys;
 	long			text_delta;
 	long			data_delta;
 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
