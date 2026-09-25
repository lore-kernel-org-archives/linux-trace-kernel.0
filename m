Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC53F1ABE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790316881; cv=pass; b=uqjpH7XQdo6A3KAAdglJom0/1Gc4COHP7xw1l9W58ktmyfBjuxR8R7j4VLTvbK6LLnXP4uwOMwz3AGFKGSxjnWaoqHLd9CB4UQXK89uiL0hMFFIA0tmKwQecXvhXszJogzZ2+HiTcDpZMsMPv84+1vSGyta/k4RG2P92IplI2U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790316881; c=relaxed/simple;
	bh=pIByjY3MvJnspCd964LZh81BUBiaIaBli1/hY0MWvsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvwUem0jowqkAUpMSByz4BYs4DU4KkoJV4h/hoBoT6oO32cu1FkfaxYNXmVhKIGuLrXSqcn9eDmuN4vc0bK2UC8r4HixYxsQaTwg/tkc693iGSsj2j8PTl6KXmT4Zw+xGC1I+4FKAYGdAYCL9PEsueURP8u8vcSGiw56GFbxz9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ra1NJGv2; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ra1NJGv2"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-530e8c6fb80so123431cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 23:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790316876; cv=none;
        d=google.com; s=arc-20260327;
        b=N7iM2yCDOzfSMfDNDu4lK612WpdJqYkxm2pLL5+hu555u+5tcZzeKlSnXbUPZYgoAV
         kJmrh5ADjsSTTJ9hLY2gy0TZYuONrXx0CxFz48FFZKZSpdMoM1Xa5xSuI1JyfEb8QnL+
         igai1F6xbGTEIV3pL119y+P9ovJG0KdxiRV6NVRhl9Pd3n57ZPCToqiR9n6DYygDRkFz
         1QeDxrqfyVmleoxgkVOc0d157HOOVB+Z1dqJMHK/WhpUbw/4tDKPQ1Vz4Ft2Mbwtjz28
         2wGLL5NIFau3962lg20OuO+uQkoQ6jSfNJGGCMMQadCsG4MdqoRQGbo+B5HkcL5osuec
         vCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dB9h9+O7xaQzApg35xo4jfP6YMn41G4cQ0NtyV8KjtE=;
        fh=xJwLMBXHWWitAhdSslNK+w2MH/ax/1vp+G9QvXBdo38=;
        b=W4HTHZdRf0hLza2rQEVIXeP3+YMUGZGrr2IT+Ihn2DFaUbsFJByP8pCoYKABVyHC6W
         LQUoQ9oXflnIrSxrqeVypvuylpAeMRup+NDHuFwY3P+DG/xxSwuLbQQ9G7LM319dQqRD
         Qv+YISGeUYxqbipiyRvdow3Fm3IQz7nSqRsGiVjuRMkaqs2kg8rVVJGZr8vTE4KIIet0
         bDF975gp6//PaMASWNXsbQQ1Fh2FCwykbIkRkuRaw0Py2I3p2H8o2x3i11OmGAeAAmy0
         4QQQIoV8L+ZgLnulVmDgAQ8tQ2EBLfw2OrCzHEnyHe2opZf5aZJQIByXeJsAE6N6nlJk
         xM7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790316876; x=1790921676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dB9h9+O7xaQzApg35xo4jfP6YMn41G4cQ0NtyV8KjtE=;
        b=ra1NJGv27JCuiA7rYo9jOKHWykLKUvbpLAxFtwBFRJ489tQ4IopYqexHMXcUEMDkxA
         2UnhvQ37Qkf2opVv3+UPJbPkVSvzpFh2IRiDJ/mA5+ondE+jvsb2tIgZfCu+6UwbG4cC
         V0r0ieWMm6Pz5/fP1fu0bEojjOklNOlGrtahio28nB90cXbQCM/Ib47Jy47liSOspcbO
         VVsKXoHZYSaFLHX8eRetI3omU29qvFOo/d153Pj5Kh1QQ1Kf0mfKtXI4sqhliW/QxQrF
         soYwy6as3QbKfWZXHfQqsBKnu2LAx60knmzgEj8uWcWJJojOnCl25Qqw3LI0Cj3Y3OAy
         Sd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790316876; x=1790921676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dB9h9+O7xaQzApg35xo4jfP6YMn41G4cQ0NtyV8KjtE=;
        b=fFCd6C0B7UO0KZ6ii7saE15weMbmwzOeVb9JvW+02l+EInEaClzhJlkC9yT1Ls/CN3
         a6vd5uXugH+e2GIi/OzrXk6E8xhimq+O43OfR1a0pMjEVHArbSy9DHOJnvIaSogy7gQ2
         kixLqyh+Gp+6SjiIGUmfsraboppr3fDHmHI1RS+YQJr9R2OWo6kJkoI2UtF4bIv4zQo+
         6p1GaC6dtDfM60SSic6N2xSotUiBYBoc/u2Nn+JjftwnGcVTIO7L96oIBtlTsWXdSNkm
         n+LEb8sHd6U65CVSs+zzMleMwtJ0yx0V1ELYGaAYG2S34YCiCNZ+yX8tN3tnj0ExdS+x
         CnsA==
