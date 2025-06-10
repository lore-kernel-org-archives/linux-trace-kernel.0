Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBC07083C;
	Tue, 10 Jun 2025 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749534789; cv=none; b=UvAh7KWav3BiGjLLufnkL61S9CCbqlRMM6heutyNUzPzQdzdEesjw+kxcAM+Bjx5hjFjGcjtKqzf8TXAAESsTvQiOKfPYJJAs28ADGLUNrnRHydzR235nVRgA3v2sR4CcQ3IkjfKXMY5vFmutaShXgmyr6kl0qoBbVXTjUAS8p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749534789; c=relaxed/simple;
	bh=33Y0UGYbvh2zMrvnTTnRtLl/ElBvVlGu21fmhR2LOoQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AqsLUOuXZcOKR1yZ+8bc4iFrygBafnQvF1y2AW02xLfTVdPqrpRpxoZv+EM8C508nxi+ku2tyujtgA7DMx2ttA2jnAbowbrH5ul7oTyzU5aXCknxQtOEuJTe9LYs3SIKDOc1xFHIuYl6/FSq6uwVwPRTFTrU5OxAreK46P3Ode8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+yXadYR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+yXadYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513DCC4CEEF;
	Tue, 10 Jun 2025 05:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749534789;
	bh=33Y0UGYbvh2zMrvnTTnRtLl/ElBvVlGu21fmhR2LOoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q+yXadYRl5O/LAR7dkWzypnsu7o3/UHLJd3PFStTq3r4uJTefQl21tG0C/ZqAVz61
	 bLwTI/AhiMYtVdwxr+SDjax6mzPJ53L7yWGfwSRbLcLq7fBhaPK9fyxVwSSDMaFwE1
	 tPJOWq7t9Rw3edmi2gg0AGvjaSy5Ars/TEsdVKSpiMPyNfRa1qbNSEEAqwm0/JnTTC
	 Bd1HifpxKolNbqjFUQVFb8kxmY8R1kUrlWCfiN12QC4CQAvn7l/mqTiOL5ADt/JLco
	 V69bhMA4MpZsp43x7XAYyBahnE4qB5kHc815aYTzkJOqz/rjj5feTdYA0fCbHdNoYZ
	 glzdQ94ySkfmQ==
Date: Tue, 10 Jun 2025 14:53:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Caleb Sander Mateos <csander@purestorage.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov
 <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] tracepoints: Add verifier that makes sure all
 defined tracepoints are used
Message-Id: <20250610145305.c925856f0201fb748c08b331@kernel.org>
In-Reply-To: <20250529130138.544ffec4@gandalf.local.home>
References: <20250529130138.544ffec4@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2025 13:01:38 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> If a tracepoint is defined via DECLARE_TRACE() or TRACE_EVENT() but never
> called (via the trace_<tracepoint>() function), its meta data is still
> around in memory and not discarded.
> 
> When created via TRACE_EVENT() the situation is worse because the
> TRACE_EVENT() creates meta data that can be around 5k per trace event.
> Having unused trace events causes several thousand of wasted bytes.
> 
> Add a verifier that injects a pointer to the tracepoint structure in the
> functions that are used and added to a section called __tracepoint_check.
> Then on boot up, iterate over this section and for every tracepoint
> descriptor that is pointed to, update its ".funcs" field to (void *)1, as
> the .funcs field is only set when a tracepoint is registered. At this
> time, no tracepoints should be registered.
> 
> Then iterate all tracepoints and if any tracepoints doesn't have its
> .funcs field set to (void*)1, trigger a warning, and list all tracepoints
> that are not found.
> 
> Enabling this currently with a given config produces:
> 
>  Tracepoint x86_fpu_before_restore unused
>  Tracepoint x86_fpu_after_restore unused
>  Tracepoint x86_fpu_init_state unused
>  Tracepoint pelt_hw_tp unused
>  Tracepoint pelt_irq_tp unused
>  Tracepoint ipi_raise unused
>  Tracepoint ipi_entry unused
>  Tracepoint ipi_exit unused
>  Tracepoint irq_matrix_alloc_reserved unused
>  Tracepoint psci_domain_idle_enter unused
>  Tracepoint psci_domain_idle_exit unused
>  Tracepoint powernv_throttle unused
>  Tracepoint clock_enable unused
>  Tracepoint clock_disable unused
>  Tracepoint clock_set_rate unused
>  Tracepoint power_domain_target unused
>  Tracepoint xdp_bulk_tx unused
>  Tracepoint xdp_redirect_map unused
>  Tracepoint xdp_redirect_map_err unused
>  Tracepoint mem_return_failed unused
>  Tracepoint vma_mas_szero unused
>  Tracepoint vma_store unused
>  Tracepoint hugepage_set_pmd unused
>  Tracepoint hugepage_set_pud unused
>  Tracepoint hugepage_update_pmd unused
>  Tracepoint hugepage_update_pud unused
>  Tracepoint dax_pmd_insert_mapping unused
>  Tracepoint dax_insert_mapping unused
>  Tracepoint block_rq_remap unused
>  Tracepoint xhci_dbc_handle_event unused
>  Tracepoint xhci_dbc_handle_transfer unused
>  Tracepoint xhci_dbc_gadget_ep_queue unused
>  Tracepoint xhci_dbc_alloc_request unused
>  Tracepoint xhci_dbc_free_request unused
>  Tracepoint xhci_dbc_queue_request unused
>  Tracepoint xhci_dbc_giveback_request unused
>  Tracepoint tcp_ao_wrong_maclen unused
>  Tracepoint tcp_ao_mismatch unused
>  Tracepoint tcp_ao_key_not_found unused
>  Tracepoint tcp_ao_rnext_request unused
>  Tracepoint tcp_ao_synack_no_key unused
>  Tracepoint tcp_ao_snd_sne_update unused
>  Tracepoint tcp_ao_rcv_sne_update unused
> 
> Some of the above is totally unused but others are not used due to their
> "trace_" functions being inside configs, in which case, the defined
> tracepoints should also be inside those same configs. Others are
> architecture specific but defined in generic code, where they should
> either be moved to the architecture or be surrounded by #ifdef for the
> architectures they are for.
> 
> Note, currently this only handles tracepoints that are builtin. This can
> easily be extended to verify tracepoints used by modules, but it requires a
> slightly different approach as it needs updates to the module code.
> 
> Link: https://lore.kernel.org/all/20250528114549.4d8a5e03@gandalf.local.home/
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/asm-generic/vmlinux.lds.h |  1 +
>  include/linux/tracepoint.h        | 10 ++++++++++
>  kernel/trace/Kconfig              |  8 ++++++++
>  kernel/tracepoint.c               | 26 ++++++++++++++++++++++++++
>  4 files changed, 45 insertions(+)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index fa5f19b8d53a..600d8b51e315 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -708,6 +708,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>  	MCOUNT_REC()							\
>  	*(.init.rodata .init.rodata.*)					\
>  	FTRACE_EVENTS()							\
> +	BOUNDED_SECTION_BY(__tracepoint_check, ___tracepoint_check)	\

