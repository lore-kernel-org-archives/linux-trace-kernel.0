Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794960030;
	b=aafEPqGy8qpaJvwOMfe5RK33jUo/UjdOC/dIeQTERFDoFNpSqW/Z55cGn5yd7XkIya9U
	 W2OoZp5bBEecjM32TLk8iUcMPpXU9l4qihWEHoHTCB1k4faa0cpxjiuJumepNps7ep28a
	 wKHECEQrt1AyKKHk2x/Cjt0yv+Y8a62gjuybs6WzM9KxytFespquishq9zAGEBmMYzPJr
	 6ImzTzcG+1eb7mmrqccYxRBf0/FysEzgrWOjlAtVd+d/f+kKdB2gaG9tiAtyAmbLO6IkX
	 JHpPFHjBbbv+lrczRnCwrtEzPzkf4s2jgS8JNQWhLPIcDXXCdJz84vpzfAJVEol2yWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794960030;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=bclIWZ6FX0mX08OYKuqV5M5iFQvVjJ51ZeOco2b+exc=;
	b=aA25LIBicM2u+HKX5AXfvBvq/jVrbXGApcaYOfn4EHBbaRXnwC2WkF4S8fQwS+MawTtu
	 QsUNDEXHBYjhbUtUZtgNQFYXHHiNnccKRgRalUWZhmF5zL+qCeDZWBCgVwOCEk7iTY65N
	 sQKXq6Qyth0sKMxmlnUOtnSkIz04/T3HWnGhBPl5ycMaUqUOoRNfH5FEyxMCvkBqhG8o8
	 l2+NbchVuezip1SS/5QuCdg/zRL/PNfo8kuwmd8QB+7Z5T0Iogkka4CTZmE5dxQt1eQAs
	 vxEcUfWVBmvvyhz2LYa/H6p9p7ZU3ZWhU2H3UjXsKmL2Rrm6QqUUtuDWFhQKlm6XDMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=O0y8IEfs;
	arc=none smtp.remote-ip=95.215.58.181
Received: from mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B58606A32C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 00:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3B58606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=O0y8IEfs
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LfZWu2kDl00YJ8hzTGAr/QsVPZ0HXBKeCp53dE5Im/c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794960026; v=1; x=1795564826;
 b=O0y8IEfsOoJRQCQ7xQIuUqvj9rU7PKozSy/jaDvl9s3OiFU//Nl+JprWKvUyAaPcRPGMCV+2
 qLOhKKLvj4OIJ3qNqrVbvvTT8IkqEd1cRig9QI8gc6JPJLtXfrKzXBzjWVXbP9cWiVA62doebro
 WhTw9Y4FcjcPVBCDW0zrgTNM=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f54fc8da450d0984;
	Wed, 18 Nov 2026 00:00:25 +0000
X-Mizu-Trace-ID: f54fc8da450d0984
X-Migadu-Flow: FLOW_OUT
Message-ID: <8130b695-c281-46e9-bfdd-e4873046c36d@linux.dev>
Date: Tue, 17 Nov 2026 16:00:21 -0800
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, andrii@kernel.org, peterz@infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
References: <20261021174406.2891598-1-vineet.gupta@linux.dev>
 <20261021174406.2891598-2-vineet.gupta@linux.dev>
 <20261117185645.628de864@gandalf.local.home>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20261117185645.628de864@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/26 3:56 PM, Steven Rostedt wrote:
> On Wed, 21 Oct 2026 10:44:05 -0700
> Vineet Gupta <vineet.gupta@linux.dev> wrote:
>
>> smp_store_release() is a drop-in replacement for the smp_wmb() and
>> plain store it replaces.
> This should be added with that, but I can just add it as a separate patch.

Thx for that. Let me know if you need me to do anything.

-Vineet

>
> -- Steve
>
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index bbf6e4e2da2d..d32160a6b835 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -568,7 +568,11 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
>   	if (unlikely(ftrace_graph_is_dead()))
>   		return -EBUSY;
>   
> -	if (!current->ret_stack)
> +	/*
> +	 * We must make sure the ret_stack is tested before we read
> +	 * anything else (See alloc_retstack_tasklist()).
> +	 */
> +	if (!smp_load_acquire(&current->ret_stack))
>   		return -EBUSY;
>   
>   	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
> @@ -576,12 +580,6 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
>   	/* Set val to "reserved" with the delta to the new fgraph frame */
>   	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
>   
> -	/*
> -	 * We must make sure the ret_stack is tested before we read
> -	 * anything else.
> -	 */
> -	smp_rmb();
> -
>   	/*
>   	 * Check if there's room on the shadow stack to fit a fraph frame
>   	 * and a bitmap word.

