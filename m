Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC652222AC;
	Wed, 16 Apr 2025 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804624; cv=none; b=lcxoJgutJ/IkbQnyhMfE1Aa/rpdbDHnIPjrptzZGa8o4oKmGi6TcliIVfUfQtTpOXrBOICtQoYf73COysOnYOoYKDZif5nvU0DaYP00e4XsHszM62eVMfXtvVpproPhOyjZIcnjR2Ns03psh1zB5+qUBUPSCvc7q2gBvtPSnZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804624; c=relaxed/simple;
	bh=DBHd+n1xvpx0LD/RgJDY+JYvv1dy95CSWgQOK70yanM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qk6LE0TEEr+NpBAkpp5ei4LZiSu/46PjHnr4pIk4XcphQOpfdraFjQCZ+/vWmZDn6wJjam54cEar1US3bRpKbYmH5fi24x6vx6+/dPJIV3KZ74qtIHoBw03Y4RFHMv+rxUopaRGH3qynLlQ9s5QdqeosD4Y1hq7uup92zfdwjK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nk8VrfjG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5uI8YFSp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nk8VrfjG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5uI8YFSp"
Date: Wed, 16 Apr 2025 13:56:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744804619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIIyuonDNoGtEXjJpWrXHyZnPS1l4K/5Xgfv/afWSJw=;
	b=Nk8VrfjG182gR9y5Ry8riE2xzrpd9q8Rg42ca78vNcCES4Yfv0MlnIrbDhtuIOoqxn3jpz
	cFM9ruyVVjUjoFiNz9MITgIUfKKVXSHG5ywN4GE6m4cstbH3Clt4PBnS5p6oXFV89BV0Gd
	X2SJ7K647MDGCp+JUof8tvR+4MRpK+mr+KANVX1KoUKKQrt1SZZrjRotcAJHFdpiOnD+29
	VxrOZ/FBUmzZXU4/gIqxSkd71gx/VJutgtpsJa8VwQWlR4EYnfLHiKxB04m/Oy188w4I6F
	CzCzHgWn5ggmVq/+nbg5QYanAcI4fArt0duQlLD3Oj/sSvj94AL9gHllVIWegw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744804619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIIyuonDNoGtEXjJpWrXHyZnPS1l4K/5Xgfv/afWSJw=;
	b=5uI8YFSpf0zv8SvPq/Sub/c9KwB4t/GgYP2EDLXxgeVtEiidjiP7FD6PLDlmm1bNFzHPAN
	TEkBCNNj4tN03OCQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v3 13/22] rv: Add support for LTL monitors
Message-ID: <20250416115658.AkFAts-B@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
 <19f424c910bfa0f4854117e3f8771aeb6e98a9d2.1744785335.git.namcao@linutronix.de>
 <4edad1940b2d05f1997895d4bbc11f02a921e8e5.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4edad1940b2d05f1997895d4bbc11f02a921e8e5.camel@redhat.com>

