Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25E81A83F8
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 02:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756435796; cv=none; b=Z1nkXm9aYn44XnkZLlzO2PViMejjVgsq40xmXBstp02ZWpU1j4HVzdXCwhEn+ctZmAmrBni3hMVXvhNz7BDNQykNcSTyYnc9EjB9ZENKIAxBbT6CFfjt8V1o2dh91kdidJ4uM4Kr0mWJjEFBVYueIm8joOgd+5hm2p2dd3ADAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756435796; c=relaxed/simple;
	bh=vJRQm0dAkpEGZ44IY0X2gTuHJlx1ARhV+s0u47Drtz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NK80NVEIl9aA6BZYmMbJMyKstLRSERKZNhBsgunxB5a+XT9scr9cYk9k1z2RukwiBb+7e3+IbTIHCxB2Kp0wOEYd3s2d5+pNCaxHrUnpzO1cl58dNELf4n6uvXjZCrHQrW5jf3RGfo1jFAOAqqFDMAxOKvDUO3eL9jSmRuqojpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=McN9MHhj; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="McN9MHhj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756435791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHWX2ztP4eygxHjunFegKxK8vFLeIQnyXceb8aDigJ4=;
	b=McN9MHhjH86tQu+ZKh1zeBHE28PXpN3dwbBHPHtI0F9UVfTNLg+lkSVpGb1xVnXtfig3Ev
	fCyzUT6/BIO5mx3u9c1qXDxnXDb57048kho7AliaFt47BhxuNTBqX6OW3TS3zJTZfN8iPp
	t8ftpHgjATCyDmsRfEvMLnES97bq+u4=
From: menglong.dong@linux.dev
To: Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] tracing: fprobe: fix suspicious rcu usage in fprobe_entry
Date: Fri, 29 Aug 2025 10:49:46 +0800
Message-ID: <2396899.ElGaqSPkdT@7940hx>
In-Reply-To: <20250828222357.55fab4c2@batman.local.home>
References:
 <20250829021436.19982-1-dongml2@chinatelecom.cn>
 <20250828222357.55fab4c2@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/8/29 10:23 Steven Rostedt <rostedt@goodmis.org> write:
> On Fri, 29 Aug 2025 10:14:36 +0800
> Menglong Dong <dongml2@chinatelecom.cn> wrote:
> 
> > rcu_read_lock() is not needed in fprobe_entry, but rcu_dereference_check()
> > is used in rhltable_lookup(), which causes suspicious RCU usage warning:
> > 
> >   WARNING: suspicious RCU usage
> >   6.17.0-rc1-00001-gdfe0d675df82 #1 Tainted: G S
> >   -----------------------------
> >   include/linux/rhashtable.h:602 suspicious rcu_dereference_check() usage!
> >   ......
> >   stack backtrace:
> >   CPU: 1 UID: 0 PID: 4652 Comm: ftracetest Tainted: G S
> >   Tainted: [S]=CPU_OUT_OF_SPEC, [I]=FIRMWARE_WORKAROUND
> >   Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
> >   Call Trace:
> >    <TASK>
> >    dump_stack_lvl+0x7c/0x90
> >    lockdep_rcu_suspicious+0x14f/0x1c0
> >    __rhashtable_lookup+0x1e0/0x260
> >    ? __pfx_kernel_clone+0x10/0x10
> >    fprobe_entry+0x9a/0x450
> >    ? __lock_acquire+0x6b0/0xca0
> >    ? find_held_lock+0x2b/0x80
> >    ? __pfx_fprobe_entry+0x10/0x10
> >    ? __pfx_kernel_clone+0x10/0x10
> >    ? lock_acquire+0x14c/0x2d0
> >    ? __might_fault+0x74/0xc0
> >    function_graph_enter_regs+0x2a0/0x550
> >    ? __do_sys_clone+0xb5/0x100
> >    ? __pfx_function_graph_enter_regs+0x10/0x10
> >    ? _copy_to_user+0x58/0x70
> >    ? __pfx_kernel_clone+0x10/0x10
> >    ? __x64_sys_rt_sigprocmask+0x114/0x180
> >    ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
> >    ? __pfx_kernel_clone+0x10/0x10
> >    ftrace_graph_func+0x87/0xb0
> > 
> > Fix this by using rcu_read_lock() for rhltable_lookup(). Alternatively, we
> > can use rcu_lock_acquire(&rcu_lock_map) here to obtain better performance.
> > However, it's not a common usage :/
> 
> So this is needed even though it's called under preempt_disable().

It is needed when the lock debug configs are enabled.

> 
> Paul, do we need to add an rcu_read_lock() because the code in rht
> (rhashtable) requires RCU read lock?
> 
> I thought that rcu_read_lock() and preempt_disable() have been merged?

Maybe we can do some adjustment do rcu_read_lock_held_common()
like this:

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c912b594ba98..280fa4d2fc79 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -114,6 +114,10 @@ static bool rcu_read_lock_held_common(bool *ret)
                *ret = false;
                return true;
        }
+       if (!preemptible()) {
+               *ret = true;
+               return true;
+       }
        return false;
 }
 
@@ -123,7 +127,7 @@ int rcu_read_lock_sched_held(void)
 
        if (rcu_read_lock_held_common(&ret))
                return ret;
-       return lock_is_held(&rcu_sched_lock_map) || !preemptible();
+       return lock_is_held(&rcu_sched_lock_map);
 }
 EXPORT_SYMBOL(rcu_read_lock_sched_held);
 #endif

I think it's a bad idea, as !preemptiable() has different semantic
with rcu_read_lock() :(

Thanks!
Menglong Dong

> 
> -- Steve
> 
> 
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202508281655.54c87330-lkp@intel.com
> > Fixes: dfe0d675df82 ("tracing: fprobe: use rhltable for fprobe_ip_table")
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  kernel/trace/fprobe.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index fb127fa95f21..fece0f849c1c 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -269,7 +269,9 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> >  	if (WARN_ON_ONCE(!fregs))
> >  		return 0;
> >  
> > +	rcu_read_lock();
> >  	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
> > +	rcu_read_unlock();
> >  	reserved_words = 0;
> >  	rhl_for_each_entry_rcu(node, pos, head, hlist) {
> >  		if (node->addr != func)
> 
> 
> 




