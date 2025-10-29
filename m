Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84881D63F7;
	Wed, 29 Oct 2025 04:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761710571; cv=none; b=n4db0G9GIQe0Xh0JQECcQQbGlk2qbJYUGVASD1okO9Dnh0P1Ehah2f4DAdcXnTEOJQavhFNcloqx+0zKshuUaG6lpR2/IbJg3otLLpjOSw0vQJU3gsVlHFkcBtnyfh15NcDVDNnqRDL3p09CPKO0eKntrZ/bHsxdLOfryvKWfTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761710571; c=relaxed/simple;
	bh=Eb8N5K9sYJnJLP1i4bFDNvvBAcHerL60w5OahhRNHxY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QwyQ2sPlkXjYeDUWPtazwpepeIzOvHy/O6A5OQu64/3EKXIrjIgk2g76QBD2FXQ64MEONlU8YIrEjoudeyrDSPHODrT4l+NH5b3BDpHdkg4yvXli/7lX57qGKDd2JhmzO1cZ0po+aRQBAjQfdrHNqzYgSbeJvNPMRqIhSPxPswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kqdd0wbJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kqdd0wbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D66CC4CEFB;
	Wed, 29 Oct 2025 04:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761710571;
	bh=Eb8N5K9sYJnJLP1i4bFDNvvBAcHerL60w5OahhRNHxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kqdd0wbJPXmb9VrTBjTGXRBbZEL3GDVluPn30xZHSxoBdNcaahyCyTu8/y+z9urwj
	 dGQK6Vf6yOGea05iaSJiAuvR8XQbrYUz6UuYGsyM5vh+2jZUaQclO99Wk2937jpdDd
	 VEBMjQwtA6g/FRoBZujpjtNgaA1cDbYjYei5U2s7dMPQ/xVVJSV++CGIi2335N+Q+d
	 bIpJ/tGSHU/zA9E4egjRJ48RbkA5/THoRMYTZRqzIsXYQ+okiMxQ2IJptOZshegND6
	 66P18xAbMx7ot3oa9iOU2oObjHrl4gF9bwcGwll2UnSHAoiHf0TQ7J8DyAUN9Sg14U
	 nrN1/ASYWZ/qg==
Date: Wed, 29 Oct 2025 13:02:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: hongao <hongao@uniontech.com>
Cc: naveen@kernel.org, anil.s.keshavamurthy@intel.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: retry pending optprobe after freeing blocker
Message-Id: <20251029130247.fa760b2f35f01a91c9e80eee@kernel.org>
In-Reply-To: <2B0BC73E9D190B7B+20251027130535.2296913-1-hongao@uniontech.com>
References: <2B0BC73E9D190B7B+20251027130535.2296913-1-hongao@uniontech.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 21:05:35 +0800
hongao <hongao@uniontech.com> wrote:

> The freeing_list cleanup now retries optimizing any sibling probe that was
> deferred while this aggregator was being torn down.  Track the pending
> address in struct optimized_kprobe so __disarm_kprobe() can defer the
> retry until kprobe_optimizer() finishes disarming.

Thanks Hongao! I have some comment below.
Please make it simpler.

> 
> Signed-off-by: hongao <hongao@uniontech.com>
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 8c4f3bb24..33d65b008 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -338,6 +338,7 @@ DEFINE_INSN_CACHE_OPS(insn);
>  struct optimized_kprobe {
>  	struct kprobe kp;
>  	struct list_head list;	/* list for optimizing queue */
> +	kprobe_opcode_t *pending_reopt_addr;	/* addr that should trigger re-optimization */

You may need "bool reopt_unblocked_probes".

>  	struct arch_optimized_insn optinsn;
>  };
>  
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index da59c68df..0976ab57d 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -514,6 +514,7 @@ static LIST_HEAD(freeing_list);
>  
>  static void kprobe_optimizer(struct work_struct *work);
>  static DECLARE_DELAYED_WORK(optimizing_work, kprobe_optimizer);
> +static void optimize_kprobe(struct kprobe *p);
>  #define OPTIMIZE_DELAY 5
>  
>  /*
> @@ -591,6 +592,20 @@ static void do_free_cleaned_kprobes(void)
>  			 */
>  			continue;
>  		}
> +		if (op->pending_reopt_addr) {
> +			struct kprobe *blocked;

	unblocked?

> +
> +			/*
> +			 * The aggregator was holding back another probe while it sat on the
> +			 * unoptimizing/freeing lists.  Now that the aggregator has been fully
> +			 * reverted we can safely retry the optimization of that sibling.
> +			 */
> +
> +			blocked = get_optimized_kprobe(op->pending_reopt_addr);

You can use op->kp.addr.

> +			if (unlikely(blocked))
> +				optimize_kprobe(blocked);
> +		}
> +
>  		free_aggr_kprobe(&op->kp);
>  	}
>  }
> @@ -1009,13 +1024,13 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
>  		_p = get_optimized_kprobe(p->addr);
>  		if (unlikely(_p) && reopt)
>  			optimize_kprobe(_p);
> +	} else if (reopt && kprobe_aggrprobe(p)) {

Here, the @p is queued. This means @p is an optprobe (and aggrprobe).

> +		struct optimized_kprobe *op =
> +			container_of(p, struct optimized_kprobe, kp);
> +
> +		/* Defer the re-optimization until the worker finishes disarming. */
> +		op->pending_reopt_addr = p->addr;

You should save the @reopt flag instead of addr.

Thank you,

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
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
