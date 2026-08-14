Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8051371049;
	Fri, 14 Aug 2026 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718531; cv=none; b=MI4KuArUVyjOeI9AndY9oBETUihy+V8igkiwXIaGT7yWCX+7J6u87AWS92xHvKaZZo2y7o4BjrysdpukuBVe3q6tFEqjVWGgl4hDrBtAK23B6a+GPOLno9kV/ETvcuNCCdbKGhFUkI/TWW8MBitxtCxGvxm0EfVYjuZUEtaJ20g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718531; c=relaxed/simple;
	bh=ESqGrT8Y5wkxyNti2RRAQIC1rfIKJ8JAwjA+N6zqtsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNvVJDHhBeI/BGDbhq4o4GAftXL7CYUmR5Xr4ef4veSDNwDi9kewDXcs5yVj/2OhysiiDb+2z1KNH1Lmzi15xBtVgg8b5BWSDFkanVctPZmGZ0P32QodPkL9+M1Pqn7e7TFJLpxZKWf1WuLVSljljyrHcgR7BVRAqcqsIcanK8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=EImOmhAB; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="EImOmhAB"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id DF9B0140154;
	Fri, 14 Aug 2026 14:41:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 03D5680012;
	Fri, 14 Aug 2026 14:41:54 +0000 (UTC)
Date: Fri, 14 Aug 2026 10:42:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] ring-buffer: Fix race between
 ring_buffer_subbuf_order_set() and readers
Message-ID: <20260814104208.28f47749@gandalf.local.home>
In-Reply-To: <178663777320.475864.4716637934003507750.stgit@devnote2>
References: <178663776361.475864.7685868697103378735.stgit@devnote2>
	<178663777320.475864.4716637934003507750.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 03D5680012
X-Stat-Signature: 8feun9cjyiscoa1eaiajd9qed5em3zpm
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/8hF0FAfIB+mBecBIO8JIxKH9aBvCIL5U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=5CyMVG30F2iZ8b/+HsMW0K3xks6dXu9lvQBrqsFrYOo=; b=EImOmhABDCcdn807WqaoZ6zNFiz6PGLl3xc106aUU4eSvv7vdKFSFCTiIvDOG8Z91lK+wTnxx1xxERSao1lTrHybVa/ZLf4syX4D8eCEI50wc0AU8nFJxKPYNQa/5rV77YBCQYLSz8KDtglTnYkTiBurNmqcE35aRDT3c1o3W4Q=
X-HE-Tag: 1786718514-210664
X-HE-Meta: U2FsdGVkX1/AYTNEPPbxdSrMB1dcmc0agQuTqg1ZXCkik5Rceyys3bGrqISTZkRurM/w88gMGsHQuf6Ie1dl4GnusPxt1gqQHCEjrjaSq7V2A+Zk8mZwDRKjBxj1x5Kttlo6ZrJZpPVh3Zt+uYVhwulOnvqy+9MO+BGkISC/ozh6k7dSJiVZr99p9DhF7OR31Ybw4I4FTkyewIYbSqvpmOuXLGDnh80UkLTngKfFEQ/R0RacVtejSMKom8QWIYxnQOG9X2HQwCh9D3It639ORLWaScgaJYH9iZxJOtSti0HBkleCpkoeUMux0CovB/UtwIxy3UkOzuqf4ZnHJLABQ0ODY9yBXrG4

On Fri, 14 Aug 2026 01:16:13 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> When ring_buffer_subbuf_order_set() updates buffer->subbuf_order, it
> previously modified buffer->subbuf_order before clearing the cached
> per-CPU free_page entries. Furthermore, clearing cpu_buffer->free_page
> was done under cpu_buffer->reader_lock, whereas
> ring_buffer_alloc_read_page() protects cpu_buffer->free_page using
> arch_spin_lock(&cpu_buffer->lock).
> 
> Because ring_buffer_alloc_read_page(), ring_buffer_free_read_page(),
> and ring_buffer_read_page() checked buffer->subbuf_order locklessly
> before accessing reader resources, a TOCTOU race allowed a concurrent
> reader to obtain, cache, or swap a page allocated under an outdated order
> while tagging bpage->order with the new order. This allowed undersized
> pages to be swapped into the ring buffer, leading to heap buffer overflows,
> or caused free_pages() to be called with an invalid order.
> 
> Fix this by:
> 1. Flushing and freeing all per-CPU cached free_page entries under
>    arch_spin_lock(&cpu_buffer->lock) using old_order before modifying
>    buffer->subbuf_order.
> 2. Protecting bpage->order assignment under
>    arch_spin_lock(&cpu_buffer->lock) in ring_buffer_alloc_read_page().
> 3. Moving the buffer->subbuf_order validation inside
>    arch_spin_lock(&cpu_buffer->lock) in ring_buffer_free_read_page().
> 4. Re-validating buffer->subbuf_order inside reader_lock in
>    ring_buffer_read_page().
> 5. Protecting cpu_buffer->free_page extraction with
>    arch_spin_lock(&cpu_buffer->lock) in ring_buffer_subbuf_order_set().
> 
> Fixes: 2808e31ec12e ("ring-buffer: Add interface for configuring trace sub buffer size")
> Assisted-by: Antigravity:gemini-3.6-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---


