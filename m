Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783BC34BA53;
	Mon, 29 Sep 2025 05:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759124359; cv=none; b=XHWVQj1nRDtdsKCUeB1y+lwCbJ3008JxFWiQC5hStbsB5S9cMn4j+BsvgtAnwz4CumEFo4hedjBLB72NTW+JD/6ReaWXRW/YlJheRUnkN6xHEN5z+mAfdA+i3+oeUz5xtnGn4MX35bgNvOezZcI8bf4Vf2NV/NoIRl2u62/HJuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759124359; c=relaxed/simple;
	bh=uFyVRrmf1hBz0VN8uXtkpg+tjIPeDCXurlVKT+XTNKQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VSiY0Rz/xCJkvOQIgegICHjGi6LMGrJIa6FoJ+OcsLDb1xYAU2k6sP2EllS8XFdgfilBdyIB8N2dowTMUjkuuvKOPJf7PcyBV4qtOQT1B44+q7qysc+IpFcDF2CWJ1Xo6iL7lJjCKarIbVKAJgWWPR8ABb5nsWnnkudCsHHHbMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na1OywAf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na1OywAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14ABC4CEF4;
	Mon, 29 Sep 2025 05:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759124358;
	bh=uFyVRrmf1hBz0VN8uXtkpg+tjIPeDCXurlVKT+XTNKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=na1OywAfH0QKzW9SjKCfBYqDOCfQGvagtpoZnpLstzcY00vd2L6gat0vfmosm1hvy
	 zw66eNMTvDxGCU05voIkUdemjW1nuTukA3M3Ih6+X76tv6vgXKbjgEwu3SWDTxBsJq
	 2OCKCpWeNYxysiIz4XvLFiZn6qmi3/z9wjbUEhyhbkOgkIgPDMzwb+EcQaXLJGMPjX
	 MUDAeDqh9ypQqEOfDr5Y4unsEwobBUAw2GWWqrTS2rK11VxZAjO02vWuDPkvbpqtcl
	 mPfVcnVgZ7S6mI8NW4r9u6ukq3L9zXej+6BJQ00ATvLeVe6mQxDNdQfVG6yDLszrcM
	 6Wn6UtxFfzpDw==
Date: Mon, 29 Sep 2025 14:39:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: <87ms751z28.wl-kuninori.morimoto.gx@renesas.com>
Cc: chenyuan_fl@163.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Yuan CHen <chenyuan@kylinos.cn>
Subject: Re: [PATCH] tracing: Fix race condition in kprobe initialization
 causing NULL pointer dereference
Message-Id: <20250929143916.5984441b32e6f84618b4deb8@kernel.org>
In-Reply-To: <20250929031122.2825-1-chenyuan_fl@163.com>
References: <20250929031122.2825-1-chenyuan_fl@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 29 Sep 2025 04:11:22 +0100
chenyuan_fl@163.com wrote:

> From: Yuan CHen <chenyuan@kylinos.cn>
> 
> There is a critical race condition in kprobe initialization that can lead to
> NULL pointer dereference and kernel crash.

Good catch!

