Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E39190665;
	Wed, 26 Feb 2025 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582287; cv=none; b=TI5t1A0gmGI7F8jmWkclDk0X2U2BdNXvTCztpKOTtNSrKxXAbubNjMueLGzKHaSxBLqqtLUTs2U1GXhp12XXn0FaKeh0KPRsPxwUj2J8InJiqB2Jh4ogR69zf5WccAKuFUYhFqd69m7Gl7n4SY8vwxV7of2QeYerd2TMavMHJOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582287; c=relaxed/simple;
	bh=1NPMnlLH6CTFkjQURe97JYrL80EWkR7Iiy9OAhcn0r8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOIGoAcI8Qh6P0Cuu92+PpivK7O1l27oq3pvhMgVPbLbouGWZ4AE+7eI5RIKc5IdfJS62nmDhjtHDK5RnIVorLxEPsDT/as/aW9hr4syoALhM9MTUEH8sWQYOeCwX35fw4yCkdmO/+oZbXKqzX0FUM8daKLucMI7FldOJsVCa8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55331C4CED6;
	Wed, 26 Feb 2025 15:04:46 +0000 (UTC)
Date: Wed, 26 Feb 2025 10:05:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ran Xiaokai <ranxiaokai627@163.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 ran.xiaokai@zte.com.cn, wang.yong12@zte.com.cn, yang.guang5@zte.com.cn
Subject: Re: [PATCH] tracing/osnoise: Fix possible recursive locking for
 cpus_read_lock()
Message-ID: <20250226100526.3039102d@gandalf.local.home>
In-Reply-To: <20250226034253.2587709-1-ranxiaokai627@163.com>
References: <20250225113032.5e01922d@gandalf.local.home>
	<20250226034253.2587709-1-ranxiaokai627@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 03:42:53 +0000
Ran Xiaokai <ranxiaokai627@163.com> wrote:

> >> @@ -2105,7 +2104,12 @@ static void osnoise_hotplug_workfn(struct
> >> work_struct *dummy)
> >>      if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
> >>          return;
> >>  
> >> -    start_kthread(cpu);
> >> +    if (start_kthread(cpu)) {
> >> +        cpus_read_unlock();
> >> +        stop_per_cpu_kthreads();
> >> +        return;  
> >
> >If all you want to do is to unlock before calling stop_per_cpu_kthreads(),
> >then this should simply be:
> >
> >   if (start_kthread(cpu)) {
> >       cpus_read_unlock();
> >       stop_per_cpu_kthreads();
> >       cpus_read_lock(); // The guard() above will unlock this
> >       return;
> >   }  
> 
> This is the deadlock senario:
> start_per_cpu_kthreads()
>   cpus_read_lock();                  // first lock call
>   start_kthread(cpu)
>     ... kthread_run_on_cpu() fails:
>     if (IS_ERR(kthread)) {
>       stop_per_cpu_kthreads(); {
>         cpus_read_lock();      // second lock call. Cause the AA deadlock senario
>       }
>     }
>   stop_per_cpu_kthreads();
> 
> Besides, stop_per_cpu_kthreads() is called both in start_per_cpu_kthreads() and
> start_kthread() which is unnecessary.
> 
> So the fix should be inside start_kthread()?
> How about this ?

No! You misunderstood what I wrote above.

Instead of removing the guard, keep it!

Do everything the same, but instead of having the error path of:

[..]
    if (start_kthread(cpu)) {
        cpus_read_unlock();
        stop_per_cpu_kthreads();
        return;
    }
    cpus_read_unlock();
 }

Which requires removing the guard. Just do:

    if (start_kthread(cpu)) {
        cpus_read_unlock();
        stop_per_cpu_kthreads();
        cpus_read_lock(); // The guard() will unlock this
    }
 }

I'm just saying to not replace the guard with open coded locking of
cpus_read_lock().

-- Steve
