Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24CA2571BF;
	Tue, 24 Jun 2025 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750583; cv=none; b=KH94Ms1S5QED2KwrHg/vV/ESW8t7EU8yKP2ptswwzpNLpY5cy02k+qx6kjyPNC5t8git0/ljI1TOcG3OtP/s+uEYG32NGVu65472rem4nYIbS7vymM9YnERW3KlV63V2zAMSW/Wpu1Q0Dcn+yciROpjLt5jzsw6YlTyiK2kMZK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750583; c=relaxed/simple;
	bh=V00eRtkZmW3pS/tIYaNjrH9iQXJJOPTf0MJar/mKIVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyYDK2Y05SeUnSystEJ3prNLckCArl8M3mIcZVfsIBxk3NCjNGbhMEr0s7CC7NkjRCf7YsHoTm+q4A+2chyW3BLkUSDPscc1z9zEFUYdfoG+8YgEEU8o4qXhIIYxiFzFEDlQKB79cfbZ2Sl8NKAQBLc6EIT7QqiYe/BYijYnnhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i+Q7ULGT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2cWt1fdr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i+Q7ULGT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2cWt1fdr"
Date: Tue, 24 Jun 2025 09:36:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750750574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3i1MmWycKIjSa1eRswkqM6h98UB4zkHzxS3AAMMtz+E=;
	b=i+Q7ULGTa616Iqv0o+NQzdQRe+CNprF6yDmVee8nf5+26nTWuTfbYPR0WUpzk4/EY2iMl2
	+fb2pom2zzpVlBX9P0s1ICUN0ufE4FTEFZ5+VClq6j1YSuuTD6W6mEBhh4SL0xjcUfPhQQ
	Q2Sh/1lCJxqiepbp2rvDrPGYveHJTIZZ49DmRyxR71rS5OlKOMu+BIbQSZjNVPCb3GcHQl
	Z53kdHqu5KdDyxs0mDqIYVtKLKgEimUBaLJtHy4xCwR0jjjxidFCocEv30xnZAX7kk48ka
	IifuT3wsO3mAbNt554ZvcST+RNRogJE44Yb7+SUEHRI2Lmp+TRlCJJZSXVj0nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750750574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3i1MmWycKIjSa1eRswkqM6h98UB4zkHzxS3AAMMtz+E=;
	b=2cWt1fdrOBRfhNP+nkf8mfmrpu3POA7VXVHVN8W74rVO0Czrg52m/MlZWBGsjeROgUG92h
	JFCpNJyuHUbrjmBw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	john.ogness@linutronix.de
Subject: Re: [RFC PATCH v2 09/12] rv: Replace tss monitor with more complete
 sts
Message-ID: <20250624073609.OA9Q1V4g@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
 <20250514084314.57976-10-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514084314.57976-10-gmonaco@redhat.com>

On Wed, May 14, 2025 at 10:43:11AM +0200, Gabriele Monaco wrote:
> diff --git a/kernel/trace/rv/monitors/tss/tss_trace.h b/kernel/trace/rv/monitors/sts/sts_trace.h
> similarity index 67%
> rename from kernel/trace/rv/monitors/tss/tss_trace.h
> rename to kernel/trace/rv/monitors/sts/sts_trace.h
> index 4619dbb50cc0..d78beb58d5b3 100644
> --- a/kernel/trace/rv/monitors/tss/tss_trace.h
> +++ b/kernel/trace/rv/monitors/sts/sts_trace.h
> @@ -4,12 +4,12 @@
>   * Snippet to be included in rv_trace.h
>   */
>  
> -#ifdef CONFIG_RV_MON_TSS
> -DEFINE_EVENT(event_da_monitor, event_tss,
> +#ifdef CONFIG_RV_MON_STS
> +DEFINE_EVENT(event_da_monitor, event_sts,
>  	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
>  	     TP_ARGS(state, event, next_state, final_state));
>  
> -DEFINE_EVENT(error_da_monitor, error_tss,
> +DEFINE_EVENT(error_da_monitor, error_sts,
>  	     TP_PROTO(char *state, char *event),
>  	     TP_ARGS(state, event));
> -#endif /* CONFIG_RV_MON_TSS */
> +#endif /* CONFIG_RV_MON_STS */

You are changing the tracepoint's name. Should we worry about breaking
userspace?

It probably doesn't matter at the moment, because I doubt anyone is really
relying on this tracepoint. But I think we should have a definite stance on
this, for future references.

I have seen tracepoints being changed (I know of [1][2][3], I was one of
them :P), so it seems to be considered okay. But adding userspace tools to
the equation and it doesn't make sense to me. For example, lttng is using
the page_fault tracepoints [4], which is broken by [3].

If this should be stable user API, then we should starting thinking about
better API which allows changes like this to happen. Otherwise, they should
be clearly documented to be unstable.

(I think I may also need to change my rtapp's tracepoint names at some point
in the future, that's why I am asking)

Best regards,
Nam

[1] commit dbb6ecb328cb ("btrfs: tracepoints: simplify raid56 events")
[2] commit 244132c4e577 ("tracing/timers: Rename the hrtimer_init event to hrtimer_setup")
[3] https://lore.kernel.org/lkml/2dda8c03-072a-43b2-af0c-bb996d64c388@cs.wisc.edu/#t
[4] https://github.com/lttng/lttng-modules/blob/master/include/instrumentation/events/arch/x86/exceptions.h#L88C48-L88C63
