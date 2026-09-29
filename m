Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5B5437FC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703135; cv=pass; b=XG2B9j7CsXqFer08GPnc351BTj171OakR95Oar3izCSaJBUEL/uKeAf7lsv+KY1W7hpX/8qi0WAPDyFVWpoH6eWXsA6k555NA70yu5EJskM1uUe/I2bqIOBTjzlV9PiW6Xs1kbIYb1Pwye6fC5u383DkfFxo8cgHBAb7rvf+sUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703135; c=relaxed/simple;
	bh=CdyOt6CTh4TFum55ZQJ83hgDxHWy+ewtHlGh3qkmRxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIC903SC5evg4w3+8AxQ8pO96Z5y/CUrIhLYWWrt6mene51rxPLAOjR3j9ufXNkcdDzUezdVTGxk2PffR0i1w6nyZYWNj5QqF7rVt3Cyfie4W5Erl5Zm/2nn7Ssix1U33GR4skCm9zjFjX+oJk6IogudTxlbCEQjW+BUOD3JEHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qquQunlh; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qquQunlh"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so3925ad.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 10:32:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790703133; cv=none;
        d=google.com; s=arc-20260327;
        b=jd4NdywANA1hjqT2kmyzeNQkZzzm8pr7kHrX7e7GcTsj+KQ8w/kd2duTb5WWafXIuU
         +Y9mprsBsRR9YXyCcVbeKodzi64GraPkTDS9IeODG0o1/dA3uYaQUrOimbGALJIER1CH
         bc2KhzJZNMdc56/tRWVmVpRr3yW6WeCeu76DYI1SXRrfWwyFFsUx3RZLXE1xPjMv/DPY
         aJ6hvD0vYYPCD7a0wsnGQzE4M+wQ3Ca+Naee7JfoPnA8UPC+H3cn6OLNSLGpb8ahrWXX
         Dt1mIKXSGktUonv8XrU0Qo34fxP4wtYXR0aZokejNm2XSQWGn6vUyWSNXqFlB3hrb+6m
         a9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gop9G4Z2JBpfOEWZ1J6wcLApHLej9ebsfoqPAQlg414=;
        fh=kK31K5dJVKhSRaaj5iQclkETukyYz4qMXG59DsJTYfM=;
        b=ckdxvYIDAKso06Smum5NhZZbC50Q+BgXZX3sMT8dT8P87u4a1biGX60IePTA1srmbC
         FZl63iL5yqfrwjtngaJ+jXYMh4HrqvT6w4rhLffXZUA3Upw+4CKK1SLRc5qZjJ10Cmnx
         M6IeqhvGZu66vLxE+H/AEgl+/jypEMcBjL5y1pRdWy+kZ3j55Pi+fayGqAfz0eSm1BAS
         FqCyrSoSbZp/npfec9r6qxgATkgW6/zLrnG1rMXebTYPKR7qhJMzp4G2OV8Tsdk8BLid
         VFiVRpyXoa443aISNmArLNfio2TnMWYAKN2rQhMT3Q4BvA6alXYQ5SL7szyR5F+cZQiG
         1bUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790703133; x=1791307933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gop9G4Z2JBpfOEWZ1J6wcLApHLej9ebsfoqPAQlg414=;
        b=qquQunlhSNi0sR1JRvaUjxhbgSuxpcmHr2BoTxb/YemzJc74NYZ9zWMtZdyVOCCfUq
         UQNsUf91g2Zh80HfTWmnVtxfD1G98iBCqj+ibAkJemqhR5rLOC9jgXcg0QnGH8qrNYJA
         zdvzO2e/UPNA3uBiefX0EOTT4Lbv/3B5hxeTBTmcBtUbelF9pNyiJzv0uevcDUk+TpRF
         hFzerKkg4xmAngjA43McpWaDh8t6TrKEJMZJcsz1Q4urj21Lcmy4tK0dyRdOTwhZW5mL
         6gf8xNSdwlFGPaaIedDNoWiFO2+psGFW8SfS9hNOOyId/TJYWtJ2KH8SimS92cbO9TiC
         gD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790703133; x=1791307933;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gop9G4Z2JBpfOEWZ1J6wcLApHLej9ebsfoqPAQlg414=;
        b=epgbgYMhzaBa6DzB/UJn6EJAPj4LXlTUL4/Rm3RaJVUCIvx38FpuHl81CtAhPJ7G+b
         mdcbvWfVln0gxWLhTDRkDJ5Hdo07Fa60SIz9lZVIijezP7KDRhy4Frvc+zZq5N6yHuH6
         az/4H48/C2BPuBh4F0PvJkSrzzFpyry5+I/DvjJbs0dhWK1OYKS34Kgqu3/VOv1ecFwP
         TZM0LBZz0iT358WalleVB/BUk2/Qs2KTESt35KHotnjlrYV6ey2Z4bpO8sSIP1bSm/GH
         CKlAgbal8rV1q9vG9yl8RBvo2U08R13Bmsd4ol1yvFqKb+ZnFUgAUrTHm8VY+svqEeV7
         jRLg==
