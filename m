Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78082230BD5;
	Fri, 31 Jul 2026 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785457625; cv=none; b=meNdwDB66uSsL25MgCHlpNiqehOmnSXnMe6lH/9PbjMibwGkkAuPQ8FwELngYGyHtdyfcDcRapF4gel3ltMUH+AfEH0mDEPsL8i7lTK60Gprxak/H3mSY9y98sGhVSmzsaC9FYPq2kCpj41oDczPaiHm3VsztjeF2Bg5ayvqh50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785457625; c=relaxed/simple;
	bh=GsAeSXPb/i0tQwsqsCLE+eQ0ByBWcYcY6nJsp270jLE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=d1mawDMGJu/mtlj07L9wi5c2z4uEel5ZIfbmMjU/RZFlrwbbAxhkfMaMH3aXTNuzWNy3ib1VfPlq5X00tyJArHJZ58GNYcceQwgHy31uPlHE86rXohdnOyeL6ilNfMafQr4oOL9bdvlg50GjB4ByfKWXEMmYAZHkyV415puxG+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeKocfuk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeKocfuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806471F000E9;
	Fri, 31 Jul 2026 00:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785457624;
	bh=gl1PAht9zZ/yejPkp7VZqU/MURfNgRRuRRye82hpQOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SeKocfukZKCk6+kvVnAs5b9RkfWRqOQ1kvNeHvel/Jv9eQydDwSrG5QxuB5bia8Xz
	 oJ2Af33/xG//+xbdyYWsyau7G/E4oqF1k5aCy5zv8UZu3Oh/gLiiKL4uaw9i+ktj/b
	 Ut1S5RZeAlqiiBJc4Qd1mrAlcS/HGiwpwJD4AcFR0QhFl0JcVseedxnixHNKUJU6nf
	 x02FaAZyf0XGHrfrEsxymCsi3SRS+RdoQzqz7YwXjTQH3Zbm3BNp6LG6UeAsZ1WMWp
	 kg/fezIasZtItT9koTn24s4SFKN2mfpkt0lY+OE/9cMTIeOqTCEwh9wvt7D//7GWpo
	 3q8/G/2bmShPA==
Date: Fri, 31 Jul 2026 09:26:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Michael Wu <michael@allwinnertech.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] tracing: Fix race between update_event_fields and
 event_define_fields
Message-Id: <20260731092659.af05c03f86e827d3ab45672f@kernel.org>
In-Reply-To: <08216429-43ba-efc2-f6b1-459210d07b02@allwinnertech.com>
References: <8147bb04-b890-f18a-9cab-48b712f54856@allwinnertech.com>
	<20260730173157.e756d8a021d827b7aa9686cf@kernel.org>
	<9613182c-6299-3c68-5afb-2bf8d9f90f03@allwinnertech.com>
	<08216429-43ba-efc2-f6b1-459210d07b02@allwinnertech.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 30 Jul 2026 19:13:28 +0800
Michael Wu <michael@allwinnertech.com> wrote:

> Hi Masami,
>    Thanks for the review. I've rebased the patch. The new version is below.

As Steve said, please send a clean patch mail (as a new thread) instead
of embedding it in the mail. Embedding patch is just for testing, not
for merging.

Thank you,

> 
> ---
>  From ec00b31c58b56f4cbbe6dd67c9f88a1d87d8d5ac Mon Sep 17 00:00:00 2001
> From: Michael Wu <michael@allwinnertech.com>
> Date: Wed, 29 Jul 2026 17:34:09 +0800
> Subject: [PATCH v2] tracing: Fix race between update_event_fields and
>   event_define_fields
> 
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
> Fixes: b3bc8547d3be ("tracing: Have TRACE_DEFINE_ENUM affect trace event 
> types as well")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
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
> On 7/30/2026 6:54 PM, Michael Wu wrote:
> > event_define_fields() (pri=1 MODULE_STATE_COMING notifier, locked by
> > event_mutex) populates class->fields via list_add(), while
> > update_event_fields() (called from the pri=0 notifier path via
> > trace_event_update_all) traverses class->fields protected only by
> > trace_event_sem.  These are two different locks guarding the same
> > data structure, so during cross-module loading a reader on one CPU can
> > observe partially initialized list nodes being concurrently added by a
> > writer on another CPU.
> > 
> > On arm64 with weak memory ordering, __list_add() writes to two
> > different cache lines:
> > 
> >          next->prev = new;                // (1) ordinary store
> >          new->next = next;                // (2) ordinary store — 
> > field's cache line
> >          new->prev = prev;                // (3) ordinary store
> >          WRITE_ONCE(prev->next, new);    // (4) release store — head's 
> > cache line
> > 
> > The store buffer can drain (2) and (4) independently since they target
> > different cache lines.  A remote CPU may observe (4) before (2): it
> > sees prev->next pointing to the new node, but the new node's link.next
> > is still zero (kmem_cache_alloc zero-initialized via KMEM_CACHE with
> > SLAB_PANIC).  Since offsetof(struct ftrace_event_field, link) == 0,
> > list_for_each_entry() derives field == NULL from link.next == 0 and
> > crashes at field->type (offset 0x18):
> > 
> >    Unable to handle kernel access ... at virtual address 0000000000000018
> >    pc : update_event_fields+0xf8/0x368
> >    Call trace:
> >     update_event_fields+0xf8/0x368
> >     trace_event_update_all+0x7c/0x2b4
> >     trace_module_notify+0x4c/0x1dc
> >     notifier_call_chain+0x84/0x168
> >     blocking_notifier_call_chain_robust+0x64/0xd4
> >     load_module+0x10c8/0x123c
> >     __arm64_sys_finit_module+0x230/0x31c
> > 
> > Fix by holding event_mutex in trace_event_update_all() before
> > down_write(&trace_event_sem).  This serializes the reader against
> > event_define_fields() which takes event_mutex for the entire
> > write-side critical section.  The lock ordering event_mutex ->
> > trace_event_sem is already established at three other sites
> > (trace_remove_event_call, event_trace_add_tracer,
> > event_trace_del_tracer), so this introduces no ordering conflict.
> > 
> > An alternative of placing mutex_lock inside update_event_fields() was
> > considered but rejected — it would invert the established lock
> > ordering (trace_event_sem -> event_mutex) and risk ABBA deadlock.
> > 
> > Fixes: b3bc8547d3be ("tracing: Have TRACE_DEFINE_ENUM affect trace event 
> > types as well")
> > Cc: stable@vger.kernel.org
> > ---
> >   kernel/trace/trace_events.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 956692856fa8..9632788da5af 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -3566,6 +3566,7 @@ void trace_event_update_all(struct trace_eval_map 
> > **map, int len)
> >       int last_i;
> >       int i;
> > 
> > +    mutex_lock(&event_mutex);
> >       down_write(&trace_event_sem);
> >       list_for_each_entry_safe(call, p, &ftrace_events, list) {
> >           /* events are usually grouped together with systems */
> > @@ -3604,6 +3605,7 @@ void trace_event_update_all(struct trace_eval_map 
> > **map, int len)
> >           cond_resched();
> >       }
> >       up_write(&trace_event_sem);
> > +    mutex_unlock(&event_mutex);
> >   }
> > 
> >   static bool event_in_systems(struct trace_event_call *call,
> 
> 
> -- 
> Regards,
> Michael Wu


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