nit: Shouldn't we also make this as TRACEPOINT_CHECKS() ?

Others looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

>  	TRACE_SYSCALLS()						\
>  	KPROBE_BLACKLIST()						\
>  	ERROR_INJECT_WHITELIST()					\
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index a351763e6965..c9c03ec8e552 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -221,6 +221,14 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		__do_trace_##name(args);				\
>  	}
>  
> +#ifdef CONFIG_TRACEPOINT_VERIFY_USED
> +# define TRACEPOINT_CHECK(name)						\
> +	static void __used __section("__tracepoint_check") *__trace_check = \
> +		&__tracepoint_##name;
> +#else
> +# define TRACEPOINT_CHECK(name)
> +#endif
> +
>  /*
>   * Make sure the alignment of the structure in the __tracepoints section will
>   * not add unwanted padding between the beginning of the section and the
> @@ -270,6 +278,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
>  	static inline void __do_trace_##name(proto)			\
>  	{								\
> +		TRACEPOINT_CHECK(name)					\
>  		if (cond) {						\
>  			guard(preempt_notrace)();			\
>  			__DO_TRACE_CALL(name, TP_ARGS(args));		\
> @@ -289,6 +298,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
>  	static inline void __do_trace_##name(proto)			\
>  	{								\
> +		TRACEPOINT_CHECK(name)					\
>  		guard(rcu_tasks_trace)();				\
>  		__DO_TRACE_CALL(name, TP_ARGS(args));			\
>  	}								\
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index a3f35c7d83b6..8867eee5b58f 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -1044,6 +1044,14 @@ config GCOV_PROFILE_FTRACE
>  	  Note that on a kernel compiled with this config, ftrace will
>  	  run significantly slower.
>  
> +config TRACEPOINT_VERIFY_USED
> +	bool "Verify that all defined tracepoints are used"
> +	depends on TRACEPOINTS
> +	help
> +	  This option checks if every builtin defined tracepoint is
> +	  used in the code. If a tracepoint is defined but not used,
> +	  it will waste memory as its meta data is still created.
> +
>  config FTRACE_SELFTEST
>  	bool
>  
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 62719d2941c9..f354d3850a04 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -677,10 +677,36 @@ static struct notifier_block tracepoint_module_nb = {
>  	.priority = 0,
>  };
>  
> +#ifdef CONFIG_TRACEPOINT_VERIFY_USED
> +extern void * __start___tracepoint_check[];
> +extern void * __stop___tracepoint_check[];
> +
> +#define VERIFIED_TRACEPOINT	((void *)1)
> +
> +static void check_tracepoint(struct tracepoint *tp, void *priv)
> +{
> +	if (WARN_ONCE(tp->funcs != VERIFIED_TRACEPOINT, "Unused tracepoints found"))
> +		pr_warn("Tracepoint %s unused\n", tp->name);
> +
> +	tp->funcs = NULL;
> +}
> +#endif
> +
>  static __init int init_tracepoints(void)
>  {
>  	int ret;
>  
> +#ifdef CONFIG_TRACEPOINT_VERIFY_USED
> +	for (void **ptr = __start___tracepoint_check;
> +	     ptr < __stop___tracepoint_check; ptr++) {
> +		struct tracepoint *tp = *ptr;
> +
> +		tp->funcs = VERIFIED_TRACEPOINT;
> +	}
> +
> +	for_each_kernel_tracepoint(check_tracepoint, NULL);
> +#endif
> +
>  	ret = register_module_notifier(&tracepoint_module_nb);
>  	if (ret)
>  		pr_warn("Failed to register tracepoint module enter notifier\n");
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