> 
> [1135630.084782] Unable to handle kernel paging request at virtual address 0000710a04630000
> ...
> [1135630.260314] pstate: 404003c9 (nZcv DAIF +PAN -UAO)
> [1135630.269239] pc : kprobe_perf_func+0x30/0x260
> [1135630.277643] lr : kprobe_dispatcher+0x44/0x60
> [1135630.286041] sp : ffffaeff4977fa40
> [1135630.293441] x29: ffffaeff4977fa40 x28: ffffaf015340e400
> [1135630.302837] x27: 0000000000000000 x26: 0000000000000000
> [1135630.312257] x25: ffffaf029ed108a8 x24: ffffaf015340e528
> [1135630.321705] x23: ffffaeff4977fc50 x22: ffffaeff4977fc50
> [1135630.331154] x21: 0000000000000000 x20: ffffaeff4977fc50
> [1135630.340586] x19: ffffaf015340e400 x18: 0000000000000000
> [1135630.349985] x17: 0000000000000000 x16: 0000000000000000
> [1135630.359285] x15: 0000000000000000 x14: 0000000000000000
> [1135630.368445] x13: 0000000000000000 x12: 0000000000000000
> [1135630.377473] x11: 0000000000000000 x10: 0000000000000000
> [1135630.386411] x9 : 0000000000000000 x8 : 0000000000000000
> [1135630.395252] x7 : 0000000000000000 x6 : 0000000000000000
> [1135630.403963] x5 : 0000000000000000 x4 : 0000000000000000
> [1135630.412545] x3 : 0000710a04630000 x2 : 0000000000000006
> [1135630.421021] x1 : ffffaeff4977fc50 x0 : 0000710a04630000
> [1135630.429410] Call trace:
> [1135630.434828]  kprobe_perf_func+0x30/0x260
> [1135630.441661]  kprobe_dispatcher+0x44/0x60
> [1135630.448396]  aggr_pre_handler+0x70/0xc8
> [1135630.454959]  kprobe_breakpoint_handler+0x140/0x1e0
> [1135630.462435]  brk_handler+0xbc/0xd8
> [1135630.468437]  do_debug_exception+0x84/0x138
> [1135630.475074]  el1_dbg+0x18/0x8c
> [1135630.480582]  security_file_permission+0x0/0xd0
> [1135630.487426]  vfs_write+0x70/0x1c0
> [1135630.493059]  ksys_write+0x5c/0xc8
> [1135630.498638]  __arm64_sys_write+0x24/0x30
> [1135630.504821]  el0_svc_common+0x78/0x130
> [1135630.510838]  el0_svc_handler+0x38/0x78
> [1135630.516834]  el0_svc+0x8/0x1b0
> 
> kernel/trace/trace_kprobe.c: 1308
> 0xffff3df8995039ec <kprobe_perf_func+0x2c>:     ldr     x21, [x24,#120]
> include/linux/compiler.h: 294
> 0xffff3df8995039f0 <kprobe_perf_func+0x30>:     ldr     x1, [x21,x0]
> 
> kernel/trace/trace_kprobe.c
> 1308: head = this_cpu_ptr(call->perf_events);
> 1309: 	if (hlist_empty(head))
> 1310:		return 0;
> 
> crash> struct trace_event_call -o
> struct trace_event_call {
>   ...
>   [120] struct hlist_head *perf_events;  //(call->perf_event)
>   ...
> }
> 
> crash> struct trace_event_call ffffaf015340e528
> struct trace_event_call {
>   ...
>   perf_events = 0xffff0ad5fa89f088, //this value is correct, but x21 = 0
>   ...
> }
> 
> Race Condition Analysis:
> 
> The race occurs between kprobe activation and perf_events initialization:
> 
>     CPU0                                    CPU1
>     ====                                    ====
>     perf_kprobe_init
>       create_local_trace_kprobe
>         alloc_trace_kprobe
>           __register_trace_kprobe(tk);
>             arm_kprobe(p);(1)← KPROBE ACTIVE

This is strange, alloc_trace_kprobe() does not register kprobes,
but just allocate a trace_kprobe data structure.
Also, __register_trace_kprobe() should not activate the kprobe
event because it is not enabled.

To enable trace_kprobe, you should call kprobe_register()
via call->class->reg. That is (3).


>                                             Debug exception triggers
>                                             ...
>                                             kprobe_handler(regs)
>       perf_trace_event_init                 ...
>         tp_event->perf_events = list;(2)
>         tp_event->class->reg (3)

So after this point, kprobe is armed (swbp is installed).

Anyway, the point is
 - perf_trace_event_init() sets `tp_event->perf_events` and
   install kprobes on CPU0. But kprobe_dispatcher() on CPU1
   sees the call->perf_events == NULL. This is because the
   memory update is not shown in CPU1.

So I think code is OK, but the explanation is not correct.
We need a memory barrier which ensures that the `perf_events`
is shown on other CPUs. This may happen on the machine with
weak memory model.

Can you update the analysis part?

Thank you,


>                                             kprobe_dispatcher (tk->tp.flags & TP_FLAG_PROFILE)
>                                               kprobe_perf_func
> 					        head = this_cpu_ptr(call->perf_events)(4)
>                                                 (perf_events is still NULL)
> 
> Critical Issue:
> 
> The race window is:
> 1. CPU0 calls `arm_kprobe(p)` at point (1) - kprobe becomes active
> 2. CPU1 triggers debug exception and reaches `kprobe_dispatcher`
> 3. CPU0 sets `tp_event->perf_events = list` at point (2) but this assignment
>    may not be visible to CPU1 due to memory ordering
> 4. CPU0 calls `class->reg()` at point (3) setting `TP_FLAG_PROFILE`
> 5. CPU1 checks `(tk->tp.flags & TP_FLAG_PROFILE)` - condition passes
> 6. CPU1 calls `kprobe_perf_func()` and crashes at point (4)
> 
> The kprobe becomes active immediately at point (1), allowing concurrent CPUs
> to enter kprobe handlers. However, `perf_events` assignment at point (2) happens
> at a different time and may not be visible to other CPUs due to missing memory
> barriers before point (3) sets `TP_FLAG_PROFILE`.
> 
> Signed-off-by: Yuan CHen <chenyuan@kylinos.cn>
> ---
>  kernel/trace/trace_event_perf.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index a6bb7577e8c5..6eff8c9d6bae 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -113,6 +113,11 @@ static int perf_trace_event_reg(struct trace_event_call *tp_event,
>  
>  	tp_event->perf_events = list;
>  
> +	/* Ensure perf_events assignment is visible to all CPUs before enabling
> +	 * profile functionality
> +	 */
> +	smp_mb();
> +
>  	if (!total_ref_count) {
>  		char __percpu *buf;
>  		int i;
> -- 
> 2.39.5
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
