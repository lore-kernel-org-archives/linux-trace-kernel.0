Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12DB667;
	Wed, 28 May 2025 00:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392340; cv=none; b=pSOIrvdptemeiydvEgXnIIPupWgUAV0E7Jy0DzuJuNFKAB9mwABeCyDSB6ZnMmK1GsPCll8xbfit+T7pimdTSxvj99OLBAb46u1zjtjh8j09GzwL/muzFBAh/Ymk4mz8cLd2QPYF7I20CXaZB7QKyjrr09QoTcQz9ub8zF5rzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392340; c=relaxed/simple;
	bh=g+0xIknKOTlR5K4WGreRBmyCPChTUPRIXfJeAmIpMes=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZnFtxHtnm8veQrw8qtPdVh7SCEOVovywyzhHrBHrxNnP/3zJAX3iz3WcFKQ84phz+t1KU9xsYsl1gOoMWlPi0uu3kQCIraeQFVOHv3HtTvB6j4tnRB2a7qpwEr37YME6uQOKHcxCEfqYJETmOxCGcBlVW1a4YygDeggIyn6u3qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMAN9Mtd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMAN9Mtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CEAC4CEE9;
	Wed, 28 May 2025 00:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748392340;
	bh=g+0xIknKOTlR5K4WGreRBmyCPChTUPRIXfJeAmIpMes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rMAN9Mtd2zxgFsd+TEboIoNsFfRrF28Iv6bEwtaVSOhoKAQScr0xhei/+w3KGCbsP
	 8+AzVP8+g+FJ/wv/QhcDkwiCSQ3+msKX54bTs9smQIbs9RnaexpF0obJGBLpgxC96q
	 y0wTCjwEkxw5UMpA0VAC96jXqtLi0gXdI2CvDQZ3jU0vksnu8ovWSm/xaIqbktti/m
	 iW4BSqvUxXgBt8OlfPvBi4+uXg41bPD3tvdQAjrMJtnWJU9xvUEIdZDBi8Av+byYn2
	 mvzc4ervmcJQkX0ZwK79QdT3reuOzMQLcW99q99QDojZF951lolT5l+6o6SlSWJ+Jz
	 HGcKtP1vCI4CA==
Date: Wed, 28 May 2025 09:32:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Remove jump to out label in
 ring_buffer_swap_cpu()
Message-Id: <20250528093217.5a106d3561b2234080e3be35@kernel.org>
In-Reply-To: <20250527145753.6b45d840@gandalf.local.home>
References: <20250527145753.6b45d840@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 14:57:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The function ring_buffer_swap_cpu() has a bunch of jumps to the label out
> that simply returns "ret". There's no reason to jump to a label that
> simply returns a value. Just return directly from there.
> 
> This goes back to almost the beginning when commit 8aabee573dff
> ("ring-buffer: remove unneeded get_online_cpus") was introduced. That
> commit removed a put_online_cpus() from that label, but never updated all
> the jumps to it that now no longer needed to do anything but return a
> value.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 897ce51d3bbf..e2aa90dc8d9e 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6309,37 +6309,33 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
>  
>  	if (!cpumask_test_cpu(cpu, buffer_a->cpumask) ||
>  	    !cpumask_test_cpu(cpu, buffer_b->cpumask))
> -		goto out;
> +		return -EINVAL;
>  
>  	cpu_buffer_a = buffer_a->buffers[cpu];
>  	cpu_buffer_b = buffer_b->buffers[cpu];
>  
>  	/* It's up to the callers to not try to swap mapped buffers */
> -	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped)) {
> -		ret = -EBUSY;
> -		goto out;
> -	}
> +	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped))
> +		return -EBUSY;
>  
>  	/* At least make sure the two buffers are somewhat the same */
>  	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
> -		goto out;
> +		return -EINVAL;
>  
>  	if (buffer_a->subbuf_order != buffer_b->subbuf_order)
> -		goto out;
> -
> -	ret = -EAGAIN;
> +		return -EINVAL;
>  
>  	if (atomic_read(&buffer_a->record_disabled))
> -		goto out;
> +		return -EAGAIN;
>  
>  	if (atomic_read(&buffer_b->record_disabled))
> -		goto out;
> +		return -EAGAIN;
>  
>  	if (atomic_read(&cpu_buffer_a->record_disabled))
> -		goto out;
> +		return -EAGAIN;
>  
>  	if (atomic_read(&cpu_buffer_b->record_disabled))
> -		goto out;
> +		return -EAGAIN;
>  
>  	/*
>  	 * We can't do a synchronize_rcu here because this
> @@ -6376,7 +6372,6 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
>  out_dec:
>  	atomic_dec(&cpu_buffer_a->record_disabled);
>  	atomic_dec(&cpu_buffer_b->record_disabled);
> -out:
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_swap_cpu);
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
