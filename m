Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0173C0C;
	Fri,  5 Sep 2025 05:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757050421; cv=none; b=m1ILTMvHGT4eR5R97yT4deYT+CIHmz/F1gcbC0h2WqZcI7pwtBJa6DX4fRL5HJ+K1BgPYSnE+j8s2+fB8zaeLfmspwIxwUxyofO0KdEssC6NdhtDrEJeBKuKFc6BkrSrso9w2W23auXR1O7LNSDCLj1QgIim60k6QGHQpt7UJBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757050421; c=relaxed/simple;
	bh=z6ZMhChpG/YjKZS440yz+21mwMCNkfqayALs77Q0EQA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qSEAvETYxnH1WVjgeWdrbkHr9S2jnMQPuhJzCM1WL9uskIkHkMAF+02BnCbTsuKaaijIaeCbO1an1AqwORDxaNVoYFxzn4SbLjsE0TCzVUtSD6DyZKagyDL9JcRoUCP2QEvxl+kfnWUQEUN/kRjYa58QqPm1tF3kvvndvzqRTec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiDul2kz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiDul2kz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD23C4CEF1;
	Fri,  5 Sep 2025 05:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757050420;
	bh=z6ZMhChpG/YjKZS440yz+21mwMCNkfqayALs77Q0EQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CiDul2kz3sf2fndz0v+IGj3QJ0y/eWJiL59tZWvonRIowXikUWWZNCT5SkT9JAicT
	 pqOOf3maR7b5RVO6pGSnViqLRyLCCe8adIK1psw/sepYsFtVkoQsZvk9jnIBk97XtE
	 j4/Oj3na5fG5eACMv2SnbdYN0Pyd6Icxm+/OQnZB/Q0JjGyghesXrHcb8D+HINudTo
	 CwvZ6jARkwiyApKEghTmS5Xqi1IRgYKatL28ws7m8fVYrnPunMVqPQqAhFgW3RXUYF
	 jO5QICZID3bPYUrqmwzPQcdCYLXwa7sM+m7H+C0AVBOjMd+OHpFfVx6YVju/HIp+aK
	 wM58xhHKVYs4A==
Date: Fri, 5 Sep 2025 14:33:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: fprobe: fix suspicious rcu usage in
 fprobe_entry
Message-Id: <20250905143336.85682a1443ed998137bee0b7@kernel.org>
In-Reply-To: <20250904062729.151931-1-dongml2@chinatelecom.cn>
References: <20250904062729.151931-1-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Sep 2025 14:27:29 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

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
> As we discussed in [1], fix this by using guard(rcu)() in fprobe_entry()
> to protect the rhltable_lookup() and rhl_for_each_entry_rcu() with
> rcu_read_lock and suppress this warning.
> 
> Link: https://lore.kernel.org/all/20250829021436.19982-1-dongml2@chinatelecom.cn/ [1]
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202508281655.54c87330-lkp@intel.com
> Fixes: dfe0d675df82 ("tracing: fprobe: use rhltable for fprobe_ip_table")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Looks good to me. Let me pick this to probes/for-next.

Thanks!

> ---
> v2:
> - use guard(rcu)() instead of rcu_read_lock()
> ---
>  kernel/trace/fprobe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index fb127fa95f21..6a205903b1ed 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -269,6 +269,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
>  	if (WARN_ON_ONCE(!fregs))
>  		return 0;
>  
> +	guard(rcu)();
>  	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
>  	reserved_words = 0;
>  	rhl_for_each_entry_rcu(node, pos, head, hlist) {
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
