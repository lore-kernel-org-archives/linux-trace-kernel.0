Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B34231A21;
	Wed, 25 Mar 2026 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449207; cv=none; b=tZXqsd0n4spYxiMgSen0GkEP5JVBD2gPnxF2LXS6yLzwoeZhNt21ZLNcbcwYGGxf2mgwstDqbGbEU41hmAyp4rsSDErHcjjLWYaY+80MW2/mSNjiVj5gxR7FhF08laNtW0NlnsFRhtGPGFJg5g8OJt8dlHBuIm8BWACXds7hUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449207; c=relaxed/simple;
	bh=fOnFfoNkggcrlbMGeTqlcxZMa9OEdDG041CKGkGHr6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/J6YlDJLuZW49zVrZBExZYjEziIqfj5vcVW3sUI0BJnq/yTxS4uGhnTZ/5x2EpKFGkMpnNdQqeGGeTOJRtG8tR3TFCUP86gOdSLhH3noNwrEH4tt0FZIH1RPNyIyYj84gw9KfzfqOeI4bE7INj+qeKkLJiKwaA7dNgDnjFLp0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 1CF1B13B260;
	Wed, 25 Mar 2026 14:33:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id F3DFF18;
	Wed, 25 Mar 2026 14:33:21 +0000 (UTC)
Date: Wed, 25 Mar 2026 10:34:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: <hu.shengming@zte.com.cn>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <zhang.run@zte.com.cn>, <yang.tao172@zte.com.cn>, <ran.xiaokai@zte.com.cn>,
 <luo.haiyang@zte.com.cn>
Subject: Re: [PATCH] tracing/osnoise: fix potential deadlock in cpu hotplug
Message-ID: <20260325103406.2ed71054@gandalf.local.home>
In-Reply-To: <20260325102542300G48VT-wLNp-dOgT_9Qi2f@zte.com.cn>
References: <20260324121918.454d6a7b@gandalf.local.home>
	<20260325102542300G48VT-wLNp-dOgT_9Qi2f@zte.com.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F3DFF18
X-Stat-Signature: hpoo4tfz7xrbbz9gjrqogwfwq5z3z3bo
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18C9T7bfJ0g7n8A/8V+7oLzzpjqZUPKKPc=
X-HE-Tag: 1774449201-257298
X-HE-Meta: U2FsdGVkX1+pARm/SsNdAo3pHgf6wWJTHujYSAzor/wlFYDp5buT9IaoBtPXaAPXBEMQLKIGtRxKm//nJ35bL1oxiBRL7g8giYazMovHzacUC6abCM5zjEMWkUgWDaK30Equzm0hzV3zUZEJtYDKA3cIL+AxfPOqam3nnwHZIf2EqH0nHiCb7XVmJZxbjLWR7shTMtSSMGVHeUDG6n3FLAWpDSCVkEJeJ9rluBsEAECLlPkpkojO8cInIbD81+QeodSEhlhJRxDO+hHYKW4JxrRYEL/JZZ2r73XCg48DwAN/mIiT10lFIO1h7lbri46F0aimU0Bht7W1qpnwoNuWaJpRHqNKDPWtnO6LwfhJILc7n6PxpxWlw0q8M9BE8Qff

On Wed, 25 Mar 2026 10:25:42 +0800 (CST)
<hu.shengming@zte.com.cn> wrote:

> >On Tue, 24 Mar 2026 15:06:16 +0800 (CST)
> ><hu.shengming@zte.com.cn> wrote:
> >  
> >> From: luohaiyang10243395 <luo.haiyang@zte.com.cn>
> >> 
> >> The following sequence may leads deadlock in cpu hotplug:
> >> 
> >>   CPU0                        |  CPU1
> >>                               |  schedule_work_on
> >>                               |
> >>   _cpu_down//set CPU1 offline |
> >>   cpus_write_lock             |
> >>                               |  osnoise_hotplug_workfn
> >>                               |    mutex_lock(&interface_lock);
> >>                               |    cpus_read_lock();  //wait cpu_hotplug_lock
> >>                               |
> >>                               |  cpuhp/1
> >>                               |    osnoise_cpu_die
> >>                               |      kthread_stop
> >>                               |        wait_for_completion //wait osnoise/1 exit
> >>                               |
> >>                               |  osnoise/1
> >>                               |    osnoise_sleep
> >>                               |      mutex_lock(&interface_lock); //deadlock
> >> 
> >> Fix by swap the order of cpus_read_lock() and mutex_lock(&interface_lock).  
> >
> >So the deadlock is due to the "wait_for_completion"?  
> 
> The osnoise_cpu_init callback returns directly, which may allow another CPU offline task to run, 
> the offline task holds the cpu_hotplug_lock while waiting for the osnoise task to exit. 
> osnoise_hotplug_workfn may acquire interface_lock first, causing the offline task to be blocked. 
> This is an ABBA deadlock.

Right, as I said, it is due to the "wait_for_completion" and not due to two
different locks. One is waiting for the osnoise task to exit (the
"wait_for_completion") but the osnoise task is blocked on the interface_lock().

Better to show it as:


    task1		task2		task3
    -----		-----		-----

 mutex_lock(&interface_lock)

		    [CPU GOING OFFLINE]

		    cpus_write_lock();
		    osnoise_cpu_die();
		      kthread_stop(task3);
		        wait_for_completion();

				      osnoise_sleep();
				        mutex_lock(&interface_lock);

 cpus_read_lock();

 [DEAD LOCK]

> 
> >How did you find this bug? Inspection, AI, triggered?
> >
> >Thanks,
> >
> >-- Steve  
> 
> We run autotests on kernel-6.6, report following hung task warning, and we think the same issue exists
> in linux-stable.

Thanks. It's usually good to state how a bug was discovered when fixing it.

Could you send a v2 with an updated change log?

-- Steve
