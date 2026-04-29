Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404AE3AE704;
	Wed, 29 Apr 2026 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777452058; cv=none; b=FMtRu6sK4Q/zrWRvz/4RKGp5jTNX8XS3zsQjQW3nAgwWkT//+gIhOo9RDJenH4ly0UyVFQ8mqmrDwVs2n3LeJ51soxlNvumZk2siNooTtY53IMK8af+GTyZNBlTI5j5+/7TQJPNMPdiDp9GT/P05xxN6MPAo9uqDw+wZ/oFz/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777452058; c=relaxed/simple;
	bh=pnnPZcCkAy9nsHmuIEq6UodUMe/4RgyIp3EeaUJLPnw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=anhjJeDwv+y2Gt1+8AmsdZFgOglnqF1kQOlhNQdfWN90CUMHWKPKNIPA+lOPGry05thjRrZCiJ3k/xBzDoB/n9MHGPGLao/tf5B10ygYwTOp28ccjt1ek9VhrJBmdt1BJ6PeVUfI3GSwk9CP2EhMtsX22l3nLU37j6HgPt8r/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9qd/sIL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9qd/sIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4372C19425;
	Wed, 29 Apr 2026 08:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777452057;
	bh=pnnPZcCkAy9nsHmuIEq6UodUMe/4RgyIp3EeaUJLPnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M9qd/sILJwri7mFnJJmRHSWfspRweez1/Xk+YqPTZLQTl3AM0SaBkGKhsYHlaB9ae
	 cM+HSXZHOFSd4QspAEimztfMrLUgBeZRMOqcsskB3DEGj8lObDEwnNwNNgn1fk2NN2
	 YkhcAye/rma9M/WOGlO0GWMgWJywTrqvBg4h0NECbbmXdDjUhnt43sk1JF4tpOXurV
	 fMFWUJRDiQvBd+2a1xKEUkzuMzJJLa/Ep0eQbJwg9pwHmt9Pr+mJnc/4lpiQvdA9yu
	 pd1y074pXmO+JnOVCdtQL/VOBYWMxPbUBtvC4NhI1uO/Ej+gorHAgjed4b8Pxx8iJj
	 iy6dTJarOpplA==
Date: Wed, 29 Apr 2026 17:40:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Shijia Hu <hushijia1@uniontech.com>
Cc: naveen@kernel.org, davem@davemloft.net, ananth@in.ibm.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Remove dead child probes from aggrprobe list
 on module unload
Message-Id: <20260429174053.b66f3a0032408f544128afd4@kernel.org>
In-Reply-To: <20260429032919.208790-1-hushijia1@uniontech.com>
References: <20260429032919.208790-1-hushijia1@uniontech.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 11:29:19 +0800
Shijia Hu <hushijia1@uniontech.com> wrote:

> When a kernel module that registered kprobes is unloaded without calling
> unregister_kprobe(), kprobes_module_callback() calls kill_kprobe() to
> mark the probe(s) GONE.  If the probe is an aggrprobe, kill_kprobe()
> also marks all child probes GONE, but it does not remove them from
> the aggrprobe's list.

That sounds like a bug in the module.

> 
> The problem is that child probes whose struct kprobe resides in the
> unloading module's memory are freed along with the module, yet they
> remain on the aggrprobe's list.  Later, when another caller registers
> a kprobe at the same address, __get_valid_kprobe() walks that list
> and dereferences the freed child probe, causing a use-after-free.
> 
> Reproduction steps:
> 
>     1) Load module A which registers two kprobes on the same kernel
>        function address (e.g., do_nanosleep), causing them to be
>        aggregated under one aggrprobe.
> 
>     2) Unload module A without calling unregister_kprobe().
>        Module A's memory is freed, but its two child probes remain
>        on the aggrprobe's list as dangling pointers.

Would you mean "load a buggy kernel module and unload it, the kernel cause
use-after-free."? for example:

----
struct kprobe my_probe = {...};

init_module() {
	register_kprobe(&my_probe);
}
exit_module() {
	/* do nothing */
}
----

