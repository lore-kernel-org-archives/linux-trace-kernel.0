Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30843CA49C;
	Thu, 30 Jul 2026 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400328; cv=none; b=FYcZ2y5rK8O66OTZjyhygvtu9z7WI0pBaifzJS1RQsyBybaYrJ36qgkAdrfJyD0/IClLtJ4VAcC8TZgjS4I8H1clxRMrEUd75OUTVH5sKBYYahvgRQOlfjncNMNn2ahdRTavrO89td6pbJ03yhwLu5WBSuOSJdnBo3jE5qvsMso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400328; c=relaxed/simple;
	bh=/21bkUVrgRqLyj+ULObxWwj2Mdd33FtaRa+VRWu1dkM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hnGtlIkFscUF0LZf51a22SWGNmSneEP4R3ZtN5AH1tFn4CBCyPxE5HAQ7O2+HciGZ6o1o83Mj3Pfz7U0PBE2/wFP2EyT2K0ZhsOaHbw78NTKWA/ncElUdm22Ag2WgIMQ4fXtpFZvjJRno40MvQZ4RqbC/KuiA3Tdz63+oH1Fgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVbgNngJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVbgNngJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF071F000E9;
	Thu, 30 Jul 2026 08:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785400322;
	bh=+ciy7RhxB0nKlW7gjxcZOYF4/e1S7oQ3xtx6WgxuYNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iVbgNngJqc5tIRQC6maKOkTUUWCOnOHAxilUpvwAPaPF1WGOMMnNpOFDLah9u3slR
	 UN+JFDOq6S3/YwyIybdaXuNIoAx++R0XVu/aH9z0TAZnYUl5XL0IV8+V/6nOQUNSWj
	 PZoSXs3axKstTxROFKByIGg1L4rvWMA1bgXkQK/G6rbeHn2omoz8dp2xwXtcgPnEKP
	 lPoii4f6EHWbULArNzNP4B+TLeZx/8hkuVz4a/A7YrmgEqPJzhH28RWQ+6tQ20AYN1
	 OF0OkGOBqAj8v1sGGOpCMI6+r5OU3oekWt4oO21ddcbL4KFM7wugpmNBVfLThQTrwD
	 jQreBykej6qOg==
Date: Thu, 30 Jul 2026 17:31:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Michael Wu <michael@allwinnertech.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix race between update_event_fields and
 event_define_fields
Message-Id: <20260730173157.e756d8a021d827b7aa9686cf@kernel.org>
In-Reply-To: <8147bb04-b890-f18a-9cab-48b712f54856@allwinnertech.com>
References: <8147bb04-b890-f18a-9cab-48b712f54856@allwinnertech.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Michael,

On Thu, 30 Jul 2026 13:37:59 +0800
Michael Wu <michael@allwinnertech.com> wrote:

> Kernel: Linux version 6.18.21
> Platform: Android

We will accept the patch which is for the upstream kernel here.
Can you rebase the patch on top of trace/fixes branch of 
https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
or linus tree?

> 
> event_define_fields() (pri=1 MODULE_STATE_COMING notifier, locked by
> event_mutex) populates class->fields via list_add(), while
> update_event_fields() (called from the pri=0 notifier path via
> trace_event_update_all) traverses class->fields protected only by
> trace_event_sem.  These are two different locks guarding the same
> data structure, so during cross-module loading a reader on one CPU can
> observe partially initialized list nodes being concurrently added by a
> writer on another CPU.

I confirmed this is still valid on upstream kernel.
I have some comments, see below;

> 
> On arm64 with weak memory ordering, __list_add() writes to two
> different cache lines:
> 
>          next->prev = new;                // (1) ordinary store
>          new->next = next;                // (2) ordinary store — 
> field's cache line
>          new->prev = prev;                // (3) ordinary store
>          WRITE_ONCE(prev->next, new);    // (4) release store — head's 
> cache line
> 
> The store buffer can drain (2) and (4) independently since they target
> different cache lines.  A remote CPU may observe (4) before (2): it
> sees prev->next pointing to the new node, but the new node's link.next
> is still zero (kmem_cache_alloc zero-initialized via KMEM_CACHE with
> SLAB_PANIC).  Since offsetof(struct ftrace_event_field, link) == 0,
> list_for_each_entry() derives field == NULL from link.next == 0 and
> crashes at field->type (offset 0x18):
> 
>    Unable to handle kernel access ... at virtual address 0000000000000018
>    pc : update_event_fields+0xf8/0x368
>    Call trace:
>     update_event_fields+0xf8/0x368
>     trace_event_update_all+0x7c/0x2b4
>     trace_module_notify+0x4c/0x1dc
>     notifier_call_chain+0x84/0x168
>     blocking_notifier_call_chain_robust+0x64/0xd4
>     load_module+0x10c8/0x123c
>     __arm64_sys_finit_module+0x230/0x31c
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
> considered but rejected — it would invert the established lock
> ordering (trace_event_sem -> event_mutex) and risk ABBA deadlock.
> 

Also add:

Fixes: b3bc8547d3be ("tracing: Have TRACE_DEFINE_ENUM affect trace event types as well")
Cc: stable@vger.kernel.org

Thank you,

> Signed-off-by:  Michael Wu <michael@allwinnertech.com>
> ---
>   kernel/trace/trace_events.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 956692856fa8..9632788da5af 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3566,6 +3566,7 @@ void trace_event_update_all(struct trace_eval_map 
> **map, int len)
>   	int last_i;
>   	int i;
> 
> +	mutex_lock(&event_mutex);
>   	down_write(&trace_event_sem);
>   	list_for_each_entry_safe(call, p, &ftrace_events, list) {
>   		/* events are usually grouped together with systems */
> @@ -3604,6 +3605,7 @@ void trace_event_update_all(struct trace_eval_map 
> **map, int len)
>   		cond_resched();
>   	}
>   	up_write(&trace_event_sem);
> +	mutex_unlock(&event_mutex);
>   }
> 
>   static bool event_in_systems(struct trace_event_call *call,
> -- 
> 2.29.0
> 
> 
> -- 
> Regards,
> Michael Wu


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
