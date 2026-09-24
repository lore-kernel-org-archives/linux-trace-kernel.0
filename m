Received: from mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61DB433BAC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790237807; cv=none; b=cpob7Q0gd4oMSPOrVjBlk+wUQiltijiRzFyYyPDG9YpCscfDVataj367oh+Jt3ULk6RM/mt1V99afBPtE3vpwH7GeYf/zwyoeSiPu1WZmvJY4QGmhas9AoSEoRJ7dZZ3VhKWQjuXW47NAXcg31EgxrhL1UePT9KNh51jWxji44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790237807; c=relaxed/simple;
	bh=4zWOSTBNfGb9w1wTIc0wuOpgNTBigCOzpfBfTYk5Zus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7wlrWxgTx6dZ8bRx7yRK3sqdKbEFvdTPH6sO4hngzGHxnl0kTYTwXmLyKsAm+VSqQdeejfpTFnKVe9FoIddrJilMQ8zAiJKZ1bRSKx8boF4qcHjXL0w8ik6Vp1C+URsVCqSaqlM3GFJtU0nJI8CrpZXRMm5woHc8tw7KiWuiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ajv2nv9j; arc=none smtp.client-ip=95.215.58.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ajv2nv9j"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4zWOSTBNfGb9w1wTIc0wuOpgNTBigCOzpfBfTYk5Zus=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790237800; v=1; x=1790842600;
 b=ajv2nv9jhNgTG68frvsyQvul9M/2R9b6yiAg966ErSx5rCqi9b/0jTU473eNtaZMCviFPBRR
 cX7VzqwUjVdDuCHZUM01vR2VuDCMwO0Z4+4XMev01Knr9TfWOHEqPrcPMXqyRssF23SznuQhAil
 H0tCNzgY35PGFXSsz9w0oFxU=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ece7adc700c99cc0;
	Thu, 24 Sep 2026 08:16:40 +0000
X-Mizu-Trace-ID: ece7adc700c99cc0
X-Migadu-Flow: FLOW_OUT
Message-ID: <0e2db0a0-663e-45fc-b073-126b8e80b625@linux.dev>
Date: Thu, 24 Sep 2026 16:17:43 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] alloc_tag: Introduce IOCTLs to toggle allocation
 tracepoints
To: Abhishek Bapat <abhishekbapat@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <cover.1790025465.git.abhishekbapat@google.com>
 <95bf63d2b9ef14f6610d6543b6892d266e4dc5c6.1790025465.git.abhishekbapat@google.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <95bf63d2b9ef14f6610d6543b6892d266e4dc5c6.1790025465.git.abhishekbapat@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Abhishek

