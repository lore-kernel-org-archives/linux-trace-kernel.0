Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525721C16A;
	Mon,  3 Aug 2026 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785797358; cv=none; b=uT3BA4GOTf58lS9+Gv8l3tg87SAxIJd8bTQU1Y0v7db5Ri40TknHbUf/ubhm8y4wj+1offTYw0Iw1vVFCNbOS501QD2IU2jukbj7aHgwvA8BtCjQvPMn9gCxQKC84wlFW7TmcwJQlFxNJglECmQ8JW8+F+yN0EVTsk3FDvIDp14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785797358; c=relaxed/simple;
	bh=ASv9q3+xfLRGKOhSf7EjnwSfh468LoNVhgU5FT1wnyI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FUVdvzwrNqwL5Y3UYDBpWiMGY/1vVDV4lT5926rsPNMgqWm41p1UfIRNAL1a9W9XTLp8XxUx7E6Gz0/GCBZr1R7rQhMNBlx/AgvkTqzSdufickbXUk3mS4cPTlw825ms55O7GJFT9jMRdAwSsHIL4d1R8QCvsmlgkK1oSCIUyeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+Bjn1jH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+Bjn1jH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6E21F000E9;
	Mon,  3 Aug 2026 22:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785797357;
	bh=hb4MB0ev5cZX0v2JbE6xC67R9BeB4dvfLrD64khG9DU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I+Bjn1jHPLd4B0Vohh0kcxN4xjgd1lGAQ2+1y82l73ejCgDR/eK0s9HT0SqDMkiTM
	 faOnZlLoEB2CSRmPEZSBshoKqCStZQN9mp8DGTbbRGKtS2FB0GEhW+YSu1G+EB/NSX
	 60ix6PbbL0YTbCOdJNy0QwRCAAJ1zSQXh7kFnR1+vI6AUl2NDOCk1K5h4Hdvn9EaB9
	 rmIgFRG+Pv731QesOSExwuGC3F97TdGxJrVYeuCk94U6Y1KtZ4vFgcMqGSkG7dZ6JP
	 Jb/o0MmgjHt42/w85CZJWfqXA0Wa7jrABxLTNpUvdKl4n5Q0WHKM3ZUt7MXHGnZqkv
	 3GM7t2eBXpj1A==
Date: Tue, 4 Aug 2026 07:49:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Michael Wu <michael@allwinnertech.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tracing: Fix race between update_event_fields and,
 event_define_fields
Message-Id: <20260804074913.d5ffb39d70afc48aec556eb6@kernel.org>
In-Reply-To: <6c515e5f-66f4-0dc7-00f2-69f319c8ad87@allwinnertech.com>
References: <6c515e5f-66f4-0dc7-00f2-69f319c8ad87@allwinnertech.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 17:40:55 +0800
Michael Wu <michael@allwinnertech.com> wrote:

> event_define_fields() (pri=1 MODULE_STATE_COMING notifier, locked by
> event_mutex) populates class->fields via list_add(), while
> update_event_fields() (called from the pri=0 notifier path via
> trace_event_update_all) traverses class->fields protected only by
> trace_event_sem.  These are two different locks guarding the same
> data structure, so during cross-module loading a reader on one CPU can
> observe partially initialized list nodes being concurrently added by a
> writer on another CPU.
> 
> On arm64 with weak memory ordering, __list_add() writes to two
> different cache lines:
> 
>         next->prev = new;                // (1) ordinary store
>         new->next = next;                // (2) ordinary store
>         new->prev = prev;                // (3) ordinary store
>         WRITE_ONCE(prev->next, new);    // (4) release store
> 
> The store buffer can drain (2) and (4) independently since they target
> different cache lines.  A remote CPU may observe (4) before (2): it
> sees prev->next pointing to the new node, but the new node's link.next
> is still zero (kmem_cache_alloc zero-initialized via KMEM_CACHE with
> SLAB_PANIC).  Since offsetof(struct ftrace_event_field, link) == 0,
> list_for_each_entry() derives field == NULL from link.next == 0 and
> crashes at field->type (offset 0x18):
> 
>   Unable to handle kernel access ... at virtual address 0000000000000018
>   pc : update_event_fields+0xf8/0x368
>   Call trace:
>    update_event_fields+0xf8/0x368
>    trace_event_update_all+0x7c/0x2b4
>    trace_module_notify+0x4c/0x1dc
>    notifier_call_chain+0x84/0x168
>    blocking_notifier_call_chain_robust+0x64/0xd4
>    load_module+0x10c8/0x123c
>    __arm64_sys_finit_module+0x230/0x31c
> 
> Fix by holding event_mutex in trace_event_update_all() before
> down_write(&trace_event_sem).  This serializes the reader against
> event_define_fields() which takes event_mutex for the entire
> write-side critical section.  The lock ordering event_mutex ->
> trace_event_sem is already established at three other sites
> (trace_remove_event_call, event_trace_add_tracer,
> event_trace_del_tracer), so this introduces no ordering conflict.
> 
> An alternative of placing mutex_lock inside update_event_fields() was
> considered but rejected -- it would invert the established lock
> ordering (trace_event_sem -> event_mutex) and risk ABBA deadlock.
> 

Looks good to me!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Fixes: b3bc8547d3be ("tracing: Have TRACE_DEFINE_ENUM affect trace event types as well")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  kernel/trace/trace_events.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 956692856fa8..9632788da5af 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3566,6 +3566,7 @@ void trace_event_update_all(struct trace_eval_map **map, int len)
>  	int last_i;
>  	int i;
>  
> +	mutex_lock(&event_mutex);
>  	down_write(&trace_event_sem);
>  	list_for_each_entry_safe(call, p, &ftrace_events, list) {
>  		/* events are usually grouped together with systems */
> @@ -3604,6 +3605,7 @@ void trace_event_update_all(struct trace_eval_map **map, int len)
>  		cond_resched();
>  	}
>  	up_write(&trace_event_sem);
> +	mutex_unlock(&event_mutex);
>  }
>  
>  static bool event_in_systems(struct trace_event_call *call,
> -- 
> 2.29.0


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
