Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6CB221541;
	Fri, 14 Feb 2025 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739534823; cv=none; b=FHxMxpIV7zRqRzDmKdVAKzooNSN1pcKx5VAPYsFfwGTVFXCEXL01QE4S7ZFTALgMlnDomm25+4DMawQtNqd+z58LRW8+rbPCM2ySUPF/p+anXVHKWDZ4BHGWgYOy2mx+73y8pLLPkTGGDi+oW+zlZVX8B1xAigHAeNmqnF0niP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739534823; c=relaxed/simple;
	bh=uBUJSEL5HuOe9zrSMv4zj/jgUFFhuIj6M7Q1fYfmraM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdYKNMRIJ7rKe8pbow3NgT6gBDQbfC525oJon5gAxxazPuA3LKN8SkSdb22ykDdoDVv8LUt5WnVkzVhvXWu7FSmkj26405R+HMDykGLuINZcRo7SsLmOOrb8J4E8GCTWPFDMXT33AUCqxiQV3cMka1DSOK4GVwooRREqqJ3Ufto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B9DC4CED1;
	Fri, 14 Feb 2025 12:07:01 +0000 (UTC)
Date: Fri, 14 Feb 2025 07:07:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] tracing: Do not allow mmap() of persistent ring buffer
Message-ID: <20250214070712.01997ea1@gandalf.local.home>
In-Reply-To: <20250214161332.8797b20f09e068c33f872698@kernel.org>
References: <20250213180737.061871ae@gandalf.local.home>
	<20250214110722.7eaf35b42c4858e6b74500f7@kernel.org>
	<20250213212147.6511b235@gandalf.local.home>
	<20250214161332.8797b20f09e068c33f872698@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 16:13:32 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 13 Feb 2025 21:21:47 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 14 Feb 2025 11:07:22 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >   
> > > This may be good for fixing crash short term but may not allow us to read the
> > > subbufs which is read right before crash. Can we also add an option to reset
> > > the read pointer in the previous boot for the persistent ring buffer?  
> > 
> > I'm not sure what you mean here.
> > 
> > Note, this is just for mmapping the buffers. Currently we never tried it as
> > if we did, it would have crashed. But this does not affect normal reads.  
> 
> But reading buffer via mmap() is already supported. Can we read all pages,
> which had been read by trace_pipe_raw in previous boot, again on this boot?

It's not supported. If you try it, it will crash. This prevents reading via
mmap() on a boot buffer. I don't know what you are asking. Once this patch
is applied, mmap() will always fail on the boot buffer before or after you
start it.

> 
> Anyway, I made another patch to fix it to allow mmap() on persistent ring
> buffer here. I thought I can get the phys_addr from struct vm_area, but
> it could not for vmap()'d area. So this stores the phys_addr in trace_buffer.

Which is way too complex and intrusive. If you want to allow mapping, all
it needs is this:

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 07b421115692..9339adc88ad5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5927,12 +5941,18 @@ static void rb_clear_buffer_page(struct buffer_page *page)
 static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
+	struct page *page;
 
 	if (!meta)
 		return;
 
 	meta->reader.read = cpu_buffer->reader_page->read;
-	meta->reader.id = cpu_buffer->reader_page->id;
+	/* For boot buffers, the id is the index */
+	if (cpu_buffer->ring_meta)
+		meta->reader.id = rb_meta_subbuf_idx(cpu_buffer->ring_meta,
+						     cpu_buffer->reader_page->page);
+	else
+		meta->reader.id = cpu_buffer->reader_page->id;
 	meta->reader.lost_events = cpu_buffer->lost_events;
 
 	meta->entries = local_read(&cpu_buffer->entries);
@@ -5940,7 +5960,12 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 	meta->read = cpu_buffer->read;
 
 	/* Some archs do not have data cache coherency between kernel and user-space */
-	flush_dcache_folio(virt_to_folio(cpu_buffer->meta_page));
+	if (virt_addr_valid(cpu_buffer->meta_page))
+		page = virt_to_page(cpu_buffer->meta_page);
+	else
+		page = vmalloc_to_page(cpu_buffer->meta_page);
+
+	flush_dcache_folio(page_folio(page));
 }
 
 static void
@@ -7041,7 +7066,10 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 			goto out;
 		}
 
-		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+		if (virt_addr_valid(cpu_buffer->subbuf_ids[s]))
+			page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+		else
+			page = vmalloc_to_page((void *)cpu_buffer->subbuf_ids[s]);
 
 		for (; off < (1 << (subbuf_order)); off++, page++) {
 			if (p >= nr_pages)
@@ -7187,6 +7215,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 	unsigned long missed_events;
 	unsigned long reader_size;
 	unsigned long flags;
+	struct page *page;
 
 	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
 	if (IS_ERR(cpu_buffer))
@@ -7255,7 +7291,12 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 
 out:
 	/* Some archs do not have data cache coherency between kernel and user-space */
-	flush_dcache_folio(virt_to_folio(cpu_buffer->reader_page->page));
+	if (virt_addr_valid(cpu_buffer->meta_page))
+		page = virt_to_page(cpu_buffer->meta_page);
+	else
+		page = vmalloc_to_page(cpu_buffer->meta_page);
+
+	flush_dcache_folio(page_folio(page));
 
 	rb_update_meta_page(cpu_buffer);
 
But this still doesn't work, as the index is still off (I'm still fixing it).

The persistent ring buffer uses the page->id for one thing but the user
space mmap() uses it for something else.

-- Steve
