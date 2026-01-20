Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0570829BDA3;
	Tue, 20 Jan 2026 05:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768888239; cv=none; b=UsXpeGeDGOxwnRH1naP/h+PzXXpzakAOvmNs9ccgSu7byPI5hFHGa3NbK7IJJtul9y/AbtXbckm0YeDpf9h/Y6yqjyOYXoNp574WlVR2AuyAGrNULtdcjrNhcdWkRJXcxs0Dr2qPR1ehfuDEHrqkemv5flixBrXZQ9XaFj67AL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768888239; c=relaxed/simple;
	bh=Yx3iiV8rkR8mSXy5GChFZ7ek0U2l6xgFt0uC0I/9Yls=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Mnd+shFww+nqt/UIuD6FZODG6s+d8/nIhdn9jJOZ3m019htPHCbE4r/VqDOqMe4f5J4NAl+8By2E5Ruk+Lp1QfM0793chKLzn3J5jDKo4vegeALr1gYlh+FRVPSE+C5rJrG1WbaAEknu/HsR3jIZQsHEHoWFGWDHMlPxg7MWuF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVSQmflA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVSQmflA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2587C16AAE;
	Tue, 20 Jan 2026 05:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768888238;
	bh=Yx3iiV8rkR8mSXy5GChFZ7ek0U2l6xgFt0uC0I/9Yls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SVSQmflA6TevvPIqJzzMd49EYL+NMFIzvGDuT1qNC9+VXVIFzVA55ocev6rU93DkT
	 9hUkZV9Kf9FXLmulxjsUZya+zzK3AaRw0sDRTdeIWEv4MuUhYsvVIKjMBG7LFtQG5C
	 3/WT3buKD3AtFaoUwAcyLQBFUosqPgqW/EhVYMFtLuX/G7OEvqX+5RpLDvHEiGfCHX
	 rEh0/9nIUAorrsXNgxmOuZUTIID1KX1iCdKsSay4DgoEEIG/QYOkyTxCHPvHDFxlpD
	 qUf4bK1tqB/olgaq9s6j6urXgQ2d/4+i/rBSDyaHXarNjKHtq0WLh9/Qst2fRVqv0D
	 /sCsaI/woDN8A==
Date: Tue, 20 Jan 2026 14:50:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: hongao <hongao@uniontech.com>
Cc: naveen@kernel.org, anil.s.keshavamurthy@intel.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] kprobes: retry blocked optprobe in
 do_free_cleaned_kprobes
Message-Id: <20260120145036.f3fda6f57da8fd21745af7e9@kernel.org>
In-Reply-To: <349359900266B25F+20260115023804.3951960-2-hongao@uniontech.com>
References: <20260105135800.1f9f05ab5635e2ab85a2f2bd@kernel.org>
	<20260115023804.3951960-1-hongao@uniontech.com>
	<349359900266B25F+20260115023804.3951960-2-hongao@uniontech.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 10:38:03 +0800
hongao <hongao@uniontech.com> wrote:

> Once the aggrprobe is fully reverted in do_free_cleaned_kprobes(), retry
> optimize_kprobe() on that sibling so it can return to OPTIMIZED.
> 
> Also remove the stale comment in __disarm_kprobe().
> 

Thanks, let me pick it.

> Signed-off-by: hongao <hongao@uniontech.com>
> ---
>  kernel/kprobes.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index ab8f9fc1f0d1..1bd84d3b4817 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -516,6 +516,7 @@ static LIST_HEAD(freeing_list);
>  
>  static void kprobe_optimizer(struct work_struct *work);
>  static DECLARE_DELAYED_WORK(optimizing_work, kprobe_optimizer);
> +static void optimize_kprobe(struct kprobe *p);
>  #define OPTIMIZE_DELAY 5
>  
>  /*
> @@ -593,6 +594,17 @@ static void do_free_cleaned_kprobes(void)
>  			 */
>  			continue;
>  		}
> +
> +		/*
> +		 * The aggregator was holding back another probe while it sat on the
> +		 * unoptimizing/freeing lists.  Now that the aggregator has been fully
> +		 * reverted we can safely retry the optimization of that sibling.
> +		 */
> +
> +		struct kprobe *_p = get_optimized_kprobe(op->kp.addr);
> +		if (unlikely(_p))
> +			optimize_kprobe(_p);
> +
>  		free_aggr_kprobe(&op->kp);
>  	}
>  }
> @@ -1002,12 +1014,6 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
>  		if (unlikely(_p) && reopt)
>  			optimize_kprobe(_p);
>  	}
> -	/*
> -	 * TODO: Since unoptimization and real disarming will be done by
> -	 * the worker thread, we can not check whether another probe are
> -	 * unoptimized because of this probe here. It should be re-optimized
> -	 * by the worker thread.
> -	 */
>  }
>  
>  #else /* !CONFIG_OPTPROBES */
> -- 
> 2.50.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
