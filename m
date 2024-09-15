Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19242CA6;
	Sun, 15 Sep 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726392133; cv=none; b=fpug2wUgLkGQDdUQkpcJIv0wQU3YJ8JNofuD5JyoqVfWl0z+Kniwy76gLprtbIcY0LJ+iUC0S9FxsnC4pkS5YXkTCeD7DU44Zx7kliRMuECdffkz8fWfpHl0IQhXvULy9Ehq0ihRTzANNAVnMlyBj6vZLIiaPpRL8CDe54BiX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726392133; c=relaxed/simple;
	bh=hlKhojcEd9iQsGKbuSqGRPSfk4f5cdS8JzNz7/1tFxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWWYHea5j2gHXjXPvWtKekh2KqKRfAISsxMSnyMWHgKw4ZuqCrc3fiaJSk5dln8ery1mqpdbB/4YGBmaSVDGUouQtvVDagIydePm1GycWZwA/WwtW9XuZdjJ+fmeInzBs2zokS+ZT19MF7NFfvsVWqRX+T/M2rA3Yw/S8FYcxWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298DFC4CEC3;
	Sun, 15 Sep 2024 09:22:09 +0000 (UTC)
Date: Sun, 15 Sep 2024 05:22:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 08/19] tracing: Add ftrace_partial_regs() for
 converting ftrace_regs to pt_regs
Message-ID: <20240915052204.3dff1f75@rorschach.local.home>
In-Reply-To: <172615377576.133222.5911358383330497277.stgit@devnote2>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<172615377576.133222.5911358383330497277.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Can I get an Acked-by from the AARCH64 maintainers for this patch?

Thanks!

-- Steve


On Fri, 13 Sep 2024 00:09:35 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
> This is for the eBPF which needs this to keep the same pt_regs interface
> to access registers.
> Thus when replacing the pt_regs with ftrace_regs in fprobes (which is
> used by kprobe_multi eBPF event), this will be used.
> 
> If the architecture defines its own ftrace_regs, this copies partial
> registers to pt_regs and returns it. If not, ftrace_regs is the same as
> pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Florent Revest <revest@chromium.org>
> ---
>  Changes in v14:
>   - Add riscv change.
>  Changes in v8:
>   - Add the reason why this required in changelog.
>  Changes from previous series: NOTHING, just forward ported.
> ---
>  arch/arm64/include/asm/ftrace.h |   11 +++++++++++
>  arch/riscv/include/asm/ftrace.h |   12 ++++++++++++
>  include/linux/ftrace.h          |   17 +++++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index dffaab3dd1f1..5cd587afab6d 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -132,6 +132,17 @@ ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
>  	return fregs->fp;
>  }
>  
> +static __always_inline struct pt_regs *
> +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> +{
> +	memcpy(regs->regs, fregs->regs, sizeof(u64) * 9);
> +	regs->sp = fregs->sp;
> +	regs->pc = fregs->pc;
> +	regs->regs[29] = fregs->fp;
> +	regs->regs[30] = fregs->lr;
> +	return regs;
> +}
> +
>  int ftrace_regs_query_register_offset(const char *name);
>  
>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> index e9f364ce9fe8..897779dec402 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -193,6 +193,18 @@ static __always_inline void ftrace_override_function_with_return(struct ftrace_r
>  	fregs->epc = fregs->ra;
>  }
>  
> +static __always_inline struct pt_regs *
> +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> +{
> +	memcpy(&regs->a0, fregs->args, sizeof(u64) * 8);
> +	regs->epc = fregs->epc;
> +	regs->ra = fregs->ra;
> +	regs->sp = fregs->sp;
> +	regs->s0 = fregs->s0;
> +	regs->t1 = fregs->t1;
> +	return regs;
> +}
> +
>  int ftrace_regs_query_register_offset(const char *name);
>  
>  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index a1b2ef492c7f..bd9a26bdf660 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -176,6 +176,23 @@ static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs
>  	return arch_ftrace_get_regs(fregs);
>  }
>  
> +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
> +	defined(CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST)
> +
> +static __always_inline struct pt_regs *
> +ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
> +{
> +	/*
> +	 * If CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST=y, ftrace_regs memory
> +	 * layout is the same as pt_regs. So always returns that address.
> +	 * Since arch_ftrace_get_regs() will check some members and may return
> +	 * NULL, we can not use it.
> +	 */
> +	return &fregs->regs;
> +}
> +
> +#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
> +
>  /*
>   * When true, the ftrace_regs_{get,set}_*() functions may be used on fregs.
>   * Note: this can be true even when ftrace_get_regs() cannot provide a pt_regs.

