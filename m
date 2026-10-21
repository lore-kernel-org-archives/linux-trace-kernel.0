Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792568123;
	b=2I2cp0i/9HtGD9n3fMbNH7bD9BSOEkcbRRKVMAp/GEmg4sJ3KwuCr/5XnOW6YnEmQv/N
	 YspV6t1lno3uV+EZOSPEPR9gH2E1NzoBxzi/fx8Gk0LSGepSDPw0gva8jHvxBjXAuVtQS
	 LMU9ppfIaxg0dmVyG306sSX2ReZvIn73RExFa84wR/aHcaLGEzetqM6Ao+jVRx4fyXmxN
	 rNYYZYollUGneZT0j7MzoU90E1bxpmPls60tO3shXx//FvNiaZjDkUnIHX5ZCHWcE8wM5
	 50UEJEGA6QaAor05SDri52sUPnl1iFc/4v+3b/0pyyM053HAtC2z2vaiEYVjR68JYQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568123;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=0PqGtcZfJEv7f1tdHbHDT8RrzBs2F23hGucrZ7FWHXQ=;
	b=T9crN7mGWjnDlxAk2HvzpbqariieFmlR0faNKmL5IaJDgqK4pXYOuvVvsZs2FABI8ZU7
	 fk1TmCg6atnVivR2ZkQuB/311ceYksfNTJYPuRVthsjwX7PB/mV3ae9xEjZaKpgZX8RQQ
	 1HVBxSyw4NQSSj1GBIw6k2eMPLXgQDrK8E55uC0VGzdyggtuTPl6I/w2hR0fV0VkpCj4/
	 B7ai+mu7J7QQ4NZArOpjt718jUUseZ43xuKD6vu7GwxgTRfnx5FaGPFn9DC2sfxm+IH7P
	 Vtr7AWXXu8kSmMuXXWu8BHJ9SlQAxcdXT1pWriCnzUf+/8Hx3/twLVZ22i2qCjlx0/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.228
