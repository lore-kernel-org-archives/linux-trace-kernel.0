Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB549643;
	Wed, 31 Jul 2024 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722404272; cv=none; b=r/HO2VnDelxIbjAADXsHyIFIceua913eMDf6fVue/iyeHAMWyrUZXsR8Oi4CTAhPl0pOt4ml5HXFPlCH9Bpq9dpDqGb+QztVCl+Xq3CuRHkudUmon0pB+PK9TKALJjqYqmdo9lHvLRSa1AHw+SJvY/RGpuCX7ifngQLRSk1jfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722404272; c=relaxed/simple;
	bh=nuK5IhR8wYzp6ANKjkoRcwHuzp4JZbmJSzE/Sb+/2oU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OuyioMI/Q08bUeGk6h39lDdeo2CqS0bv3t0n1Bnry8YvjkC3XY+QZFQMDrwwecHK3ctWjcIitfDl3zlzZyurxS2gB43a2qHXCTG/oq0cHUyuxAuI4ym+cYd1xlfhb8WEBroXg/GAOUETqfu35X9Y9efyB0aqk+5UHjJQBBKzlyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G10I71C5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G10I71C5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2C9C116B1;
	Wed, 31 Jul 2024 05:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722404272;
	bh=nuK5IhR8wYzp6ANKjkoRcwHuzp4JZbmJSzE/Sb+/2oU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G10I71C5l6U0gayOjzbQYIrZkfwXJOOe+A41JXiNFArBpQRYgViQw3iN+Wkk9pQrg
	 J6YyaeQAOiVtt4kQnz64Y1XXvuRci5Ks3VJAkRMHSKISsOzB1eAUvCp4TLZMP5VdRj
	 qTk/qtfcZHTk1ydLqgcOwBQlBnNK1h61lKGfIYrsTh5WRoz98l2spy9nB9f6i41Prb
	 QqQTvjxsLM6PlI0N2Vzz82xybRU9V154N6KmDj9YLxuBXJJb7TBU+nnQ5wMTEeMBHL
	 ZWZvo3wpsC0m+EyBE+3rB045r6OWmDy45+/XpxIUbpz+H8XrHPp/fK2aEwHCKkysQU
	 /6WAj6u8bTS9g==
Date: Wed, 31 Jul 2024 14:37:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, peterz@infradead.org, jolsa@kernel.org,
 rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] uprobes: kill uprobe_register_refctr()
Message-Id: <20240731143748.55bb97c1d68aea1f1946729d@kernel.org>
In-Reply-To: <20240729134530.GA12318@redhat.com>
References: <20240729134444.GA12293@redhat.com>
	<20240729134530.GA12318@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 15:45:30 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> It doesn't make any sense to have 2 versions of _register(). Note that
> trace_uprobe_enable(), the only user of uprobe_register(), doesn't need
> to check tu->ref_ctr_offset to decide which one should be used, it could
> safely pass ref_ctr_offset == 0 to uprobe_register_refctr().
> 
> Add this argument to uprobe_register(), update the callers, and kill
> uprobe_register_refctr().
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/uprobes.h     |  9 ++-------
>  kernel/events/uprobes.c     | 24 ++++++------------------
>  kernel/trace/bpf_trace.c    |  8 ++++----
>  kernel/trace/trace_uprobe.c |  7 +------
>  4 files changed, 13 insertions(+), 35 deletions(-)

OK, but it seems 

tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c

is still using uprobe_register_refctr().

That should be updated too.

Thanks,

> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index b503fafb7fb3..440316fbf3c6 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -110,8 +110,7 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
>  extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
>  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
>  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
> -extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
> -extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
> +extern int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
>  extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
>  extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
>  extern int uprobe_mmap(struct vm_area_struct *vma);
> @@ -152,11 +151,7 @@ static inline void uprobes_init(void)
>  #define uprobe_get_trap_addr(regs)	instruction_pointer(regs)
>  
>  static inline int
> -uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> -{
> -	return -ENOSYS;
> -}
> -static inline int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc)
> +uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc)
>  {
>  	return -ENOSYS;
>  }
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index dfe6306a63b1..b7f40bad8abc 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1121,25 +1121,26 @@ void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consume
>  EXPORT_SYMBOL_GPL(uprobe_unregister);
>  
>  /*
> - * __uprobe_register - register a probe
> + * uprobe_register - register a probe
>   * @inode: the file in which the probe has to be placed.
>   * @offset: offset from the start of the file.
> + * @ref_ctr_offset: offset of SDT marker / reference counter
>   * @uc: information on howto handle the probe..
>   *
> - * Apart from the access refcount, __uprobe_register() takes a creation
> + * Apart from the access refcount, uprobe_register() takes a creation
>   * refcount (thro alloc_uprobe) if and only if this @uprobe is getting
>   * inserted into the rbtree (i.e first consumer for a @inode:@offset
>   * tuple).  Creation refcount stops uprobe_unregister from freeing the
>   * @uprobe even before the register operation is complete. Creation
>   * refcount is released when the last @uc for the @uprobe
> - * unregisters. Caller of __uprobe_register() is required to keep @inode
> + * unregisters. Caller of uprobe_register() is required to keep @inode
>   * (and the containing mount) referenced.
>   *
>   * Return errno if it cannot successully install probes
>   * else return 0 (success)
>   */
> -static int __uprobe_register(struct inode *inode, loff_t offset,
> -			     loff_t ref_ctr_offset, struct uprobe_consumer *uc)
> +int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset,
> +		    struct uprobe_consumer *uc)
>  {
>  	struct uprobe *uprobe;
>  	int ret;
> @@ -1189,21 +1190,8 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
>  		goto retry;
>  	return ret;
>  }
> -
> -int uprobe_register(struct inode *inode, loff_t offset,
> -		    struct uprobe_consumer *uc)
> -{
> -	return __uprobe_register(inode, offset, 0, uc);
> -}
>  EXPORT_SYMBOL_GPL(uprobe_register);
>  
> -int uprobe_register_refctr(struct inode *inode, loff_t offset,
> -			   loff_t ref_ctr_offset, struct uprobe_consumer *uc)
> -{
> -	return __uprobe_register(inode, offset, ref_ctr_offset, uc);
> -}
> -EXPORT_SYMBOL_GPL(uprobe_register_refctr);
> -
>  /*
>   * uprobe_apply - unregister an already registered probe.
>   * @inode: the file in which the probe has to be removed.
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index cd098846e251..afa909e17824 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3480,10 +3480,10 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  		      &bpf_uprobe_multi_link_lops, prog);
>  
>  	for (i = 0; i < cnt; i++) {
> -		err = uprobe_register_refctr(d_real_inode(link->path.dentry),
> -					     uprobes[i].offset,
> -					     uprobes[i].ref_ctr_offset,
> -					     &uprobes[i].consumer);
> +		err = uprobe_register(d_real_inode(link->path.dentry),
> +				      uprobes[i].offset,
> +				      uprobes[i].ref_ctr_offset,
> +				      &uprobes[i].consumer);
>  		if (err) {
>  			bpf_uprobe_unregister(&path, uprobes, i);
>  			goto error_free;
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index c98e3b3386ba..1f590f989c1e 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1089,12 +1089,7 @@ static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
>  	tu->consumer.filter = filter;
>  	tu->inode = d_real_inode(tu->path.dentry);
>  
> -	if (tu->ref_ctr_offset)
> -		ret = uprobe_register_refctr(tu->inode, tu->offset,
> -				tu->ref_ctr_offset, &tu->consumer);
> -	else
> -		ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
> -
> +	ret = uprobe_register(tu->inode, tu->offset, tu->ref_ctr_offset, &tu->consumer);
>  	if (ret)
>  		tu->inode = NULL;
>  
> -- 
> 2.25.1.362.g51ebf55
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