X-Forwarded-Encrypted: i=1; AKwUvBycgHZRcOeMQZ765unGTaeMvkyX8CT48xgyxY0n1H492w3UwyHQLFGXK6qWhH0E1DxxBJHkO4dM9fohLeqDkqbFyxs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTtWusImZG2kc/qe6fmXf53f7SArYiSUIQbPjKi4N8Rk4SgBbw
	rjCF6NlcLaXjRZ/YsyxheU8ufYtDfiLPKLN8mVyvSP1pxaxnG3gISXEx1NtKn9An+1dJ1sij39k
	1iUOZJ6IVo1RIdmLuMiHag724HCTirWca3EfvV+MW
X-Gm-Gg: AYBFou1Vj3TAPp2VWtrAMSSM7HspuLvF8eH3lINyS6Mzp+MixmRVICaO00hOaMkWjgw
	garncymUqquOXTvJ1KxPL3r1FtQ5d46cYII4IfA2yeQ6Ls75rW4bx4fpigU9QNTivo/eK4HYRKP
	7xMIJetjUuijxaWLYO2PXQ5KvA5DrlJ3Ko2lPQ2i8LNzUaQS34KnO/nvi7FETTwtkoGyJ7rltBo
	BhcsQjjjhz8HFMwsrJaAnOhpFNlyxfVjKcPyc70RY+f17eU/DVzR97klEuO05//VUZyMlqo878v
	oqfY5enx/DONXpO66cAbZLZTsugEIaqjEDmGQtWwDYY/14QR4Kuxu0icwVhb0bdZfybPo5WzgUY
	E3n5rfwe0Sw==
X-Received: by 2002:a17:902:fc4c:b0:2d5:db38:8010 with SMTP id
 d9443c01a7336-2e2c7ab691amr5373235ad.15.1790703130325; Tue, 29 Sep 2026
 10:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790025465.git.abhishekbapat@google.com>
 <06c3a9b52785e6968ea15709a55365b2342c7a15.1790025465.git.abhishekbapat@google.com>
 <cb229e38-3e52-4309-9594-0d3947c1a81c@linux.dev> <CAJuCfpGZf+HDj8B2vV2WB68P2JMyqctF5CPvV0R6x=WU7+nwvQ@mail.gmail.com>
 <cf6ff2bf-1b3c-4575-b981-fc3c65625d5d@linux.dev>
