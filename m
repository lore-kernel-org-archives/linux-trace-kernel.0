Received: from mta1.migadu.com (out-65.mta1.migadu.com [95.215.58.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA4B2AD0C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790561426; cv=none; b=JB40SUGTkyrfpAALprNGp/hS6rhdoQ6sSkI9XCwKvtHifiB8kaft/lKGzRqqJoO9B+JZzHU7dm5RIFEytG5AJlsNCU9psZL6MQ+BiYOefFtr4rdGtx2dwG0x9IU4N5UiBS29vPBoyWeUuhxJ8cYSUl4xg2wIW5HfLHrKpRO6Y9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790561426; c=relaxed/simple;
	bh=4qfzjfYArCFqrIDaqjA7/J3B4eUqELJL3++oCkS730M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYa9cc1muntKht7+jkbQ3+kExLwrEFhZrwVBYtaIOMDOnHERDWv169aA6VMfzUh8oueKWhdWVBuTNaEVUx22KuMtMtbtyHkEQeSKnH0dnmIkbZoNSyBsaoJGgF7RjSUUjZeoqciA5DvOlm78FweC16Lxc8duMKisoSCYVWr/f6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B28ROPlA; arc=none smtp.client-ip=95.215.58.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B28ROPlA"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4qfzjfYArCFqrIDaqjA7/J3B4eUqELJL3++oCkS730M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790561421; v=1; x=1791166221;
 b=B28ROPlA5ona41T2uwZ98Yjzs/Y1hUGdaafORWvxvHCoX2ev/2HjiIqnVzc9UdpDF+2aewo9
 p9nWQlOMiAcfq28jHdSzN3L1OgXOHY8PybREGMdmy5AB9rAv/NChob6+T+yf+a59bWWqgXN7oEs
 IawL5iI+RDmkFfytCFCpsDTc=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5bd72edd5c8eb864;
	Mon, 28 Sep 2026 02:10:21 +0000
X-Mizu-Trace-ID: 5bd72edd5c8eb864
X-Migadu-Flow: FLOW_OUT
Message-ID: <cf6ff2bf-1b3c-4575-b981-fc3c65625d5d@linux.dev>
Date: Mon, 28 Sep 2026 10:11:19 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] alloc_tag: Add trace events for tracing allocations
To: Suren Baghdasaryan <surenb@google.com>
Cc: Abhishek Bapat <abhishekbapat@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <cover.1790025465.git.abhishekbapat@google.com>
 <06c3a9b52785e6968ea15709a55365b2342c7a15.1790025465.git.abhishekbapat@google.com>
 <cb229e38-3e52-4309-9594-0d3947c1a81c@linux.dev>
 <CAJuCfpGZf+HDj8B2vV2WB68P2JMyqctF5CPvV0R6x=WU7+nwvQ@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpGZf+HDj8B2vV2WB68P2JMyqctF5CPvV0R6x=WU7+nwvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Suren

On 2026/9/25 14:14, Suren Baghdasaryan wrote:
> On Thu, Sep 24, 2026 at 12:21 AM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> Hi Abhishek
>>
>> Sorry, I merged and tested your patches today and found a few details,
>> so I've started a separate mail thread for this review.
>>
>> On 2026/9/22 05:26, Abhishek Bapat wrote:
>>> The memory allocation profiling framework intercepts allocations across
>>> the core subsystems, but currently lacks runtime tracing hooks for
>>> standard observability tools to dynamically track the context (stack
>>> traces and lifecycles of the individual memory chunks) of the
>>> allocations made.
>>>
>>> Introduce three standard trace events to allow this tracking:
>>>
>>> 1. `alloc_tag_hit`: Fired at the exact call site. This allows userspace
>>>    tools to trigger and capture a call stack.
>>> 2. `alloc_tag_mem_alloced`: Fired in alloc_tag_add upon successful
>>>    allocation. It records the allocated size, the tag, and the uniquely
>>>    generated codetag_ref metadata pointer.
>>> 3. `alloc_tag_mem_freed`: Fired in alloc_tag_sub right before memory is
>>>    freed, yielding the same codetag_ref to allow tracing tools to find
>>>    the corresponding allocation.
>>>
>>> Because the introduced trace events occur at different stages in the
>>> call stack, userspace tracing tools must stitch them together to form a
>>> complete picture of a buffer's lifetime. Here's an example of how
>>> userspace correlates these three events:
>>>
>>> 1. On `alloc_tag_hit`: The tool captures the stack trace and caches it,
>>>    keyed by the combination of the current thread's PID and the `tag`.
>>> 2. On `alloc_tag_mem_alloced`: The tool extracts the PID and `tag` from
>>>    the event and looks up the stack trace cached in step 1. It creates a
>>>    new active allocation record, mapping the new provided `codetag_ref`
>>>    to this cached stack trace and the newly returned allocation size.
>>> 3. On `alloc_tag_mem_freed`: When the memory is freed, the event yields
>>>    the same `codetag_ref`. The tool uses this reference to look up the
>>>    original allocation record, correlates the free, and safely retires
>>>    the tracking entry.
>>>
>>> Also, introduce `alloc_tag_trace_key` static key to minimize the
>>> overhead when no tags are being traced (the usual case). Once tracing
>>> for any tag is requested, the key is set, opening the path to check
>>> whether tracing is enabled for the current tag.
>>> Nore that the mechanism to enabl tag tracing is implemented in the next
>>> patch, therefore for now, `alloc_tag_trace_key` stays always unset.
>>>
>>> Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
>>> ---
>>>  MAINTAINERS                      |   1 +
>>>  include/linux/alloc_tag.h        |  57 ++++++++++++---
>>>  include/trace/events/alloc_tag.h | 122 +++++++++++++++++++++++++++++++
>>>  mm/alloc_tag.c                   |  28 +++++++
>>>  4 files changed, 196 insertions(+), 12 deletions(-)
>>>  create mode 100644 include/trace/events/alloc_tag.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 24420a8c06d0..29e1f7915cb9 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -17096,6 +17096,7 @@ S:    Maintained
>>>  F:   Documentation/mm/allocation-profiling.rst
>>>  F:   include/linux/alloc_tag.h
>>>  F:   include/linux/pgalloc_tag.h
>>> +F:   include/trace/events/alloc_tag.h
>>>  F:   include/uapi/linux/alloc_tag.h
>>>  F:   mm/alloc_tag.c
>>>  F:   tools/testing/selftests/alloc_tag/
>>> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
>>> index 7f2d80a59792..2994934cf44a 100644
>>> --- a/include/linux/alloc_tag.h
>>> +++ b/include/linux/alloc_tag.h
>>> @@ -128,12 +128,33 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
>>>  DECLARE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
>>>                       mem_alloc_profiling_key);
>>>
>>> +DECLARE_STATIC_KEY_FALSE(alloc_tag_trace_key);
>>> +
>>>  static inline bool mem_alloc_profiling_enabled(void)
>>>  {
>>>       return static_branch_maybe(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
>>>                                  &mem_alloc_profiling_key);
>>>  }
>>>
>>> +static inline bool alloc_tag_trace_enabled(const struct alloc_tag *tag)
>>> +{
>>> +     return static_branch_unlikely(&alloc_tag_trace_key);
>>> +}
>>> +
>>> +void alloc_tag_trace_mem_alloc(union codetag_ref *ref, struct alloc_tag *tag,
>>> +                           size_t bytes);
>>> +
>>> +void alloc_tag_trace_mem_free(union codetag_ref *ref, struct alloc_tag *tag,
>>> +                          size_t bytes);
>>> +
>>> +void __alloc_tag_trace_hit(struct alloc_tag *tag);
>>> +
>>> +static inline void alloc_tag_trace_hit(struct alloc_tag *tag)
>>> +{
>>> +     if (alloc_tag_trace_enabled(tag))
>>> +             __alloc_tag_trace_hit(tag);
>>> +}
>>> +
>>>  bool mem_alloc_profiling_permanently_disabled(void);
>>>
>>>  static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
>>> @@ -200,8 +221,13 @@ static inline bool alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *t
>>>
>>>  static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes)
>>>  {
>>> -     if (likely(alloc_tag_ref_set(ref, tag)))
>>> +     if (likely(alloc_tag_ref_set(ref, tag))) {
>>>               this_cpu_add(tag->counters->bytes, bytes);
>>> +
>>> +             if (alloc_tag_trace_enabled(tag))
>>> +                     /* Trace successful allocs with their unique ref */
>>> +                     alloc_tag_trace_mem_alloc(ref, tag, bytes);
>>> +     }
>>>  }
>>>
>>>  static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
>>> @@ -222,6 +248,10 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
>>>       this_cpu_sub(tag->counters->bytes, bytes);
>>>       this_cpu_dec(tag->counters->calls);
>>>
>>> +     if (alloc_tag_trace_enabled(tag))
>>> +             /* Trace frees with their unique ref */
>>> +             alloc_tag_trace_mem_free(ref, tag, bytes);
>>> +
>>>       ref->ct = NULL;
>>>  }
>>>
>>> @@ -247,21 +277,24 @@ static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
>>>  static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
>>>  static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag) {}
>>>  static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag) { return false; }
>>> +#define alloc_tag_trace_hit(_tag)    /* NOOP */
>>
>> I'd prefer we use `do {} while (0)` here, following the same pattern
>> as alloc_tag_record.
>>
>>>  #define alloc_tag_record(p)  do {} while (0)
>>>
>>>  #endif /* CONFIG_MEM_ALLOC_PROFILING */
>>>
>>> -#define alloc_hooks_tag(_tag, _do_alloc)                             \
>>> -({                                                                   \
>>> -     typeof(_do_alloc) _res;                                         \
>>> -     if (mem_alloc_profiling_enabled()) {                            \
>>> -             struct alloc_tag * __maybe_unused _old;                 \
>>> -             _old = alloc_tag_save(_tag);                            \
>>> -             _res = _do_alloc;                                       \
>>> -             alloc_tag_restore(_tag, _old);                          \
>>> -     } else                                                          \
>>> -             _res = _do_alloc;                                       \
>>> -     _res;                                                           \
>>> +#define alloc_hooks_tag(_tag, _do_alloc)                                     \
>>> +({                                                                           \
>>> +     typeof(_do_alloc) _res;                                                 \
>>> +     if (mem_alloc_profiling_enabled()) {                                    \
>>> +             struct alloc_tag * __maybe_unused _old;                         \
>>> +             /* Fired here to cleanly capture the caller's stack trace */    \
>>> +             alloc_tag_trace_hit(_tag);                                      \
>>> +             _old = alloc_tag_save(_tag);                                    \
>>> +             _res = _do_alloc;                                               \
>>> +             alloc_tag_restore(_tag, _old);                                  \
>>> +     } else                                                                  \
>>> +             _res = _do_alloc;                                               \
>>> +     _res;                                                                   \
>>>  })
>>>
>>>  #define alloc_hooks(_do_alloc)                                               \
>>> diff --git a/include/trace/events/alloc_tag.h b/include/trace/events/alloc_tag.h
>>> new file mode 100644
>>> index 000000000000..af2182501864
>>> --- /dev/null
>>> +++ b/include/trace/events/alloc_tag.h
>>> @@ -0,0 +1,122 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#undef TRACE_SYSTEM
>>> +#define TRACE_SYSTEM alloc_tag
>>> +
>>> +#if !defined(_TRACE_ALLOC_TAG_H) || defined(TRACE_HEADER_MULTI_READ)
>>> +#define _TRACE_ALLOC_TAG_H
>>> +
>>> +#include <linux/tracepoint.h>
>>> +
>>> +/*
>>> + * alloc_tag_hit is generated at the exact allocation call site and can be
>>> + * used to capture a clean stack trace.
>>> + *
>>> + * To link this stack trace to the actual allocated memory chunk, tools must
>>> + * correlate this event with the resulting alloc_tag_mem_alloced event. Since
>>> + * multiple threads can hit the same tag simultaneously, tools must match BOTH
>>> + * the `tag` field and the implicitly recorded PID provided by the core
>>> + * tracing subsystem.
>>> + */
>>> +TRACE_EVENT(alloc_tag_hit,
>>> +
>>> +     TP_PROTO(struct alloc_tag *tag),
>>> +
>>> +     TP_ARGS(tag),
>>> +
>>> +     TP_STRUCT__entry(
>>> +             __field(struct alloc_tag *, tag)
>>> +             __string(modname, tag->ct.modname ? tag->ct.modname : "NONE")
>>> +             __string(filename, tag->ct.filename)
>>> +             __string(function, tag->ct.function)
>>> +             __field(unsigned int, lineno)
>>> +     ),
>>> +
>>> +     TP_fast_assign(
>>> +             __entry->tag = tag;
>>> +             __assign_str(modname);
>>> +             __assign_str(filename);
>>> +             __assign_str(function);
>>> +             __entry->lineno = tag->ct.lineno;
>>> +     ),
>>> +
>>> +     TP_printk("tag %p, module: %s, filename: %s, function %s, lineno %u",
>>> +             __entry->tag,
>>> +             __get_str(modname),
>>> +             __get_str(filename),
>>> +             __get_str(function),
>>> +             __entry->lineno
>>> +     )
>>> +);
>>>
>>
>> When I trace an interface provided by a kernel build-in such as shmem,
>> this is what I see in the trace:
>>
>> trig-6838    [004] .....  1309.321906: alloc_tag_hit: tag 000000007874a2c9, module: NONE, filename: mm/shmem.c, function shmem_alloc_folio, lineno 2138
>>
>> The module field shows NONE, which looks a bit odd.
>>
>>> +/*
>>> + * alloc_tag_mem_alloced is generated after memory is successfully allocated.
>>> + * It captures the exact byte size.
>>> + *
>>> + * The `ref` pointer identifies the memory chunk for tracking its lifecycle
>>> + * (e.g., matching it with alloc_tag_mem_freed).
>>> + *
>>> + * Because the kernel isolates active allocations within the task struct
>>> + * (current->alloc_tag), this even will always share the same implicit PID as
>>> + * its corresponding alloc_tag_hit event. Tools should use the combination
>>> + * PID + `tag` to correlate them.
>>> + */
>>> +TRACE_EVENT(alloc_tag_mem_alloced,
>>> +
>>> +     TP_PROTO(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes),
>>> +
>>> +     TP_ARGS(ref, tag, bytes),
>>> +
>>> +     TP_STRUCT__entry(
>>> +             __field(union codetag_ref *, ref)
>>> +             __field(struct alloc_tag *, tag)
>>> +             __field(size_t, bytes)
>>> +     ),
>>> +
>>> +     TP_fast_assign(
>>> +             __entry->ref = ref;
>>> +             __entry->tag = tag;
>>> +             __entry->bytes = bytes;
>>> +     ),
>>> +
>>> +     TP_printk("reference %p, tag %p, bytes %zu",
>>> +             __entry->ref,
>>> +             __entry->tag,
>>> +             __entry->bytes
>>> +     )
>>> +);
>>> +
>>> +/*
>>> + * alloc_tag_mem_freed event is generated immediately before memory is
>>> + * freed. The `ref` pointer matches the one emitted during allocation,
>>> + * allowing tools to match it to it's corresponding allocation and
>>> + * call stack.
>>> + */
>>
>> But the thread for allocation and free may not be the same.
>> For example, memory allocated in thread A could be freed by kswapd.
>> In this case, would the ref fail to match and falsely report a memory leak?
> 
> No, ref is unique within the system, so even if alloc and free happen
> in different threads it still can be used to match them. The
> thread+tag is used only when matching alloc_tag_hit with
> alloc_tag_mem_alloced because at the time of alloc_tag_hit we don't
> yet have the ref.
>

"The ref is unique within the system" is true of the obj_ext/page_ext slot,
but for page allocations the event does not carry the slot's address,
it carries the address of a stack temporary.

/* Should be called only if mem_alloc_profiling_enabled() */
static noinline
void __pgalloc_tag_add(struct page *page, struct task_struct *task,
		       unsigned int nr, unsigned int alloc_flags)
{
	union pgtag_ref_handle handle;
	union codetag_ref ref;	<- stack temporary

	if (likely(get_page_tag_ref(page, &ref, &handle))) {
		alloc_tag_add(&ref, task->alloc_tag, PAGE_SIZE * nr);
		update_page_tag_ref(handle, &ref);
		put_page_tag_ref(handle);
	} else {
		......
	}
}

/* Should be called only if mem_alloc_profiling_enabled() */
static noinline
void __pgalloc_tag_sub(struct page *page, unsigned int nr)
{
	union pgtag_ref_handle handle;
	union codetag_ref ref; <- stack temporary

	if (get_page_tag_ref(page, &ref, &handle)) {
		alloc_tag_sub(&ref, PAGE_SIZE * nr);
		update_page_tag_ref(handle, &ref);
		put_page_tag_ref(handle);
	}
}

Or am I missing / confusing something here?

Thanks
Best Regards
Hao

>>
>> Thanks
>> Best Regards
>> Hao
>>
>>> +TRACE_EVENT(alloc_tag_mem_freed,
>>> +
>>> +     TP_PROTO(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes),
>>> +
>>> +     TP_ARGS(ref, tag, bytes),
>>> +
>>> +     TP_STRUCT__entry(
>>> +             __field(union codetag_ref *, ref)
>>> +             __field(struct alloc_tag *, tag)
>>> +             __field(size_t, bytes)
>>> +     ),
>>> +
>>> +     TP_fast_assign(
>>> +             __entry->ref = ref;
>>> +             __entry->tag = tag;
>>> +             __entry->bytes = bytes;
>>> +     ),
>>> +
>>> +     TP_printk("reference %p, tag %p, bytes %zu",
>>> +             __entry->ref,
>>> +             __entry->tag,
>>> +             __entry->bytes
>>> +     )
>>> +);
>>> +
>>> +#endif /* _TRACE_ALLOC_TAG_H */
>>> +
>>> +/* This part must be outside protection */
>>> +#include <trace/define_trace.h>
>>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
>>> index f30ef8dd24c7..a5339767efd5 100644
>>> --- a/mm/alloc_tag.c
>>> +++ b/mm/alloc_tag.c
>>> @@ -19,6 +19,9 @@
>>>  #include <linux/kmemleak.h>
>>>  #include <uapi/linux/alloc_tag.h>
>>>
>>> +#define CREATE_TRACE_POINTS
>>> +#include <trace/events/alloc_tag.h>
>>> +
>>>  #include "internal.h"
>>>  #include "page_alloc.h"
>>>
>>> @@ -55,6 +58,9 @@ EXPORT_SYMBOL(mem_alloc_profiling_key);
>>>
>>>  DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
>>>
>>> +DEFINE_STATIC_KEY_FALSE(alloc_tag_trace_key);
>>> +EXPORT_SYMBOL(alloc_tag_trace_key);
>>> +
>>>  struct alloc_tag_kernel_section kernel_tags = { NULL, 0 };
>>>  unsigned long alloc_tag_ref_mask;
>>>  int alloc_tag_ref_offs;
>>> @@ -485,6 +491,28 @@ static const struct proc_ops allocinfo_proc_ops = {
>>>  #endif
>>>  };
>>>
>>> +void __alloc_tag_trace_hit(struct alloc_tag *tag)
>>> +{
>>> +     if (unlikely(!tag))
>>> +             return;
>>> +     trace_alloc_tag_hit(tag);
>>> +}
>>> +EXPORT_SYMBOL(__alloc_tag_trace_hit);
>>> +
>>> +void alloc_tag_trace_mem_alloc(union codetag_ref *ref, struct alloc_tag *tag,
>>> +                           size_t bytes)
>>> +{
>>> +     trace_alloc_tag_mem_alloced(ref, tag, bytes);
>>> +}
>>> +EXPORT_SYMBOL(alloc_tag_trace_mem_alloc);
>>> +
>>> +void alloc_tag_trace_mem_free(union codetag_ref *ref, struct alloc_tag *tag,
>>> +                          size_t bytes)
>>> +{
>>> +     trace_alloc_tag_mem_freed(ref, tag, bytes);
>>> +}
>>> +EXPORT_SYMBOL(alloc_tag_trace_mem_free);
>>> +
>>>  size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sleep)
>>>  {
>>>       struct codetag_iterator iter;
