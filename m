Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995BE2F1FF9;
	Mon,  1 Sep 2025 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714955; cv=none; b=XqcNbMbdfz0r8SyFp8FNkfqPBh/fcQ9exLmZKxygjZ+vOexPy95x8dznrGuOgwst6X4rk2A2M+m1biPqGEy/+YF51N392z0BE2JaM8EGNwL/JHQyrXXRMuvBoGcPP6vJ0EEp14V2Cu5DA95tG2hOG1fujZ+r6fF6/PS8HmpdwOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714955; c=relaxed/simple;
	bh=sxw14vs5AHoSaWl4UFUw0pfb3lH9xr1HRRdG2HAco4k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sWXpOu+INLiiQwWo/iD3a9ijKvDGGb4qG106QoiCPIsZVy7mLP/BWogKPlDHOHpy75eMSy+Zjb+Ll0rGoEHTC069wbS9VlCXRp2sCa5Vmd/PDvvB6KrymQTCJqbz89JGktbW5oWGBTJtd5tK8z1D6xZSyIJ+4ONPgv8BKT+UegM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilh8Fmfq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilh8Fmfq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932FFC4CEF0;
	Mon,  1 Sep 2025 08:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756714955;
	bh=sxw14vs5AHoSaWl4UFUw0pfb3lH9xr1HRRdG2HAco4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ilh8Fmfq6P/qMUutvpkr3kOGF+vjz4+8FOmjP4gRrD7+5cC+epLCBpKfMovYkVk44
	 YMPeyuYJIOQblOF8dBsOKG2h5oncwXT+3r0myG+22UXNAFExVXsImLOjhdoK2tSnyn
	 jLlmGozHYDqCq8iap1G527ZRX/qpik91D4rtx2TQxHaEJSAsdAuuhFm1QBlfYsYkgk
	 TEx+FAic0YI5sFmWJ4UhyokAanQwcGBiMI/uszlI20a5vCC5qlZSbg92TWaVe6R8R7
	 ksLs7eXaTpOs1eCSO0PA78ocfUrCkctVympDSwxnu5yK75lmlH9qTInR083Cns5nTp
	 8rfcpH/lERQRg==
Date: Mon, 1 Sep 2025 17:22:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <dongml2@chinatelecom.cn>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, kernel
 test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] tracing: fprobe: fix suspicious rcu usage in
 fprobe_entry
Message-Id: <20250901172231.67db79e4bc5652ac15c32224@kernel.org>
In-Reply-To: <20250829021436.19982-1-dongml2@chinatelecom.cn>
References: <20250829021436.19982-1-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 10:14:36 +0800
Menglong Dong <dongml2@chinatelecom.cn> wrote:

> rcu_read_lock() is not needed in fprobe_entry, but rcu_dereference_check()
> is used in rhltable_lookup(), which causes suspicious RCU usage warning:
> 
>   WARNING: suspicious RCU usage
>   6.17.0-rc1-00001-gdfe0d675df82 #1 Tainted: G S
>   -----------------------------
>   include/linux/rhashtable.h:602 suspicious rcu_dereference_check() usage!
>   ......
>   stack backtrace:
>   CPU: 1 UID: 0 PID: 4652 Comm: ftracetest Tainted: G S
>   Tainted: [S]=CPU_OUT_OF_SPEC, [I]=FIRMWARE_WORKAROUND
>   Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x7c/0x90
>    lockdep_rcu_suspicious+0x14f/0x1c0
>    __rhashtable_lookup+0x1e0/0x260
>    ? __pfx_kernel_clone+0x10/0x10
>    fprobe_entry+0x9a/0x450
>    ? __lock_acquire+0x6b0/0xca0
>    ? find_held_lock+0x2b/0x80
>    ? __pfx_fprobe_entry+0x10/0x10
>    ? __pfx_kernel_clone+0x10/0x10
>    ? lock_acquire+0x14c/0x2d0
>    ? __might_fault+0x74/0xc0
>    function_graph_enter_regs+0x2a0/0x550
>    ? __do_sys_clone+0xb5/0x100
>    ? __pfx_function_graph_enter_regs+0x10/0x10
>    ? _copy_to_user+0x58/0x70
>    ? __pfx_kernel_clone+0x10/0x10
>    ? __x64_sys_rt_sigprocmask+0x114/0x180
>    ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
>    ? __pfx_kernel_clone+0x10/0x10
>    ftrace_graph_func+0x87/0xb0
> 
> Fix this by using rcu_read_lock() for rhltable_lookup(). Alternatively, we
> can use rcu_lock_acquire(&rcu_lock_map) here to obtain better performance.

Yeah, that kind of trick may not good. 

> However, it's not a common usage :/
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202508281655.54c87330-lkp@intel.com
> Fixes: dfe0d675df82 ("tracing: fprobe: use rhltable for fprobe_ip_table")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

OK, I agree this fixes the problem. Let me pick it.

> ---
>  kernel/trace/fprobe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index fb127fa95f21..fece0f849c1c 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -269,7 +269,9 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  	if (WARN_ON_ONCE(!fregs))
>  		return 0;
>  
> +	rcu_read_lock();
>  	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
> +	rcu_read_unlock();
>  	reserved_words = 0;
>  	rhl_for_each_entry_rcu(node, pos, head, hlist) {
>  		if (node->addr != func)
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