Yes, this cause UAF because that module has a bug. Please call
unregister_kprobe().

Thanks,

> 
>     3) Load module B and register a kprobe on the same address
>        (e.g., do_nanosleep). register_kprobe() -> __get_valid_kprobe()
>        traverses the aggrprobe's list and dereferences the freed child
>        probe from module A, triggering a use-after-free and kernel panic.
> 
> The resulting crash looks like:
>     [  464.950864] BUG: kernel NULL pointer dereference, address: 0000000000000000
>     [  464.950872] #PF: supervisor read access in kernel mode
>     [  464.950874] #PF: error_code(0x0000) - not-present page
>     ...
>     [  464.950915] Call Trace:
>     [  464.950922]  <TASK>
>     [  464.950923]  register_kprobe+0x65/0x2e0
>     [  464.950928]  ? __pfx_stage2_init+0x10/0x10 [kprobe_leak_stage2]
>     [  464.950933]  stage2_init+0x37/0xff0 [kprobe_leak_stage2]
>     [  464.950938]  ? __pfx_stage2_init+0x10/0x10 [kprobe_leak_stage2]
>     [  464.950942]  do_one_initcall+0x56/0x2e0
>     [  464.950948]  do_init_module+0x60/0x230
>     ...
> 
>   Fix this by adding selective cleanup in kprobes_module_callback():
>   after calling kill_kprobe() on the aggrprobe, iterate its child list
>   and remove any child probe whose struct kprobe is inside the going
>   module's memory range (within_module_init / within_module_core).
> 
>   This is done in kprobes_module_callback() rather than kill_kprobe()
>   because kill_kprobe()'s semantic is "the probed code is going away,
>   mark probes GONE".  The lifetime of a probe is bound to the probed
>   code, not to the module containing the struct kprobe.  Child probes
>   owned by other still-loaded modules or by kmalloc (ftrace, perf,
>   kprobe-events) must stay on the list so they can be unregistered
>   later.  Only child probes whose memory is about to be freed need to
>   be removed from the list to prevent dangling pointers.
> 
> Fixes: e8386a0cb22f4 ("kprobes: support probing module __exit function")
> Signed-off-by: Shijia Hu <hushijia1@uniontech.com>
> ---
>  kernel/kprobes.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index bfc89083daa9..ff277314183c 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2664,6 +2664,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
>  				   unsigned long val, void *data)
>  {
>  	struct module *mod = data;
> +	struct hlist_node *tmp;
>  	struct hlist_head *head;
>  	struct kprobe *p;
>  	unsigned int i;
> @@ -2685,7 +2686,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
>  	 */
>  	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
>  		head = &kprobe_table[i];
> -		hlist_for_each_entry(p, head, hlist)
> +		hlist_for_each_entry_safe(p, tmp, head, hlist) {
>  			if (within_module_init((unsigned long)p->addr, mod) ||
>  			    (checkcore &&
>  			     within_module_core((unsigned long)p->addr, mod))) {
> @@ -2702,6 +2703,26 @@ static int kprobes_module_callback(struct notifier_block *nb,
>  				 */
>  				kill_kprobe(p);
>  			}
> +
> +			/*
> +			 * Child probes are not on the kprobe hash list, so
> +			 * the above loop can not find them. If a child probe
> +			 * is allocated in the module's memory, it will become
> +			 * a dangling pointer after the module is freed.
> +			 */
> +			if (kprobe_aggrprobe(p)) {
> +				struct kprobe *kp, *kptmp;
> +
> +				list_for_each_entry_safe(kp, kptmp, &p->list, list) {
> +					if (within_module_init((unsigned long)kp, mod) ||
> +					    (checkcore &&
> +					     within_module_core((unsigned long)kp, mod))) {
> +						kp->flags |= KPROBE_FLAG_GONE;
> +						list_del_rcu(&kp->list);
> +					}
> +				}
> +			}
> +		}
>  	}
>  	if (val == MODULE_STATE_GOING)
>  		remove_module_kprobe_blacklist(mod);
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
