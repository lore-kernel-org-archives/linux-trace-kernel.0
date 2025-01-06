Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C84A1DDA2E;
	Mon,  6 Jan 2025 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169888; cv=none; b=BmE01uThYGLj82UdbJfT8bWWuEznPXKs30+QUw4AsrE581he4BYmB80W6elkO26vtM25ozFo9/eziLmsCuFkwOWeTzCMwAT8TgOGl/r/RaU6JaaTOTdpb7i5TyJrdFvd8OS1Qas5Pc9VM5/G0wvlV+v0Lj2r+iyQ6lPyzCOoVNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169888; c=relaxed/simple;
	bh=ExWqDD7WEFcCsYzyUGTWC1ki7ltdi+y3LVg5hPlWiuE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a+7FhsUOsbLUX34DwZQNveUl+KX2cLPkn75heUiHi567iCORsbrcvZQT4g7vYikYFhnDGvf804FjVytiADllRvCja198wm5/E4Q7dhEyBXXiypQDKxwhp4Uj5MWz6cSEYTwlUGn7nPDp8VnudRwS+UjF0g0rm3bxWQMjUKrhe90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qM33E4OM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qM33E4OM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90669C4CED2;
	Mon,  6 Jan 2025 13:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736169888;
	bh=ExWqDD7WEFcCsYzyUGTWC1ki7ltdi+y3LVg5hPlWiuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qM33E4OM4XuzFr5dK36wdItkSgx9Libym6en3yLSGK25xTziEvA6J1UFmbfXRCAhk
	 Y/LjWk3QjylAEz1x8s5Mx+f5LfHzVeR9v8L9kC7tLFiUHTPcV1HqaEIc4W+Ixm1J3g
	 Y0S4pb9M1tvSDoWstMLIulB4USMxER/hfCSexYI/GHwCCbaW3a//gQPQQKGFQI49NF
	 xblCvc9V4f8MKmwTLh+DzsurT+rq0kyDmzr+1529jK98slJ02y6Rq0h+HqXWoRuyZ9
	 SAjmCK3P74A5b7BzmVvFN5WHMVWVlILO6pkAojNPiRcQ3lpPvaCem8/zsNU//Y/l1d
	 mRqnMRDRDbz/A==
Date: Mon, 6 Jan 2025 22:24:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: rostedt@goodmis.org, mark.rutland@arm.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: print lazy preemption model
Message-Id: <20250106222444.28141b2b05cb4c7906f5e91e@kernel.org>
In-Reply-To: <20250103093647.575919-1-sshegde@linux.ibm.com>
References: <20250103093647.575919-1-sshegde@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jan 2025 15:06:47 +0530
Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> Print lazy preemption model in ftrace header when latency-format=1.
> 
> cat /sys/kernel/debug/sched/preempt 
> none voluntary full (lazy)
> 
> Without patch:
> latency: 0 us, #232946/232946, CPU#40 | (M:unknown VP:0, KP:0, SP:0 HP:0 #P:80)
> With Patch:
> latency: 0 us, #1897938/25566788, CPU#16 | (M:lazy VP:0, KP:0, SP:0 HP:0 #P:80)
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,


> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/trace/trace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index f8aebcb01e62..b6e40e8791fa 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4122,6 +4122,7 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
>  		   preempt_model_none()      ? "server" :
>  		   preempt_model_voluntary() ? "desktop" :
>  		   preempt_model_full()      ? "preempt" :
> +		   preempt_model_lazy()	     ? "lazy"    :
>  		   preempt_model_rt()        ? "preempt_rt" :
>  		   "unknown",
>  		   /* These are reserved for later use */
> -- 
> 2.39.3
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
