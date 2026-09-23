Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B40585992
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194400; cv=pass; b=kM+9WmsKKxFEoQiNEJum7svzZg+EJRQjaJ1XzjMTo5JorNStPbE7+wsGYnCxmTluK1VK4+FKOL89usBkU5DIACaYVI2pZ3Yzgr6TGNgZs88enVJmZR464hloeVzeu0q5sVYKsnKbJaIwVbvxcoLRfprmvkCzdl8fESaJHJBt4hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194400; c=relaxed/simple;
	bh=gWu15iqRJxgX/RGyZaRqm+zMAOUbKzCJkVvlqDFqjUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ku8ze3rcjxxU1K2LEmk89XI0mnMP91JrX+Xf3qIwZptnEqMiL6p4wZEdJz2M5B1EaREvhpEMT+u0ovu4up6JsqCJFX3uCEUcVruPYudM9/KEgL4nOsPK+Dmf1aNaaWNyka4DH7kDoAj1Uq/o7J2LAZiPgzg9bduGdio9JYjv+lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D6MyiWwo; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6MyiWwo"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so3405ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 13:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790194378; cv=none;
        d=google.com; s=arc-20260327;
        b=LfQagBv9fW3c+xdC4zgUO3hCOXzO1jlhV31mimtAop/dPgPDKH1FSkPJSm30ua9jRH
         O1V9jsJ/3bc7K95Me9veWgJIxzG2vjH7p192jpVFBinuoGGieCSqH1kPDMsiCwa2uxPX
         fOmrr9Qrz7uD6izkya4O9dPbwqpx/J2NuA/HsKSXuXsnYMlndGPCW2ba2d8kji9ifjRv
         IaiTmuKK2LfGy9T7AXEieNUper7d3t38NV7IaxaKoW7i8KNTD40GEktTqAlWqlkn/HSf
         CKprmsmTdqXIStgntPlPOkVqJTBOxyl7AcJMmS9UeAaYUlY1e/N7fNEXHjm5G3iBEYxA
         x2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q/Qf9KIEloyGlc9WNysMiio4j06l4Rvqcqlp89ks3rI=;
        fh=TadCEuHZf+w53vVUb9hjoHAMkMya2X2jyp9Tt84nEpU=;
        b=bp68xqEoiK8W5HG7Fvwem9oK7Q5FxnONLb8pzvTRnJxMX916cAZNj0LzZXP7nyR8Ue
         jN3wshcVidwXutjOma7K+mr1s3LQU6jjoQkLlzKZCeMiBLIIDPL0MGQiTErOBBPn5PCh
         0agf7Id/7Fqf2EvVBl7Mo6CTyZ3QahnPUgQWHNXSGmOkZyfJvVTY/ROx2Aon6acXxBcp
         hLT/Ek4z0jkRUE1jYVwDbh0XRrcjxWD+qiuwtetsSyvOUpmPqTUSDQirxKKWDSTLW8/6
         5hErWRJBX0HWrzdi5LO4iZTdVftdBngIVkjrUf/KGggFPsaCUzGRhlfqk+G+REMxGpQT
         +6QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790194378; x=1790799178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q/Qf9KIEloyGlc9WNysMiio4j06l4Rvqcqlp89ks3rI=;
        b=D6MyiWwoOGEfjRBqhn2Rboi1pPtO0FDcHa1jTAmukEVtb0+4HZ+y/XSkXrq4bSkMr8
         nBp9IXns4KjzDCQUmL085gMZ9DcioEbZbFfkO9kJwrUX5VtQEFrUt2ll6BxsR2qS2UUf
         7gjMvRAR0DvIhuyqIKa7PEj008pJENjsLZOKe9qDCsk5HMw6o1cubB4OWvQ2DRW2RGSL
         oLHzJbCcybToYZuDdKWDPrDRWnOlkV5dyIAZ9k9mFNdpkOqJv7gjrcKOSxR2WnD8g68r
         wSrXtxVKTTP5hkjc1UgSHLicQD1JT7cxHPbnAwUOtAHg30aoTJFvhGz2ycWEgJyO+fRG
         IKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790194378; x=1790799178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q/Qf9KIEloyGlc9WNysMiio4j06l4Rvqcqlp89ks3rI=;
        b=p3lvF4hwAY9aRddGl5XfaJOCyTkAfUfmL4iGiFIorYX2uKrsWqA5YRwEc6CJLrd+Hy
         wfl9vY24Pw/Zf7FJIDtxyZc2n8Bx3731kyIZlJqLKm6ZgppOuU943IcJFgPzGD5w2Qsn
         +Sbc0/s3JflRigUijfmVzbqda2KVcMUIyG5YnTsXA+MavJkjqbLgQmFu++0Pi760s6gc
         zaZ6dWgQSASuYQT5pdAoQo1z1TFapP+AVuaPe2UhVEkaS0vopZsPh6Zd/AI22ZpexBUG
         PR79nc8K8gF4ZnUMZ3NQ9wgE4KaNVqjxFH7p5Ybq0TZ8yzofIOxOjuEi+CylOzCnwOhf
         jRyg==