In-Reply-To: <cf6ff2bf-1b3c-4575-b981-fc3c65625d5d@linux.dev>
From: Abhishek Bapat <abhishekbapat@google.com>
Date: Tue, 29 Sep 2026 10:31:59 -0700
X-Gm-Features: AclHuK9odsV9vmHK3YA0RDia2gPNWzUBPdXr8LDkNYU_mIx1XAEJCAOGyCfvoVA
Message-ID: <CAL41Mv4nqEWkFZajL-Z3ny_gx-9zyBY041AXvYL4K+FUUQ5gzA@mail.gmail.com>
Subject: Re: [PATCH 1/4] alloc_tag: Add trace events for tracing allocations
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 7:10=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
> On 2026/9/25 14:14, Suren Baghdasaryan wrote:
> > On Thu, Sep 24, 2026 at 12:21=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrot=
e:
> >>
> >> Hi Abhishek
> >>
> >> Sorry, I merged and tested your patches today and found a few details,
> >> so I've started a separate mail thread for this review.
> >>
> >> On 2026/9/22 05:26, Abhishek Bapat wrote:
> >>> The memory allocation profiling framework intercepts allocations acro=
ss
> >>> the core subsystems, but currently lacks runtime tracing hooks for
> >>> standard observability tools to dynamically track the context (stack
> >>> traces and lifecycles of the individual memory chunks) of the
> >>> allocations made.
> >>>
> >>> Introduce three standard trace events to allow this tracking:
> >>>
> >>> 1. `alloc_tag_hit`: Fired at the exact call site. This allows userspa=
ce
> >>>    tools to trigger and capture a call stack.
> >>> 2. `alloc_tag_mem_alloced`: Fired in alloc_tag_add upon successful
> >>>    allocation. It records the allocated size, the tag, and the unique=
ly
> >>>    generated codetag_ref metadata pointer.
> >>> 3. `alloc_tag_mem_freed`: Fired in alloc_tag_sub right before memory =
is
> >>>    freed, yielding the same codetag_ref to allow tracing tools to fin=
d
> >>>    the corresponding allocation.
> >>>
> >>> Because the introduced trace events occur at different stages in the
> >>> call stack, userspace tracing tools must stitch them together to form=
 a
