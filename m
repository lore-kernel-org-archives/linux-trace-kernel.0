Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A753207;
	Tue, 15 Jul 2025 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752538895; cv=none; b=Y4BGGh0QRUPx7AWv6gLTwXyu/FMbpImncuvhm7D5FkI2c7CMdemScohQox0r6AwlRQi/6Uojhp7BzrSrjQRHMUFaaFYQk1d25dzRjyJvZ8vo1UO1wEoGgkzELUv4RHsZYQj+xtIrW7+6TLQhgdNFiK3SFvR6HrB/Px5xBXZ3ZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752538895; c=relaxed/simple;
	bh=ggcEC9bbWrHlmXqb/IZkagM/1dITGxzsZ7d7NZy45XA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rkd6UtqH9qwiTm6HkHrqcZf2N2lqBfCceYjzqIjZpB3nep/fOPEC7pjkWPND3NCj9BnULGlXvCJnZB4E8T+RqTf+byDibUKdmPqkUhuJUrbt2vPSBA2pP4eKfkdqutZpHrgT1X7gGMsIKYAhxNK0NGtIvwuF7OCf/rjJxxYtgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbwfmwSy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbwfmwSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF290C4CEED;
	Tue, 15 Jul 2025 00:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752538894;
	bh=ggcEC9bbWrHlmXqb/IZkagM/1dITGxzsZ7d7NZy45XA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cbwfmwSy95HmlSWI4uiy/mtiUWFaeu/uH7ad9AQ4TACV7HMBT0oaevtd6abttH333
	 Le8jxJFr/1McYBGAH3q9PI6W0fxrP4PIOl8fA49YokMeLF4ahnaXk0n8tnE5khdFXl
	 FSPnuQDjOpQgn00x8nn0TLS5ydHbfc69JXWsYVeiZBp6r22sqyxTFHkBvksFKwc1yA
	 4Q/1jX8bf32gzrSR6LZTEbe0cYIoonR8H2wvCdxrdzbZixmXOfOAAJWX7zCvyHiytS
	 J5k8Q3FR46+0gtrqVv8VxFGTOEaYy6vKEX9gs/HYrkj0SFvg7uxl5ZBvYOUDBA/v0T
	 dANMPu5y9fwzQ==
Date: Tue, 15 Jul 2025 09:21:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski
 <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Daniel Gomez <da.gomez@samsung.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, Yann Ylavic <ylavic.dev@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org
Subject: Re: [PATCH v3 7/8] x86/kprobes: enable EXECMEM_ROX_CACHE for
 kprobes allocations
Message-Id: <20250715092130.0b4eda67c5db02e815e478b2@kernel.org>
In-Reply-To: <20250713071730.4117334-8-rppt@kernel.org>
References: <20250713071730.4117334-1-rppt@kernel.org>
	<20250713071730.4117334-8-rppt@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 10:17:29 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> x86::alloc_insn_page() always allocates ROX memory.
> 
> Instead of overriding this method, add EXECMEM_KPROBES entry in
> execmem_info with pgprot set to PAGE_KERNEL_ROX and  use ROX cache when
> configuration and CPU features allow it.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/x86/kernel/kprobes/core.c | 18 ------------------
>  arch/x86/mm/init.c             |  9 ++++++++-
>  2 files changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 47cb8eb138ba..6079d15dab8c 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -481,24 +481,6 @@ static int prepare_singlestep(kprobe_opcode_t *buf, struct kprobe *p,
>  	return len;
>  }
>  
> -/* Make page to RO mode when allocate it */
> -void *alloc_insn_page(void)
> -{
> -	void *page;
> -
> -	page = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
> -	if (!page)
> -		return NULL;
> -
> -	/*
> -	 * TODO: Once additional kernel code protection mechanisms are set, ensure
> -	 * that the page was not maliciously altered and it is still zeroed.
> -	 */
> -	set_memory_rox((unsigned long)page, 1);
> -
> -	return page;
> -}
> -
>  /* Kprobe x86 instruction emulation - only regs->ip or IF flag modifiers */
>  
>  static void kprobe_emulate_ifmodifiers(struct kprobe *p, struct pt_regs *regs)
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index dbc63f0d538f..442fafd8ff52 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -1098,7 +1098,14 @@ struct execmem_info __init *execmem_arch_setup(void)
>  				.pgprot	= pgprot,
>  				.alignment = MODULE_ALIGN,
>  			},
> -			[EXECMEM_KPROBES ... EXECMEM_BPF] = {
> +			[EXECMEM_KPROBES] = {
> +				.flags	= flags,
> +				.start	= start,
> +				.end	= MODULES_END,
> +				.pgprot	= PAGE_KERNEL_ROX,
> +				.alignment = MODULE_ALIGN,
> +			},
> +			[EXECMEM_FTRACE ... EXECMEM_BPF] = {
>  				.flags	= EXECMEM_KASAN_SHADOW,
>  				.start	= start,
>  				.end	= MODULES_END,
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
