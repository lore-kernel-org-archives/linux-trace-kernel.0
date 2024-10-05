Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E19915AF6;
	Sat,  5 Oct 2024 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728137606; cv=none; b=XHX3kfWsqhjxBpU/u6rEr31DDO38qZ3VgH2ylrqrwnYynQuXRkCqo1IdsRJb8/yZF5Msb+mZC8FVvLatZEq/8pEz7D1udhxr7iauUkFeKI75COXABAooqA2K4V9jn/Ftw8iMwgR+UMItxVFlZZSZ7elniRIrgfjCyMMO5KD0/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728137606; c=relaxed/simple;
	bh=k8cdQUvfCIdUlb3RlxUUrYdbkkPaLnrGvqHOFOXBcjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEw1UKzWBJqwkiw/7aY/pu7EAR4mJIWabchKrfmUBq/XTuTe5YFlD48N43OghLPRCtapWdIWw1cqFXC0iox4i70WK/Wrsdn5VRv5E8G6tpk6X9AZftyqQQrkjiAlPaWcuJVR/+WjqVeLtihtfUqHEeFd5mWsv8fxuT0X3yDw4ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255B4C4CEC2;
	Sat,  5 Oct 2024 14:13:24 +0000 (UTC)
Date: Sat, 5 Oct 2024 10:13:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Xie <jeff.xie@linux.dev>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiehuan09@gmail.com, dolinux.peng@gmail.com, chensong_2000@189.cn
Subject: Re: [PATCH v3] ftrace: Get the true parent ip for function tracer
Message-ID: <20241005101320.766c1100@rorschach.local.home>
In-Reply-To: <20240910133620.19711-1-jeff.xie@linux.dev>
References: <20240910133620.19711-1-jeff.xie@linux.dev>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 21:36:20 +0800
Jeff Xie <jeff.xie@linux.dev> wrote:

> When using both function tracer and function graph simultaneously,
> it is found that function tracer sometimes captures a fake parent ip
> (return_to_handler) instead of the true parent ip.
> 
> This issue is easy to reproduce. Below are my reproduction steps:
> 
> jeff-labs:~/bin # ./trace-net.sh

I applied this and it failed one of my testes:

On x86 32 bit:

[  668.043429] BUG: kernel NULL pointer dereference, address: 0000003c
[  668.045840] #PF: supervisor read access in kernel mode
[  668.047869] #PF: error_code(0x0000) - not-present page
[  668.049867] *pdpt = 000000000afad001 *pde = 0000000000000000 
[  668.052481] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[  668.054408] CPU: 3 UID: 0 PID: 4347 Comm: cat Not tainted 6.12.0-rc1-test-00008-gc274c40c37e8-dirty #444
[  668.057679] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  668.060944] EIP: function_trace_call+0x14b/0x1a0
[  668.062824] Code: ff b8 10 00 00 00 e9 56 ff ff ff 8d 74 26 00 e8 1b c7 c0 00 eb a1 2e 8d b4 26 00 00 00 00 90 8b 45 e0 8d 55 ec b9 98 9e 10 c7 <ff> 70 3c 89 f8 e8 eb 0a 01 00 89 45 e8 5a e9 47 ff ff ff 8b 87 ac
[  668.068726] EAX: 00000000 EBX: c1b02000 ECX: c7109e98 EDX: cab21e50
[  668.071076] ESI: fffffff7 EDI: ca828000 EBP: cab21e64 ESP: cab21e44
[  668.073425] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010246
[  668.075938] CR0: 80050033 CR2: 0000003c CR3: 091a0000 CR4: 000006f0
[  668.078331] Call Trace:
[  668.079687]  ? ftrace_graph_caller+0x1c/0x1c
[  668.081541]  ? __die_body.cold+0x14/0x1b
[  668.083440]  ? ftrace_graph_caller+0x1c/0x1c
[  668.085347]  ? __die+0x21/0x28
[  668.087062]  ? ftrace_graph_caller+0x1c/0x1c
[  668.088944]  ? page_fault_oops+0x68/0x120
[  668.091245]  ? ftrace_graph_caller+0x1c/0x1c
[  668.093208]  ? kernelmode_fixup_or_oops.constprop.0+0x58/0x70
[  668.095669]  ? ftrace_graph_caller+0x1c/0x1c
[  668.097574]  ? __bad_area_nosemaphore.constprop.0+0x107/0x130
[  668.101278]  ? ftrace_graph_caller+0x18/0x1c
[  668.103358]  ? ftrace_graph_caller+0x1c/0x1c
[  668.105272]  ? bad_area_nosemaphore+0xf/0x20
[  668.107276]  ? ftrace_graph_caller+0x1c/0x1c
[  668.109279]  ? do_user_addr_fault+0x20b/0x3d0
[  668.111518]  ? exc_page_fault+0x5b/0x240
[  668.113474]  ? pvclock_clocksource_read_nowd+0x110/0x110
[  668.115738]  ? handle_exception+0x133/0x133
[  668.117689]  ? ftrace_graph_caller+0x1c/0x1c
[  668.119827]  ? ftrace_graph_set_hash+0xbb/0x1c0
[  668.121955]  ? pvclock_clocksource_read_nowd+0x110/0x110
[  668.124258]  ? function_trace_call+0x14b/0x1a0
[  668.126456]  ? pvclock_clocksource_read_nowd+0x110/0x110
[  668.128773]  ? function_trace_call+0x14b/0x1a0
[  668.130909]  ? sched_tick+0x370/0x370
[  668.134063]  ? ftrace_graph_caller+0x1c/0x1c
[  668.136213]  ? ftrace_stacktrace_count+0xa0/0xa0

The crash happened here:

static __always_inline unsigned long
function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
{
        unsigned long true_parent_ip;
        int idx = 0;

        true_parent_ip = parent_ip;
        if (unlikely(parent_ip == (unsigned long)&return_to_handler))
                true_parent_ip = ftrace_graph_ret_addr(current, &idx, parent_ip,  <<<----- CRASH
                                (unsigned long *)fregs->regs.sp);
        return true_parent_ip;
}

It appears that on some archs (x86 32 bit) the function tracer can be
called when "current" is not set up yet, and can crash when accessing it.

So perhaps we need to add:

#ifdef CONFIG_ARCH_WANTS_NO_INSTR
static __always_inline unsigned long
function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
{
        unsigned long true_parent_ip;
        int idx = 0;

        true_parent_ip = parent_ip;
        if (unlikely(parent_ip == (unsigned long)&return_to_handler))
                true_parent_ip = ftrace_graph_ret_addr(current, &idx, parent_ip,  <<<----- CRASH
                                (unsigned long *)fregs->regs.sp);
        return true_parent_ip;
}
#else
# define function_get_true_parent_ip(parent_ip, fregs)  parent_ip
#endif

That is, if the arch has noinstr implemented, it should always be safe
to access current, but if not, then there's no guarantee.

?

-- Steve
