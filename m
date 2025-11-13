Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6A2E718E;
	Thu, 13 Nov 2025 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047054; cv=none; b=gDkc5w2QvUPGaLaNmNyxjK+guRIJOCLTZaG6zYsFXVQqgj2w1Z8omxxTZa/Wu6BZau6870PJmAvpTEvV00+GJIy8cBECuchT2nI1dhXzxILhVCxd+oejs8ZM7WTpV82gi8Ofjruru67+0R7BgNrRmf3dl6SF6KA+pzWJvGT6zL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047054; c=relaxed/simple;
	bh=2XwcqBLHOsV5v27fR5+JKATUgPG5pt6EmLzkGRRbm/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oN4LqXb7BzfdOqi5CFrdwhU70/GNG9Ghttwa4P8ig4FqhavJKvfhfiCzU4OvgjbAr8ZokJEPwe7HsampHjmTYEVsPTePbH3drXOevpiyIZX6cHncATNKuHk2yOd89ExiuEfbapAM0FO8AbeeWiidrotrK4ZM+5Qyp4b5kDjQsEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rK9Y1i+0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JbyhO9r5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rK9Y1i+0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JbyhO9r5"
Date: Thu, 13 Nov 2025 16:17:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdOSrWQmxQkHahlrLaL2Uoxf2RpYM8xKbqXKtJw+zio=;
	b=rK9Y1i+0P4gqlRSMzZA+9zZsQOmGoGDkPXnfCyjhTKXOMxt4CSJyqNcgALG5ZOHZkPRq/S
	sy3fT8Mm2h4y6hHdj6sKOqrI/QLaK4OfkSpvhMGe3RTC1gbGtuD7kK2MAtCo+Kkf55f7Bk
	GSLWNHbs1KbXTWusAZCirWx0yjgnrXA8pk2jDxQbUwiZWPXAuyP1JhQf1fvqbud2c6WBcU
	GY3R7Lscx+kPLZ6T78TRV6ZT02kXTMdPynUPD7TAgJb7q+dQDqyfdy0tIYqo3+InYi/2eG
	Vo+0dGC/HSSdg6XWCUoMJ7vaxOHDTWWY0Gr6wSKiv/3nBuer9BwqlFyUjYJhfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdOSrWQmxQkHahlrLaL2Uoxf2RpYM8xKbqXKtJw+zio=;
	b=JbyhO9r52twMXmqGA3aiAzZz2bx35B4u32sHGO5V1m4WBY8v344Ccjz8jKsk3qs7t0OCX9
	TQQG3jdgYtCVyIDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yongliang Gao <leonylgao@gmail.com>, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, frankjpliu@tencent.com,
	Yongliang Gao <leonylgao@tencent.com>,
	Huang Cun <cunhuang@tencent.com>
Subject: Re: [PATCH v3] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251113151729.4Zky6d-t@linutronix.de>
References: <20251113000252.1058144-1-leonylgao@gmail.com>
 <20251113073420.yko6jYcI@linutronix.de>
 <CAJxhyqCyB3-CyDKgPtP-EoC=G9cWAYgLvse003+i2n6U4Pgv1w@mail.gmail.com>
 <20251113141515.iZSIDK0T@linutronix.de>
 <20251113100524.5c5f6bdc@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251113100524.5c5f6bdc@gandalf.local.home>

On 2025-11-13 10:05:24 [-0500], Steven Rostedt wrote:
> This means that the chunks are not being freed and we can't be doing
> synchronize_rcu() in every exit.

You don't have to, you can do call_rcu().

> > Additionally it would guarantee that the buffer is not released in
> > trace_pid_list_free(). I don't see how the seqcount ensures that the
> > buffer is not gone. I mean you could have a reader and the retry would
> > force you to do another loop but before that happens you dereference the
> > upper_chunk pointer which could be reused.
>=20
> This protection has nothing to do with trace_pid_list_free(). In fact,
> you'll notice that function doesn't even have any locking. That's because
> the pid_list itself is removed from view and RCU synchronization happens
> before that function is called.
>=20
> The protection in trace_pid_list_is_set() is only to synchronize with the
> adding and removing of the bits in the updates in exit and fork as well as
> with the user manually writing into the set_*_pid files.

