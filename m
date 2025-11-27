Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D032F1E1A17;
	Thu, 27 Nov 2025 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764209645; cv=none; b=cQ4lU8aAfJ91uKFAkpc3PKGq/SF62D8wWQ0uPhKSWFToze5xu6iNkGUtzmoi1ufBlg7WGtmbXP4oeXb3xYBtdQuW5VGej8ifHVmfxK/qR1iig82QD6HsMpN8+K7JQsITQDunakPur1L+ZanTcjHu4OMtniW3hCOeQ8NC8u/gZjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764209645; c=relaxed/simple;
	bh=IFqYUZzq/jzvNAotoBLmtazNmaL0/3Amx3MFWLru9+I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ExRQ8uFnkOr9GGOLVf8l/DYT2TRh/76RmXNdvvUzc0DzyXTbcEZjIrF87tlEfRUBmupaISgQdsuX1P8RoGTet+sl3KJEHhOigNnWKMYOlUagM1d+HXJnY9Ftj3Zh/tUW6k03AZfcS8VBoSi5iYaKJ27bLGpMYuj2NyashE3rH7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDNkD0l5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDNkD0l5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C99C4CEF7;
	Thu, 27 Nov 2025 02:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764209645;
	bh=IFqYUZzq/jzvNAotoBLmtazNmaL0/3Amx3MFWLru9+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oDNkD0l5tVbI5YCQPKX2hVO9qKYsdHnZ4iecrTrg9O57eLiKDr+pZEkvZ9CUZnxMc
	 bjr5VdRlmTaE5odqa68YzIGuTPPjkQyBW1ZDDZ9aS6QrbEArFkN7yt5HUqiiG4Q3c2
	 uMe1MoRiMwrLjRPBS9CFJSQ+3VRQLkC+ZjUAnv76GL3n+zjPJpc56S/jSAjuOe+12v
	 CYQYxQo9kFkFz2/NYCUSLprwLk6ktAL7eX0ei5mJ0pZF/HSH95f0cWEg/VcWVewg7C
	 +W/PFqTTJjBfThMo3SaYKkK4xCDD7MxI4KMcEyHmV7Kps6uSRLriogHI9BykXTHt4k
	 7V0YJaRuGADaw==
Date: Thu, 27 Nov 2025 11:14:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: oleg@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: simplify arch_uprobe_xol_was_trapped return
Message-Id: <20251127111402.c228292177bbd2b8e88c8629@kernel.org>
In-Reply-To: <20251126223130.216302-1-osama.abdelkader@gmail.com>
References: <20251126223130.216302-1-osama.abdelkader@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Nov 2025 00:31:30 +0200
Osama Abdelkader <osama.abdelkader@gmail.com> wrote:

> convert arch_uprobe_xol_was_trapped() from explicit if/return true
> return false pattern to direct boolean expression return in
> arch/arm64/kernel/probes/uprobes.c
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>


Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> ---
>  arch/arm64/kernel/probes/uprobes.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
> index 2799bdb2fb82..b38c1dab7eb4 100644
> --- a/arch/arm64/kernel/probes/uprobes.c
> +++ b/arch/arm64/kernel/probes/uprobes.c
> @@ -103,10 +103,7 @@ bool arch_uprobe_xol_was_trapped(struct task_struct *t)
>  	 * insn itself is trapped, then detect the case with the help of
>  	 * invalid fault code which is being set in arch_uprobe_pre_xol
>  	 */
> -	if (t->thread.fault_code != UPROBE_INV_FAULT_CODE)
> -		return true;
> -
> -	return false;
> +	return t->thread.fault_code != UPROBE_INV_FAULT_CODE;
>  }
>  
>  bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
