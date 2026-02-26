Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC425771;
	Thu, 26 Feb 2026 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110619; cv=none; b=G3CHUQnaGNSo5bMOYi/jggY9+ZNh+DBzxIwqWP3nUYa5MDIa25ZNSyLZ5/J6REqje33UyT5AWn2l2PUAO2yQGR/BkDbW1owYOpq+5jaCW5/ngDwKaJREWmiid1TY2ATpnCbV1QgpQk3GqinBgMH3+hkdE3QT20oIX+rgj+Yk/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110619; c=relaxed/simple;
	bh=28vwV37Zzv8vY7Xj+jR5X+7eWEaI0M112mDdqvWwpq0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qAIQUHoLSLU2ZEvSUeGJYH26AJl2jfYwu21k/2HGVHC9jyoWWzGZor8GXI05IhGuwlU/stRA/hpjh/c8Et5CDXNEZNum1UEh/nFl1GVMwiSaGqyWuaheaPeRambsmu3lEHWjkEQvEyoUD+oOOGHGSyYAbcJTaorXR5c3cb3oihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCqywI9D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCqywI9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229F7C116C6;
	Thu, 26 Feb 2026 12:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772110619;
	bh=28vwV37Zzv8vY7Xj+jR5X+7eWEaI0M112mDdqvWwpq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iCqywI9DkT3ja/mduMQD+XKeNenZG3Nq83S2ehimIwd0Qnxm42U7u0olgmx27BPJL
	 LjGVoQ/YRG2sA5rMDjKlm02qbqwpQhHrIbsu/USfSgxf5ij741iGxAE0XePdSDMk6X
	 ugGh4FEdt9OGwOmhsQxutQoE5JuWYiSDENcXY5fKTNPlDT39ydifz9Oj26u6XNiC7C
	 JCzrTHmKmlvpvQKs6QHbUBU6g9UEG3CQlPa6AcyDq7S0d7za9CRzrvtfEHsG9uGw6/
	 d7gES5WVsa0eHQVFwR/zai2Cx1ktW1KpTelydW72vBzEmBF6t30BnHuoLPcm7SRPMF
	 0ozFlUCbBzjIQ==
Date: Thu, 26 Feb 2026 21:56:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] ring-buffer: Flush and stop persistent ring
 buffer on panic
Message-Id: <20260226215656.7f4d5368393c417fd8da5a2f@kernel.org>
In-Reply-To: <177191596224.435720.8250761603256925623.stgit@mhiramat.tok.corp.google.com>
References: <177191595057.435720.10116014529518464418.stgit@mhiramat.tok.corp.google.com>
	<177191596224.435720.8250761603256925623.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Feb 2026 15:52:42 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> On real hardware, panic and machine reboot may not flush hardware cache
> to memory. This means the persistent ring buffer, which relies on a
> coherent state of memory, may not have its events written to the buffer
> and they may be lost. Moreover, there may be inconsistency with the
> counters which are used for validation of the integrity of the
> persistent ring buffer which may cause all data to be discarded.
> 
> To avoid this issue, stop recording of the ring buffer on panic and
> flush the cache of the ring buffer's memory.
> 
> Fixes: e645535a954a ("tracing: Add option to use memmapped memory for trace boot instance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v3:
>    - update patch description.
> ---
>  kernel/trace/ring_buffer.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index f16f053ef77d..3eb124c93d72 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6,6 +6,7 @@
>   */
>  #include <linux/sched/isolation.h>
>  #include <linux/trace_recursion.h>
> +#include <linux/panic_notifier.h>
>  #include <linux/trace_events.h>
>  #include <linux/ring_buffer.h>
>  #include <linux/trace_clock.h>
> @@ -589,6 +590,7 @@ struct trace_buffer {
>  
>  	unsigned long			range_addr_start;
>  	unsigned long			range_addr_end;
> +	struct notifier_block		flush_nb;
>  
>  	struct ring_buffer_meta		*meta;
>  
> @@ -2471,6 +2473,16 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
>  	kfree(cpu_buffer);
>  }
>  
> +static int rb_flush_buffer_cb(struct notifier_block *nb, unsigned long event, void *data)
> +{
> +	struct trace_buffer *buffer = container_of(nb, struct trace_buffer, flush_nb);
> +
> +	ring_buffer_record_disable(buffer);

I found this was a wrong API. I have to use ring_buffer_record_off().

> +	flush_kernel_vmap_range((void *)buffer->range_addr_start,
> +				buffer->range_addr_end - buffer->range_addr_start);

This does nothing on arm64.



Thanks,

> +	return NOTIFY_DONE;
> +}
> +
>  static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
>  					 int order, unsigned long start,
>  					 unsigned long end,
> @@ -2590,6 +2602,12 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
>  
>  	mutex_init(&buffer->mutex);
>  
> +	/* Persistent ring buffer needs to flush cache before reboot. */
> +	if (start & end) {
> +		buffer->flush_nb.notifier_call = rb_flush_buffer_cb;
> +		atomic_notifier_chain_register(&panic_notifier_list, &buffer->flush_nb);
> +	}
> +
>  	return_ptr(buffer);
>  
>   fail_free_buffers:
> @@ -2677,6 +2695,9 @@ ring_buffer_free(struct trace_buffer *buffer)
>  {
>  	int cpu;
>  
> +	if (buffer->range_addr_start && buffer->range_addr_end)
> +		atomic_notifier_chain_unregister(&panic_notifier_list, &buffer->flush_nb);
> +
>  	cpuhp_state_remove_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
>  
>  	irq_work_sync(&buffer->irq_work.work);
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
