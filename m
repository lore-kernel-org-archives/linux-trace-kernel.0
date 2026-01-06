Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE17260D;
	Tue,  6 Jan 2026 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660751; cv=none; b=C3Mnd0SuGpFv3yn33Udl3NsnzZa74S+zn1bcypYJnubtcLWY9oNi6IhbTlIC6uzgFloXxmdGseFrho0Nn2OZ3wyk9Ne8N9XluYaIZt17vfYBOrBeheuocrWAiNb7aqPVaqkRSA9LonSd22fuTqWCsXeYJ2ULu8vx+n9OyMLuexw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660751; c=relaxed/simple;
	bh=Qog7+iQQQxOnwzc9mbSXRPC+4h9WsleX9uiSCYqrkBc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rU8mNVvijkdCYyg9BBo5VRH3dFiKj9eqLaGNcRdk3gwxRUCei/rsixSLVqwM/2QZqMI/DMcO98YZ/T3nOeF+2oyQrpzi5kTwKTx+eBfPvftIRCB1OeXVv992+TWFV2lCxoRg+LBEoiyoP98urszoVMqd31FxUjYZIYMlDSmSC54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jhp8APPo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jhp8APPo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C98C116D0;
	Tue,  6 Jan 2026 00:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767660751;
	bh=Qog7+iQQQxOnwzc9mbSXRPC+4h9WsleX9uiSCYqrkBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jhp8APPoVax3FOh5oo/u+QLsT6HESKlw98iiuJZjzAn/XDCMM+riXaphEFZTyQH2b
	 n3mChhGqtK9G2MY3l1mE5WCAQ71FYn2H+4RXFEU5cruUiZcyOQFcEg8iymoOH2cWvE
	 DB+QGOWt/E6tQbDoY8VEf965Bam4IAuWwI8cI4s70M39UA14UXwnuvDezQmuH4xjRe
	 0UaPLjB/FH8l7M/QjdzZ95RIJFc/x2eYPNByCWD4B17bPPGt5D2VE3psNeOb/y+Nba
	 fQa3KQzG5ln5yeGT2elEccbyHkp1CE+kdsOHJqMGK8mm1tda4YF1wA1VjEHaqDPQl6
	 Kzc8WP+lvv+IQ==
Date: Tue, 6 Jan 2026 09:52:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Wupeng Ma <mawupeng1@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] ring-buffer: Avoid softlockup in ring_buffer_resize()
 during memory free
Message-Id: <20260106095227.fb363651e87e5aa1855779bc@kernel.org>
In-Reply-To: <20251228065008.2396573-1-mawupeng1@huawei.com>
References: <20251228065008.2396573-1-mawupeng1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Dec 2025 14:50:07 +0800
Wupeng Ma <mawupeng1@huawei.com> wrote:

> When user resize all trace ring buffer through file 'buffer_size_kb',
> then in ring_buffer_resize(), kernel allocates buffer pages for each
> cpu in a loop.
> 
> If the kernel preemption model is PREEMPT_NONE and there are many cpus
> and there are many buffer pages to be freed, it may not give up cpu
> for a long time and finally cause a softlockup.
> 
> To avoid it, call cond_resched() after each cpu buffer free as Commit
> f6bd2c92488c ("ring-buffer: Avoid softlockup in ring_buffer_resize()")
> does.
> 
> Detailed call trace as follow:
> 
>   rcu: INFO: rcu_sched self-detected stall on CPU
>   rcu: 	24-....: (14837 ticks this GP) idle=521c/1/0x4000000000000000 softirq=230597/230597 fqs=5329
>   rcu: 	(t=15004 jiffies g=26003221 q=211022 ncpus=96)
>   CPU: 24 UID: 0 PID: 11253 Comm: bash Kdump: loaded Tainted: G            EL      6.18.2+ #278 NONE
>   pc : arch_local_irq_restore+0x8/0x20
>    arch_local_irq_restore+0x8/0x20 (P)
>    free_frozen_page_commit+0x28c/0x3b0
>    __free_frozen_pages+0x1c0/0x678
>    ___free_pages+0xc0/0xe0
>    free_pages+0x3c/0x50
>    ring_buffer_resize.part.0+0x6a8/0x880
>    ring_buffer_resize+0x3c/0x58
>    __tracing_resize_ring_buffer.part.0+0x34/0xd8
>    tracing_resize_ring_buffer+0x8c/0xd0
>    tracing_entries_write+0x74/0xd8
>    vfs_write+0xcc/0x288
>    ksys_write+0x74/0x118
>    __arm64_sys_write+0x24/0x38
> 
> Signed-off-by: Wupeng Ma <mawupeng1@huawei.com>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> ---
>  kernel/trace/ring_buffer.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index afcd3747264d2..3ba08fc1b7d05 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3121,6 +3121,8 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
>  					list) {
>  			list_del_init(&bpage->list);
>  			free_buffer_page(bpage);
> +
> +			cond_resched();
>  		}
>  	}
>   out_err_unlock:
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
