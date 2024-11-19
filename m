Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ABE1CF28C;
	Tue, 19 Nov 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029744; cv=none; b=lv9pWr90XK+JlChxlSgBkUvnN2wCAVdd1lbyOqlBk6KszehiJ+N6l/277LaRrtB5vQrSfFRaSrwm5XfGjJAMY+cfJEJZDbmzv+vmO/7yj5ExBzR9UN6HXFKfIdwPNCGqOZlZFRm/uQAiDAlxEcsbELW9jvzu64mINDofav3BVQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029744; c=relaxed/simple;
	bh=449agTMGEJsvMmzF4jteImk9vRetwz+2aS+3jTMj4GA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wbr6N2m+kLGfJVtMRAz3TpQGyw2rCFnvm0cNI0ZZEtD9AaKlHmsg5YlDjGozcozSixhTxCcQSP76qVL6C2+muYYcXBtERbP3j/Il7+ky6mRa55nOiOUiyNfewSSR3i1nkjTH++Dmg527MZAq5ZnsR7SXc2Z9AeNCw+5wufQm/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEB1C4CECF;
	Tue, 19 Nov 2024 15:22:23 +0000 (UTC)
Date: Tue, 19 Nov 2024 10:22:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: tglozar@redhat.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jkacur@redhat.com
Subject: Re: [PATCH] rtla/timerlat: Fix histogram ALL for zero samples
Message-ID: <20241119102257.3df588ce@gandalf.local.home>
In-Reply-To: <20241119134858.1862632-1-tglozar@redhat.com>
References: <20241119134858.1862632-1-tglozar@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 14:48:57 +0100
tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> rtla timerlat hist currently computers the minimum, maximum and average
> latency even in cases when there are zero samples. This leads to
> nonsensical values being calculated for maximum and minimum, and to
> divide by zero for average.
> 
> A similar bug is fixed by 01b05fc0e5f3 ("rtla/timerlat: Fix histogram
> report when a cpu count is 0") but the bug still remains for printing
> the sum over all CPUs in timerlat_print_stats_all.
> 
> The issue can be reproduced with this command:
> 
> $ rtla timerlat hist -U -k -d 1s
> Index
> over:
> count:
> min:
> avg:
> max:
> Floating point exception (core dumped)
> 
> (There are always no samples with -U unless the user workload is
> created; the -k is to work around a bug with -U.)
> 
> Fix the bug by omitting max/min/avg when sample count is zero,
> displaying a dash instead, just like we already do for the individual
> CPUs.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1462501c7a8 ("rtla/timerlat: Add a summary for hist mode")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat_hist.c | 93 ++++++++++++++++++--------
>  1 file changed, 66 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
> index a3907c390d67..5cbbe3e98c1d 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -504,51 +504,90 @@ timerlat_print_stats_all(struct timerlat_hist_params *params,
>  	if (!params->no_index)
>  		trace_seq_printf(trace->seq, "min:  ");
>  
> -	if (!params->no_irq)
> -		trace_seq_printf(trace->seq, "%9llu ",
> -				 sum.min_irq);
> +	if (!params->no_irq) {
> +		if (sum.irq_count != 0)
> +			trace_seq_printf(trace->seq, "%9llu ",
> +					 sum.min_irq);
> +		else
> +			trace_seq_printf(trace->seq, "%9c ", '-');
> +	}
>  
> -	if (!params->no_thread)
> -		trace_seq_printf(trace->seq, "%9llu ",
> -				 sum.min_thread);
> +	if (!params->no_thread) {
> +		if (sum.thread_count != 0)
> +			trace_seq_printf(trace->seq, "%9llu ",
> +					 sum.min_thread);
> +		else
> +			trace_seq_printf(trace->seq, "%9c ", '-');
> +	}
>  
> -	if (params->user_hist)
> -		trace_seq_printf(trace->seq, "%9llu ",
> -				 sum.min_user);
> +	if (params->user_hist) {
> +		if (sum.user_count != 0) {
> +			trace_seq_printf(trace->seq, "%9llu ",
> +					 sum.min_user);
> +		} else {
> +			trace_seq_printf(trace->seq, "%9c ", '-');
> +		}
> +	}
>  
>  	trace_seq_printf(trace->seq, "\n");
>  
>  	if (!params->no_index)
>  		trace_seq_printf(trace->seq, "avg:  ");
>  
> -	if (!params->no_irq)
> -		trace_seq_printf(trace->seq, "%9llu ",
> -				 sum.sum_irq / sum.irq_count);
> +	if (!params->no_irq) {
> +		if (sum.irq_count != 0)
> +			trace_seq_printf(trace->seq, "%9llu ",
> +					 sum.sum_irq / sum.irq_count);
> +		else
> +			trace_seq_printf(trace->seq, "%9c ", '-');
> +	}
>  
> -	if (!params->no_thread)
> -		trace_seq_printf(trace->seq, "%9llu ",
> -				 sum.sum_thread / sum.thread_count);
> +	if (!params->no_thread) {
> +		if (sum.thread_count != 0)
> +			trace_seq_printf(trace->seq, "%9llu ",
> +					 sum.sum_thread / sum.thread_count);
> +		else
> +			trace_seq_printf(trace->seq, "%9c ", '-');
> +	}
>  
> -	if (params->user_hist)
> -		trace_seq_printf(trace->seq, "%9llu ",
> -				 sum.sum_user / sum.user_count);
> +	if (params->user_hist) {
> +		if (sum.user_count != 0) {
> +			trace_seq_printf(trace->seq, "%9llu ",
> +					 sum.sum_user / sum.user_count);
> +		} else {
> +			trace_seq_printf(trace->seq, "%9c ", '-');
> +		}
> +	}
>  
>  	trace_seq_printf(trace->seq, "\n");
>  
>  	if (!params->no_index)
>  		trace_seq_printf(trace->seq, "max:  ");
>  
> -	if (!params->no_irq)
> -		trace_seq_printf(trace->seq, "%9llu ",
> -				 sum.max_irq);
> +	if (!params->no_irq) {
> +		if (sum.irq_count != 0)
> +			trace_seq_printf(trace->seq, "%9llu ",
> +					 sum.max_irq);
> +		else
> +			trace_seq_printf(trace->seq, "%9c ", '-');
> +	}
>  
> -	if (!params->no_thread)
> -		trace_seq_printf(trace->seq, "%9llu ",
> -				 sum.max_thread);
> +	if (!params->no_thread) {
> +		if (sum.thread_count != 0)
> +			trace_seq_printf(trace->seq, "%9llu ",
> +					 sum.max_thread);
> +		else
> +			trace_seq_printf(trace->seq, "%9c ", '-');
> +	}
>  
> -	if (params->user_hist)
> -		trace_seq_printf(trace->seq, "%9llu ",
> -				 sum.max_user);
> +	if (params->user_hist) {
> +		if (sum.user_count != 0) {
> +			trace_seq_printf(trace->seq, "%9llu ",
> +					 sum.max_user);
> +		} else {
> +			trace_seq_printf(trace->seq, "%9c ", '-');
> +		}
> +	}

There's a lot of duplicate code here. Can you please make a helper
function, that at least has:

static void show_count(struct trace_seq *seq, int count, unsigned long long val)
{
	if (count)
		trace_seq_printf(seq, "%9llu ", val);
	else
		trace_seq_printf(seq, "%9c ", '-');
}

Then the above could be just:

	if (params->user_hist)
		show_count(trace->seq, sum.user_count, sum.max_user);

Thanks,

-- Steve


>  
>  	trace_seq_printf(trace->seq, "\n");
>  	trace_seq_do_printf(trace->seq);

