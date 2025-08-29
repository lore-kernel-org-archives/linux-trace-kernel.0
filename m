Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D3C274FFE;
	Fri, 29 Aug 2025 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756465960; cv=none; b=P0agqy/WlNIxQeJg3kBGDHl38krHNb2LYpbv9Z4vtw2VQgf4BceYF5g8cVAYhy6srng9OJwYovwvXhrfaf9uTDA93XCHtTzyJsVTc5pEcs4wl+xxX0bCVKeNYJFIm42W6prb5JcolJSjtLLybyPpoKKkP2pYwu2wLkQq/VTMObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756465960; c=relaxed/simple;
	bh=Qlwzayq/Pf0Medk24NErKYNLUDYes+Gcgm2LBjkXTgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8XmgDSf4fxPhm+/kNbD1bM+4Chsq3flZNxV2CJHjOAj2Tb2JlHQGgmjhRUVbQZPWJdyO0jxTZYyaRbYiUVQgNTGcDrbuERWNj9XmdY/qjlY23uGfzYYsiTa0eR/wBx0xy+67BGcIhPIW4v9cKbmfZ00FX2PmjWhq86C/TgQ7+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXKjOj7A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXKjOj7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AA0C4CEF0;
	Fri, 29 Aug 2025 11:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756465959;
	bh=Qlwzayq/Pf0Medk24NErKYNLUDYes+Gcgm2LBjkXTgk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tXKjOj7AG876DMc52h/44P4naRLGEWgfjFATVKZTrYKtuvR98EqkPj9hVHuttvdpu
	 W/H8boSrZ5l8MMl5pZzlbnC8k1x+St3TM17LDMXbcQwB91UYD9fFG5E0GhVdfqaChY
	 bYf++Fo2NGJusO5BUUCgEZ8821b4yPAGkcJAAF30aE8X60wwg5pUBK6DA1j8r0BVu7
	 1h/JaY5nT8CEu5T3q5W2o3Frw2sQ2M6507hyd++IR/sIU0aWESlPA2uo/+J+1zjn/C
	 HooUW/AXwtIOqf424wiaXR57fFBTPXN5gVsTaJVAF9CfXnk0RPzRMkSkp68yAriyEp
	 QDEjGe94zDWQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4234DCE0B2A; Fri, 29 Aug 2025 04:12:39 -0700 (PDT)
Date: Fri, 29 Aug 2025 04:12:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: menglong.dong@linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] tracing: fprobe: fix suspicious rcu usage in fprobe_entry
Message-ID: <89796a20-5fe8-4ec9-a192-6b8c58f8388a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250829021436.19982-1-dongml2@chinatelecom.cn>
 <20250828222357.55fab4c2@batman.local.home>
 <2396899.ElGaqSPkdT@7940hx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396899.ElGaqSPkdT@7940hx>

