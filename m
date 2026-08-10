Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8C93B42F1;
	Mon, 10 Aug 2026 22:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786400820; cv=none; b=e3nCigY63D6t3thZICFWX25c1tJR1vb+f2bfIPt2uvR6z5EBz000JPqoNEqxDACBsm2cS2QMME+/kmQYgoxZLBh1unc4vEgGGI40Q1M/WXEXyTjVY/SiNw+wJpsRw1GkzkUhrxJQzuEuiEOE+atuW60tRdkagFUzAZK96XzWRZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786400820; c=relaxed/simple;
	bh=ldlDnxFElbwISCwsRO66bpqVM7HP0acn21PsNVrRwSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WU+bqxu9yRb8/gXjeep5J5KsZcvZBOBSkuqgJprg+B4WBnaLJoOeukPEY6FRjxxO1pe71mjT2PhO37mraqfDri8JR9fLzxTL+r9va6hKxGFYS5f8RdBKZJCOGj6m325H0E8a30Qjue4kBao+ik9FKZ81NylWIJE1+AJFmmbw1qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A28511602D3;
	Mon, 10 Aug 2026 22:26:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id BAAF720025;
	Mon, 10 Aug 2026 22:26:53 +0000 (UTC)
Date: Mon, 10 Aug 2026 18:27:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 1/6] ring-buffer: Fix subbuf resize concurrency
Message-ID: <20260810182703.6b348465@gandalf.local.home>
In-Reply-To: <20260810125633.3344684-2-vdonnefort@google.com>
References: <20260810125633.3344684-1-vdonnefort@google.com>
	<20260810125633.3344684-2-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BAAF720025
X-Stat-Signature: rfz4o4fbau7b9n3xdbajy48knxtskspj
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/b3OHMry5iavDY+0eGbXFbQU3PtvlQYC0=
X-HE-Tag: 1786400813-670061
X-HE-Meta: U2FsdGVkX1+ZXu3K4ZGyhd9Sc14u5aRh5/Gc7/jAU1BUZ/OfIdPI/stVpxbyvGIhPsbRsVcd412OHCUCPCOMrXiTa+f2T+RgwaRVTJHxw8qfdawKHglgBlKrA/3JE1WLlqJZ66IC7jJfjmLglUmMjaYEboo6wQMx37669p58STed5SZtp4pnnr6ZM6+gAHX5MYXs8CG5W6XAEfJz9OGG+ob6NEVOjenLm+UMxKCtaNT2oCwmNkfkG6EHk7MmoCloPAiMX31TsSdrgfKoYX3U2S68YZBnFRp/30n6Ebtxy8mbJgNZP64sUtuAPIRz7AjGtCLU1YBS+/fT+5GVApyONh8eSbZdz845

On Mon, 10 Aug 2026 13:56:28 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:



> +static __always_inline unsigned int rb_subbuf_size(struct trace_buffer *buffer)
> +{
> +	return PAGE_SIZE << buffer->subbuf_order;
> +}



> @@ -3513,7 +3524,7 @@ rb_event_index(struct ring_buffer_per_cpu *cpu_buffer, struct ring_buffer_event
>  {
>  	unsigned long addr = (unsigned long)event;
>  
> -	addr &= (PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1;
> +	addr &= (unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1;

This one is fine because it already sits in a helper function.

>  
>  	return addr - BUF_PAGE_HDR_SIZE;
>  }

> @@ -4102,7 +4113,7 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
>  	new_index = rb_event_index(cpu_buffer, event);
>  	old_index = new_index + rb_event_ts_length(event);
>  	addr = (unsigned long)event;
> -	addr &= ~((PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1);
> +	addr &= ~((unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1);
>  
>  	bpage = READ_ONCE(cpu_buffer->tail_page);
>  

> @@ -5012,7 +5023,7 @@ rb_decrement_entry(struct ring_buffer_per_cpu *cpu_buffer,
>  	struct buffer_page *bpage = cpu_buffer->commit_page;
>  	struct buffer_page *start;
>  
> -	addr &= ~((PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1);
> +	addr &= ~((unsigned long)rb_subbuf_size(cpu_buffer->buffer) - 1);
>  
>  	/* Do the likely case first */
>  	if (likely(bpage->page == (void *)addr)) {


I really hate the above open coded typecasting to get the address correct.
Seems very fragile to me. As it is getting the address of the sub buffer,
let's add another helper function:

/**
 * rb_subbuf_addr - Return the address of the start of a subbuffer
 * @cpu_buffer: The cpu buffer that @addr is on
 * @addr: An address of an event on a subbuffer
 *
 * Returns: The start of the subbuffer for where @addr sits
 */
static __always_inline unsigned long rb_subbuf_addr(struct ring_buffer_per_cpu *cpu_buffer,
						    unsigned long addr)
{
	return addr & ~((unsigned long)(rb_subbuf_size(cpu_buffer->buffer) - 1));
}

And use that for these locatons.

-- Steve
