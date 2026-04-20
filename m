Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931CC212D7C;
	Mon, 20 Apr 2026 23:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776729448; cv=none; b=rPNOa4cR4+QeznOtH6i8bmakZaeQkO1WuAq78IljZobulML53KufMqbbXFl13u6LcQWHkKwoTWJz57EX3l/dPf2F/MYBs1GzgUeSHBz2tqDKWkIPlNK+tQjj/d+7uZdzd7WcH5m2YlRhuk7TQsc3Swn+BBzMkcdOD0AFyZpmzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776729448; c=relaxed/simple;
	bh=SgbK2Ycca8ktwcDxfzwexeOL/UiqLEfnnFekZIG/eLA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f2M1AvVPYNT/mQH+mDz/rQ5HW0u7jPmi6EK8idSbB+f5wW9/toyBqpe5iHS72yRSLy7cL6/5DfPLyHb4UoS54UNDy/ZI3mkLYpnhTaa/hI2PridfyaXM1CpkTcCVVeog2aft6taoGVMsSXnlAIkekdN11+A00EkVsC8LsUFFZWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1VWzgzh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1VWzgzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76C4C19425;
	Mon, 20 Apr 2026 23:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776729448;
	bh=SgbK2Ycca8ktwcDxfzwexeOL/UiqLEfnnFekZIG/eLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P1VWzgzhKoGyzO4Rl1xPscbFQcIMcZuTr4h7e3kz0Q1dpLi/YTYYYnXqL0w56mklI
	 Ar/Y/TGUm3kwesvEEllPzL5Yr8Wq1JZbcndlyeQfx780KRyCmKS7w9w2FhDKA5BC8b
	 CT8GGBU7TXNN27FPdyznccTMWhcxHfoanD2WcRz5jvvHic/wxC01qaIODQeIM5OxUR
	 x4UflF0c1sMZ3J5QP3bzyPZ2gb0cQtwnSFiIrGWGQULg5Cw32wxDXPEh8F628Gu0BE
	 E0mtU9UqzHyvWx3tOkJhiFZN3bLkSMs8wtCUwqxBNvDB5+p0YhrcUobTY5+iOdEb1W
	 2KVTXxSjfFmnA==
Date: Tue, 21 Apr 2026 08:57:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@elte.hu>, Frederic
 Weisbecker <fweisbec@gmail.com>, Steven Rostedt <srostedt@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 paulmck@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] tracing: branch: Fix inverted check on stat tracer
 registration
Message-Id: <20260421085725.4e5c8ebf3a5e0470bab61e4e@kernel.org>
In-Reply-To: <20260420-tracing-v1-1-d8f4cd0d6af1@debian.org>
References: <20260420-tracing-v1-1-d8f4cd0d6af1@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 06:25:09 -0700
Breno Leitao <leitao@debian.org> wrote:

> init_annotated_branch_stats() and all_annotated_branch_stats() check the
> return value of register_stat_tracer() with "if (!ret)", but
> register_stat_tracer() returns 0 on success and a negative errno on
> failure. The inverted check causes the warning to be printed on every
> successful registration, e.g.:
> 
>   Warning: could not register annotated branches stats
> 
> while leaving real failures silent. The initcall also returned a
> hard-coded 1 instead of the actual error.
> 
> Invert the check and propagate ret so that the warning fires on real
> errors and the initcall reports the correct status.
> 

Good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Fixes: 002bb86d8d42 ("tracing/ftrace: separate events tracing and stats tracing engine")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  kernel/trace/trace_branch.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
> index 6809b370e991d..d1564db95a8f5 100644
> --- a/kernel/trace/trace_branch.c
> +++ b/kernel/trace/trace_branch.c
> @@ -373,10 +373,10 @@ __init static int init_annotated_branch_stats(void)
>  	int ret;
>  
>  	ret = register_stat_tracer(&annotated_branch_stats);
> -	if (!ret) {
> +	if (ret) {
>  		printk(KERN_WARNING "Warning: could not register "
>  				    "annotated branches stats\n");
> -		return 1;
> +		return ret;
>  	}
>  	return 0;
>  }
> @@ -438,10 +438,10 @@ __init static int all_annotated_branch_stats(void)
>  	int ret;
>  
>  	ret = register_stat_tracer(&all_branch_stats);
> -	if (!ret) {
> +	if (ret) {
>  		printk(KERN_WARNING "Warning: could not register "
>  				    "all branches stats\n");
> -		return 1;
> +		return ret;
>  	}
>  	return 0;
>  }
> 
> ---
> base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
> change-id: 20260420-tracing-3f1367ee4b93
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