On Wed, Apr 16, 2025 at 11:34:53AM +0200, Gabriele Monaco wrote:
> On Wed, 2025-04-16 at 08:51 +0200, Nam Cao wrote:
> >  #endif /* CONFIG_DA_MON_EVENTS_ID */
> > +#if CONFIG_LTL_MON_EVENTS_ID
> > +TRACE_EVENT(event_ltl_monitor_id,
> > +
> > +	TP_PROTO(struct task_struct *task, char *states, char
> > *atoms, char *next),
> > +
> > +	TP_ARGS(task, states, atoms, next),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(comm, task->comm)
> > +		__field(pid_t, pid)
> > +		__string(states, states)
> > +		__string(atoms, atoms)
> > +		__string(next, next)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__assign_str(comm);
> > +		__entry->pid = task->pid;
> > +		__assign_str(states);
> > +		__assign_str(atoms);
> > +		__assign_str(next);
> > +	),
> > +
> > +	TP_printk("%s[%d]: (%s) x (%s) -> (%s)", __get_str(comm),
> > __entry->pid, __get_str(states),
> > +		  __get_str(atoms), __get_str(next))
> > +);
> > +
> > +TRACE_EVENT(error_ltl_monitor_id,
> > +
> > +	TP_PROTO(struct task_struct *task),
> > +
> > +	TP_ARGS(task),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(comm, task->comm)
> > +		__field(pid_t, pid)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__assign_str(comm);
> > +		__entry->pid = task->pid;
> > +	),
> > +
> > +	TP_printk("%s[%d]: violation detected", __get_str(comm),
> 
> In your workflow you're probably using events and errors together, but
> wouldn't it help printing the atoms together with the violation
> detected?
> At least to give a clue on the error in case the user doesn't want to
> see the entire trace (which might be needed for a full debug though).
> 
> The same could be said from reactors, the user doesn't have much
> information to infer what went wrong.

Actually my intention for the "event" tracepoints are only for debugging
the monitor itself. I don't want to bother users with the Büchi automaton,
because that's implementation details.

The "error" tracepoints should be enough for identifying problems with
realtime applications. Because errors from the monitors are unambiguous:

  - pagefault monitor: error means an RT task is raising pagefault
  - sleep monitor: error means an RT task is delayed unboundedly

That and a stacktrace (e.g. from perf) is enough to understand the problem.
That was all I need to identifying problems with pipewire using the
monitors.

In the future, we can have other monitors whose warnings are ambiguous, and
a more detailed error message will be necessary. But for now, I think we
can keep it simple.

> > +def abbreviate_atoms(atoms: list[str]) -> list[str]:
> > +    abbrs = list()
> > +    for atom in atoms:
> > +        size = 1
> > +        while True:
> > +            abbr = atom[:size]
> > +            if sum(a.startswith(abbr) for a in atoms) == 1:
> > +                break
> > +            size += 1
> > +        abbrs.append(abbr.lower())
> > +    return abbrs
> 
> I get this is just a matter of preference, so feel free to ignore my
> suggestion.
> This abbreviation algorithm doesn't work too well with atoms starting
> with the same substring and can produce some unexpected result:
> 
> LTL_BLOCK_ON_RT_MUTEX:                b,
> LTL_KERNEL_THREAD:                    ke,
> LTL_KTHREAD_SHOULD_STOP:              kt,
> LTL_NANOSLEEP:                        n,
> LTL_PI_FUTEX:                         p,
> LTL_RT:                               r,
> LTL_SLEEP:                            s,
> LTL_TASK_IS_MIGRATION:                task_is_m,
> LTL_TASK_IS_RCU:                      task_is_r,
> LTL_WAKE:                             wa,
> LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO:    woken_by_e,
> LTL_WOKEN_BY_HARDIRQ:                 woken_by_h,
> LTL_WOKEN_BY_NMI:                     woken_by_n,
> 
> "woken_by_*" and "task_is_*" atom can get unnecessarily long and
> while reading "kt" I might think about kernel_thread.
> 
> I was thinking about something like:
> 
> LTL_BLOCK_ON_RT_MUTEX:                b_o_r_m
> LTL_KERNEL_THREAD:                    k_t
> LTL_KTHREAD_SHOULD_STOP:              k_s_s
> LTL_NANOSLEEP:                        n
> LTL_PI_FUTEX:                         p_f
> LTL_RT:                               r
> LTL_SLEEP:                            s
> LTL_TASK_IS_MIGRATION:                t_i_m
> LTL_TASK_IS_RCU:                      t_i_r
> LTL_WAKE:                             w
> LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO:    w_b_e_o_h_p
> LTL_WOKEN_BY_HARDIRQ:                 w_b_h
> LTL_WOKEN_BY_NMI:                     w_b_n
> 
> or even
> 
> LTL_BLOCK_ON_RT_MUTEX:                b_m
> LTL_KERNEL_THREAD:                    k_t
> LTL_KTHREAD_SHOULD_STOP:              k_s_s
> LTL_NANOSLEEP:                        n
> LTL_PI_FUTEX:                         p_f
> LTL_RT:                               r
> LTL_SLEEP:                            s
> LTL_TASK_IS_MIGRATION:                t_m
> LTL_TASK_IS_RCU:                      t_r
> LTL_WAKE:                             w
> LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO:    w_e_h_p
> LTL_WOKEN_BY_HARDIRQ:                 w_h
> LTL_WOKEN_BY_NMI:                     w_n
> 
> I used the following code to come up with this:
> 
> def abbreviate_atoms(atoms: list[str]) -> list[str]:
>     # completely arbitrary..
>     skip = [ "is", "by", "or", "and" ]
>     def abbr (n, s):
>         return '_'.join(word[:n] for word in s.lower().split('_') if word not in skip)
>     for n in range(1, 32):
>         abbrs = [abbr(n, a) for a in atoms]
>         if len(abbrs) == len(set(abbrs)):
>             return abbrs
> 
> Which could even be tuned to use 2 letters per block instead of 1
> (improving readability by a lot actually)..
> 'bl_on_rt_mu', 'ke_th', 'kt_sh_st', 'na', 'pi_fu', 'rt', 'sl', 'ta_mi',
> 'ta_rc', 'wa', 'wo_eq_hi_pr', 'wo_ha', 'wo_nm'
> 
> What do you think?

Yes, this would be very nice. But as mentioned, this is mainly for
debugging the monitors, not for end users. Therefore I don't want to spend
too much energy on it.

Let me see how "nice" we can make it without spending too many hours.
Thanks for the suggestion!

Best regards,
Nam
