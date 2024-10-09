Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625B81E1C39;
	Wed,  9 Oct 2024 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489773; cv=none; b=Etyutj7z5DI0PO2cfAnTz9mX07vYxgnl+PDZjjnJKXF2e0lXWuB1BvJMAgiU0Yqd9ym33s2imKcXpkgg/GvYMz1a9vrGoAqR36K9r+PXxwVGd4amyIap6aUL/7///aJQ90ZqZNK+U4YL9Mbiit9Lh/RBCk9iV6kFimfQxPl+D4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489773; c=relaxed/simple;
	bh=yX/VcAfD828w1JOGsFEzEOMlRXxsxT6rWWsv1ha/jFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puLeroeIo0UB5EbpPxfFxU0PrkWJ29E6y4vzxZi0OfTMMP9wQvrnS/F1v8fDCrNkg101icMEW3JgVW+SwNZ5tGDNQ9neadKqouAnw0fZQeyGy61WmLVzB92ZW6vSUa+Wuj+9DNYPZB1LMiGquX77K+U6aE8V6oIuzf4Pky/dnvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E16C4CEC3;
	Wed,  9 Oct 2024 16:02:52 +0000 (UTC)
Date: Wed, 9 Oct 2024 12:02:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Ard
 Biesheuvel <ardb@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] x86/ftrace: Don't bother preserving/restoring R10/R11
Message-ID: <20241009120257.7b2de987@gandalf.local.home>
In-Reply-To: <20241009153901.3878233-2-ardb+git@google.com>
References: <20241009153901.3878233-2-ardb+git@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 17:39:01 +0200
Ard Biesheuvel <ardb+git@google.com> wrote:

> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index 214f30e9f0c0..9e13f9b203d1 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -216,8 +216,6 @@ SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
>  	movq %r14, R14(%rsp)
>  	movq %r13, R13(%rsp)
>  	movq %r12, R12(%rsp)
> -	movq %r11, R11(%rsp)
> -	movq %r10, R10(%rsp)
>  	movq %rbx, RBX(%rsp)

This may need to still be saved. Even though they are pretty much useless,
it can be used by kprobes, and perhaps they want to see what's in R10 or
R11 from the caller. I'm not sure we want to remove this. Especially since
we are even saving "flags"!

That is, this part is visible by the callbacks, and the ftrace_get_regs()
is to return a fully populated pt_regs if FTRACE_OPS_FL_SAVE_REGS is set.

>  	/* Copy saved flags */
>  	movq MCOUNT_REG_SIZE(%rsp), %rcx
> @@ -256,7 +254,6 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
>  	movq R14(%rsp), %r14
>  	movq R13(%rsp), %r13
>  	movq R12(%rsp), %r12
> -	movq R10(%rsp), %r10

This part of the patch I think is perfectly fine. We haven't been restoring
R11 for 12 years I'm sure nobody will notice if we don't restore R10.

-- Steve


>  	movq RBX(%rsp), %rbx
>  
>  	movq ORIG_RAX(%rsp), %rax
> -- 