On Fri, Aug 29, 2025 at 10:49:46AM +0800, menglong.dong@linux.dev wrote:
> On 2025/8/29 10:23 Steven Rostedt <rostedt@goodmis.org> write:
> > On Fri, 29 Aug 2025 10:14:36 +0800
> > Menglong Dong <dongml2@chinatelecom.cn> wrote:
> > 
> > > rcu_read_lock() is not needed in fprobe_entry, but rcu_dereference_check()
> > > is used in rhltable_lookup(), which causes suspicious RCU usage warning:
> > > 
> > >   WARNING: suspicious RCU usage
> > >   6.17.0-rc1-00001-gdfe0d675df82 #1 Tainted: G S
> > >   -----------------------------
> > >   include/linux/rhashtable.h:602 suspicious rcu_dereference_check() usage!
> > >   ......
> > >   stack backtrace:
> > >   CPU: 1 UID: 0 PID: 4652 Comm: ftracetest Tainted: G S
> > >   Tainted: [S]=CPU_OUT_OF_SPEC, [I]=FIRMWARE_WORKAROUND
> > >   Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
> > >   Call Trace:
> > >    <TASK>
> > >    dump_stack_lvl+0x7c/0x90
> > >    lockdep_rcu_suspicious+0x14f/0x1c0
> > >    __rhashtable_lookup+0x1e0/0x260
> > >    ? __pfx_kernel_clone+0x10/0x10
> > >    fprobe_entry+0x9a/0x450
> > >    ? __lock_acquire+0x6b0/0xca0
> > >    ? find_held_lock+0x2b/0x80
> > >    ? __pfx_fprobe_entry+0x10/0x10
> > >    ? __pfx_kernel_clone+0x10/0x10
> > >    ? lock_acquire+0x14c/0x2d0
> > >    ? __might_fault+0x74/0xc0
> > >    function_graph_enter_regs+0x2a0/0x550
> > >    ? __do_sys_clone+0xb5/0x100
> > >    ? __pfx_function_graph_enter_regs+0x10/0x10
> > >    ? _copy_to_user+0x58/0x70
> > >    ? __pfx_kernel_clone+0x10/0x10
> > >    ? __x64_sys_rt_sigprocmask+0x114/0x180
> > >    ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
> > >    ? __pfx_kernel_clone+0x10/0x10
> > >    ftrace_graph_func+0x87/0xb0
> > > 
> > > Fix this by using rcu_read_lock() for rhltable_lookup(). Alternatively, we
> > > can use rcu_lock_acquire(&rcu_lock_map) here to obtain better performance.
> > > However, it's not a common usage :/
> > 
> > So this is needed even though it's called under preempt_disable().
> 
> It is needed when the lock debug configs are enabled.
> 
> > 
> > Paul, do we need to add an rcu_read_lock() because the code in rht
> > (rhashtable) requires RCU read lock?
> > 
> > I thought that rcu_read_lock() and preempt_disable() have been merged?
> 
> Maybe we can do some adjustment do rcu_read_lock_held_common()
> like this:
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index c912b594ba98..280fa4d2fc79 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -114,6 +114,10 @@ static bool rcu_read_lock_held_common(bool *ret)
>                 *ret = false;
>                 return true;
>         }
> +       if (!preemptible()) {
> +               *ret = true;
> +               return true;
> +       }
>         return false;
>  }
>  
> @@ -123,7 +127,7 @@ int rcu_read_lock_sched_held(void)
>  
>         if (rcu_read_lock_held_common(&ret))
>                 return ret;
> -       return lock_is_held(&rcu_sched_lock_map) || !preemptible();
> +       return lock_is_held(&rcu_sched_lock_map);
>  }
>  EXPORT_SYMBOL(rcu_read_lock_sched_held);
>  #endif
> 
> I think it's a bad idea, as !preemptiable() has different semantic
> with rcu_read_lock() :(

Especially given the definition of preemptible() within kernels built
with CONFIG_PREEMPT_COUNT=n...

							Thanx, Paul

> Thanks!
> Menglong Dong
> 
> > 
> > -- Steve
> > 
> > 
> > > 
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202508281655.54c87330-lkp@intel.com
> > > Fixes: dfe0d675df82 ("tracing: fprobe: use rhltable for fprobe_ip_table")
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > ---
> > >  kernel/trace/fprobe.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > > index fb127fa95f21..fece0f849c1c 100644
> > > --- a/kernel/trace/fprobe.c
> > > +++ b/kernel/trace/fprobe.c
> > > @@ -269,7 +269,9 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> > >  	if (WARN_ON_ONCE(!fregs))
> > >  		return 0;
> > >  
> > > +	rcu_read_lock();
> > >  	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
> > > +	rcu_read_unlock();
> > >  	reserved_words = 0;
> > >  	rhl_for_each_entry_rcu(node, pos, head, hlist) {
> > >  		if (node->addr != func)
> > 
> > 
> > 
> 
> 
> 
> 
