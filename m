Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA9550285;
	Mon,  6 Jan 2025 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202963; cv=none; b=eB76GT27N00mX/bprnIynav5/IwtQhFcCIYC4AAo25/jvIrhzDJjw9ovuhpPe3Jl1VexqOzycOGWitinUdcLKN2USJmUBTAzhzNTSP86retESYv/iwoBOEcype7kMrdUx+1oP3k+K4UUTyhXyth81JaysBUJx2w7iKEBFb5Hmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202963; c=relaxed/simple;
	bh=FBqZMHE+yKppHSOUOg/BRZvQAwzHAZl8sSjzZ3QExbQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=i1iFb0FpjzznPhwsspBdyNA9bQ3yz2zZzxUnlizDn1I/zcdcUviEXHoHCFHHFIRCNNaJOLA7F9Sbbre3Sz0FEMOCjExsVJsJjCEgLvN7O56TDH3B+wY7rFtryUYyBum8/9cgNM2b6Q4HrTRp+e1cUgmWvMoyRU7liDIgxhpD0xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbl9KbGz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbl9KbGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4B2C4CED2;
	Mon,  6 Jan 2025 22:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736202963;
	bh=FBqZMHE+yKppHSOUOg/BRZvQAwzHAZl8sSjzZ3QExbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qbl9KbGz2Jz2bn82HLgOzFFSx/b1ivSofyBJ4i9+gCKBntgITxZH7PB9/Vj8pi4wt
	 4zec4DinM/iL7kSQZ2R36w3aRpqkgXRhcmxUpadH2xtgm3WR8pullTGswCj3HA7MNl
	 Dd2X+OxS5cCDyyMlBEB6oJcQ4xmlTXTROWAC3fel505oYxRExCoGNTCw6acEp/2wHz
	 q9qLH8Sv/06Hc+9qnElFEGc6hmyC6/ozgTs5pYVuJmox3ksHqj6hz1gTMi3YXDi3wS
	 uff6/+eU9JcCKd8U2ym0qd4tYqNvg5eNiZl43pce8myLlASiy8lawukwhIYMrbXC3f
	 ZPpQKC3dnOUmw==
Date: Tue, 7 Jan 2025 07:35:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] tracing: Fix using ret variable in tracing_set_tracer()
Message-Id: <20250107073558.7dd7753a0973afb2962ae775@kernel.org>
In-Reply-To: <20250106111143.2f90ff65@gandalf.local.home>
References: <20250106111143.2f90ff65@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jan 2025 11:11:43 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When the function tracing_set_tracer() switched over to using the guard()
> infrastructure, it did not need to save the 'ret' variable and would just
> return the value when an error arised, instead of setting ret and jumping
> to an out label.
> 
> When CONFIG_TRACER_SNAPSHOT is enabled, it had code that expected the
> "ret" variable to be initialized to zero and had set 'ret' while holding
> an arch_spin_lock() (not used by guard), and then upon releasing the lock
> it would check 'ret' and exit if set. But because ret was only set when an
> error occurred while holding the locks, 'ret' would be used uninitialized
> if there was no error. The code in the CONFIG_TRACER_SNAPSHOT block should
> be self contain. Make sure 'ret' is also set when no error occurred.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202412271654.nJVBuwmF-lkp@intel.com/
> Fixes: d33b10c0c73ad ("tracing: Switch trace.c code over to use guard()")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 0aaf442271e9..5aeb898054e7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6104,8 +6104,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  	if (t->use_max_tr) {
>  		local_irq_disable();
>  		arch_spin_lock(&tr->max_lock);
> -		if (tr->cond_snapshot)
> -			ret = -EBUSY;
> +		ret = tr->cond_snapshot ? -EBUSY : 0;
>  		arch_spin_unlock(&tr->max_lock);
>  		local_irq_enable();
>  		if (ret)
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
