Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1909EBA27;
	Sun, 25 Aug 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724598335; cv=none; b=j3AQNtjcnyemWyUFyiPxQxpgf1VDrx0StrEgYxDXn4T/jytc1qxYHSZfqE4tWsB2x08rOyMMYz561QnnI3bL5WsNtfFrJCR2nBg1h8WlVWdPRrH0lUkj3no4rI7+iL41m6CybWMXykTHZW0SxvnsDXKYayQSHFkKooM3PsqSNr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724598335; c=relaxed/simple;
	bh=f+6J2JxYoziwhkgwPilvolO5/I6DFA4JlIaY7rXHuHk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cLN5MdFMOC1leERNedkAySYiLWE1n+C6y4iV6dP4Fa7bosytZCE+d2oW+Hdpv0yZU44pZZFeK88ULOELAqK7/Yn+Cj0rjUuMlVbt49iwCy21r2Pcgb8pKDWBktkKituvb4qjh/EFTFb+uvT6djyo+gj4vGfwdU5tkSPK2Fp6Fhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIZQNadc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIZQNadc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C00AC32782;
	Sun, 25 Aug 2024 15:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724598334;
	bh=f+6J2JxYoziwhkgwPilvolO5/I6DFA4JlIaY7rXHuHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NIZQNadcFGwdREDDQhZpx6ZPT2Dtd29lRfUCscuFJ/X3bXyDvV4einSoSM70P70R9
	 g8OvIoNBPE0NbshBJO9FEbji76CsKt6bMKXwzzLaLZW/iqk2/FHW1I+utsnAMSpmjY
	 BFwljbGLSmXdxvN4i1oZ541mtSEqHIRjubSYmSbV4iK91qXHdqoc9IMpPWCkX9nMFZ
	 oFRokYEK9te6GdW0eH2sIeeNRG+nvnI8q/tEv5cKtvTSlSv5LEYcNrtQMt1CAg2jxC
	 WPHcgTzu5ixrS7syYgy7Z12k9aLFRqiaueJqCStWmis5tcQrHehDIZcjNEV9Rm/quo
	 iyqgS+475VqZA==
Date: Mon, 26 Aug 2024 00:05:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Zheng Yejian <zhengyejian@huaweicloud.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Mitigate possible softlockup in
 __tracing_open()
Message-Id: <20240826000531.5ff4cc3c3d6a48ecc26069dd@kernel.org>
In-Reply-To: <20240824030343.3218618-1-zhengyejian@huaweicloud.com>
References: <20240824030343.3218618-1-zhengyejian@huaweicloud.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Aug 2024 11:03:43 +0800
Zheng Yejian <zhengyejian@huaweicloud.com> wrote:

> In __tracing_open(), when max latency tracers took place on the cpu,
> the time start of its buffer would be updated, then event entries with
> timestamps being earlier than start of the buffer would be skipped
> (see tracing_iter_reset()).
> 
> Softlockup will occur if the kernel is non-preemptible and too many
> entries were skipped in the loop that reset every cpu buffer, so add
> cond_resched() to avoid it.
> 
> Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
> ---
>  kernel/trace/trace.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ebe7ce2f5f4a..88faa95b457b 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4706,6 +4706,15 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
>  		for_each_tracing_cpu(cpu) {
>  			ring_buffer_read_start(iter->buffer_iter[cpu]);
>  			tracing_iter_reset(iter, cpu);
> +			/*
> +			 * When max latency tracers took place on the cpu, the time start
> +			 * of its buffer would be updated, then event entries with timestamps
> +			 * being earlier than start of the buffer would be skipped
> +			 * (see tracing_iter_reset()). Softlockup will occur if the kernel
> +			 * is non-preemptible and too many entries were skipped in the loop,
> +			 * so add cond_resched() to mitigate it.
> +			 */
> +			cond_resched();

OK, but why we cond_resched() only here? Another tracing_iter_reset() in
s_start() does not cause the soft lockups in the same situation?

Thank you,


>  		}
>  	} else {
>  		cpu = iter->cpu_file;
> -- 
> 2.25.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