X-Forwarded-Encrypted: i=1; AKwUvBx4x7Ia5UuJ2b/iCRKQSuKrqhDYvpfJvw8+8eHQs6HPEQwYqKR3a0zLB4exN+O8oesIWv2mH/0mJcHVc3WdTQzvmzg=@vger.kernel.org
X-Gm-Message-State: AFuF++nIcQr6yFljRK29+9yH8F57dCQcZ1jEGwmm5pYyHSkaWNxNTHgN
	klEdbiljz0uoydkD1w7R6CXdMt6xBeoXkFDVXvFhV4mqACZF0Ncb4sMG+p1seUn4w0V6N6EVbpC
	SlrCA+lWMzMST3BYS/1MBqoRQVFdt6P5kFI3XLz3g
X-Gm-Gg: AYBFou1SCk2kzNjObN7wSqJCnZankdgIjiqXrLIDDhRDJ8YTGZYB4qNHstlLnO/azLU
	+0bTGJmKcDp/GrBVs96bQPqmLAcUi8A8hOkOFNVy5BmhkqsX5fj8bPaRRpiAZSIEWc1+ATj45yE
	zQ5Kl/ktzqlr8itWZbx5hWZ9DMmlp0Wj49wJ4A/ecR02LhjLk7oAnJnZDKwCIMTyk3YxBKKhJfQ
	K2bSe4up3HuYsBtkg0BculK0waNpyzZ5ppjaBtYrlsDb1II8UJ2yWL2bSmH+edRG85LaHA9JAq7
	Rg6At6Tnj2nu1ssasJF+vbm6fN/aBdf5Zn40kBY4AeDGI3D678hS7g==
X-Received: by 2002:a05:622a:53c5:b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-5330c02f3fcmr4183701cf.14.1790316875026; Thu, 24 Sep 2026
 23:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790025465.git.abhishekbapat@google.com>
 <06c3a9b52785e6968ea15709a55365b2342c7a15.1790025465.git.abhishekbapat@google.com>
 <cb229e38-3e52-4309-9594-0d3947c1a81c@linux.dev>
