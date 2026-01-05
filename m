Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC11B22129B;
	Mon,  5 Jan 2026 04:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767589084; cv=none; b=rAIE4nTQ6M3ipDPnAHDcA/K8B6ref/rMhE352ueWKHtnT3rpuAjDuvrR2p5lGKF5r/W7MySIA8xmZ8ICIcjL2uwkp27veqswtXPFEJ8XYdjQyZn15x77eU9vNiYL8XOUfMNvDEQh3v0o4A82wRu3Z3G7jGKpL/zIGrk+IGuxDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767589084; c=relaxed/simple;
	bh=iK+Qknn7JtfXqOzfxAFZee7osfGCMP+bnjPqUZc7uMA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Tm/w6dEvRJxAGaozJQJnhA2z8yS/Np81XDDflp/26IH/woSHMtufBPXp+uchQSBb8AZHCQZLx9LOIFL6E3TwWN0mdKxQu+quHCuLa9h4RmRkvjrpsiACkT5pK6w1VEtSbP7kFMiFxW+afdJMaXlYuixhvd3A4XzxTHdBBuxr8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgMs13cP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgMs13cP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5C5C116D0;
	Mon,  5 Jan 2026 04:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767589084;
	bh=iK+Qknn7JtfXqOzfxAFZee7osfGCMP+bnjPqUZc7uMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qgMs13cPfORvObmCiQOsH9a1glIXFt0iru8kdrNoHLzCxBm27m87/qG9gXzLU9v60
	 Nf2Nk0tKQr3aXtntY29d+I4SpY6dMfCRL2IEolEcJmTK2fu4bf78FFr1FmBucNewmD
	 X+wYWtv2KBvQxURjnLWMSQEguHYfLKjJcyIR8Dc458HgXuhwssfp26C1KT5qCCSttX
	 iRMNWdBVi8CpTmZNYAPt/16Nb5e+vp4y6R4gaCt+JljlFoOaY87U/M2KOWpm2/j0X2
	 dswD1vEr8nxITJ1pFyXYaKtDhZtA1ApluZfMczosXJEyvb89P7qslxQ7mOS6ScNhba
	 ljuNnNySMvQvA==
Date: Mon, 5 Jan 2026 13:58:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: hongao <hongao@uniontech.com>
Cc: naveen@kernel.org, anil.s.keshavamurthy@intel.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [[PATCH v2] 1/1] kprobes: retry pending optprobe after freeing
 blocker
Message-Id: <20260105135800.1f9f05ab5635e2ab85a2f2bd@kernel.org>
In-Reply-To: <C5E6295166D4EDE9+20251210033321.2895692-1-hongao@uniontech.com>
References: <C5E6295166D4EDE9+20251210033321.2895692-1-hongao@uniontech.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Hongao,

Thanks for updating. After a detailed review, we don't need a new boolean
flag for it. Since the "queued unused probe" (which is handled by
do_free_cleaned_kprobes() eventually) is always disarmed. Thus, we only
need to check all probes to reoptimize sibling probes in the
do_free_cleaned_kprobes().

On Wed, 10 Dec 2025 11:33:21 +0800
hongao <hongao@uniontech.com> wrote:

> The freeing_list cleanup now retries optimizing any sibling probe that was
> deferred while this aggregator was being torn down.  Track the pending
> address in struct optimized_kprobe so __disarm_kprobe() can defer the
> retry until kprobe_optimizer() finishes disarming.
> 
> Signed-off-by: hongao <hongao@uniontech.com>
> ---
> Changes since v1:
> - Replace `kprobe_opcode_t *pending_reopt_addr` with `bool reopt_unblocked_probes`
>   in `struct optimized_kprobe` to avoid storing an address and simplify logic.
> - Use `op->kp.addr` when looking up the sibling optimized probe instead of
>   keeping a separate stored address.
> - Defer re-optimization by setting/clearing `op->reopt_unblocked_probes` in
>   `__disarm_kprobe()` / consuming it in `do_free_cleaned_kprobes()` so the
>   retry runs after the worker finishes disarming.
> - Link to v1: https://lore.kernel.org/all/2B0BC73E9D190B7B+20251027130535.2296913-1-hongao@uniontech.com/
> ---
>  include/linux/kprobes.h |  1 +
>  kernel/kprobes.c        | 28 ++++++++++++++++++++++------
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 8c4f3bb24..4f49925a4 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -338,6 +338,7 @@ DEFINE_INSN_CACHE_OPS(insn);
>  struct optimized_kprobe {
>  	struct kprobe kp;
>  	struct list_head list;	/* list for optimizing queue */
> +	bool reopt_unblocked_probes;
>  	struct arch_optimized_insn optinsn;
>  };

This is not needed. 

>  
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index da59c68df..799542dff 100644
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
> @@ -591,6 +592,21 @@ static void do_free_cleaned_kprobes(void)
>  			 */
>  			continue;
>  		}
> +		if (op->reopt_unblocked_probes) {
> +			struct kprobe *unblocked;
> +
> +			/*
> +			 * The aggregator was holding back another probe while it sat on the
> +			 * unoptimizing/freeing lists.  Now that the aggregator has been fully
> +			 * reverted we can safely retry the optimization of that sibling.
> +			 */
> +
> +			unblocked = get_optimized_kprobe(op->kp.addr);
> +			if (unlikely(unblocked))
> +				optimize_kprobe(unblocked);
> +			op->reopt_unblocked_probes = false;
> +		}

This is what we need. (but do not need to check/update reopt_unblocked_probes.

> +
>  		free_aggr_kprobe(&op->kp);
>  	}
>  }



> @@ -1009,13 +1025,13 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
>  		_p = get_optimized_kprobe(p->addr);
>  		if (unlikely(_p) && reopt)
>  			optimize_kprobe(_p);
> +	} else if (reopt && kprobe_aggrprobe(p)) {
> +		struct optimized_kprobe *op =
> +			container_of(p, struct optimized_kprobe, kp);
> +
> +		/* Defer the re-optimization until the worker finishes disarming. */
> +		op->reopt_unblocked_probes = true;

Do not need this.

>  	}
> -	/*
> -	 * TODO: Since unoptimization and real disarming will be done by
> -	 * the worker thread, we can not check whether another probe are
> -	 * unoptimized because of this probe here. It should be re-optimized
> -	 * by the worker thread.
> -	 */

Only remove this comment.

Thank you,

>  }
>  
>  #else /* !CONFIG_OPTPROBES */
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