Received: from mta1.migadu.com (out-228.mta1.migadu.com [95.215.58.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1BD606A31C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 07:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B1BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nqardKFouZLzhvG1GwLE28mrgZ6sAyUxCB2/J3C6f6g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792568110; v=1; x=1793172910;
 b=MBpord0D9PHlWSZRoUpEcJVx/XHhxjsSqmyXZ/a4ixI18h8SkV23pkY7peDZUChhzwbhUiML
 JJOdkKN1X/D1+M+5cAvmUPgHUz4EUYVWavZ45qGIALXMPa++rUHmCBdCmytAf1iz+8grDb01Nti
 CbXB+CPOWFQtqTq4vBg11zpY=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1d1af01dce31e0b9;
	Wed, 21 Oct 2026 07:35:08 +0000
X-Mizu-Trace-ID: 1d1af01dce31e0b9
X-Migadu-Flow: FLOW_OUT
Message-ID: <79568d55-705d-466c-8a3a-c2ec3143e5c2@linux.dev>
Date: Wed, 21 Oct 2026 15:36:16 +0800
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] alloc_tag: Add trace events for tracing
 allocations
To: Abhishek Bapat <abhishekbapat@google.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
References: <cover.1792439751.git.abhishekbapat@google.com>
 <323077f96bca23b512a86a6781ebc9dfe6ae9ec1.1792439751.git.abhishekbapat@google.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <323077f96bca23b512a86a6781ebc9dfe6ae9ec1.1792439751.git.abhishekbapat@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2026/10/20 04:00, Abhishek Bapat wrote:
> The memory allocation profiling framework intercepts allocations across
> the core subsystems, but currently lacks runtime tracing hooks for
> standard observability tools to dynamically track the context (stack
> traces and lifecycles of the individual memory chunks) of the
> allocations made.
> 
> Introduce three standard trace events to allow this tracking:
> 
> 1. `alloc_tag_hit`: Fired at the exact call site. This allows userspace
>    tools to trigger and capture a call stack.
> 2. `alloc_tag_mem_alloced`: Fired in alloc_tag_add upon successful
>    allocation. It records the allocated size, the tag, and the uniquely
>    generated `ptr` value which is `codetag_ref` for slab and percpu
>    allocators and the pointer to the head `struct page` for the page
>    allocator.
> 3. `alloc_tag_mem_freed`: Fired in alloc_tag_sub right before memory is
>    freed, yielding the same `ptr` value to allow tracing tools to find
>    the corresponding allocation.
> 
> Because the introduced trace events occur at different stages in the
> call stack, userspace tracing tools must stitch them together to form a
> complete picture of a buffer's lifetime. Here's an example of how
> userspace correlates these three events:
> 
> 1. On `alloc_tag_hit`: The tool captures the stack trace and caches it,
>    keyed by the combination of the current thread's PID and the `tag`.
> 2. On `alloc_tag_mem_alloced`: The tool extracts the PID and `tag` from
>    the event and looks up the stack trace cached in step 1. It creates a
>    new active allocation record, mapping the new provided `ptr` value
>    to this cached stack trace and the newly returned allocation size.
> 3. On `alloc_tag_mem_freed`: When the memory is freed, the event yields
>    the same `ptr` value. The tool uses this reference to look up the
>    original allocation record, correlates the free, and safely retires
>    the tracking entry.
> 
> Modify `alloc_tag_add()` and `alloc_tag_sub()` with a `ptr` argument to
> map frees to allocations in the trace events. Slab and percpu pass the
> address of the object's `codetag_ref`. The page allocator passes the
> head `struct page` because its `codetag_ref` is a temporary copy on the
> stack.
> 
> Also, introduce `alloc_tag_trace_key` static key to minimize the
> overhead when no tags are being traced (the usual case). Once tracing
> for any tag is requested, the key is set, opening the path to check
> whether tracing is enabled for the current tag.
> Note that the mechanism to enable tag tracing is implemented in the next
> patch, therefore for now, `alloc_tag_trace_key` stays always unset.
> 
> Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
> Acked-by: Hao Ge <hao.ge@linux.dev>
> Acked-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  Documentation/mm/allocation-profiling.rst |  53 ++++++++++
>  MAINTAINERS                               |   1 +
>  include/linux/alloc_tag.h                 |  67 +++++++++---
>  include/trace/events/alloc_tag.h          | 122 ++++++++++++++++++++++
>  mm/alloc_tag.c                            |  28 +++++
>  mm/page_alloc.c                           |   4 +-
>  mm/percpu.c                               |  13 ++-
>  mm/slub.c                                 |   6 +-
>  8 files changed, 269 insertions(+), 25 deletions(-)
>  create mode 100644 include/trace/events/alloc_tag.h
> 
> diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/mm/allocation-profiling.rst
> index b11ea77c0673..b241450394df 100644
> --- a/Documentation/mm/allocation-profiling.rst
> +++ b/Documentation/mm/allocation-profiling.rst
> @@ -129,6 +129,59 @@ To do so:
>  - Then, use the following form for your allocations:
>    alloc_hooks_tag(ht->your_saved_tag, kmalloc_noprof(...))
>  
> +Tracing
> +=======
> +
> +Three trace events are available under `/sys/kernel/tracing/events/alloc_tag` to
> +expose the full call stack and the lifetime of individual allocations:
> +
> +- `alloc_tag_hit`: Fired at the exact call site, before the allocation happens.
> +  Can be used to capture the call stack of the caller.
> +
> +- `alloc_tag_mem_alloced`: Fired once the allocation succeeds. Carries the `ptr`,
> +  `tag` and `bytes` for each allocation.
> +
> +- `alloc_tag_mem_freed`: Fired before memory is freed. Carries the same
> +  `ptr`, `tag` and `bytes` as the matching alloc event.
> +
> +`ptr` identifies the allocation, and its meaning depends on the allocator:
> +
> +- slab and percpu: the address of the object's `codetag_ref`
> +- page allocator: the `struct page` pointer of the head page
> +
> +Correlating the events
> +----------------------
> +
> +`alloc_tag_hit` and `alloc_tag_mem_alloced` come from different points in the
> +call stack, so they have to be stitched together by the user consuming the
> +events. Here's a typical flow:
> +
> +1. On `alloc_tag_hit`: Capture the stack trace and cache it keyed by `(pid, tag)`.
> +
> +2. On `alloc_tag_mem_alloced`: Look up the cached stack trace by `(pid, tag)`,
> +   then create an active allocation record keyed by `ptr` that holds the stack
> +   trace and `bytes`.
> +
> +3. On `alloc_tag_mem_freed`: Look up the record by `ptr` and retire it.
> +
> +Limitations
> +-----------
> +
> +- For the page allocator, events are generated for the original allocation and
> +  the free only. If the tag reference is split or moved to another folio in
> +  between, no event is generated for that. As a result:
> +
> +  - a free event may carry a `ptr` that never appeared in an alloc event;
> +  - `bytes` in a free event may be smaller than in the matching alloc event.
> +
> +  Tools should correlate on `ptr` but must not assume that freed bytes equal
> +  allocated bytes, or that every free has a matching alloc.
> +
> +- Freeing a non-compound high-order page with `__free_pages()` while another CPU
> +  holds a reference frees the tail pages immediately and the head page later when
> +  the reference is dropped. The free event is emitted at the second point and
> +  reports `PAGE_SIZE` rather than the full size.
> +
>  Notes
>  =====
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6f1f35a017a6..fb2df7b8e9ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17100,6 +17100,7 @@ S:	Maintained
>  F:	Documentation/mm/allocation-profiling.rst
>  F:	include/linux/alloc_tag.h
>  F:	include/linux/pgalloc_tag.h
> +F:	include/trace/events/alloc_tag.h
>  F:	include/uapi/linux/alloc_tag.h
>  F:	mm/alloc_tag.c
>  F:	tools/testing/selftests/alloc_tag/
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 7f2d80a59792..0319c2f1e4e2 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -128,12 +128,33 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
>  DECLARE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
>  			mem_alloc_profiling_key);
>  
> +DECLARE_STATIC_KEY_FALSE(alloc_tag_trace_key);
> +
>  static inline bool mem_alloc_profiling_enabled(void)
>  {
>  	return static_branch_maybe(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
>  				   &mem_alloc_profiling_key);
>  }
>  
> +static inline bool alloc_tag_trace_enabled(void)
> +{
> +	return static_branch_unlikely(&alloc_tag_trace_key);
> +}
> +
> +void alloc_tag_trace_mem_alloc(const void *ptr, struct alloc_tag *tag,
> +			       size_t bytes);
> +
> +void alloc_tag_trace_mem_free(const void *ptr, struct alloc_tag *tag,
> +			      size_t bytes);
> +
> +void __alloc_tag_trace_hit(struct alloc_tag *tag);
> +
> +static __always_inline void alloc_tag_trace_hit(struct alloc_tag *tag)
> +{
> +	if (alloc_tag_trace_enabled())
> +		__alloc_tag_trace_hit(tag);
> +}
> +
>  bool mem_alloc_profiling_permanently_disabled(void);
>  
>  static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
> @@ -198,13 +219,19 @@ static inline bool alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *t
>  	return true;
>  }
>  
> -static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes)
> +static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes,
> +				 const void *ptr)
>  {
> -	if (likely(alloc_tag_ref_set(ref, tag)))
> +	if (likely(alloc_tag_ref_set(ref, tag))) {
>  		this_cpu_add(tag->counters->bytes, bytes);
> +
> +		if (alloc_tag_trace_enabled())
> +			/* Trace successful allocs with their unique ptr */
> +			alloc_tag_trace_mem_alloc(ptr, tag, bytes);
> +	}
>  }
>  
> -static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
> +static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes, const void *ptr)
>  {
>  	struct alloc_tag *tag;
>  
> @@ -222,6 +249,10 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
>  	this_cpu_sub(tag->counters->bytes, bytes);
>  	this_cpu_dec(tag->counters->calls);
>  
> +	if (alloc_tag_trace_enabled())
> +		/* Trace frees with their unique ptr */
> +		alloc_tag_trace_mem_free(ptr, tag, bytes);
> +
>  	ref->ct = NULL;
>  }
>  
> @@ -243,25 +274,29 @@ static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
>  static inline bool mem_alloc_profiling_enabled(void) { return false; }
>  static inline bool mem_alloc_profiling_permanently_disabled(void) { return true; }
>  static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
> -				 size_t bytes) {}
> -static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
> +				 size_t bytes, const void *ptr) {}
> +static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes,
> +				 const void *ptr) {}
>  static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag) {}
>  static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag) { return false; }
> +#define alloc_tag_trace_hit(_tag)	/* NOOP */