Please rebase on top of ring-buffer/for-next, as I added Vincent's patches to that.

>  kernel/trace/ring_buffer.c |   35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 2667992f0aa2..6d180689ad59 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6957,11 +6957,11 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
>  	if (!bpage)
>  		return ERR_PTR(-ENOMEM);
>  
> -	bpage->order = buffer->subbuf_order;
>  	cpu_buffer = buffer->buffers[cpu];
>  	local_irq_save(flags);
>  	arch_spin_lock(&cpu_buffer->lock);
>  
> +	bpage->order = buffer->subbuf_order;

This is still needed.

>  	if (cpu_buffer->free_page) {
>  		bpage->data = cpu_buffer->free_page;
>  		cpu_buffer->free_page = NULL;
> @@ -7010,13 +7010,13 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
>  	 * is different from the subbuffer order of the buffer -
>  	 * we can't reuse it
>  	 */
> -	if (page_ref_count(page) > 1 || data_page->order != buffer->subbuf_order)
> +	if (page_ref_count(page) > 1)
>  		goto out;
>  
>  	local_irq_save(flags);
>  	arch_spin_lock(&cpu_buffer->lock);
>  
> -	if (!cpu_buffer->free_page) {
> +	if (data_page->order == buffer->subbuf_order && !cpu_buffer->free_page) {

Swap the order please. It has to check both to continue and if one fails it
will not continue. Checking for cpu_buffer->free_page to be NULL first is
the quicker check. And also the more likely one to fail.

>  		cpu_buffer->free_page = dpage;
>  		dpage = NULL;
>  	}
> @@ -7094,15 +7094,15 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
>  	if (!data_page || !data_page->data)
>  		return -1;
>  
> -	if (data_page->order != buffer->subbuf_order)
> -		return -1;
> -
>  	dpage = data_page->data;
>  	if (!dpage)
>  		return -1;
>  
>  	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
>  
> +	if (data_page->order != buffer->subbuf_order)
> +		return -1;
> +
>  	reader = rb_get_reader_page(cpu_buffer);
>  	if (!reader)
>  		return -1;
> @@ -7350,6 +7350,27 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  	/* Make sure all commits have finished */
>  	synchronize_rcu();
>  
> +	/* Flush any cached free_page allocated with old_order */
> +	for_each_buffer_cpu(buffer, cpu) {
> +		struct buffer_data_page *old_free;
> +		unsigned long flags;
> +
> +		if (!cpumask_test_cpu(cpu, buffer->cpumask))
> +			continue;
> +
> +		cpu_buffer = buffer->buffers[cpu];
> +
> +		local_irq_save(flags);
> +		arch_spin_lock(&cpu_buffer->lock);
> +		old_free = cpu_buffer->free_page;
> +		cpu_buffer->free_page = NULL;
> +		arch_spin_unlock(&cpu_buffer->lock);
> +		local_irq_restore(flags);
> +
> +		if (old_free)
> +			free_pages((unsigned long)old_free, old_order);
> +	}

Honestly, this should be a separate patch. The first part of this patch is
data races with adding and freeing, but this is about changes to the size.

> +
>  	buffer->subbuf_order = order;
>  	buffer->subbuf_size = psize - BUF_PAGE_HDR_SIZE;
>  
> @@ -7431,8 +7452,10 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  		cpu_buffer->nr_pages = cpu_buffer->nr_pages_to_update;
>  		cpu_buffer->nr_pages_to_update = 0;
>  
> +		arch_spin_lock(&cpu_buffer->lock);
>  		old_free_data_page = cpu_buffer->free_page;
>  		cpu_buffer->free_page = NULL;
> +		arch_spin_unlock(&cpu_buffer->lock);

This is already fixed by Vincent (and I would have asked this to be a
separate patch too if it hadn't).

-- Steve

>  
>  		rb_head_page_activate(cpu_buffer);
>  

