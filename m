Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E8D2D7804;
	Thu, 12 Mar 2026 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303309; cv=none; b=kl5ULg5MPmaAByJn17g9RpxYhZPgd3/ZCzFAdYw3JOCygdqp7MC2H0lJjvNYHrOgRaHhZotQOCoDHMUIyuhcvE4T5N4cRiYPWeJGvAmcYDnhPJFXniPek3h/+1aeCYmaC4JRAYSilTc3YaR/h8YhiTLoht8tvvSwnjymeozyN2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303309; c=relaxed/simple;
	bh=D2VqqLzzQNOEjdSWnphzoUNSdnnSZO+F4wcQXWLpCmM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KTQbb56ziiWNFCuZJJFpYfYDZ9that2YITejVgkUJC/pi2V56Y1aPrJlxGZBm62JXU22t8P68RUvG6ZWZAZcKvRjK4RuZqGMnE55ipkR2Inw4bqEHC4rcEFSImCz19UaFAw94tk6JBjrTXBqGJy73CbR2LEb3XAKdWotIWD8l9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBvFwZs8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBvFwZs8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1C5C4CEF7;
	Thu, 12 Mar 2026 08:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773303308;
	bh=D2VqqLzzQNOEjdSWnphzoUNSdnnSZO+F4wcQXWLpCmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pBvFwZs8RddxqQ7hXJ9cQr1nOdGW33VCwVWzYucgwZcMptZihMNf+c+d34PRN2UzK
	 bvyzuv1IDrjvboZUYAMhCrNBMundkx7IdqDe0pc+37BmcA0cxy+CMGsptZSH6/ZQXt
	 RiCSS5dLy4+WY8mcpbSZ1OSgtuFCeYbc9flIihnUKTludMsS+ShwHMatBik7EHtF2X
	 4qcOeNDSs9ZwOX5vv8j1p8X49z03iSRtv7DYcm0dWVzbrBIFKDxMjrqTI3CFubATaz
	 fXcD/79fdNai7hewcBch+NWSjPuYYB0HifUnQOQawtvbDru0XVHQtjF5o4ihfdT5wS
	 X0Jgiu38WRMug==
Date: Thu, 12 Mar 2026 17:15:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Brian Geffon <bgeffon@google.com>, John
 Stultz <jstultz@google.com>, Ian Rogers <irogers@google.com>, Suleiman
 Souhlal <suleiman@google.com>
Subject: Re: [PATCH v2 3/3] tracing: Show TID and flags for PI futex system
 call trace event
Message-Id: <20260312171505.bd5c45cb67d42c7ab3cfe1f9@kernel.org>
In-Reply-To: <20260310201036.879130564@kernel.org>
References: <20260310200954.285663884@kernel.org>
	<20260310201036.879130564@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 16:09:57 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> For the futex system call trace event for FUTEX_LOCK_PI and
> FUTEX_UNLOCK_PI commands, show the TID from the value (which is usually in
> hex) as well as translate the flags (DIED and WAITERS).
> 
>  pi_mutex_hammer-1098    [000] .....   121.876928: sys_futex(uaddr: 0x560f40cc8180 (0x450) tid: 1104, FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG, val: 0, timespec: 0x7f2f9d4b1e50 (0.000100000))
>  pi_mutex_hammer-1128    [000] .....   121.877120: sys_futex(uaddr: 0x560f40cc8180 (0x8000042a) tid: 1066 (WAITERS), FUTEX_LOCK_PI|FUTEX_PRIVATE_FLAG, val: 0, timespec: 0x7f2f8e493e50 (0.000100000))
>  pi_mutex_hammer-1106    [000] .....   121.877242: sys_futex(uaddr: 0x560f40cc8180 (0x80000452) tid: 1106 (WAITERS), FUTEX_UNLOCK_PI|FUTEX_PRIVATE_FLAG, val: 0)
> 
> This makes it easier to see the hand off of a mutex and who the owner was.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!


> ---
> Changes since v1: https://lore.kernel.org/all/20260303174442.548b6524@gandalf.local.home/
> 
> - Updated to have the print processing in kernel/futex/syscall.c
> 
>  kernel/futex/syscalls.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
> index a46706d6bc6c..24d912d9b20d 100644
> --- a/kernel/futex/syscalls.c
> +++ b/kernel/futex/syscalls.c
> @@ -211,6 +211,9 @@ void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *args,
>  	unsigned int op, cmd;
>  	bool done = false;
>  
> +	op = args[1];
> +	cmd = op & FUTEX_CMD_MASK;
> +
>  	for (int i = 0; !done && i < nr_args; i++) {
>  
>  		if (seq_buf_has_overflowed(s))
> @@ -225,11 +228,30 @@ void futex_print_syscall(struct seq_buf *s, int nr_args, unsigned long *args,
>  					seq_buf_printf(s, " (%u)", val);
>  				else
>  					seq_buf_printf(s, " (0x%x)", val);
> +
> +				switch(cmd) {
> +				case FUTEX_LOCK_PI:
> +				case FUTEX_UNLOCK_PI:
> +					seq_buf_printf(s, " tid: %d",
> +						       val & FUTEX_TID_MASK);
> +
> +					if (!(val & (FUTEX_OWNER_DIED|FUTEX_WAITERS)))
> +						break;
> +
> +					seq_buf_puts(s, " (");
> +					if (val & FUTEX_WAITERS)
> +						seq_buf_puts(s, "WAITERS");
> +					if (val & FUTEX_OWNER_DIED) {
> +						if (op & FUTEX_WAITERS)
> +							seq_buf_putc(s, '|');
> +						seq_buf_puts(s, "DIED");
> +					}
> +					seq_buf_putc(s, ')');
> +					break;
> +				}
>  			}
>  			continue;
>  		case 1:
> -			op = args[i];
> -			cmd = op & FUTEX_CMD_MASK;
>  			if (cmd <= FUTEX_LOCK_PI2)
>  				seq_buf_printf(s, ", %s", __futex_cmds[cmd]);
>  			else
> -- 
> 2.51.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