In-Reply-To: <cb229e38-3e52-4309-9594-0d3947c1a81c@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 24 Sep 2026 23:14:23 -0700
X-Gm-Features: AclHuK_XhdtkT9XgGzeMyyHdkxgqp0XCio74QHugzN47Ep5XxbzMjuhNMUijqKE
Message-ID: <CAJuCfpGZf+HDj8B2vV2WB68P2JMyqctF5CPvV0R6x=WU7+nwvQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] alloc_tag: Add trace events for tracing allocations
To: Hao Ge <hao.ge@linux.dev>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 12:21=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Abhishek
>
> Sorry, I merged and tested your patches today and found a few details,
> so I've started a separate mail thread for this review.
>
> On 2026/9/22 05:26, Abhishek Bapat wrote:
> > The memory allocation profiling framework intercepts allocations across
> > the core subsystems, but currently lacks runtime tracing hooks for
> > standard observability tools to dynamically track the context (stack
> > traces and lifecycles of the individual memory chunks) of the
> > allocations made.
> >
> > Introduce three standard trace events to allow this tracking:
> >
> > 1. `alloc_tag_hit`: Fired at the exact call site. This allows userspace
> >    tools to trigger and capture a call stack.
> > 2. `alloc_tag_mem_alloced`: Fired in alloc_tag_add upon successful
> >    allocation. It records the allocated size, the tag, and the uniquely
> >    generated codetag_ref metadata pointer.
> > 3. `alloc_tag_mem_freed`: Fired in alloc_tag_sub right before memory is
> >    freed, yielding the same codetag_ref to allow tracing tools to find
> >    the corresponding allocation.
> >
> > Because the introduced trace events occur at different stages in the
> > call stack, userspace tracing tools must stitch them together to form a
> > complete picture of a buffer's lifetime. Here's an example of how
> > userspace correlates these three events:
> >
> > 1. On `alloc_tag_hit`: The tool captures the stack trace and caches it,
> >    keyed by the combination of the current thread's PID and the `tag`.
> > 2. On `alloc_tag_mem_alloced`: The tool extracts the PID and `tag` from
> >    the event and looks up the stack trace cached in step 1. It creates =
a
> >    new active allocation record, mapping the new provided `codetag_ref`
> >    to this cached stack trace and the newly returned allocation size.
> > 3. On `alloc_tag_mem_freed`: When the memory is freed, the event yields
> >    the same `codetag_ref`. The tool uses this reference to look up the
> >    original allocation record, correlates the free, and safely retires
> >    the tracking entry.
> >
> > Also, introduce `alloc_tag_trace_key` static key to minimize the
> > overhead when no tags are being traced (the usual case). Once tracing
> > for any tag is requested, the key is set, opening the path to check
> > whether tracing is enabled for the current tag.
> > Nore that the mechanism to enabl tag tracing is implemented in the next
> > patch, therefore for now, `alloc_tag_trace_key` stays always unset.
> >
> > Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
> > ---
> >  MAINTAINERS                      |   1 +
> >  include/linux/alloc_tag.h        |  57 ++++++++++++---
> >  include/trace/events/alloc_tag.h | 122 +++++++++++++++++++++++++++++++
> >  mm/alloc_tag.c                   |  28 +++++++
> >  4 files changed, 196 insertions(+), 12 deletions(-)
> >  create mode 100644 include/trace/events/alloc_tag.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 24420a8c06d0..29e1f7915cb9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17096,6 +17096,7 @@ S:    Maintained
> >  F:   Documentation/mm/allocation-profiling.rst
> >  F:   include/linux/alloc_tag.h
> >  F:   include/linux/pgalloc_tag.h
> > +F:   include/trace/events/alloc_tag.h
> >  F:   include/uapi/linux/alloc_tag.h
> >  F:   mm/alloc_tag.c
> >  F:   tools/testing/selftests/alloc_tag/
> > diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> > index 7f2d80a59792..2994934cf44a 100644
> > --- a/include/linux/alloc_tag.h
> > +++ b/include/linux/alloc_tag.h
> > @@ -128,12 +128,33 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _share=
d_alloc_tag);
> >  DECLARE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=
,
> >                       mem_alloc_profiling_key);
> >
> > +DECLARE_STATIC_KEY_FALSE(alloc_tag_trace_key);
> > +
> >  static inline bool mem_alloc_profiling_enabled(void)
> >  {
> >       return static_branch_maybe(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_=
DEFAULT,
> >                                  &mem_alloc_profiling_key);
> >  }
> >
> > +static inline bool alloc_tag_trace_enabled(const struct alloc_tag *tag=
)
> > +{
> > +     return static_branch_unlikely(&alloc_tag_trace_key);
> > +}
> > +
> > +void alloc_tag_trace_mem_alloc(union codetag_ref *ref, struct alloc_ta=
g *tag,
> > +                           size_t bytes);
> > +
> > +void alloc_tag_trace_mem_free(union codetag_ref *ref, struct alloc_tag=
 *tag,
> > +                          size_t bytes);
> > +
> > +void __alloc_tag_trace_hit(struct alloc_tag *tag);
> > +
> > +static inline void alloc_tag_trace_hit(struct alloc_tag *tag)
> > +{
> > +     if (alloc_tag_trace_enabled(tag))
> > +             __alloc_tag_trace_hit(tag);
> > +}
> > +
> >  bool mem_alloc_profiling_permanently_disabled(void);
> >
> >  static inline struct alloc_tag_counters alloc_tag_read(struct alloc_ta=
g *tag)
> > @@ -200,8 +221,13 @@ static inline bool alloc_tag_ref_set(union codetag=
_ref *ref, struct alloc_tag *t
> >
> >  static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_=
tag *tag, size_t bytes)
> >  {
> > -     if (likely(alloc_tag_ref_set(ref, tag)))
> > +     if (likely(alloc_tag_ref_set(ref, tag))) {
> >               this_cpu_add(tag->counters->bytes, bytes);
> > +
> > +             if (alloc_tag_trace_enabled(tag))
> > +                     /* Trace successful allocs with their unique ref =
*/
> > +                     alloc_tag_trace_mem_alloc(ref, tag, bytes);
> > +     }
> >  }
> >
> >  static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
> > @@ -222,6 +248,10 @@ static inline void alloc_tag_sub(union codetag_ref=
 *ref, size_t bytes)
