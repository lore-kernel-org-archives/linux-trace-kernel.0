Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78331ED81;
	Fri,  6 Mar 2026 02:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763280; cv=none; b=Gj39U3E45Ye3neLrUGN5SNr+41QVdlyZhT4xcYJ7wAihFu4kZ3ApThVFJK76SQSKg2l0LU32hj7DS0F3ETBvXsaoUkQrY+ndVrSOpuG1rYzhUc6ulSAwdAhg+t2VVAIJa1BdgClwxaypL9rJaOIwimNgvi2osM1dabKWlQoOP/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763280; c=relaxed/simple;
	bh=/vsEfLMWoC9w+0JTI7OEhhNQUDZVxFeaVWbLyvCfgak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Frm6yELiYoGnlaGzIaSwhwdf+GZXxoOYNn+0vysv+fJBR+1dKd3O20QY5DH45OTJb2qGCxomoml1iEB5kBLg26mWh+fySE3YuMqUYVWGjFbfdfdBdBEgKVNvkTnfu6/G7EyTNvbHdlj2PGX/CYJuI6ZFuw6XqX+LOcA5DHIOGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id EF01358584;
	Fri,  6 Mar 2026 02:14:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 066D934;
	Fri,  6 Mar 2026 02:14:34 +0000 (UTC)
Date: Thu, 5 Mar 2026 21:14:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <sashal@kernel.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix use-after-free race in copy_trace_marker
 on instance removal
Message-ID: <20260305211433.68bfc6c8@robin>
In-Reply-To: <20260225133122.237275-1-sashal@kernel.org>
References: <20260225133122.237275-1-sashal@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 066D934
X-Stat-Signature: np7id78aybmauaddztnhhwp7xjstgpmu
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/V36+fB9OOn05m/x+KTezeslVHB0jZUks=
X-HE-Tag: 1772763274-810152
X-HE-Meta: U2FsdGVkX1+gnE/9tPmvv0gbbxdkcnj+RIoCwd7rXwT+JtEfQFw92ZT0TGVfYfLlWaPtuc2O1B5ZzxauAbBp6WdpXZSzo6WeQk3F9Oec6HOpip9LvUh5VABgtzYxb2AkVG+mai08x92egwsczZKYm90hNjBUlTXif9oMuqtLCC6xBoA2XgWM24LKRk1r8WxueYSMF00/t7FM+Ub5mCD0RxTEUC6U0O0JgyB6E4fXOdkTOQbroltTtaUSiml4PLQ11FFqIVbLcO2RHug0Fuq6uDgiHc2TMcvbCqdaKaQQdoC+gjv6ypvkKoHWOGLRZGfzcsvCXMBSCbC4TyuXVu+eI1qcrXhMe3yE

On Wed, 25 Feb 2026 08:31:22 -0500
Sasha Levin <sashal@kernel.org> wrote:

> When a trace instance with copy_trace_marker enabled is removed,
> __remove_instance() first iterates ZEROED_TRACE_FLAGS (which includes
> COPY_MARKER), calling set_tracer_flag() -> update_marker_trace(tr, 0).
> This removes the instance from the marker_copies RCU list via
> list_del_init() and returns immediately.

Hmm, did the AI write the change log too?

It breaks things as much as it fixes.

> 
> The subsequent explicit update_marker_trace(tr, 0) call then finds
> list_empty(&tr->marker_list) is true and returns false, causing
> synchronize_rcu() to be skipped. The ring buffer and trace_array are
> then freed while a concurrent writer in tracing_mark_write() may still
> hold an RCU-protected reference, leading to use-after-free.
> 
>   BUG: KASAN: slab-use-after-free in write_marker_to_buffer+0x1e7/0x610 kernel/trace/trace.c:6527
>   Write of size 4054 at addr ffff888103af7058 by task syz.0.277/5019
> 
>   CPU: 3 UID: 0 PID: 5019 Comm: syz.0.277 Tainted: G                 N  7.0.0-rc1-00001-gc5447a46efed #51 PREEMPT(full)
>   Tainted: [N]=TEST
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
>   Call Trace:
>    <TASK>
>    __dump_stack lib/dump_stack.c:94 [inline]
>    dump_stack_lvl+0xba/0x110 lib/dump_stack.c:120
>    print_address_description mm/kasan/report.c:378 [inline]
>    print_report+0x156/0x4d9 mm/kasan/report.c:482
>    kasan_report+0xf6/0x1f0 mm/kasan/report.c:595
>    check_region_inline mm/kasan/generic.c:186 [inline]
>    kasan_check_range+0x125/0x200 mm/kasan/generic.c:200
>    __asan_memcpy+0x3c/0x60 mm/kasan/shadow.c:106
>    write_marker_to_buffer+0x1e7/0x610 kernel/trace/trace.c:6527
>    tracing_mark_write+0x218/0x3f0 kernel/trace/trace.c:6875
>    vfs_write+0x2b7/0x1070 fs/read_write.c:686
>    ksys_write+0x1f8/0x250 fs/read_write.c:740
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0xf3/0x700 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   RIP: 0033:0x7fdb7eb9df29
>   Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48
>    c7 c1 e8 ff ff ff f7 d8 64 89 01 48
>   RSP: 002b:00007fdb7fa81008 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>   RAX: ffffffffffffffda RBX: 00007fdb7ee15fa0 RCX: 00007fdb7eb9df29
>   RDX: 0000000000001000 RSI: 0000200000000300 RDI: 0000000000000003
>   RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>   R13: 00007ffec21bfd06 R14: 00007fdb7fa81ce4 R15: 00007fdb7fa61000
>    </TASK>
> 
>   The buggy address belongs to the physical page:
>   page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffffffffffffffff pfn:0x103af7
>   flags: 0x200000000000000(node=0|zone=2)
>   raw: 0200000000000000 0000000000000000 dead000000000122 0000000000000000
>   raw: ffffffffffffffff 0000000000000000 00000001ffffffff 0000000000000000
>   page dumped because: kasan: bad access detected
> 
>   Memory state around the buggy address:
>    ffff888103af7f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    ffff888103af7f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   >ffff888103af8000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb  
>                      ^
>    ffff888103af8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
>    ffff888103af8100: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
> 
> Fix this by:
> 
> 1. Removing TRACE_ITER(COPY_MARKER) from ZEROED_TRACE_FLAGS so the flag
>    loop doesn't pre-clear it. The explicit update_marker_trace(tr, 0) +
>    synchronize_rcu() then correctly waits for RCU readers to finish
>    before freeing.

