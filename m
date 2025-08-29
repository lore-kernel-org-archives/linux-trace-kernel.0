Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA211BC5C;
	Fri, 29 Aug 2025 02:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756434246; cv=none; b=nFfUeJEv3H50tLxZRzm0umS4WgOB71t5P2zqr73SHT+ZTJIxJPpZuXTMI5+DvnkqzsJgREuDVNNhLF0YoL+oTfcXpIz3v8MR1At8I1SKpcheDUYuj+vpNmbH2DrThWnqseoHN0wqVThRTfAAgnQQMQkKpkSeCE29ZYQ+j5WD0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756434246; c=relaxed/simple;
	bh=LD/dzZkotatbWC2pE8zf0hWA4c2sI4NHyeAEv9C7cWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AT40xwjQPbdSeKiEvnlkU8yCIDYAfLUz9HIS/Yt3eT/P88nhBK+qtB2oG3MVKisNG3DMX1jPmkw8pDNLw5EAhalj1WYlOIksCiE4lTuFY5a3ZExt/x4YFu/7TKJ0UdVSQQSV4uxsCSRo/finf0OrQmZkbzRbq66NJuxYfMjh6Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 89F1713A104;
	Fri, 29 Aug 2025 02:24:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 8C5916000B;
	Fri, 29 Aug 2025 02:23:58 +0000 (UTC)
Date: Thu, 28 Aug 2025 22:23:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <dongml2@chinatelecom.cn>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, kernel
 test robot <oliver.sang@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] tracing: fprobe: fix suspicious rcu usage in
 fprobe_entry
Message-ID: <20250828222357.55fab4c2@batman.local.home>
In-Reply-To: <20250829021436.19982-1-dongml2@chinatelecom.cn>
References: <20250829021436.19982-1-dongml2@chinatelecom.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ima4r3ynrjku7c7wbsowqez1ui5yugaf
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 8C5916000B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Um7o/xuj05SM+I7zwu49yDvaXP8UURTk=
X-HE-Tag: 1756434238-941031
X-HE-Meta: U2FsdGVkX1+FHbgTP4MfqSCwG9uihNP6dP7ItW+sZr3ePzAx9HQ5c+Dgw8J/7OPRXZ3Nu4Y6JNJ/ds01+7jSZBhERC0W9TOk12MTo+zFRJ8vutOg3L7m8dKYaqV5FKtFHp5M4RTxk4RkLzenmiB+lXj5TNija+K6C4ibVSZYmL3tdvltH7s1szI246tiQXD1P2POJrt2pPbwEjR9NbeWHJ5ZFNulVL8PA0RYriESOUMyyL7OafSjKSWN8V8e4H1lpSGZsSA4foxdnIMB+75Lbd31mCqOmQF5NtsbRWG0OE/+5lKu0CCr56wujU2BDVG6iG/111qDS4SBgxfCQFoWu/zvIA2WQ1doiUppHLL4tv9+sjsCr14yLw==

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
> However, it's not a common usage :/

So this is needed even though it's called under preempt_disable().

Paul, do we need to add an rcu_read_lock() because the code in rht
(rhashtable) requires RCU read lock?

I thought that rcu_read_lock() and preempt_disable() have been merged?

-- Steve


> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202508281655.54c87330-lkp@intel.com
> Fixes: dfe0d675df82 ("tracing: fprobe: use rhltable for fprobe_ip_table")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
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