On 2026/9/22 05:26, Abhishek Bapat wrote:
> Introduce a new IOCTL (`ALLOCINFO_IOC_TOGGLE_TRACE`) to selectively
> toggle tracing on exact allocation call sites. Userspace tools can
> use the existing filtering mechanism to specify the set of tags to
> toggle tracing for.
> 
> To facilitate low overhead execution for non-targeted call sites, add a
> new `CODETAG_FLAG_TRACE_ON` flag to `struct codetag` to track per-site
> activation. Protect these conditional branch evaluations using a global
> `alloc_tag_trace_key` static branch and an inline static key check
> pattern in the allocator hooks (`alloc_tag_add`, `alloc_tag_sub`, etc).
> This ensures that the trace events are entirely skipped when no
> allocation call sites are being actively traced, leaving only a NOP on
> the allocation fast path.
> 
> Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
> ---
>  include/linux/alloc_tag.h      |  39 ++++++++----
>  include/linux/codetag.h        |   5 +-
>  include/uapi/linux/alloc_tag.h |   9 +++
>  mm/alloc_tag.c                 | 110 ++++++++++++++++++++++++++++++++-
>  4 files changed, 147 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 2994934cf44a..dc86f8997476 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -136,9 +136,36 @@ static inline bool mem_alloc_profiling_enabled(void)
>  				   &mem_alloc_profiling_key);
>  }
>  
> +static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag)
> +{
> +	atomic_or(CODETAG_FLAG_INACCURATE, &tag->ct.flags);
> +}
> +
> +static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
> +{
> +	return !!(atomic_read(&tag->ct.flags) & CODETAG_FLAG_INACCURATE);
> +}
> +
> +static inline void alloc_tag_set_traced(struct alloc_tag *tag)
> +{
> +	atomic_or(CODETAG_FLAG_TRACE_ON, &tag->ct.flags);
> +}
> +
> +static inline void alloc_tag_clear_traced(struct alloc_tag *tag)
> +{
> +	atomic_andnot(CODETAG_FLAG_TRACE_ON, &tag->ct.flags);
> +}
> +
> +static inline bool alloc_tag_is_traced(const struct alloc_tag *tag)
> +{
> +	return !!(atomic_read(&tag->ct.flags) & CODETAG_FLAG_TRACE_ON);
> +}
> +
>  static inline bool alloc_tag_trace_enabled(const struct alloc_tag *tag)
>  {
> -	return static_branch_unlikely(&alloc_tag_trace_key);
> +	if (static_branch_unlikely(&alloc_tag_trace_key))
> +		return tag && alloc_tag_is_traced(tag);
> +	return false;
>  }
>  
>  void alloc_tag_trace_mem_alloc(union codetag_ref *ref, struct alloc_tag *tag,
> @@ -255,16 +282,6 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
>  	ref->ct = NULL;
>  }
>  
> -static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag)
> -{
> -	tag->ct.flags |= CODETAG_FLAG_INACCURATE;
> -}
> -
> -static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
> -{
> -	return !!(tag->ct.flags & CODETAG_FLAG_INACCURATE);
> -}
> -
>  #define alloc_tag_record(p)	((p) = current->alloc_tag)
>  
>  #else /* CONFIG_MEM_ALLOC_PROFILING */
> diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> index a25a085c2df1..f728295d50c0 100644
> --- a/include/linux/codetag.h
> +++ b/include/linux/codetag.h
> @@ -18,6 +18,7 @@ struct module;
>  
>  /* codetag flags */
>  #define CODETAG_FLAG_INACCURATE	(1 << 0)
> +#define CODETAG_FLAG_TRACE_ON	(1 << 1)
>  
>  /*
>   * An instance of this structure is created in a special ELF section at every
> @@ -25,7 +26,7 @@ struct module;
>   * an array of these.
>   */
>  struct codetag {
> -	unsigned int flags;
> +	atomic_t flags;
>  	unsigned int lineno;
>  	const char *modname;
>  	const char *function;
> @@ -71,7 +72,7 @@ struct codetag_iterator {
>  	.function	= __func__,			\
>  	.filename	= __FILE__,			\
>  	.lineno		= __LINE__,			\
> -	.flags		= 0,				\
> +	.flags		= ATOMIC_INIT(0),		\
>  }
>  
>  void codetag_lock_module_list(struct codetag_type *cttype);
> diff --git a/include/uapi/linux/alloc_tag.h b/include/uapi/linux/alloc_tag.h
> index 7d4618bea043..069ab8341e87 100644
> --- a/include/uapi/linux/alloc_tag.h
> +++ b/include/uapi/linux/alloc_tag.h
> @@ -85,9 +85,16 @@ struct allocinfo_get_at {
>  	struct allocinfo_tag_data data;
>  };
>  
> +struct allocinfo_toggle_traces {
> +	/* inputs */
> +	struct allocinfo_tag fields;
> +	__u64 enable;
> +};
> +
>  #define _ALLOCINFO_IOC_CONTENT_ID	0
>  #define _ALLOCINFO_IOC_GET_AT		1
>  #define _ALLOCINFO_IOC_GET_NEXT		2
> +#define _ALLOCINFO_IOC_TOGGLE_TRACE	3
>  
>  #define ALLOCINFO_IOC_BASE		0xA6
>  #define ALLOCINFO_IOC_CONTENT_ID	_IOR(ALLOCINFO_IOC_BASE, _ALLOCINFO_IOC_CONTENT_ID,	\
> @@ -96,5 +103,7 @@ struct allocinfo_get_at {
>  					      struct allocinfo_get_at)
>  #define ALLOCINFO_IOC_GET_NEXT		_IOR(ALLOCINFO_IOC_BASE, _ALLOCINFO_IOC_GET_NEXT,	\
>  					     struct allocinfo_tag_data)
> +#define ALLOCINFO_IOC_TOGGLE_TRACE	_IOW(ALLOCINFO_IOC_BASE, _ALLOCINFO_IOC_TOGGLE_TRACE,	\
> +					    struct allocinfo_toggle_traces)
>  
>  #endif /* _UAPI_ALLOC_TAG_H */
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index a5339767efd5..fb179321a2a1 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -61,6 +61,15 @@ DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
>  DEFINE_STATIC_KEY_FALSE(alloc_tag_trace_key);
>  EXPORT_SYMBOL(alloc_tag_trace_key);
>  
> +static atomic_t alloc_tag_trace_cnt = ATOMIC_INIT(0);
> +
> +/*
> + * As `codetag_lock_module_list` is a read lock, we need an additional mutex
> + * to protect against the race conditions involved in the alloc tag trace
> + * toggle path.
> + */
> +static DEFINE_MUTEX(alloc_tag_trace_mutex);
> +
>  struct alloc_tag_kernel_section kernel_tags = { NULL, 0 };
>  unsigned long alloc_tag_ref_mask;
>  int alloc_tag_ref_offs;
> @@ -297,7 +306,7 @@ static bool matches_filter(struct codetag *ct, struct allocinfo_filter *filter,
>  		return false;
>  
>  	if (filter->mask & ALLOCINFO_FILTER_MASK_INACCURATE) {
> -		inaccurate = !!(ct->flags & CODETAG_FLAG_INACCURATE);
> +		inaccurate = alloc_tag_is_inaccurate(ct_to_alloc_tag(ct));
>  		if (inaccurate != !!(filter->inaccurate))
>  			return false;
>  	}
> @@ -444,6 +453,81 @@ static int allocinfo_ioctl_get_next(struct seq_file *m, void __user *arg)
>  	return ret;
>  }
>  
> +static bool alloc_tag_trace_toggle(struct alloc_tag *tag, bool enable)
> +{
> +	if (enable) {
> +		if (alloc_tag_is_traced(tag))
> +			return false;
> +
> +		alloc_tag_set_traced(tag);
> +		if (atomic_fetch_inc(&alloc_tag_trace_cnt) == 0)
> +			static_branch_enable(&alloc_tag_trace_key);
> +	} else {
> +		if (!alloc_tag_is_traced(tag))
> +			return false;
> +
> +		alloc_tag_clear_traced(tag);
> +		if (atomic_dec_and_test(&alloc_tag_trace_cnt))
> +			static_branch_disable(&alloc_tag_trace_key);
> +	}
> +
> +	return true;
> +}
> +
> +/*
> + * Toggles context capture for a specified allocation.
> + */
> +static int allocinfo_ioctl_toggle_trace(struct seq_file *m, void __user *arg)
> +{
> +	struct allocinfo_toggle_traces params;
> +	struct codetag_iterator iter;
> +	struct codetag *ct;
> +	int matches = 0, successes = 0, ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (copy_from_user(&params, arg, sizeof(params)))
> +		return -EFAULT;
> +
> +	codetag_lock_module_list(alloc_tag_cttype);
> +
> +	struct allocinfo_filter filter = {
> +		.mask = ALLOCINFO_FILTER_MASK_MODNAME |
> +		       ALLOCINFO_FILTER_MASK_FUNCTION |
> +		       ALLOCINFO_FILTER_MASK_FILENAME |
> +		       ALLOCINFO_FILTER_MASK_LINENO,
> +		.fields = params.fields,
> +	};
> +
> +	iter = codetag_get_ct_iter(alloc_tag_cttype);
> +
> +	/* Toggle tracing on all codetags that match */
> +	while ((ct = codetag_next_ct(&iter))) {
> +		if (matches_filter(ct, &filter, NULL, NULL)) {
> +			matches++;
> +
> +			mutex_lock(&alloc_tag_trace_mutex);
> +			if (alloc_tag_trace_toggle(ct_to_alloc_tag(ct), !!params.enable))
> +				successes++;
> +			mutex_unlock(&alloc_tag_trace_mutex);
> +		}
> +	}
> +
> +	if (matches == 0)
> +		/* Nothing matched the filter */
> +		ret = -ENOENT;
> +	else if (successes == 0)
> +		/* Items matched, but were already in the requested state */
> +		ret = -EINVAL;

Why do we return -EINVAL in this path?
-EINVAL can mislead users into thinking their arguments are wrong.
That's not the case; the trace request they want is already active.
Maybe -EEXIST ?

Thanks
Best Regards
Hao

> +	else
> +		ret = 0;
> +
> +	codetag_unlock_module_list(alloc_tag_cttype);
> +
> +	return ret;
> +}
> +
>  /*
>   * Entry point ioctl function for /proc/allocinfo routing requests to fetch the
>   * layout content ID, seek to a specific tag, or read sequential tags.
> @@ -464,6 +548,9 @@ static long allocinfo_ioctl(struct file *file, unsigned int cmd,
>  	case ALLOCINFO_IOC_GET_NEXT:
>  		ret = allocinfo_ioctl_get_next(file->private_data, arg);
>  		break;
> +	case ALLOCINFO_IOC_TOGGLE_TRACE:
> +		ret = allocinfo_ioctl_toggle_trace(file->private_data, arg);
> +		break;
>  	default:
>  		ret = -ENOIOCTLCMD;
>  		break;
> @@ -493,8 +580,6 @@ static const struct proc_ops allocinfo_proc_ops = {
>  
>  void __alloc_tag_trace_hit(struct alloc_tag *tag)
>  {
> -	if (unlikely(!tag))
> -		return;
>  	trace_alloc_tag_hit(tag);
>  }
>  EXPORT_SYMBOL(__alloc_tag_trace_hit);
> @@ -1043,6 +1128,24 @@ static int load_module(struct module *mod, struct codetag *start, struct codetag
>  	return 0;
>  }
>  
> +static void unload_module(struct module *mod, struct codetag *start, struct codetag *stop)
> +{
> +	struct alloc_tag *start_tag = ct_to_alloc_tag(start);
> +	struct alloc_tag *stop_tag = ct_to_alloc_tag(stop);
> +	struct alloc_tag *tag;
> +
> +	/*
> +	 * Turn tracing off for the tags of the module being unloaded. Without
> +	 * this, `alloc_tag_trace_cnt` would never reach zero and tracing would
> +	 * stay enabled forever.
> +	 *
> +	 * `alloc_tag_trace_mutex` is not needed here as this code path is
> +	 * protected by a `down_write(&cttype->mod_lock)`.
> +	 */
> +	for (tag = start_tag; tag < stop_tag; tag++)
> +		alloc_tag_trace_toggle(tag, false);
> +}
> +
>  static void replace_module(struct module *mod, struct module *new_mod)
>  {
>  	MA_STATE(mas, &mod_area_mt, 0, module_tags.size);
> @@ -1369,6 +1472,7 @@ static int __init alloc_tag_init(void)
>  		.alloc_section_mem	= reserve_module_tags,
>  		.free_section_mem	= release_module_tags,
>  		.module_load		= load_module,
> +		.module_unload		= unload_module,
>  		.module_replaced	= replace_module,
>  #endif
>  	};