I'd rather this follow the code style below.

>  #define alloc_tag_record(p)	do {} while (0)
>  
>  #endif /* CONFIG_MEM_ALLOC_PROFILING */
>  
> -#define alloc_hooks_tag(_tag, _do_alloc)				\
> -({									\
> -	typeof(_do_alloc) _res;						\
> -	if (mem_alloc_profiling_enabled()) {				\
> -		struct alloc_tag * __maybe_unused _old;			\
> -		_old = alloc_tag_save(_tag);				\
> -		_res = _do_alloc;					\
> -		alloc_tag_restore(_tag, _old);				\
> -	} else								\
> -		_res = _do_alloc;					\
> -	_res;								\
> +#define alloc_hooks_tag(_tag, _do_alloc)					\
> +({										\
> +	typeof(_do_alloc) _res;							\
> +	if (mem_alloc_profiling_enabled()) {					\
> +		struct alloc_tag * __maybe_unused _old;				\
> +		/* Fired here to capture the caller's stack trace */	\
> +		alloc_tag_trace_hit(_tag);					\
> +		_old = alloc_tag_save(_tag);					\
> +		_res = _do_alloc;						\
> +		alloc_tag_restore(_tag, _old);					\
> +	} else									\
> +		_res = _do_alloc;						\
> +	_res;									\
>  })
>  
>  #define alloc_hooks(_do_alloc)						\
> diff --git a/include/trace/events/alloc_tag.h b/include/trace/events/alloc_tag.h
> new file mode 100644
> index 000000000000..58d420e64516
> --- /dev/null
> +++ b/include/trace/events/alloc_tag.h
> @@ -0,0 +1,122 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM alloc_tag
> +
> +#if !defined(_TRACE_ALLOC_TAG_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_ALLOC_TAG_H
> +
> +#include <linux/tracepoint.h>
> +
> +/*
> + * alloc_tag_hit is generated at the exact allocation call site and can be
> + * used to capture a stack trace.
> + *
> + * To link this stack trace to the actual allocated memory chunk, tools must
> + * correlate this event with the resulting alloc_tag_mem_alloced event. Since
> + * multiple threads can hit the same tag simultaneously, tools must match BOTH
> + * the `tag` field and the implicitly recorded PID provided by the core
> + * tracing subsystem.
> + */
> +TRACE_EVENT(alloc_tag_hit,
> +	TP_PROTO(struct alloc_tag *tag),
> +
> +	TP_ARGS(tag),
> +
> +	TP_STRUCT__entry(__field(struct alloc_tag *, tag)
> +			 __string(modname, tag->ct.modname ? tag->ct.modname : "NONE")
> +			 __string(filename, tag->ct.filename)
> +			 __string(function, tag->ct.function)
> +			 __field(unsigned int, lineno)
> +	),
> +
> +	TP_fast_assign(__entry->tag = tag;
> +		       __assign_str(modname);
> +		       __assign_str(filename);
> +		       __assign_str(function);
> +		       __entry->lineno = tag->ct.lineno;
> +	),
> +
> +	TP_printk("tag %p, module: %s, filename: %s, function %s, lineno %u",
> +		  __entry->tag,
> +		  __get_str(modname),
> +		  __get_str(filename),
> +		  __get_str(function),
> +		  __entry->lineno
> +	)
> +);
> +
> +/*
> + * alloc_tag_mem_alloced is generated after memory is successfully allocated.
> + * It captures the exact byte size.
> + *
> + * The `ptr` value identifies the memory chunk for tracking its lifecycle
> + * (e.g., matching it with alloc_tag_mem_freed).
> + * - slab and percpu allocators: address of the object's codetag_ref
> + * - page allocator: the head struct page of the allocation
> + *
> + * Because the kernel isolates active allocations within the task struct
> + * (current->alloc_tag), this event will always share the same implicit PID as
> + * its corresponding alloc_tag_hit event. Tools should use the combination
> + * PID + `tag` to correlate them.
> + */
> +TRACE_EVENT(alloc_tag_mem_alloced,
> +	TP_PROTO(const void *ptr, struct alloc_tag *tag, size_t bytes),
> +
> +	TP_ARGS(ptr, tag, bytes),
> +
> +	TP_STRUCT__entry(__field(const void *, ptr)
> +			 __field(struct alloc_tag *, tag)
> +			 __field(size_t, bytes)
> +	),
> +
> +	TP_fast_assign(__entry->ptr = ptr;
> +		       __entry->tag = tag;
> +		       __entry->bytes = bytes;
> +	),
> +
> +	TP_printk("ptr %p, tag %p, bytes %zu",
> +		  __entry->ptr,
> +		  __entry->tag,
> +		  __entry->bytes
> +	)
> +);
> +
> +/*
> + * alloc_tag_mem_freed event is generated immediately before memory is
> + * freed. The `ptr` value matches the one emitted during allocation,
> + * allowing tools to match it to its corresponding allocation and
> + * call stack.
> + *
> + * Page allocator caveat: Pages can be split or moved to another folio
> + * after the alloc event with no new events generated for that. As a
> + * result, a free event may carry a `ptr` that never appeared in an
> + * alloc event, and the `bytes` may be smaller than in the matching
> + * alloc event. Tools must not assume alloc bytes == free bytes, nor
> + * that every free has a matching alloc.
> + */
> +TRACE_EVENT(alloc_tag_mem_freed,
> +	TP_PROTO(const void *ptr, struct alloc_tag *tag, size_t bytes),
> +
> +	TP_ARGS(ptr, tag, bytes),
> +
> +	TP_STRUCT__entry(__field(const void *, ptr)
> +			 __field(struct alloc_tag *, tag)
> +			 __field(size_t, bytes)
> +	),
> +
> +	TP_fast_assign(__entry->ptr = ptr;
> +		       __entry->tag = tag;
> +		       __entry->bytes = bytes;
> +	),
> +
> +	TP_printk("ptr %p, tag %p, bytes %zu",
> +		  __entry->ptr,
> +		  __entry->tag,
> +		  __entry->bytes
> +	)
> +);
> +
> +#endif /* _TRACE_ALLOC_TAG_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 82e2c3448dcf..ca2412a67312 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -18,6 +18,9 @@
>  #include <linux/kmemleak.h>
>  #include <uapi/linux/alloc_tag.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/alloc_tag.h>
> +
>  #include "internal.h"
>  #include "page_alloc.h"
>  
> @@ -54,6 +57,9 @@ EXPORT_SYMBOL(mem_alloc_profiling_key);
>  
>  DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
>  
> +DEFINE_STATIC_KEY_FALSE(alloc_tag_trace_key);
> +EXPORT_SYMBOL(alloc_tag_trace_key);
> +
>  struct alloc_tag_kernel_section kernel_tags = { NULL, 0 };
>  unsigned long alloc_tag_ref_mask;
>  int alloc_tag_ref_offs;
> @@ -484,6 +490,28 @@ static const struct proc_ops allocinfo_proc_ops = {
>  #endif
>  };
>  
> +void __alloc_tag_trace_hit(struct alloc_tag *tag)
> +{
> +	if (unlikely(!tag))
> +		return;
> +	trace_alloc_tag_hit(tag);
> +}
> +EXPORT_SYMBOL(__alloc_tag_trace_hit);
> +
> +void alloc_tag_trace_mem_alloc(const void *ptr, struct alloc_tag *tag,
> +			       size_t bytes)
> +{
> +	trace_alloc_tag_mem_alloced(ptr, tag, bytes);
> +}
> +EXPORT_SYMBOL(alloc_tag_trace_mem_alloc);
> +
> +void alloc_tag_trace_mem_free(const void *ptr, struct alloc_tag *tag,
> +			      size_t bytes)
> +{
> +	trace_alloc_tag_mem_freed(ptr, tag, bytes);
> +}
> +EXPORT_SYMBOL(alloc_tag_trace_mem_free);
> +
>  size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sleep)
>  {
>  	struct codetag_iterator iter;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2daf358269ae..e8bb12a6a721 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1241,7 +1241,7 @@ void __pgalloc_tag_add(struct page *page, struct task_struct *task,
>  	union codetag_ref ref;
>  
>  	if (likely(get_page_tag_ref(page, &ref, &handle))) {
> -		alloc_tag_add(&ref, task->alloc_tag, PAGE_SIZE * nr);
> +		alloc_tag_add(&ref, task->alloc_tag, PAGE_SIZE * nr, page);
>  		update_page_tag_ref(handle, &ref);
>  		put_page_tag_ref(handle);
>  	} else {
> @@ -1270,7 +1270,7 @@ void __pgalloc_tag_sub(struct page *page, unsigned int nr)
>  	union codetag_ref ref;
>  
>  	if (get_page_tag_ref(page, &ref, &handle)) {
> -		alloc_tag_sub(&ref, PAGE_SIZE * nr);
> +		alloc_tag_sub(&ref, PAGE_SIZE * nr, page);
>  		update_page_tag_ref(handle, &ref);
>  		put_page_tag_ref(handle);
>  	}
> diff --git a/mm/percpu.c b/mm/percpu.c
> index d7883507dc15..16f29020bcad 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1695,16 +1695,19 @@ static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
>  				      size_t size)
>  {
>  	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts)) {
> -		alloc_tag_add(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag,
> -			      current->alloc_tag, pcpu_obj_full_size(size));
> +		union codetag_ref *ref = &chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag;
> +
> +		alloc_tag_add(ref, current->alloc_tag, pcpu_obj_full_size(size), ref);
>  	}
>  }
>  
>  static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
>  {
> -	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts))
> -		alloc_tag_sub(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag,
> -			      pcpu_obj_full_size(size));
> +	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts)) {
> +		union codetag_ref *ref = &chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag;
> +
> +		alloc_tag_sub(ref, pcpu_obj_full_size(size), ref);
> +	}
>  }
>  #else
>  static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
> diff --git a/mm/slub.c b/mm/slub.c
> index 544cff39762c..a866576ccb98 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2404,7 +2404,7 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags,
>  		obj_ext = slab_obj_ext(s, slab, obj_exts, object);
>  		ref = slab_obj_ext_codetag_ref(slab, obj_ext);
>  
> -		alloc_tag_add(ref, current->alloc_tag, s->size);
> +		alloc_tag_add(ref, current->alloc_tag, s->size, ref);
>  
>  		put_slab_obj_exts(obj_exts);
>  	} else {
> @@ -2444,9 +2444,11 @@ __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p
>  	get_slab_obj_exts(obj_exts);
>  	for (int i = 0; i < objects; i++) {
>  		struct slabobj_ext *ext;
> +		union codetag_ref *ref;
>  
>  		ext = slab_obj_ext(s, slab, obj_exts, p[i]);
> -		alloc_tag_sub(slab_obj_ext_codetag_ref(slab, ext), s->size);
> +		ref = slab_obj_ext_codetag_ref(slab, ext);
> +		alloc_tag_sub(ref, s->size, ref);
>  	}
>  	put_slab_obj_exts(obj_exts);
>  }