So if the kfree() is not an issue, it is just the use of the block from
the freelist which must not point to a wrong item? And therefore the
seqcount?

> > So I *think* the RCU approach should be doable and cover this.
>=20
> Where would you put the synchronize_rcu()? In do_exit()?

simply call_rcu() and let it move to the freelist.

> Also understanding what this is used for helps in understanding the scope
> of protection needed.
>=20
> The pid_list is created when you add anything into one of the pid files in
> tracefs. Let's use /sys/kernel/tracing/set_ftrace_pid:
>=20
>   # cd /sys/kernel/tracing
>   # echo $$ > set_ftrace_pid
>   # echo 1 > options/function-fork
>   # cat set_ftrace_pid
>   2716
>   2936
>   # cat set_ftrace_pid
>   2716
>   2945
>=20
> What the above did was to create a pid_list for the function tracer. I
> added the bash process pid using $$ (2716). Then when I cat the file, it
> showed the pid for the bash process as well as the pid for the cat proces=
s,
> as the cat process is a child of the bash process. The function-fork opti=
on
> means to add any child process to the set_ftrace_pid if the parent is
> already in the list. It also means to remove the pid if a process in the
> list exits.

This adding/ add-on-fork, removing and remove-on-exit is the only write
side?

> When I enable function tracing, it will only trace the bash process and a=
ny
> of its children:
>=20
>  # echo 0 > tracing_on
>  # echo function > current_tracer
>  # cat set_ftrace_pid ; echo 0 > tracing_on
>  2716
>  2989
>  # cat trace
> [..]


>             bash-2716    [003] ..... 36854.662833: rcu_read_lock_held <-m=
tree_range_walk
>             bash-2716    [003] ..... 36854.662834: rcu_lockdep_current_cp=
u_online <-rcu_read_lock_held
>             bash-2716    [003] ..... 36854.662834: rcu_read_lock_held <-v=
ma_start_read
> ##### CPU 6 buffer started ####
>              cat-2989    [006] d..2. 36854.662834: ret_from_fork <-ret_fr=
om_fork_asm
>             bash-2716    [003] ..... 36854.662835: rcu_lockdep_current_cp=
u_online <-rcu_read_lock_held
>              cat-2989    [006] d..2. 36854.662836: schedule_tail <-ret_fr=
om_fork
>             bash-2716    [003] ..... 36854.662836: __rcu_read_unlock <-lo=
ck_vma_under_rcu
>              cat-2989    [006] d..2. 36854.662836: finish_task_switch.isr=
a.0 <-schedule_tail
>             bash-2716    [003] ..... 36854.662836: handle_mm_fault <-do_u=
ser_addr_fault
> [..]
>=20
> It would be way too expensive to check the pid_list at *every* function
> call. But luckily we don't have to. Instead, we set a per-cpu flag in the
> instance trace_array on sched_switch if the next pid is in the pid_list a=
nd
> clear it if it is not. (See ftrace_filter_pid_sched_switch_probe()).
>=20
> This means, the bit being checked in the pid_list is always for a task th=
at
> is about to run.
>=20
> The bit being cleared, is always for that task that is exiting (except for
> the case of manual updates).
>=20
> What we are protecting against is when one chunk is freed, but then
> allocated again for a different set of PIDs. Where the reader has the chu=
nk,
> it was freed and re-allocated and the bit that is about to be checked
> doesn't represent the bit it is checking for.

This I assumed.
And the kfree() at the end can not happen while there is still a reader?

=E2=80=A6
> And if the "lower" bit matches the set_bit from CPU2, we have a false
> positive. Although, this race is highly unlikely, we should still protect
> against it (it could happen on a VM vCPU that was preempted in
> trace_pid_list_is_set()).
>=20
> -- Steve

Sebastian
