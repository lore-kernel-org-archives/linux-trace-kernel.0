Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528013F4119;
	Thu, 14 May 2026 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787397; cv=none; b=PAP5cIGAUL0Qr0trTgFaA3OSARzW6G+OZmr3X6MaRRhRmy5RsNGM9lssfNRVKvy94zFhV4D1VRzftqbJOZHpmJrUvqfiJ/uceK3SDz8/iXRwa/YJOCNNy2u0/aQAiwqXO15nh1XcygKMseLhy54vRjF8gTCk1rFp/jOycal8wmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787397; c=relaxed/simple;
	bh=Mx4wtsH5+NjyGsP/HE01zzfsENrVvwY5wlHkuUFnPrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CujVR74+e9JpciEXvmHurZXBkVq/su9w4u7Gk4DQvIcUqLAeq4GCB2dlGIN271JGWlqcaNQB7CGXxMy6sWdw7AVRCFnKYbFP9IZuUxk47UPX09tKbUELm6FpdKmrGxv/DDRjC+ovCT+MHLweqRMt2rtiLwkOfHYWnOfENidNzto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id C5B2B405BD;
	Thu, 14 May 2026 19:36:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id B8B212002E;
	Thu, 14 May 2026 19:36:31 +0000 (UTC)
Date: Thu, 14 May 2026 15:36:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yiyang Chen <cyyzero16@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/clock: Provide !HAVE_UNSTABLE_SCHED_CLOCK stub
 for sched_clock_stable()
Message-ID: <20260514153637.553ad41c@gandalf.local.home>
In-Reply-To: <56e45338858946cd9581b75c8bd45dd37dba52c5.1778773587.git.cyyzero16@gmail.com>
References: <56e45338858946cd9581b75c8bd45dd37dba52c5.1778773587.git.cyyzero16@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: gxr33t5ff35t4azr9w4tmcwge7tb73ek
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: B8B212002E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+xv7vj7iHDSN5VcmAmfB14CdK6qaC/ngg=
X-HE-Tag: 1778787391-588625
X-HE-Meta: U2FsdGVkX1+cy0D4gWks1x+FrLK8C4ogBqctE6FEgtBIyvebx6yUr0mhmcxNX/+vf9+S6KeaZB98ZHfK3bk8jXIsNJVC5WikbCFOrEdVXj7c1NYOW+USlCOSY3Tpy0DjzcNvVUtGkKtVYILfqrQQjCaWDI0VRL5ppmWfRF2kVdz0dnNUbPxHHUZG9c2FJYuIwAD/l1ehjt6Ey+eeHGKeGbBf3dxNuNDZ4bbsTZLFHO74wRkhe8iC/0+VEYj7HH5xTq+Zz3XV4Hb+Dvv6wP+xDdGL7JKTcq6pE7YZ4+J/zyWr/myGE64gSZts10Ts7HeFDt1sQf8rnYe7FMbPTUKjMHsosC6bVJyI/NgiOMZpbBYxpwppjtzza6n0+hbBAxkq1mWwxXEXQc8QG2Yuv01qZA==

On Fri, 15 May 2026 00:05:05 +0800
Yiyang Chen <cyyzero16@gmail.com> wrote:

> When CONFIG_HAVE_UNSTABLE_SCHED_CLOCK is disabled, sched_clock() is
> already assumed to provide stable semantics, but the public header
> doesn't provide a sched_clock_stable() stub for that case.
> 
> Add a header stub that always returns true and clean up the duplicate
> local stub in ring_buffer.c, so callers can use sched_clock_stable()
> unconditionally.
> 
> Signed-off-by: Yiyang Chen <cyyzero16@gmail.com>
> ---
>  include/linux/sched/clock.h | 5 +++++
>  kernel/trace/ring_buffer.c  | 7 -------
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/sched/clock.h b/include/linux/sched/clock.h
> index 196f0ca351a2..39f0a7f94bfc 100644
> --- a/include/linux/sched/clock.h
> +++ b/include/linux/sched/clock.h
> @@ -33,6 +33,11 @@ extern u64 sched_clock_cpu(int cpu);
>  extern void sched_clock_init(void);
>  
>  #ifndef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
> +static inline int sched_clock_stable(void)
> +{
> +	return 1;
> +}
> +
>  static inline void sched_clock_tick(void)
>  {
>  }
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 5326924615a4..02691c3c6dd6 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3769,13 +3769,6 @@ rb_add_time_stamp(struct ring_buffer_per_cpu *cpu_buffer,
>  	return skip_time_extend(event);
>  }
>  
> -#ifndef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
> -static inline bool sched_clock_stable(void)
> -{
> -	return true;
> -}
> -#endif
> -
>  static void
>  rb_check_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
>  		   struct rb_event_info *info)


Thanks for moving this out of the ring buffer code.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
