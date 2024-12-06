Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6C32C8B;
	Fri,  6 Dec 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733496551; cv=none; b=BZoqXQJRXAcFHhowS/g9q/ccc4kDkcilFcfOYPHi9FyhdjlMz2/NLyAQBtzb02LyDAEv7bFLUL7nXXF/kpbIuCvhzhR/sHzYCuloHZbAORuwpQPO3z8kK4no80IU2WtuWMoQ5MnGXBZE0j5jCl3T/i+osIGYWg4s3DhBZEdgagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733496551; c=relaxed/simple;
	bh=OUEgYCmcX8FT0oMt9HN5BcVpzzN9gy9DLVuve+ru3nc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9z368oHpaugk2xfnCTj0tPM7cirB2tUPgSCC7qy0FnVYBA29RKHyhaIuEuYWSfX5yaJOooi7TYnBN6oVTqFLR/+Pvz4nDX06fg38a0M9d4+y9Zoj2A+YsKap4+Hr1kAntJil4fY2lvlLoxgfXKv7Wn89IXnT2mn2gwWaqC8sdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C29C4CED1;
	Fri,  6 Dec 2024 14:49:07 +0000 (UTC)
Date: Fri, 6 Dec 2024 09:49:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Raghavendra K T <raghavendra.kt@amd.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, gourry@gourry.net,
 nehagholkar@meta.com, abhishekd@meta.com, david@redhat.com,
 ying.huang@intel.com, nphamcs@gmail.com, akpm@linux-foundation.org,
 hannes@cmpxchg.org, feng.tang@intel.com, kbusch@meta.com, bharata@amd.com,
 Hasan.Maruf@amd.com, sj@kernel.org, willy@infradead.org,
 kirill.shutemov@linux.intel.com, mgorman@techsingularity.net,
 vbabka@suse.cz, hughd@google.com, rientjes@google.com, shy828301@gmail.com,
 Liam.Howlett@Oracle.com, peterz@infradead.org, mingo@redhat.com, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V0 09/10] trace/kmmscand: Add tracing of scanning
 and migration
Message-ID: <20241206094915.7d198a3f@gandalf.local.home>
In-Reply-To: <86d39d52-fcc0-4215-8b68-ea6e526c0a01@amd.com>
References: <20241201153818.2633616-1-raghavendra.kt@amd.com>
	<20241201153818.2633616-10-raghavendra.kt@amd.com>
	<20241205124645.0d56ea57@gandalf.local.home>
	<86d39d52-fcc0-4215-8b68-ea6e526c0a01@amd.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Dec 2024 12:03:29 +0530
Raghavendra K T <raghavendra.kt@amd.com> wrote:

> On 12/5/2024 11:16 PM, Steven Rostedt wrote:
> > On Sun, 1 Dec 2024 15:38:17 +0000
> > Raghavendra K T <raghavendra.kt@amd.com> wrote:
> >   
> >> Add tracing support to track
> >>   - start and end of scanning.
> >>   - migration.
> >>
> >> CC: Steven Rostedt <rostedt@goodmis.org>
> >> CC: Masami Hiramatsu <mhiramat@kernel.org>
> >> CC: linux-trace-kernel@vger.kernel.org
> >>  
> 
> [...]
> 
> >> +
> >> +	TP_STRUCT__entry(
> >> +		__array(	char, comm, TASK_COMM_LEN	)  
> > 
> > Is there a reason to record "comm"? There's other ways to retrieve it than
> > to always write it to the ring buffer.
> >   
> 
> Thank you for the review Steve. The motivation was to filter benchmark
> in the trace to understand the behavior.
> I will explore regarding other ways of retrieving comm.
> (or may be even PID is enough..)

You can filter on current comm for any event with trace-cmd and even with the
"filter" file. It doesn't need to be part of the event.

For the filter file:

 # echo "COMM == rcu_preempt" > /sys/kernel/tracing/events/timer/hrtimer_cancel/filter

or with trace-cmd

 # trace-cmd start -e hrtimer_cancel -f 'COMM == "rcu_preempt"'
 # trace-cmd show
# tracer: nop
#
# entries-in-buffer/entries-written: 10/10   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
     rcu_preempt-18      [001] d..3. 54968.170887: hrtimer_cancel: hrtimer=00000000456b5702
     rcu_preempt-18      [001] d..3. 54968.177704: hrtimer_cancel: hrtimer=00000000456b5702
     rcu_preempt-18      [001] d..3. 54968.181678: hrtimer_cancel: hrtimer=00000000456b5702
     rcu_preempt-18      [001] d..3. 54968.185679: hrtimer_cancel: hrtimer=00000000456b5702
     rcu_preempt-18      [001] d..3. 54968.186092: hrtimer_cancel: hrtimer=00000000456b5702
     rcu_preempt-18      [001] d..3. 54968.193676: hrtimer_cancel: hrtimer=00000000456b5702
     rcu_preempt-18      [001] d..3. 54968.193686: hrtimer_cancel: hrtimer=00000000456b5702
     rcu_preempt-18      [001] d..3. 54972.871315: hrtimer_cancel: hrtimer=00000000456b5702
     rcu_preempt-18      [001] d..3. 54972.875176: hrtimer_cancel: hrtimer=00000000456b5702
     rcu_preempt-18      [001] d..3. 54972.881751: hrtimer_cancel: hrtimer=00000000456b5702

Or you can do it after the fact from a trace.dat file:

  # trace-cmd record -e hrtimer_cancel sleep 10
  # trace-cmd report | head
cpus=8
           sleep-1641  [006] d.h2. 55109.598846: hrtimer_cancel:       hrtimer=0xffff9800fdfa1888
           sleep-1641  [006] d..3. 55109.599089: hrtimer_cancel:       hrtimer=0xffff9800fdfb3140
          <idle>-0     [006] d..2. 55109.599111: hrtimer_cancel:       hrtimer=0xffff9800fdfa1888
          <idle>-0     [006] d.h7. 55109.603848: hrtimer_cancel:       hrtimer=0xffff9800fdfb3180
          <idle>-0     [006] dN.2. 55109.603895: hrtimer_cancel:       hrtimer=0xffff9800fdfa1888
          <idle>-0     [000] d.h3. 55109.604478: hrtimer_cancel:       hrtimer=0xffff9800fde33180
          <idle>-0     [000] dN.2. 55109.604492: hrtimer_cancel:       hrtimer=0xffff9800fde21888
     rcu_preempt-18    [000] d..3. 55109.604549: hrtimer_cancel:       hrtimer=0xffff9800fde33140
          <idle>-0     [000] d..2. 55109.604573: hrtimer_cancel:       hrtimer=0xffff9800fde21888

  # trace-cmd report -F '.*:COMM == "rcu_preempt"'
cpus=8
     rcu_preempt-18    [000] d..3. 55109.604549: hrtimer_cancel:       hrtimer=0xffff9800fde33140
     rcu_preempt-18    [000] d..3. 55109.609320: hrtimer_cancel:       hrtimer=0xffff9800fde33140
     rcu_preempt-18    [000] d..3. 55109.613350: hrtimer_cancel:       hrtimer=0xffff9800fde33140
     rcu_preempt-18    [000] d..3. 55119.609772: hrtimer_cancel:       hrtimer=0xffff9800fde33140

-- Steve