> >>> complete picture of a buffer's lifetime. Here's an example of how
> >>> userspace correlates these three events:
> >>>
> >>> 1. On `alloc_tag_hit`: The tool captures the stack trace and caches i=
t,
> >>>    keyed by the combination of the current thread's PID and the `tag`=
.
> >>> 2. On `alloc_tag_mem_alloced`: The tool extracts the PID and `tag` fr=
om
> >>>    the event and looks up the stack trace cached in step 1. It create=
s a
> >>>    new active allocation record, mapping the new provided `codetag_re=
f`
> >>>    to this cached stack trace and the newly returned allocation size.
> >>> 3. On `alloc_tag_mem_freed`: When the memory is freed, the event yiel=
ds
> >>>    the same `codetag_ref`. The tool uses this reference to look up th=
e
> >>>    original allocation record, correlates the free, and safely retire=
s
> >>>    the tracking entry.
> >>>
> >>> Also, introduce `alloc_tag_trace_key` static key to minimize the
> >>> overhead when no tags are being traced (the usual case). Once tracing
> >>> for any tag is requested, the key is set, opening the path to check
> >>> whether tracing is enabled for the current tag.
> >>> Nore that the mechanism to enabl tag tracing is implemented in the ne=
xt
> >>> patch, therefore for now, `alloc_tag_trace_key` stays always unset.
> >>>
> >>> Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
> >>> ---
> >>>  MAINTAINERS                      |   1 +
> >>>  include/linux/alloc_tag.h        |  57 ++++++++++++---
> >>>  include/trace/events/alloc_tag.h | 122 +++++++++++++++++++++++++++++=
++
> >>>  mm/alloc_tag.c                   |  28 +++++++
> >>>  4 files changed, 196 insertions(+), 12 deletions(-)
> >>>  create mode 100644 include/trace/events/alloc_tag.h
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 24420a8c06d0..29e1f7915cb9 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -17096,6 +17096,7 @@ S:    Maintained
> >>>  F:   Documentation/mm/allocation-profiling.rst
> >>>  F:   include/linux/alloc_tag.h
> >>>  F:   include/linux/pgalloc_tag.h
> >>> +F:   include/trace/events/alloc_tag.h
> >>>  F:   include/uapi/linux/alloc_tag.h
> >>>  F:   mm/alloc_tag.c
> >>>  F:   tools/testing/selftests/alloc_tag/
> >>> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> >>> index 7f2d80a59792..2994934cf44a 100644
> >>> --- a/include/linux/alloc_tag.h
> >>> +++ b/include/linux/alloc_tag.h
> >>> @@ -128,12 +128,33 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _sha=
red_alloc_tag);
> >>>  DECLARE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAU=
LT,
> >>>                       mem_alloc_profiling_key);
> >>>
> >>> +DECLARE_STATIC_KEY_FALSE(alloc_tag_trace_key);
> >>> +
> >>>  static inline bool mem_alloc_profiling_enabled(void)
> >>>  {
> >>>       return static_branch_maybe(CONFIG_MEM_ALLOC_PROFILING_ENABLED_B=
Y_DEFAULT,
> >>>                                  &mem_alloc_profiling_key);
> >>>  }
> >>>
> >>> +static inline bool alloc_tag_trace_enabled(const struct alloc_tag *t=
ag)
> >>> +{
> >>> +     return static_branch_unlikely(&alloc_tag_trace_key);
> >>> +}
> >>> +
> >>> +void alloc_tag_trace_mem_alloc(union codetag_ref *ref, struct alloc_=
tag *tag,
> >>> +                           size_t bytes);
> >>> +
> >>> +void alloc_tag_trace_mem_free(union codetag_ref *ref, struct alloc_t=
ag *tag,
> >>> +                          size_t bytes);
> >>> +
> >>> +void __alloc_tag_trace_hit(struct alloc_tag *tag);
> >>> +
> >>> +static inline void alloc_tag_trace_hit(struct alloc_tag *tag)
> >>> +{
> >>> +     if (alloc_tag_trace_enabled(tag))
> >>> +             __alloc_tag_trace_hit(tag);
> >>> +}
> >>> +
> >>>  bool mem_alloc_profiling_permanently_disabled(void);
> >>>
> >>>  static inline struct alloc_tag_counters alloc_tag_read(struct alloc_=
tag *tag)
> >>> @@ -200,8 +221,13 @@ static inline bool alloc_tag_ref_set(union codet=
ag_ref *ref, struct alloc_tag *t
> >>>
> >>>  static inline void alloc_tag_add(union codetag_ref *ref, struct allo=
c_tag *tag, size_t bytes)
> >>>  {
> >>> -     if (likely(alloc_tag_ref_set(ref, tag)))
> >>> +     if (likely(alloc_tag_ref_set(ref, tag))) {
> >>>               this_cpu_add(tag->counters->bytes, bytes);
> >>> +
> >>> +             if (alloc_tag_trace_enabled(tag))
> >>> +                     /* Trace successful allocs with their unique re=
f */
> >>> +                     alloc_tag_trace_mem_alloc(ref, tag, bytes);
> >>> +     }
> >>>  }
> >>>
> >>>  static inline void alloc_tag_sub(union codetag_ref *ref, size_t byte=
s)
> >>> @@ -222,6 +248,10 @@ static inline void alloc_tag_sub(union codetag_r=
ef *ref, size_t bytes)
> >>>       this_cpu_sub(tag->counters->bytes, bytes);
> >>>       this_cpu_dec(tag->counters->calls);
> >>>
> >>> +     if (alloc_tag_trace_enabled(tag))
> >>> +             /* Trace frees with their unique ref */
> >>> +             alloc_tag_trace_mem_free(ref, tag, bytes);
> >>> +
> >>>       ref->ct =3D NULL;
> >>>  }
> >>>
> >>> @@ -247,21 +277,24 @@ static inline void alloc_tag_add(union codetag_=
ref *ref, struct alloc_tag *tag,
> >>>  static inline void alloc_tag_sub(union codetag_ref *ref, size_t byte=
s) {}
> >>>  static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag) {=
}
> >>>  static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag) { =
return false; }
> >>> +#define alloc_tag_trace_hit(_tag)    /* NOOP */
> >>
> >> I'd prefer we use `do {} while (0)` here, following the same pattern
> >> as alloc_tag_record.
> >>
> >>>  #define alloc_tag_record(p)  do {} while (0)
> >>>
> >>>  #endif /* CONFIG_MEM_ALLOC_PROFILING */
> >>>
> >>> -#define alloc_hooks_tag(_tag, _do_alloc)                            =
 \
