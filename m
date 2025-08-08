Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7391C84BD;
	Fri,  8 Aug 2025 05:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754630996; cv=none; b=cAvAP6GDqa3qYgEUFmIzgS+D1/WhotRyI8qpSy3XKXa0GufPWTxRAY5MLMRE58wgza9Jyopn55jhf/TIXml5qMMBhxIqNEb1mIbeNiMP/JU2sWdCdgyPC4w4HEM5r1raREbjWrx3HFr3/DxpaBy/5cFf6lfEsKqEjnxCizHMSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754630996; c=relaxed/simple;
	bh=+3N/c59N2Q/1AxrrKmzUgnjRj42WZzs2QGrNEJjnFho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MbwdogjuVw4fqyaL3VHAvAtzstgWGotDlTv6x/WE4wAIQCkQH3FC/7/SEb6gLC7px0YEv5rlgPeVZttLR7TnOYPhkUQMHR6gxcK0PtV2wqBWhrshe3oi/JFOUfsPpRH8NNpPcqccLQgtpSLQAx9gp7WfbRg967DtERH4u6Abhjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MqAfp4SH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1SUhtXFd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MqAfp4SH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1SUhtXFd"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754630992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wHL70uQzzfCdF5/IMDDWLgzrkbKIyjVtvHrB1wUt3Zo=;
	b=MqAfp4SHWNDUtROtipIEvGKQs8J+hbcY7nO4G54WPb67Pc4PAZNq2KqYcZYK1PkZOBFE5+
	qAZ26WDPmMYkibxIib78izTtLewL/MATQ5HK5idVsgZxLZZmifXqqQTa9ofbGgjtzpOaLp
	V1bn2PIwPDxIhG2E+eGZ/AZCTAF0a+5nghOmQVMlPbO3HVppbYpzuTbmm7d0QyHLaWMZtj
	ECO6yits8+lcKd4xWOyPZ5v+aYCNQdroqCdasxOQ5a9I3ZokP3ym6HEwenqwYJVIBVZF3C
	JZ9Ox7pOafafF+xTZUqSeboNe89LAwszZ78LASq27EdQ/8uSHtTFEqmGFF08Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754630992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wHL70uQzzfCdF5/IMDDWLgzrkbKIyjVtvHrB1wUt3Zo=;
	b=1SUhtXFdmXQfHgCKL0oqxrK4VPbdhic4XpQC65rPO0kxOWwtFc8wefiTS3LfZH8f3Pm05N
	aC37Ej9cDDsXncDQ==
To: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2 5/5] rv: Add rts monitor
In-Reply-To: <ecd720a0b971658a915473f0f864668cd6e1ef1a.camel@redhat.com>
References: <cover.1754466623.git.namcao@linutronix.de>
 <88fdbeb3f2ecf3a6259f3ee8636ae5b21fa6b72d.1754466623.git.namcao@linutronix.de>
 <ecd720a0b971658a915473f0f864668cd6e1ef1a.camel@redhat.com>
Date: Fri, 08 Aug 2025 07:29:51 +0200
Message-ID: <87ikiypei8.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> On Wed, 2025-08-06 at 10:01 +0200, Nam Cao wrote:
>> Add "real-time scheduling" monitor, which validates that SCHED_RR and
>> SCHED_FIFO tasks are scheduled before tasks with normal and
>> extensible scheduling policies
>> 
>> Signed-off-by: Nam Cao <namcao@linutronix.de>
>> ---
>
> The monitor shows a violation also in case of priority inversion
> boosting, e.g.:
>
>  stress-ng --prio-inv 2

This looks like something that would trigger the fair deadline server or
RT throttling. Can you please try disabling both of them:

    echo 0 | tee /sys/kernel/debug/sched/fair_server/cpu*/runtime
    sysctl -w kernel.sched_rt_runtime_us=-1

and see if the problem persists?

> It seems perfectly reasonable from the monitor description but it's
> actually a behaviour meant to improve real time response.
> Is the user seeing this type of violation supposed to make sure all
> locks held by RT tasks are never shared by fair tasks? If that's the
> case I'd mention it in the description.

Boosted fair tasks are treated as RT tasks ;)

> Also very rarely I see failures while cleaning up the monitor, not sure
> exactly what caused it but I could reproduce it with something like:
>
>   for i in $(seq 100); do timeout -s INT 2 rv mon rts -r printk; done
>
> Running the monitor without stopping for the same amount of time
> doesn't seem to show violations (until I terminate it).
>
> "rv" here is the tool under tools/verifications/rv, also the rv package
> on fedora works, but debian/ubuntu may still be shipping an outdated
> version, if they ship one at all.

This one is strange, I cannot reproduce this issue. Did you run only
that command, or did you have other things running as well?

And does the problem still appears after disabling the fair deadline
server and RT throttling?

Thanks for trying it out.

nam