X-Forwarded-Encrypted: i=1; AKwUvBy8S2jagL3Yd7YafUOEtgzloDB9QLpu8EcVwrCJCh9HvuzeLezaZYWDnBU9qm4ZR4QHZtBcKTTd7q91tOjS/MbQa8w=@vger.kernel.org
X-Gm-Message-State: AFuF++kkGDhWJWbwkXCx+w+xs4afYfiYqpZ4BVZKRjUIhAnOz/92GHRk
	P5yNS3hESw+VUfmObAGlI3PpTGnCIawcdF2BNTkjStUffKqgw+IMaRK+YlQXyAgPOwv9GYFBuBL
	BTvQhCb/bmhQ6SwWw6X6lMtrzJ2noV0m33sHMywRL
X-Gm-Gg: AYBFou1u7bG2QFHE6piCR+uAM/mpQZJA2Gba0MaT69n0HY7MJDD4QRLmuU/bGE9BeYb
	MFSt13m+6VtCwp+/Z7fpB1Ga/cTl/elsAq0l/rzueaG/MOALfDBs0pztZSPB2spuMA6ipSP+PbK
	+pPG4QfQ6WvI+wQkqugtDmLFiMFw2Uu+zm0Mu6Fzd0iRhcmLj26yu68r6vfZzaKUc3pm4GufFuK
	VupVUTIGAxKbV/RDryVF5KDqNmUwyFUV10SzIdkhlbHKjG3iCvQ2VS/0ofd1o9OtsneLDwXvfBv
	EYeTS2uqLK8J6NvbRQcc3Mexq3/gzQzbPm2VASV5CFyrg4vBDYy+zGcCD3SmTCNmeGbcUBuoduM
	VJ4FAMlhK
X-Received: by 2002:a17:903:90d:b0:2ca:4bb4:4bd with SMTP id
 d9443c01a7336-2df7bbd799fmr1410675ad.5.1790194377700; Wed, 23 Sep 2026
 13:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790025465.git.abhishekbapat@google.com>
 <06c3a9b52785e6968ea15709a55365b2342c7a15.1790025465.git.abhishekbapat@google.com>
 <e8f65e6d-440b-418d-b7ba-e05ca2b0d712@linux.dev>
In-Reply-To: <e8f65e6d-440b-418d-b7ba-e05ca2b0d712@linux.dev>
From: Abhishek Bapat <abhishekbapat@google.com>
Date: Wed, 23 Sep 2026 13:12:46 -0700
X-Gm-Features: AclHuK90u3QKMhLOPT-K2l4GMYlhS4sfA0uEIsFHML1VSEDfbP-0xqaYfivaip4
Message-ID: <CAL41Mv7P3xDAvTGtdSHEG3Cvu70W6uhZ9mThm-OD3PcGDDU17w@mail.gmail.com>
Subject: Re: [PATCH 1/4] alloc_tag: Add trace events for tracing allocations
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:55=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Abhishek
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
>
> nit: s/Nore/Note/ s/enabl/enable
>
Ack.
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
>
> The tag parameter is unused here. Let's remove it for now and add it back=
 when needed,
> to avoid the -Wno=E2=80=91unused=E2=80=91parameter warning.
> Some CI bots go through each patch one=E2=80=91by=E2=80=91one, so we can'=
t leave warnings in
> intermediate commits.
>
Ack.
> One other thought: what about adding a sysctl knob here?
> It would let users grab all alloc=E2=80=91tag tracked allocations within =
a time window?
>
You mean to enable the static key? With the following patches, it
would mean that the state of the static key would change by writing to
sysctl and through IOCTLs. I am not sure if letting the static key be
controlled by two mechanism is a good idea. I'd like to get Suren's
thoughts on this.

> Thanks
> Best Regards
> Hao
>
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
> > +
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
