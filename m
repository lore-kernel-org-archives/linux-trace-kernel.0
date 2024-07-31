Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD582747B;
	Wed, 31 Jul 2024 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722404390; cv=none; b=Ii1dQTKZVRkN5gVqYz++5+ysGVbrnHoYf0tGdSx3nKquuCQZOsoletXdllpg41ApGJgYWeOfsm1kAxTzRJ2MROvDvT3DYJuSre16gOOyvXm7/a11cZ/frejhrAmkqxMW8shn0eYY/Ks18R3U9HXaaJv/ehs2evOqn7RG8Q2GEAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722404390; c=relaxed/simple;
	bh=vnuezJUtX+tILs3HXKShM8KeSnFkIHQnjEECa+ILhwc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CdAOlhbzSWdIBwWPrZquHrpJmMpIUR8hLV1ue6vwIEo08MHBhmynmISispBMWHS4UzqeUM1Ph2sUX576nFpadzB5gZGp9Du+QM19rclsi8N8WrvrN7W/kcqYR3Pm0wz8EX1rlHxv+oEDiwkAFzeFSPDfQDYgYmoKw5TIfpfQYjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsJasKQo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsJasKQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B87DC116B1;
	Wed, 31 Jul 2024 05:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722404390;
	bh=vnuezJUtX+tILs3HXKShM8KeSnFkIHQnjEECa+ILhwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AsJasKQorLAHbak26xduVOTqFUFT69GTczXMrZF7bYhef2NdZ8sCOKvzkiBktonFl
	 aLacdfPLgygpxmjwC3iYtN8qyNlKg5IzD9/FLhVTYDKFxY7aFn1Gou/7xqPHYllCBU
	 1DPS1WebLdsNxwKvVk/tuszvJL6zdgCY2CBxyMCU26j/6j9QRur1zvOI7B5s9kncJB
	 5Zz+uvsTGoYJ1dTJb6NgqAAToceEKZbv+dFsYtNXcz7T33DKLf0qAjMR9ypHF8MMQB
	 xhQITNaNlmBtlLbeS7Z2T3SJiKPAfF44smdzubdyLNtEvknq8AukkVqeY1U0ozorpY
	 PRnftjlpPaadw==
Date: Wed, 31 Jul 2024 14:39:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, peterz@infradead.org, jolsa@kernel.org,
 rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
Message-Id: <20240731143946.f5689502e03b9ff2e79be494@kernel.org>
In-Reply-To: <20240729134535.GA12332@redhat.com>
References: <20240729134444.GA12293@redhat.com>
	<20240729134535.GA12332@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 15:45:35 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> This way uprobe_unregister() and uprobe_apply() can use "struct uprobe *"
> rather than inode + offset. This simplifies the code and allows to avoid
> the unnecessary find_uprobe() + put_uprobe() in these functions.
> 
> TODO: uprobe_unregister() still needs get_uprobe/put_uprobe to ensure that
> this uprobe can't be freed before up_write(&uprobe->register_rwsem).

Is this TODO item, or just a note? At this moment, this is natural
to use get_uprobe() to protect uprobe itself.

Thank you,

> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/uprobes.h     | 15 +++++-----
>  kernel/events/uprobes.c     | 56 +++++++++++++++----------------------
>  kernel/trace/bpf_trace.c    | 25 ++++++++---------
>  kernel/trace/trace_uprobe.c | 26 ++++++++---------
>  4 files changed, 55 insertions(+), 67 deletions(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 440316fbf3c6..137ddfc0b2f8 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -16,6 +16,7 @@
>  #include <linux/types.h>
>  #include <linux/wait.h>
>  
> +struct uprobe;
>  struct vm_area_struct;
>  struct mm_struct;
>  struct inode;
> @@ -110,9 +111,9 @@ extern bool is_trap_insn(uprobe_opcode_t *insn);
>  extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
>  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
>  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
> -extern int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
> -extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
> -extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
> +extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
> +extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
> +extern void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc);
>  extern int uprobe_mmap(struct vm_area_struct *vma);
>  extern void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned long end);
>  extern void uprobe_start_dup_mmap(void);
> @@ -150,18 +151,18 @@ static inline void uprobes_init(void)
>  
>  #define uprobe_get_trap_addr(regs)	instruction_pointer(regs)
>  
> -static inline int
> +static inline struct uprobe *
>  uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc)
>  {
> -	return -ENOSYS;
> +	return ERR_PTR(-ENOSYS);
>  }
>  static inline int
> -uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool add)
> +uprobe_apply(struct uprobe* uprobe, struct uprobe_consumer *uc, bool add)
>  {
>  	return -ENOSYS;
>  }
>  static inline void
> -uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> +uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  {
>  }
>  static inline int uprobe_mmap(struct vm_area_struct *vma)
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index b7f40bad8abc..974474680820 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1099,20 +1099,14 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  		delete_uprobe(uprobe);
>  }
>  
> -/*
> +/**
>   * uprobe_unregister - unregister an already registered probe.
> - * @inode: the file in which the probe has to be removed.
> - * @offset: offset from the start of the file.
> + * @uprobe: uprobe to remove
>   * @uc: identify which probe if multiple probes are colocated.
>   */
> -void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> +void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  {
> -	struct uprobe *uprobe;
> -
> -	uprobe = find_uprobe(inode, offset);
> -	if (WARN_ON(!uprobe))
> -		return;
> -
> +	get_uprobe(uprobe);
>  	down_write(&uprobe->register_rwsem);
>  	__uprobe_unregister(uprobe, uc);
>  	up_write(&uprobe->register_rwsem);
> @@ -1120,7 +1114,7 @@ void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consume
>  }
>  EXPORT_SYMBOL_GPL(uprobe_unregister);
>  
> -/*
> +/**
>   * uprobe_register - register a probe
>   * @inode: the file in which the probe has to be placed.
>   * @offset: offset from the start of the file.
> @@ -1136,40 +1130,40 @@ EXPORT_SYMBOL_GPL(uprobe_unregister);
>   * unregisters. Caller of uprobe_register() is required to keep @inode
>   * (and the containing mount) referenced.
>   *
> - * Return errno if it cannot successully install probes
> - * else return 0 (success)
> + * Return: pointer to the new uprobe on success or an ERR_PTR on failure.
>   */
> -int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset,
> -		    struct uprobe_consumer *uc)
> +struct uprobe *uprobe_register(struct inode *inode,
> +				loff_t offset, loff_t ref_ctr_offset,
> +				struct uprobe_consumer *uc)
>  {
>  	struct uprobe *uprobe;
>  	int ret;
>  
>  	/* Uprobe must have at least one set consumer */
>  	if (!uc->handler && !uc->ret_handler)
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  
>  	/* copy_insn() uses read_mapping_page() or shmem_read_mapping_page() */
>  	if (!inode->i_mapping->a_ops->read_folio &&
>  	    !shmem_mapping(inode->i_mapping))
> -		return -EIO;
> +		return ERR_PTR(-EIO);
>  	/* Racy, just to catch the obvious mistakes */
>  	if (offset > i_size_read(inode))
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  
>  	/*
>  	 * This ensures that copy_from_page(), copy_to_page() and
>  	 * __update_ref_ctr() can't cross page boundary.
>  	 */
>  	if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  	if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  
>   retry:
>  	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
>  	if (IS_ERR(uprobe))
> -		return PTR_ERR(uprobe);
> +		return uprobe;
>  
>  	/*
>  	 * We can race with uprobe_unregister()->delete_uprobe().
> @@ -1188,35 +1182,29 @@ int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset,
>  
>  	if (unlikely(ret == -EAGAIN))
>  		goto retry;
> -	return ret;
> +
> +	return ret ? ERR_PTR(ret) : uprobe;
>  }
>  EXPORT_SYMBOL_GPL(uprobe_register);
>  
> -/*
> - * uprobe_apply - unregister an already registered probe.
> - * @inode: the file in which the probe has to be removed.
> - * @offset: offset from the start of the file.
> +/**
> + * uprobe_apply - add or remove the breakpoints according to @uc->filter
> + * @uprobe: uprobe which "owns" the breakpoint
>   * @uc: consumer which wants to add more or remove some breakpoints
>   * @add: add or remove the breakpoints
> + * Return: 0 on success or negative error code.
>   */
> -int uprobe_apply(struct inode *inode, loff_t offset,
> -			struct uprobe_consumer *uc, bool add)
> +int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool add)
>  {
> -	struct uprobe *uprobe;
>  	struct uprobe_consumer *con;
>  	int ret = -ENOENT;
>  
> -	uprobe = find_uprobe(inode, offset);
> -	if (WARN_ON(!uprobe))
> -		return ret;
> -
>  	down_write(&uprobe->register_rwsem);
>  	for (con = uprobe->consumers; con && con != uc ; con = con->next)
>  		;
>  	if (con)
>  		ret = register_for_each_vma(uprobe, add ? uc : NULL);
>  	up_write(&uprobe->register_rwsem);
> -	put_uprobe(uprobe);
>  
>  	return ret;
>  }
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index afa909e17824..4e391daafa64 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3160,6 +3160,7 @@ struct bpf_uprobe {
>  	loff_t offset;
>  	unsigned long ref_ctr_offset;
>  	u64 cookie;
> +	struct uprobe *uprobe;
>  	struct uprobe_consumer consumer;
>  };
>  
> @@ -3178,15 +3179,12 @@ struct bpf_uprobe_multi_run_ctx {
>  	struct bpf_uprobe *uprobe;
>  };
>  
> -static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
> -				  u32 cnt)
> +static void bpf_uprobe_unregister(struct bpf_uprobe *uprobes, u32 cnt)
>  {
>  	u32 i;
>  
> -	for (i = 0; i < cnt; i++) {
> -		uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset,
> -				  &uprobes[i].consumer);
> -	}
> +	for (i = 0; i < cnt; i++)
> +		uprobe_unregister(uprobes[i].uprobe, &uprobes[i].consumer);
>  }
>  
>  static void bpf_uprobe_multi_link_release(struct bpf_link *link)
> @@ -3194,7 +3192,7 @@ static void bpf_uprobe_multi_link_release(struct bpf_link *link)
>  	struct bpf_uprobe_multi_link *umulti_link;
>  
>  	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
> -	bpf_uprobe_unregister(&umulti_link->path, umulti_link->uprobes, umulti_link->cnt);
> +	bpf_uprobe_unregister(umulti_link->uprobes, umulti_link->cnt);
>  	if (umulti_link->task)
>  		put_task_struct(umulti_link->task);
>  	path_put(&umulti_link->path);
> @@ -3480,12 +3478,13 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  		      &bpf_uprobe_multi_link_lops, prog);
>  
>  	for (i = 0; i < cnt; i++) {
> -		err = uprobe_register(d_real_inode(link->path.dentry),
> -				      uprobes[i].offset,
> -				      uprobes[i].ref_ctr_offset,
> -				      &uprobes[i].consumer);
> -		if (err) {
> -			bpf_uprobe_unregister(&path, uprobes, i);
> +		uprobes[i].uprobe = uprobe_register(d_real_inode(link->path.dentry),
> +						    uprobes[i].offset,
> +						    uprobes[i].ref_ctr_offset,
> +						    &uprobes[i].consumer);
> +		if (IS_ERR(uprobes[i].uprobe)) {
> +			err = PTR_ERR(uprobes[i].uprobe);
> +			bpf_uprobe_unregister(uprobes, i);
>  			goto error_free;
>  		}
>  	}
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 1f590f989c1e..52e76a73fa7c 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -58,8 +58,8 @@ struct trace_uprobe {
>  	struct dyn_event		devent;
>  	struct uprobe_consumer		consumer;
>  	struct path			path;
> -	struct inode			*inode;
>  	char				*filename;
> +	struct uprobe			*uprobe;
>  	unsigned long			offset;
>  	unsigned long			ref_ctr_offset;
>  	unsigned long			nhit;
> @@ -1084,16 +1084,16 @@ typedef bool (*filter_func_t)(struct uprobe_consumer *self,
>  
>  static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
>  {
> -	int ret;
> +	struct inode *inode = d_real_inode(tu->path.dentry);
> +	struct uprobe *uprobe;
>  
>  	tu->consumer.filter = filter;
> -	tu->inode = d_real_inode(tu->path.dentry);
> -
> -	ret = uprobe_register(tu->inode, tu->offset, tu->ref_ctr_offset, &tu->consumer);
> -	if (ret)
> -		tu->inode = NULL;
> +	uprobe = uprobe_register(inode, tu->offset, tu->ref_ctr_offset, &tu->consumer);
> +	if (IS_ERR(uprobe))
> +		return PTR_ERR(uprobe);
>  
> -	return ret;
> +	tu->uprobe = uprobe;
> +	return 0;
>  }
>  
>  static void __probe_event_disable(struct trace_probe *tp)
> @@ -1104,11 +1104,11 @@ static void __probe_event_disable(struct trace_probe *tp)
>  	WARN_ON(!uprobe_filter_is_empty(tu->tp.event->filter));
>  
>  	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
> -		if (!tu->inode)
> +		if (!tu->uprobe)
>  			continue;
>  
> -		uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
> -		tu->inode = NULL;
> +		uprobe_unregister(tu->uprobe, &tu->consumer);
> +		tu->uprobe = NULL;
>  	}
>  }
>  
> @@ -1305,7 +1305,7 @@ static int uprobe_perf_close(struct trace_event_call *call,
>  		return 0;
>  
>  	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
> -		ret = uprobe_apply(tu->inode, tu->offset, &tu->consumer, false);
> +		ret = uprobe_apply(tu->uprobe, &tu->consumer, false);
>  		if (ret)
>  			break;
>  	}
> @@ -1329,7 +1329,7 @@ static int uprobe_perf_open(struct trace_event_call *call,
>  		return 0;
>  
>  	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
> -		err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
> +		err = uprobe_apply(tu->uprobe, &tu->consumer, true);
>  		if (err) {
>  			uprobe_perf_close(call, event);
>  			break;
> -- 
> 2.25.1.362.g51ebf55
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
