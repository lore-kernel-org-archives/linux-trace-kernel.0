Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F694F68D7;
	Mon, 28 Sep 2026 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635448; cv=none; b=rjP44wk0TxNHashk0sxSNs55SHL5pZPlnAxfP0nYCy5aOUEKGqQouVseoSHvltduxeryqYQcUbsA33Nndiwx2nus5vXlPWoCSznuip1XpnwpjIUqWrmfyiXBwEzHy6ZNNmo7Y7L5iUo5FmXVrF+DiMbqxbairCB4OMZnQpSYL0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635448; c=relaxed/simple;
	bh=c/KFS7hUG8A6eH7V/ezC0lFOknO5e1AjSx/NtFlrUbs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ad7SazeEf0KCdqGtHnbR+z80pb1VXw8aTeaReadqIYzwMOfeGolrTYMp7B1TS7VgBK5jHiwM7dw9fuwqCT9Q2z3pHZM31vwP79RVlrNpQky55bcbpHtlVKecswKge2Y0xlmrGsX1reVfALwblGllzleWPWAbqqzlqr6NVPzjMUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b3LngdvW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b3LngdvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F211F000FF;
	Mon, 28 Sep 2026 22:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790635446;
	bh=rjEgoglMKqLzn5d7BwhZmkWidKv2Uh0Zq7425Gyxqg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b3LngdvWvHsyd623puQimLNdjJxwVFIs72j1Cxn0njCiVb4QhWWB1hxgOZ2A+itVu
	 KEN5DTMU93z3OBbXrBaMJxAyS1gDPMZI4rjnO7Lpnt5xfBKURhLLN00gHdqm3g60vG
	 P3ILVq4bF+WXsw6a43Mf+68EjnlOW+wTm8mGhZ/I=
Date: Mon, 28 Sep 2026 15:44:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shashank Mohan Jain <jain.sm@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Matt Wu
 <wuqiang.matt@bytedance.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] objpool: keep objpool_push() correct when a push
 from NMI nests in it
Message-Id: <20260928154405.fc2e650ef162f53d9d8e4d0a@linux-foundation.org>
In-Reply-To: <20260928084125.67104-2-jain.sm@gmail.com>
References: <20260928084125.67104-1-jain.sm@gmail.com>
	<20260928084125.67104-2-jain.sm@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 14:11:24 +0530 Shashank Mohan Jain <jain.sm@gmail.com> wrote:

> objpool_push() adds an object to the slot of the local CPU with
> interrupts disabled. It reserves an entry with a cmpxchg() on
> slot->tail, writes the entry, and publishes it with
> smp_store_release(&slot->last, tail + 1).
> 
> A push from NMI context can still interrupt it and push to the same
> slot. kretprobes may run in NMI context since commit e03b4a084ea6
> ("kprobes: Remove NMI context check"). At the time, kretprobe instances
> came from a CAS-based lockless freelist, which tolerates that. Commit
> 4bbd93455659 ("kprobes: kretprobe scalability improvement") moved
> kretprobes and rethook to objpool.
> 
> With rethook, rethook_trampoline_handler() recycles instances with
> objpool_push() after the user handler has run, when no kprobe is marked
> running anymore; rethook_flush_task() does the same. An NMI that arrives
> during such a push and runs a function probed by the same kretprobe takes
> an instance in pre_handler_kretprobe(), and when the function returns
> inside the NMI, pushes it back to the same slot. This needs a kretprobe
> on a function that runs both in NMI context and outside it, for instance
> one that perf calls from the PMU NMI handler on x86. Before v6.14, fprobe
> also used rethook and could push from NMI the same way, with one pool
> shared by all functions of an fprobe.
> 
> ...
>
> Publish the entries in order instead:

Thanks.

> --- a/include/linux/objpool.h
> +++ b/include/linux/objpool.h
> @@ -193,19 +193,40 @@ __objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
>  	struct objpool_slot *slot = pool->cpu_slots[cpu];
>  	uint32_t head, tail;
>  
> -	/* loading tail and head as a local snapshot, tail first */
> +	/*
> +	 * Only the local CPU pushes to its slot, with irqs disabled, but a
> +	 * push from NMI context (a kretprobe'd function returning in NMI)
> +	 * can interrupt this one at any point.
> +	 */
>  	tail = READ_ONCE(slot->tail);
> +	while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1))
> +		;
>  
> -	do {
> -		head = READ_ONCE(slot->head);
> -		/* fault caught: something must be wrong */
> -		WARN_ON_ONCE(tail - head > pool->nr_objs);
> -	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
> +	/*
> +	 * fault caught: something must be wrong.  Read head only after the
> +	 * reservation: a nested push and a pop on another CPU could have
> +	 * moved head past an older snapshot of tail.
> +	 */
> +	head = READ_ONCE(slot->head);
> +	WARN_ON_ONCE(tail - head > pool->nr_objs);

This code can run in NMI?

Calling WARN_ON from NMI sounds quite sketchy - the warning handler
does all sorts of stuff.  I see this is pre-existing but perhaps this
is a chance to address it.

Sashiko liked [1/2] but had a lot to say about the test module:
	https://sashiko.dev/#/patchset/20260928084125.67104-1-jain.sm@gmail.com
