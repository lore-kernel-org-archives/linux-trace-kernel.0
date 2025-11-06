Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0F145B3E;
	Thu,  6 Nov 2025 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448469; cv=none; b=Qk04lyK2WCyvYGGHZowczh/A6tXOt3kwy1Ox+cj0cXxVUwNBgVyZa+CaPRWuNe9uJzCXyj6uEABzyFJqCnI9I9UBm00IoOHuSTQ8BgOdwYwixHvT5WcgbUWnHfjFghyQM73YGUtFwd/Dee/Ty5wN9VwnmS3VU+o+cmSU+9Ji9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448469; c=relaxed/simple;
	bh=1xmd/cakKix3IcCYvRr7/Y4fa9JwaDq2p+/Ah1ZkYzA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GWVP5y357Q6nY5uUoMRhMoWvlqr/PFKJLgumBJHxIxa5msVasTPeHD9Sp3pTLqWxVXbZt4aBif4zfSdJn0c/nFZaUEkn8WjYAZxQlUH2j4wCizEAxd+mIiCZKkTWunree/QwhzGzPtr/4o+3QViygZaZ+AWQwOoRptENCEqTD2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOS97Tpq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOS97Tpq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBFBC116C6;
	Thu,  6 Nov 2025 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762448468;
	bh=1xmd/cakKix3IcCYvRr7/Y4fa9JwaDq2p+/Ah1ZkYzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nOS97TpqsElKTaldl0ip8xAa71AH3oUDx090eUgrcWJKZ/kSb5IuWR04hs9aMHwoe
	 r/GjLD69WMar97AYMEDA1LdQ6Vm1/4m2dCDWhYT3HkNL3BELhyq5NnVYQYacn663rA
	 XEMwmoR90VFlh1ejGAU+e0sZRlddluRnYmR9boro6LrfvV3kxfc0QmHOmpCpPa4vG7
	 6Df2JIBUTXdMJ7eMb7j+q85v1nLfVXSivWualE8AUI2tyMq8zs4IRWETTEthzB2EWa
	 oQxbC+9g8bjaStFUSFcabaSDiXRAoqGzRMcVWgemjNKh9QTfBwT3qvDZhWvqw868eM
	 6iHxkwQ1CTzhQ==
Date: Fri, 7 Nov 2025 02:01:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] tracing: Hide __NR_utimensat and _NR_mq_timedsend when
 not defined
Message-Id: <20251107020104.fd7f43772d3b0ce5b28474bd@kernel.org>
In-Reply-To: <20251104205310.00a1db9a@batman.local.home>
References: <20251104205310.00a1db9a@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Nov 2025 20:53:10 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Some architectures (riscv-32) do not define __NR_utimensat and
> _NR_mq_timedsend, and fails to build when they are used.
> 
> Hide them in "ifdef"s.

(I wonder we can expect that other __NR_* also defined on every
architecture?)
Anyway, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202511031239.ZigDcWzY-lkp@intel.com/
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_syscalls.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index e07c5a3cc7ab..e96d0063cbcf 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -1072,7 +1072,9 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
>  	switch (nr) {
>  	/* user arg 1 with size arg at 2 */
>  	case __NR_write:
> +#ifdef __NR_mq_timedsend
>  	case __NR_mq_timedsend:
> +#endif
>  	case __NR_pwrite64:
>  		sys_data->user_mask = BIT(1);
>  		sys_data->user_arg_size = 2;
> @@ -1186,7 +1188,9 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
>  	case __NR_syslog:
>  	case __NR_statx:
>  	case __NR_unlinkat:
> +#ifdef __NR_utimensat
>  	case __NR_utimensat:
> +#endif
>  		sys_data->user_mask = BIT(1);
>  		break;
>  	/* user arg at position 2 */
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