> >>> -({                                                                  =
 \
> >>> -     typeof(_do_alloc) _res;                                        =
 \
> >>> -     if (mem_alloc_profiling_enabled()) {                           =
 \
> >>> -             struct alloc_tag * __maybe_unused _old;                =
 \
> >>> -             _old =3D alloc_tag_save(_tag);                         =
   \
> >>> -             _res =3D _do_alloc;                                    =
   \
> >>> -             alloc_tag_restore(_tag, _old);                         =
 \
> >>> -     } else                                                         =
 \
> >>> -             _res =3D _do_alloc;                                    =
   \
> >>> -     _res;                                                          =
 \
> >>> +#define alloc_hooks_tag(_tag, _do_alloc)                            =
         \
> >>> +({                                                                  =
         \
> >>> +     typeof(_do_alloc) _res;                                        =
         \
> >>> +     if (mem_alloc_profiling_enabled()) {                           =
         \
> >>> +             struct alloc_tag * __maybe_unused _old;                =
         \
> >>> +             /* Fired here to cleanly capture the caller's stack tra=
ce */    \
> >>> +             alloc_tag_trace_hit(_tag);                             =
         \
> >>> +             _old =3D alloc_tag_save(_tag);                         =
           \
> >>> +             _res =3D _do_alloc;                                    =
           \
> >>> +             alloc_tag_restore(_tag, _old);                         =
         \
> >>> +     } else                                                         =
         \
> >>> +             _res =3D _do_alloc;                                    =
           \
> >>> +     _res;                                                          =
         \
> >>>  })
> >>>
> >>>  #define alloc_hooks(_do_alloc)                                      =
         \
> >>> diff --git a/include/trace/events/alloc_tag.h b/include/trace/events/=
alloc_tag.h
> >>> new file mode 100644
> >>> index 000000000000..af2182501864
> >>> --- /dev/null
> >>> +++ b/include/trace/events/alloc_tag.h
> >>> @@ -0,0 +1,122 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>> +#undef TRACE_SYSTEM
> >>> +#define TRACE_SYSTEM alloc_tag
> >>> +
> >>> +#if !defined(_TRACE_ALLOC_TAG_H) || defined(TRACE_HEADER_MULTI_READ)
> >>> +#define _TRACE_ALLOC_TAG_H
> >>> +
> >>> +#include <linux/tracepoint.h>
> >>> +
> >>> +/*
> >>> + * alloc_tag_hit is generated at the exact allocation call site and =
can be
> >>> + * used to capture a clean stack trace.
> >>> + *
> >>> + * To link this stack trace to the actual allocated memory chunk, to=
ols must
> >>> + * correlate this event with the resulting alloc_tag_mem_alloced eve=
nt. Since
> >>> + * multiple threads can hit the same tag simultaneously, tools must =
match BOTH
> >>> + * the `tag` field and the implicitly recorded PID provided by the c=
ore
> >>> + * tracing subsystem.
> >>> + */
> >>> +TRACE_EVENT(alloc_tag_hit,
> >>> +
> >>> +     TP_PROTO(struct alloc_tag *tag),
> >>> +
> >>> +     TP_ARGS(tag),
> >>> +
> >>> +     TP_STRUCT__entry(
> >>> +             __field(struct alloc_tag *, tag)
> >>> +             __string(modname, tag->ct.modname ? tag->ct.modname : "=
NONE")
> >>> +             __string(filename, tag->ct.filename)
> >>> +             __string(function, tag->ct.function)
> >>> +             __field(unsigned int, lineno)
> >>> +     ),
> >>> +
> >>> +     TP_fast_assign(
> >>> +             __entry->tag =3D tag;
> >>> +             __assign_str(modname);
> >>> +             __assign_str(filename);
> >>> +             __assign_str(function);
> >>> +             __entry->lineno =3D tag->ct.lineno;
> >>> +     ),
> >>> +
> >>> +     TP_printk("tag %p, module: %s, filename: %s, function %s, linen=
o %u",
> >>> +             __entry->tag,
> >>> +             __get_str(modname),
> >>> +             __get_str(filename),
> >>> +             __get_str(function),
> >>> +             __entry->lineno
> >>> +     )
> >>> +);
> >>>
> >>
> >> When I trace an interface provided by a kernel build-in such as shmem,
> >> this is what I see in the trace:
> >>
> >> trig-6838    [004] .....  1309.321906: alloc_tag_hit: tag 000000007874=
a2c9, module: NONE, filename: mm/shmem.c, function shmem_alloc_folio, linen=
o 2138
> >>
> >> The module field shows NONE, which looks a bit odd.
> >>
> >>> +/*
> >>> + * alloc_tag_mem_alloced is generated after memory is successfully a=
llocated.
> >>> + * It captures the exact byte size.
> >>> + *
> >>> + * The `ref` pointer identifies the memory chunk for tracking its li=
fecycle
> >>> + * (e.g., matching it with alloc_tag_mem_freed).
> >>> + *
> >>> + * Because the kernel isolates active allocations within the task st=
ruct
> >>> + * (current->alloc_tag), this even will always share the same implic=
it PID as
> >>> + * its corresponding alloc_tag_hit event. Tools should use the combi=
nation
> >>> + * PID + `tag` to correlate them.
> >>> + */
> >>> +TRACE_EVENT(alloc_tag_mem_alloced,
> >>> +
> >>> +     TP_PROTO(union codetag_ref *ref, struct alloc_tag *tag, size_t =
bytes),
> >>> +
> >>> +     TP_ARGS(ref, tag, bytes),
> >>> +
> >>> +     TP_STRUCT__entry(
> >>> +             __field(union codetag_ref *, ref)
> >>> +             __field(struct alloc_tag *, tag)
> >>> +             __field(size_t, bytes)
> >>> +     ),
> >>> +
> >>> +     TP_fast_assign(
> >>> +             __entry->ref =3D ref;
> >>> +             __entry->tag =3D tag;
> >>> +             __entry->bytes =3D bytes;
> >>> +     ),
> >>> +
> >>> +     TP_printk("reference %p, tag %p, bytes %zu",
> >>> +             __entry->ref,
> >>> +             __entry->tag,
> >>> +             __entry->bytes
> >>> +     )
> >>> +);
> >>> +
> >>> +/*
> >>> + * alloc_tag_mem_freed event is generated immediately before memory =
is
> >>> + * freed. The `ref` pointer matches the one emitted during allocatio=
n,
> >>> + * allowing tools to match it to it's corresponding allocation and
> >>> + * call stack.
> >>> + */
> >>
> >> But the thread for allocation and free may not be the same.
> >> For example, memory allocated in thread A could be freed by kswapd.
> >> In this case, would the ref fail to match and falsely report a memory =
leak?
> >
> > No, ref is unique within the system, so even if alloc and free happen
> > in different threads it still can be used to match them. The
> > thread+tag is used only when matching alloc_tag_hit with
> > alloc_tag_mem_alloced because at the time of alloc_tag_hit we don't
> > yet have the ref.
> >
>
> "The ref is unique within the system" is true of the obj_ext/page_ext slo=
t,
> but for page allocations the event does not carry the slot's address,
> it carries the address of a stack temporary.
>
> /* Should be called only if mem_alloc_profiling_enabled() */
> static noinline
> void __pgalloc_tag_add(struct page *page, struct task_struct *task,
>                        unsigned int nr, unsigned int alloc_flags)
> {
>         union pgtag_ref_handle handle;
>         union codetag_ref ref;  <- stack temporary
>
>         if (likely(get_page_tag_ref(page, &ref, &handle))) {
>                 alloc_tag_add(&ref, task->alloc_tag, PAGE_SIZE * nr);
>                 update_page_tag_ref(handle, &ref);
>                 put_page_tag_ref(handle);
>         } else {
>                 ......
>         }
> }
>
> /* Should be called only if mem_alloc_profiling_enabled() */
> static noinline
> void __pgalloc_tag_sub(struct page *page, unsigned int nr)
> {
>         union pgtag_ref_handle handle;
>         union codetag_ref ref; <- stack temporary
>
>         if (get_page_tag_ref(page, &ref, &handle)) {
>                 alloc_tag_sub(&ref, PAGE_SIZE * nr);
>                 update_page_tag_ref(handle, &ref);
>                 put_page_tag_ref(handle);
>         }
> }
>
> Or am I missing / confusing something here?
>

This is a legitimate concern, I went through the code again, the
codetag_ref pointer approach works for percpu and slab allocators but
don't work for the page allocator.

Suren, Hao, I could potentially pass in the struct page * to
__alloc_tag_add and __alloc_tag_sub from the page allocator and keep
the codepath for the percpu and slab allocators the same. What do you
think? I think that should solve this concern.

> Thanks
> Best Regards
> Hao
>
> >>
> >> Thanks
> >> Best Regards
> >> Hao
> >>
> >>> +TRACE_EVENT(alloc_tag_mem_freed,
> >>> +
> >>> +     TP_PROTO(union codetag_ref *ref, struct alloc_tag *tag, size_t =
bytes),
> >>> +
> >>> +     TP_ARGS(ref, tag, bytes),
> >>> +
> >>> +     TP_STRUCT__entry(
> >>> +             __field(union codetag_ref *, ref)
> >>> +             __field(struct alloc_tag *, tag)
> >>> +             __field(size_t, bytes)
> >>> +     ),
> >>> +
> >>> +     TP_fast_assign(
> >>> +             __entry->ref =3D ref;
> >>> +             __entry->tag =3D tag;
> >>> +             __entry->bytes =3D bytes;
> >>> +     ),
> >>> +
> >>> +     TP_printk("reference %p, tag %p, bytes %zu",
> >>> +             __entry->ref,
> >>> +             __entry->tag,
> >>> +             __entry->bytes
> >>> +     )
> >>> +);
> >>> +
> >>> +#endif /* _TRACE_ALLOC_TAG_H */
> >>> +
> >>> +/* This part must be outside protection */
> >>> +#include <trace/define_trace.h>
> >>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> >>> index f30ef8dd24c7..a5339767efd5 100644
> >>> --- a/mm/alloc_tag.c
> >>> +++ b/mm/alloc_tag.c
> >>> @@ -19,6 +19,9 @@
> >>>  #include <linux/kmemleak.h>
> >>>  #include <uapi/linux/alloc_tag.h>
> >>>
> >>> +#define CREATE_TRACE_POINTS
> >>> +#include <trace/events/alloc_tag.h>
> >>> +
> >>>  #include "internal.h"
> >>>  #include "page_alloc.h"
> >>>
> >>> @@ -55,6 +58,9 @@ EXPORT_SYMBOL(mem_alloc_profiling_key);
> >>>
> >>>  DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
> >>>
> >>> +DEFINE_STATIC_KEY_FALSE(alloc_tag_trace_key);
> >>> +EXPORT_SYMBOL(alloc_tag_trace_key);
> >>> +
> >>>  struct alloc_tag_kernel_section kernel_tags =3D { NULL, 0 };
> >>>  unsigned long alloc_tag_ref_mask;
> >>>  int alloc_tag_ref_offs;
> >>> @@ -485,6 +491,28 @@ static const struct proc_ops allocinfo_proc_ops =
=3D {
> >>>  #endif
> >>>  };
> >>>
> >>> +void __alloc_tag_trace_hit(struct alloc_tag *tag)
> >>> +{
> >>> +     if (unlikely(!tag))
> >>> +             return;
> >>> +     trace_alloc_tag_hit(tag);
> >>> +}
> >>> +EXPORT_SYMBOL(__alloc_tag_trace_hit);
> >>> +
> >>> +void alloc_tag_trace_mem_alloc(union codetag_ref *ref, struct alloc_=
tag *tag,
> >>> +                           size_t bytes)
> >>> +{
> >>> +     trace_alloc_tag_mem_alloced(ref, tag, bytes);
> >>> +}
> >>> +EXPORT_SYMBOL(alloc_tag_trace_mem_alloc);
> >>> +
> >>> +void alloc_tag_trace_mem_free(union codetag_ref *ref, struct alloc_t=
ag *tag,
> >>> +                          size_t bytes)
> >>> +{
> >>> +     trace_alloc_tag_mem_freed(ref, tag, bytes);
> >>> +}
> >>> +EXPORT_SYMBOL(alloc_tag_trace_mem_free);
> >>> +
> >>>  size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count,=
 bool can_sleep)
> >>>  {
> >>>       struct codetag_iterator iter;