> >       this_cpu_sub(tag->counters->bytes, bytes);
> >       this_cpu_dec(tag->counters->calls);
> >
> > +     if (alloc_tag_trace_enabled(tag))
> > +             /* Trace frees with their unique ref */
> > +             alloc_tag_trace_mem_free(ref, tag, bytes);
> > +
> >       ref->ct =3D NULL;
> >  }
> >
> > @@ -247,21 +277,24 @@ static inline void alloc_tag_add(union codetag_re=
f *ref, struct alloc_tag *tag,
> >  static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)=
 {}
> >  static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag) {}
> >  static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag) { re=
turn false; }
> > +#define alloc_tag_trace_hit(_tag)    /* NOOP */
>
> I'd prefer we use `do {} while (0)` here, following the same pattern
> as alloc_tag_record.
>
> >  #define alloc_tag_record(p)  do {} while (0)
> >
> >  #endif /* CONFIG_MEM_ALLOC_PROFILING */
> >
> > -#define alloc_hooks_tag(_tag, _do_alloc)                             \
> > -({                                                                   \
> > -     typeof(_do_alloc) _res;                                         \
> > -     if (mem_alloc_profiling_enabled()) {                            \
> > -             struct alloc_tag * __maybe_unused _old;                 \
> > -             _old =3D alloc_tag_save(_tag);                           =
 \
> > -             _res =3D _do_alloc;                                      =
 \
> > -             alloc_tag_restore(_tag, _old);                          \
> > -     } else                                                          \
> > -             _res =3D _do_alloc;                                      =
 \
> > -     _res;                                                           \
> > +#define alloc_hooks_tag(_tag, _do_alloc)                              =
       \
> > +({                                                                    =
       \
> > +     typeof(_do_alloc) _res;                                          =
       \
> > +     if (mem_alloc_profiling_enabled()) {                             =
       \
> > +             struct alloc_tag * __maybe_unused _old;                  =
       \
> > +             /* Fired here to cleanly capture the caller's stack trace=
 */    \
> > +             alloc_tag_trace_hit(_tag);                               =
       \
> > +             _old =3D alloc_tag_save(_tag);                           =
         \
> > +             _res =3D _do_alloc;                                      =
         \
> > +             alloc_tag_restore(_tag, _old);                           =
       \
> > +     } else                                                           =
       \
> > +             _res =3D _do_alloc;                                      =
         \
> > +     _res;                                                            =
       \
> >  })
> >
> >  #define alloc_hooks(_do_alloc)                                        =
       \
> > diff --git a/include/trace/events/alloc_tag.h b/include/trace/events/al=
loc_tag.h
> > new file mode 100644
> > index 000000000000..af2182501864
> > --- /dev/null
> > +++ b/include/trace/events/alloc_tag.h
> > @@ -0,0 +1,122 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM alloc_tag
> > +
> > +#if !defined(_TRACE_ALLOC_TAG_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_ALLOC_TAG_H
> > +
> > +#include <linux/tracepoint.h>
> > +
> > +/*
> > + * alloc_tag_hit is generated at the exact allocation call site and ca=
n be
> > + * used to capture a clean stack trace.
> > + *
> > + * To link this stack trace to the actual allocated memory chunk, tool=
s must
> > + * correlate this event with the resulting alloc_tag_mem_alloced event=
. Since
> > + * multiple threads can hit the same tag simultaneously, tools must ma=
tch BOTH
> > + * the `tag` field and the implicitly recorded PID provided by the cor=
e
> > + * tracing subsystem.
> > + */
> > +TRACE_EVENT(alloc_tag_hit,
> > +
> > +     TP_PROTO(struct alloc_tag *tag),
> > +
> > +     TP_ARGS(tag),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(struct alloc_tag *, tag)
> > +             __string(modname, tag->ct.modname ? tag->ct.modname : "NO=
NE")
> > +             __string(filename, tag->ct.filename)
> > +             __string(function, tag->ct.function)
> > +             __field(unsigned int, lineno)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->tag =3D tag;
> > +             __assign_str(modname);
> > +             __assign_str(filename);
> > +             __assign_str(function);
> > +             __entry->lineno =3D tag->ct.lineno;
> > +     ),
> > +
> > +     TP_printk("tag %p, module: %s, filename: %s, function %s, lineno =
%u",
> > +             __entry->tag,
> > +             __get_str(modname),
> > +             __get_str(filename),
> > +             __get_str(function),
> > +             __entry->lineno
> > +     )
> > +);
> >
>
> When I trace an interface provided by a kernel build-in such as shmem,
> this is what I see in the trace:
>
> trig-6838    [004] .....  1309.321906: alloc_tag_hit: tag 000000007874a2c=
9, module: NONE, filename: mm/shmem.c, function shmem_alloc_folio, lineno 2=
138
>
> The module field shows NONE, which looks a bit odd.
>
> > +/*
> > + * alloc_tag_mem_alloced is generated after memory is successfully all=
ocated.
> > + * It captures the exact byte size.
> > + *
> > + * The `ref` pointer identifies the memory chunk for tracking its life=
cycle
> > + * (e.g., matching it with alloc_tag_mem_freed).
> > + *
> > + * Because the kernel isolates active allocations within the task stru=
ct
> > + * (current->alloc_tag), this even will always share the same implicit=
 PID as
> > + * its corresponding alloc_tag_hit event. Tools should use the combina=
tion
> > + * PID + `tag` to correlate them.
> > + */
> > +TRACE_EVENT(alloc_tag_mem_alloced,
> > +
> > +     TP_PROTO(union codetag_ref *ref, struct alloc_tag *tag, size_t by=
tes),
> > +
> > +     TP_ARGS(ref, tag, bytes),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(union codetag_ref *, ref)
> > +             __field(struct alloc_tag *, tag)
> > +             __field(size_t, bytes)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->ref =3D ref;
> > +             __entry->tag =3D tag;
> > +             __entry->bytes =3D bytes;
> > +     ),
> > +
> > +     TP_printk("reference %p, tag %p, bytes %zu",
> > +             __entry->ref,
> > +             __entry->tag,
> > +             __entry->bytes
> > +     )
> > +);
> > +
> > +/*
> > + * alloc_tag_mem_freed event is generated immediately before memory is
> > + * freed. The `ref` pointer matches the one emitted during allocation,
> > + * allowing tools to match it to it's corresponding allocation and
> > + * call stack.
> > + */
>
> But the thread for allocation and free may not be the same.
> For example, memory allocated in thread A could be freed by kswapd.
> In this case, would the ref fail to match and falsely report a memory lea=
k?

No, ref is unique within the system, so even if alloc and free happen
in different threads it still can be used to match them. The
thread+tag is used only when matching alloc_tag_hit with
alloc_tag_mem_alloced because at the time of alloc_tag_hit we don't
yet have the ref.

>
> Thanks
> Best Regards
> Hao
>
> > +TRACE_EVENT(alloc_tag_mem_freed,
> > +
> > +     TP_PROTO(union codetag_ref *ref, struct alloc_tag *tag, size_t by=
tes),
> > +
> > +     TP_ARGS(ref, tag, bytes),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(union codetag_ref *, ref)
> > +             __field(struct alloc_tag *, tag)
> > +             __field(size_t, bytes)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->ref =3D ref;
> > +             __entry->tag =3D tag;
> > +             __entry->bytes =3D bytes;
> > +     ),
> > +
> > +     TP_printk("reference %p, tag %p, bytes %zu",
> > +             __entry->ref,
> > +             __entry->tag,
> > +             __entry->bytes
> > +     )
> > +);
> > +
> > +#endif /* _TRACE_ALLOC_TAG_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> > index f30ef8dd24c7..a5339767efd5 100644
> > --- a/mm/alloc_tag.c
> > +++ b/mm/alloc_tag.c
> > @@ -19,6 +19,9 @@
> >  #include <linux/kmemleak.h>
> >  #include <uapi/linux/alloc_tag.h>
> >
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/alloc_tag.h>
> > +
> >  #include "internal.h"
> >  #include "page_alloc.h"
> >
> > @@ -55,6 +58,9 @@ EXPORT_SYMBOL(mem_alloc_profiling_key);
> >
> >  DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
> >
> > +DEFINE_STATIC_KEY_FALSE(alloc_tag_trace_key);
> > +EXPORT_SYMBOL(alloc_tag_trace_key);
> > +
> >  struct alloc_tag_kernel_section kernel_tags =3D { NULL, 0 };
> >  unsigned long alloc_tag_ref_mask;
> >  int alloc_tag_ref_offs;
> > @@ -485,6 +491,28 @@ static const struct proc_ops allocinfo_proc_ops =
=3D {
> >  #endif
> >  };
> >
> > +void __alloc_tag_trace_hit(struct alloc_tag *tag)
> > +{
> > +     if (unlikely(!tag))
> > +             return;
> > +     trace_alloc_tag_hit(tag);
> > +}
> > +EXPORT_SYMBOL(__alloc_tag_trace_hit);
> > +
> > +void alloc_tag_trace_mem_alloc(union codetag_ref *ref, struct alloc_ta=
g *tag,
> > +                           size_t bytes)
> > +{
> > +     trace_alloc_tag_mem_alloced(ref, tag, bytes);
> > +}
> > +EXPORT_SYMBOL(alloc_tag_trace_mem_alloc);
> > +
> > +void alloc_tag_trace_mem_free(union codetag_ref *ref, struct alloc_tag=
 *tag,
> > +                          size_t bytes)
> > +{
> > +     trace_alloc_tag_mem_freed(ref, tag, bytes);
> > +}
> > +EXPORT_SYMBOL(alloc_tag_trace_mem_free);
> > +
> >  size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, b=
ool can_sleep)
> >  {
> >       struct codetag_iterator iter;