There's a specific reason COPY_MARKER is part of the ZEROED_TRACE_FLAGS
that this patch doesn't address by removing it. That macro is all the
flags that are not copied when creating an instance. Other bad things
can happen by allowing it.

> 
> 2. Replacing list_del_init() with list_del_rcu() in update_marker_trace()
>    for proper RCU list removal semantics. list_del_init() overwrites
>    entry->next to point to itself, which can cause concurrent RCU readers
>    to loop infinitely. list_del_rcu() preserves entry->next so readers
>    can safely finish their traversal. The duplicate-operation guards are
>    changed from list_empty() to trace_flags bit checks accordingly, since
>    list_del_rcu() does not reinitialize the list head.

The above change is a fix, but it does look like AI wrote it, as it
added a lot of extra text that isn't needed for this change log. Yes,
we know why list_del_rcu() is used. It doesn't need to go into details
about use cases for list_del_rcu().

> 
> Fixes: 7b382efd5e8a ("tracing: Allow the top level trace_marker to write into another instances")
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/trace/trace.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 23de3719f4952..fa413214da764 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -523,8 +523,7 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
>  
>  /* trace_flags that are default zero for instances */
>  #define ZEROED_TRACE_FLAGS \
> -	(TRACE_ITER(EVENT_FORK) | TRACE_ITER(FUNC_FORK) | TRACE_ITER(TRACE_PRINTK) | \
> -	 TRACE_ITER(COPY_MARKER))
> +	(TRACE_ITER(EVENT_FORK) | TRACE_ITER(FUNC_FORK) | TRACE_ITER(TRACE_PRINTK))

This is wrong.

>  
>  /*
>   * The global_trace is the descriptor that holds the top-level tracing
> @@ -555,7 +554,7 @@ static bool update_marker_trace(struct trace_array *tr, int enabled)
>  	lockdep_assert_held(&event_mutex);
>  
>  	if (enabled) {
> -		if (!list_empty(&tr->marker_list))
> +		if (tr->trace_flags & TRACE_ITER(COPY_MARKER))
>  			return false;

This is fine.

>  
>  		list_add_rcu(&tr->marker_list, &marker_copies);
> @@ -563,10 +562,10 @@ static bool update_marker_trace(struct trace_array *tr, int enabled)
>  		return true;
>  	}
>  
> -	if (list_empty(&tr->marker_list))
> +	if (!(tr->trace_flags & TRACE_ITER(COPY_MARKER)))

This is fine.

>  		return false;
>  
> -	list_del_init(&tr->marker_list);
> +	list_del_rcu(&tr->marker_list);

This is fine.

>  	tr->trace_flags &= ~TRACE_ITER(COPY_MARKER);
>  	return true;
>  }

What is needed is to just reverse the order of the checks:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 855cba2ff5b5..42ea3770859b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9743,18 +9743,18 @@ static int __remove_instance(struct trace_array *tr)
 
 	list_del(&tr->list);
 
-	/* Disable all the flags that were enabled coming in */
-	for (i = 0; i < TRACE_FLAGS_MAX_SIZE; i++) {
-		if ((1ULL << i) & ZEROED_TRACE_FLAGS)
-			set_tracer_flag(tr, 1ULL << i, 0);
-	}
-
 	if (printk_trace == tr)
 		update_printk_trace(&global_trace);
 
 	if (update_marker_trace(tr, 0))
 		synchronize_rcu();
 
+	/* Disable all the flags that were enabled coming in */
+	for (i = 0; i < TRACE_FLAGS_MAX_SIZE; i++) {
+		if ((1ULL << i) & ZEROED_TRACE_FLAGS)
+			set_tracer_flag(tr, 1ULL << i, 0);
+	}
+
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
 	event_trace_del_tracer(tr);

-- Steve
