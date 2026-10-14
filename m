Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AEB560ADF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998302; cv=pass; b=Uv/zYw87igScN+4kOLedM2khBrGGxhjDIu8IklXfsblID5Qij4CgHf7jc5FpoSc7zw2VkxnyXYWXqay4TEM/8lA8tGSwfbh9wIMSgF+lq6iujt8P8yDnJsYPbfp27jFpEPBoBO2lm2rB6GC5tvMp0KhUGiLhG22gJN3JgleKoEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998302; c=relaxed/simple;
	bh=bfvaFAEiaH1t3lcr2dW6eOpQLAXAnVFj61/tsb1do1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaTo3sPJfq4hWuIsSrR+q6Dz+MQwVJHPl69kotImH4UxGskOwdoFq/263r8RUhccowyIoPTexTPOmxHWYQGomQtVwLwXK3+RM0tc7KY/GqBhJGhsALnqDi/zpLVYViDhGcU2lVojAzaChZoJgtVxbSRe58mSe7eX9zocSvlmfwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FL1p/W1T; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FL1p/W1T"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2db33db4de9so243605ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 10:18:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791998294; cv=none;
        d=google.com; s=arc-20260327;
        b=eeu9/Y+KOSgDfyzHCJyT068wA6dEeQj1EBYW8UVhUFJI8aKw7zSHPUd07d/GQ5rkoF
         Ygjb4QY+CIw8LO5p3CK+Vb1OojQwUMCEIxDgT4VjkO/s4vn4ZNEsn8pFYwArkW2cZ1uO
         cUnfRED/8vrwG91ib1VgQwBvk/hGIcZjIfYuRxSd+OcrD4qCOB8BykexbIxFPj0Q/Y0Z
         frnaGIHjJvwgssnsLOOAnZm1E5xjKARoD3i1AYRqiaekWJulHR45jKaZLQiJSykOsvd+
         IjbsT7RIQ5XmLCkuGMz//b1GWML/5QVAIyBRpkIe4ml4yGjv2MbVFY8cZyX22kq8NbiD
         nsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6dIx1C4EloGYzW+nfRM67Y+aOezqQQiy8pPph6WWQ/g=;
        fh=AIHy3AIhrFcAAoUhtfnqPZYG/5EvXhm1TqUUbgO8Dk4=;
        b=T8oQOjllkJrKDb0/ztXcjYyBJ1iiTvFWC5vKRNhmzdfPAZQ0b+daRV5xi6np7hksRp
         /6tlQp5pJfrag8iaezoVhm9prrM2Y0VkLTEET8ZoP0b90XERV4Hdil4z5j3BQf5b4ulV
         ejU4HOhS89FsqMRQGFjw+SUv68AUzD3VHoD5B2sn9E115OdmOzHaOA2yKiyNvfY+G93T
         GsCqg4r0uVwnTAvBfJJ3pN00xse8si8RKto/yDKuO8ZRmcAK5IfQWP08WsgzmlS228GB
         qf0O6GxWws/DbFvge67ntTTuz570kXBcXz0+RgqeD4qTvMiJbFfBSsH9kAtTMSrfORtF
         E+Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791998294; x=1792603094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6dIx1C4EloGYzW+nfRM67Y+aOezqQQiy8pPph6WWQ/g=;
        b=FL1p/W1TmgaydaM3lPDmtEWscS7au6EFi/qaeyZNRn3uzO0IYOB7YRnHzQirtxJsiV
         U08aGM2tg9570OLVejG9coDASvtUeyGQwOvdvMUhKVcN13lG2TcpU969JvEL11RWf8Gz
         RZ3zciA5F4HkTUf6B7hJ6bXsS0dZpJOPuB20bKnNNesvyFpdZsaMf7Lx1FIU1FTq4AvS
         1zPoqm36QgzQZ7ud80ikxIP7L4GLupBYEbUOe7VXNpAkkOSvS8fxN4IuS73pkoYzjXLn
         m/LGgJfLZinZ/jal6PxoQWwGOtO2K6q3NqUhhf3t8R1BurAzCkhd0lPMZ9InCU4LzDcu
         P/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791998294; x=1792603094;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dIx1C4EloGYzW+nfRM67Y+aOezqQQiy8pPph6WWQ/g=;
        b=1MbHYjky0Ohlf+SzFni10+NfAGBRUY/7+pgUsVZ0yqYrpMl0STmBTxx2/I5FiS4DMe
         gVaVrroxiBwJ3i9RJrJNjX3Rpgj3F8YmGV+fB3ZQ3IEF2EeFWmZRMdwDEW9FNAmUAcE9
         TGlvsAigi1nVhs8MX53g8eIlPK27LI5d7JUoij19OqVWF8o1A8+F0hDYcuwIBHfQxWiv
         pXS49jLomXy7eQs2S/0nN+853f4TA7cCc+h+NeP8tTwotpuB8jH377QLCTmlnizHpDl+
         tzqTXVaX5eVXW5WIhy+F337RSOfXCYDIQTTZWSzIe3cVksWLrMcSIke3Kt36W6mH99fw
         TYkg==
X-Forwarded-Encrypted: i=1; AKwUvBzUD8s0fnP9e9wNNFrrFCyfaTmyJ7sOiir+QcUaGCCHB/7YajE8/aj/B10pWqkFL5wIBPdshwxLdX6N7u3lUzg82rU=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7n2uRo/LbYrI/gqP4KC5tSqXz47fs/TzSXtZch60D18Ucwb35
	UL4CAe0xDJRNor2blxid0rZeT4rLz1q4Nxkc40vQybgVJIRaMF5khVeRQFub9Iy0km3h/GX/4d0
	TxVWMkl0dp40McCE4T2m5M7GNIwjMPyYQd2lEpvDO
X-Gm-Gg: AYBFou17ZNWxCwu/JqiMbJnGzQtP21dQeJxHn9oqDf/i3MVDs+mqty8MS6TzOuYKCMP
	9g8ObRQ3ZaUb2cOmbhr/ThYAqo6JdoOCQeGdRVlVp6y3FdRSUSMM2jQZ8QyQNWnoD7qAiUkvtzI
	cz+ZMBUATzLIHQ7Y4LNZb8jwHj85Us/w16u6sl0v7dpohG+r59nLCxRTEM7DIsUgQMciiRpA6iE
	X7F8zfy+EsEeL2x/z8x10mvC3pN4GmzAAtt99ANpcq4yWBwbK2v80uFZ2+wI70wgI7kfzLlPZym
	eQiOmbrl+/IK55fcy6XaBpp3RHvKVtO54PfsTqDy4SlEA/DfHX8PFaOMoauQzV8Rew+NvRPP77F
	YjWh3OYKvDw==
X-Received: by 2002:a17:903:1a45:b0:2c7:f0cc:dafa with SMTP id
 d9443c01a7336-2e93db18c22mr3905245ad.5.1791998293306; Wed, 14 Oct 2026
 10:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791410885.git.abhishekbapat@google.com>
 <1f77364a04d0ae20cf07efaca779756f92ec39f6.1791410886.git.abhishekbapat@google.com>
 <ed833aa7-90fa-4c44-a423-c5b689ede379@linux.dev>
In-Reply-To: <ed833aa7-90fa-4c44-a423-c5b689ede379@linux.dev>
From: Abhishek Bapat <abhishekbapat@google.com>
Date: Wed, 14 Oct 2026 10:18:01 -0700
X-Gm-Features: AclHuK9_ZJEant9YLtPvLQQpoEuAfQFaZJ_s2_U_90RFLmNDNJrE-gyvYTX6yYk
Message-ID: <CAL41Mv6Kp9qLtPum36WaMpOtrmTG3LZoEXyD=s78DH+9ruKO7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] alloc_tag: Introduce IOCTLs to toggle allocation tracepoints
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 12:41=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Abhishek
>
>
> On 2026/10/8 06:40, Abhishek Bapat wrote:
> > Introduce a new IOCTL (`ALLOCINFO_IOC_TOGGLE_TRACE`) to selectively
> > toggle tracing on allocation call sites. Userspace tools can use the
> > existing filtering mechanism to specify the set of tags to toggle
> > tracing for.
> >
> > To facilitate low overhead execution for non-targeted call sites, add a
> > new `CODETAG_FLAG_TRACE_ON` flag to `struct codetag` to track per-site
> > activation. Protect these conditional branch evaluations using the glob=
al
> > `alloc_tag_trace_key` static branch and an inline static key check
> > pattern in the allocator hooks (`alloc_tag_add`, `alloc_tag_sub`, etc).
> > This ensures that the trace events are entirely skipped when no
> > allocation call sites are being actively traced, leaving only a NOP on
> > the allocation fast path.
> >
> > Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
> > ---
> >  Documentation/mm/allocation-profiling.rst |  20 ++++
> >  include/linux/alloc_tag.h                 |  47 +++++---
> >  include/linux/codetag.h                   |   5 +-
> >  include/uapi/linux/alloc_tag.h            |  13 +++
> >  mm/alloc_tag.c                            | 128 ++++++++++++++++++++--
> >  5 files changed, 187 insertions(+), 26 deletions(-)
> >
> > diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/=
mm/allocation-profiling.rst
> > index b241450394df..63b668466342 100644
> > --- a/Documentation/mm/allocation-profiling.rst
> > +++ b/Documentation/mm/allocation-profiling.rst
> > @@ -149,6 +149,26 @@ expose the full call stack and the lifetime of ind=
ividual allocations:
> >  - slab and percpu: the address of the object's `codetag_ref`
> >  - page allocator: the `struct page` pointer of the head page
> >
> > +Events are only emitted for tags that have tracing turned on and while=
 profiling
> > +is enabled. When no tag is traced, the hooks are behind a static branc=
h.
> > +
> > +Enabling Tracing
> > +----------------
> > +
> > +Tracing is toggled on and off per tag with the `ALLOCINFO_IOC_TOGGLE_T=
RACE`
> > +ioctl on `/proc/allocinfo`. It takes the same filter as used by
> > +`ALLOCINFO_IOC_GET_AT`; an empty mask selects all tags. Size limits in=
 the
> > +filter are checked once, against the tag's size at the time of the cal=
l. Tags
> > +already in the requested state are skipped and a -ENOENT is returned i=
f no
> > +tag matched.
> > +
> > +Tracing is turned off for a module's tags when the module is unloaded.
> > +
> > +Memory allocated before a tag was enabled has no alloc event but will =
still
> > +produce a free event. Likewise, memory alive when tag is disabled will=
 not
> > +produce a free event. Tools should expect unmatched frees after enabli=
ng and
> > +missing frees after disabling.
> > +
> >  Correlating the events
> >  ----------------------
> >
> > diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> > index 49825177d8c8..94697b28053a 100644
> > --- a/include/linux/alloc_tag.h
> > +++ b/include/linux/alloc_tag.h
> > @@ -136,9 +136,36 @@ static inline bool mem_alloc_profiling_enabled(voi=
d)
> >                                  &mem_alloc_profiling_key);
> >  }
> >
> > -static inline bool alloc_tag_trace_enabled(void)
> > +static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag)
> >  {
> > -     return static_branch_unlikely(&alloc_tag_trace_key);
> > +     atomic_or(CODETAG_FLAG_INACCURATE, &tag->ct.flags);
> > +}
> > +
> > +static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
> > +{
> > +     return !!(atomic_read(&tag->ct.flags) & CODETAG_FLAG_INACCURATE);
> > +}
> > +
> > +static inline void alloc_tag_set_traced(struct alloc_tag *tag)
> > +{
> > +     atomic_or(CODETAG_FLAG_TRACE_ON, &tag->ct.flags);
> > +}
> > +
> > +static inline void alloc_tag_clear_traced(struct alloc_tag *tag)
> > +{
> > +     atomic_andnot(CODETAG_FLAG_TRACE_ON, &tag->ct.flags);
> > +}
> > +
> > +static inline bool alloc_tag_is_traced(const struct alloc_tag *tag)
> > +{
> > +     return !!(atomic_read(&tag->ct.flags) & CODETAG_FLAG_TRACE_ON);
> > +}
> > +
> > +static inline bool alloc_tag_trace_enabled(const struct alloc_tag *tag=
)
> > +{
> > +     if (static_branch_unlikely(&alloc_tag_trace_key))
> > +             return tag && alloc_tag_is_traced(tag);
> > +     return false;
> >  }
> >
> >  void alloc_tag_trace_mem_alloc(const void *ptr, struct alloc_tag *tag,
> > @@ -151,7 +178,7 @@ void __alloc_tag_trace_hit(struct alloc_tag *tag);
> >
> >  static __always_inline void alloc_tag_trace_hit(struct alloc_tag *tag)
> >  {
> > -     if (alloc_tag_trace_enabled())
> > +     if (alloc_tag_trace_enabled(tag))
> >               __alloc_tag_trace_hit(tag);
> >  }
> >
> > @@ -225,7 +252,7 @@ static inline void alloc_tag_add(union codetag_ref =
*ref, struct alloc_tag *tag,
> >       if (likely(alloc_tag_ref_set(ref, tag))) {
> >               this_cpu_add(tag->counters->bytes, bytes);
> >
> > -             if (alloc_tag_trace_enabled())
> > +             if (alloc_tag_trace_enabled(tag))
> >                       /* Trace successful allocs with their unique ptr =
*/
> >                       alloc_tag_trace_mem_alloc(ptr, tag, bytes);
> >       }
> > @@ -249,23 +276,13 @@ static inline void alloc_tag_sub(union codetag_re=
f *ref, size_t bytes, const voi
> >       this_cpu_sub(tag->counters->bytes, bytes);
> >       this_cpu_dec(tag->counters->calls);
> >
> > -     if (alloc_tag_trace_enabled())
> > +     if (alloc_tag_trace_enabled(tag))
> >               /* Trace frees with their unique ptr */
> >               alloc_tag_trace_mem_free(ptr, tag, bytes);
> >
> >       ref->ct =3D NULL;
> >  }
> >
> > -static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag)
> > -{
> > -     tag->ct.flags |=3D CODETAG_FLAG_INACCURATE;
> > -}
> > -
> > -static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
> > -{
> > -     return !!(tag->ct.flags & CODETAG_FLAG_INACCURATE);
> > -}
> > -
> >  #define alloc_tag_record(p)  ((p) =3D current->alloc_tag)
> >
> >  #else /* CONFIG_MEM_ALLOC_PROFILING */
> > diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> > index a25a085c2df1..f728295d50c0 100644
> > --- a/include/linux/codetag.h
> > +++ b/include/linux/codetag.h
> > @@ -18,6 +18,7 @@ struct module;
> >
> >  /* codetag flags */
> >  #define CODETAG_FLAG_INACCURATE      (1 << 0)
> > +#define CODETAG_FLAG_TRACE_ON        (1 << 1)
> >
> >  /*
> >   * An instance of this structure is created in a special ELF section a=
t every
> > @@ -25,7 +26,7 @@ struct module;
> >   * an array of these.
> >   */
> >  struct codetag {
> > -     unsigned int flags;
> > +     atomic_t flags;
> >       unsigned int lineno;
> >       const char *modname;
> >       const char *function;
> > @@ -71,7 +72,7 @@ struct codetag_iterator {
> >       .function       =3D __func__,                     \
> >       .filename       =3D __FILE__,                     \
> >       .lineno         =3D __LINE__,                     \
> > -     .flags          =3D 0,                            \
> > +     .flags          =3D ATOMIC_INIT(0),               \
> >  }
> >
> >  void codetag_lock_module_list(struct codetag_type *cttype);
> > diff --git a/include/uapi/linux/alloc_tag.h b/include/uapi/linux/alloc_=
tag.h
> > index 7d4618bea043..dafcba2f7e2c 100644
> > --- a/include/uapi/linux/alloc_tag.h
> > +++ b/include/uapi/linux/alloc_tag.h
> > @@ -85,9 +85,20 @@ struct allocinfo_get_at {
> >       struct allocinfo_tag_data data;
> >  };
> >
> > +struct allocinfo_toggle_traces {
> > +     /* inputs */
> > +     /*
> > +      * Tags matching the filter are toggled; an empty mask selects al=
l tags.
> > +      * Size criteria are checked once, against the tag's size at call=
 time.
> > +      */
> > +     struct allocinfo_filter filter;
> > +     __u64 enable;
> > +};
> > +
> >  #define _ALLOCINFO_IOC_CONTENT_ID    0
> >  #define _ALLOCINFO_IOC_GET_AT                1
> >  #define _ALLOCINFO_IOC_GET_NEXT              2
> > +#define _ALLOCINFO_IOC_TOGGLE_TRACE  3
> >
> >  #define ALLOCINFO_IOC_BASE           0xA6
> >  #define ALLOCINFO_IOC_CONTENT_ID     _IOR(ALLOCINFO_IOC_BASE, _ALLOCIN=
FO_IOC_CONTENT_ID,     \
> > @@ -96,5 +107,7 @@ struct allocinfo_get_at {
> >                                             struct allocinfo_get_at)
> >  #define ALLOCINFO_IOC_GET_NEXT               _IOR(ALLOCINFO_IOC_BASE, =
_ALLOCINFO_IOC_GET_NEXT,       \
> >                                            struct allocinfo_tag_data)
> > +#define ALLOCINFO_IOC_TOGGLE_TRACE   _IOW(ALLOCINFO_IOC_BASE, _ALLOCIN=
FO_IOC_TOGGLE_TRACE,   \
> > +                                         struct allocinfo_toggle_trace=
s)
> >
> >  #endif /* _UAPI_ALLOC_TAG_H */
> > diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> > index ca2412a67312..262f00f2bba9 100644
> > --- a/mm/alloc_tag.c
> > +++ b/mm/alloc_tag.c
> > @@ -60,6 +60,15 @@ DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
> >  DEFINE_STATIC_KEY_FALSE(alloc_tag_trace_key);
> >  EXPORT_SYMBOL(alloc_tag_trace_key);
> >
> > +static atomic_t alloc_tag_trace_cnt =3D ATOMIC_INIT(0);
> > +
> > +/*
> > + * As `codetag_lock_module_list` is a read lock, we need an additional=
 mutex
> > + * to protect against the race conditions involved in the alloc tag tr=
ace
> > + * toggle path.
> > + */
> > +static DEFINE_MUTEX(alloc_tag_trace_mutex);
> > +
> >  struct alloc_tag_kernel_section kernel_tags =3D { NULL, 0 };
> >  unsigned long alloc_tag_ref_mask;
> >  int alloc_tag_ref_offs;
> > @@ -296,7 +305,7 @@ static bool matches_filter(struct codetag *ct, stru=
ct allocinfo_filter *filter,
> >               return false;
> >
> >       if (filter->mask & ALLOCINFO_FILTER_MASK_INACCURATE) {
> > -             inaccurate =3D !!(ct->flags & CODETAG_FLAG_INACCURATE);
> > +             inaccurate =3D alloc_tag_is_inaccurate(ct_to_alloc_tag(ct=
));
> >               if (inaccurate !=3D !!(filter->inaccurate))
> >                       return false;
> >       }
> > @@ -317,6 +326,23 @@ static bool matches_filter(struct codetag *ct, str=
uct allocinfo_filter *filter,
> >       return true;
> >  }
> >
> > +/*
> > + * Checks that a user supplied filter only uses known fields and that =
its size
> > + * range, if any, is not inverted.
> > + */
> > +static bool allocinfo_filter_valid(const struct allocinfo_filter *filt=
er)
> > +{
> > +     if (filter->mask & ~ALLOCINFO_FILTER_MASKS)
> > +             return false;
> > +
> > +     if ((filter->mask & ALLOCINFO_FILTER_MASK_MIN_SIZE) &&
> > +         (filter->mask & ALLOCINFO_FILTER_MASK_MAX_SIZE) &&
> > +         filter->min_size > filter->max_size)
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> >  /*
> >   * Seeks the ioctl iterator to the specified 0-indexed tag position, r=
eads its
> >   * profiling data and returns it to userspace.
> > @@ -333,12 +359,7 @@ static int allocinfo_ioctl_get_at(struct seq_file =
*m, void __user *arg)
> >       if (copy_from_user(&params, arg, sizeof(params)))
> >               return -EFAULT;
> >
> > -     if (params.filter.mask & ~ALLOCINFO_FILTER_MASKS)
> > -             return -EINVAL;
> > -
> > -     if ((params.filter.mask & ALLOCINFO_FILTER_MASK_MIN_SIZE) &&
> > -         (params.filter.mask & ALLOCINFO_FILTER_MASK_MAX_SIZE) &&
> > -         params.filter.min_size > params.filter.max_size)
> > +     if (!allocinfo_filter_valid(&params.filter))
> >               return -EINVAL;
> >
> >       priv =3D m->private;
> > @@ -443,6 +464,75 @@ static int allocinfo_ioctl_get_next(struct seq_fil=
e *m, void __user *arg)
> >       return ret;
> >  }
> >
> > +static void alloc_tag_trace_toggle(struct alloc_tag *tag, bool enable)
> > +{
> > +     if (enable) {
> > +             if (alloc_tag_is_traced(tag))
> > +                     return;
> > +
> > +             alloc_tag_set_traced(tag);
> > +             if (atomic_fetch_inc(&alloc_tag_trace_cnt) =3D=3D 0)
> > +                     static_branch_enable(&alloc_tag_trace_key);
> > +     } else {
> > +             if (!alloc_tag_is_traced(tag))
> > +                     return;
> > +
> > +             alloc_tag_clear_traced(tag);
> > +             if (atomic_dec_and_test(&alloc_tag_trace_cnt))
> > +                     static_branch_disable(&alloc_tag_trace_key);
> > +     }
> > +}
> > +
> > +/*
> > + * Toggles tracing on every allocation tag that matches the user suppl=
ied
> > + * filter. An empty filter mask selects all tags, same as for
> > + * ALLOCINFO_IOC_GET_AT. Tags already in the requested state are not a=
n error.
> > + */
> > +static int allocinfo_ioctl_toggle_trace(struct seq_file *m, void __use=
r *arg)
> > +{
> > +     struct allocinfo_toggle_traces params;
> > +     struct codetag_iterator iter;
> > +     struct codetag *ct;
> > +     struct alloc_tag_counters counters;
> > +     bool fetched_counters;
> > +     int matches =3D 0, ret;
> > +
> > +     if (!capable(CAP_SYS_ADMIN))
> > +             return -EPERM;
> > +
> > +     if (copy_from_user(&params, arg, sizeof(params)))
> > +             return -EFAULT;
> > +
> > +     if (!allocinfo_filter_valid(&params.filter))
> > +             return -EINVAL;
> > +
> > +     codetag_lock_module_list(alloc_tag_cttype);
> > +
> > +     iter =3D codetag_get_ct_iter(alloc_tag_cttype);
> > +
> > +     /* Toggle tracing on all codetags that match */
> > +     while ((ct =3D codetag_next_ct(&iter))) {
> > +             fetched_counters =3D false;
> > +             if (matches_filter(ct, &params.filter, &counters, &fetche=
d_counters)) {
> > +                     matches++;
> > +
> > +                     mutex_lock(&alloc_tag_trace_mutex);
>
> Could we grab and drop alloc_tag_trace_mutex outside the loop?

Well, that is possible. But I did it this way to minimize the critical sect=
ion.

Since this mutex is specific to the trace ioctl, I'm comfortable doing
what you recommended too. It would just mean that one thread would be
blocked until another thread fully finishes its loop, which is not too
bad. I'll let Suren comment on this as well.
>
>
> > +                     alloc_tag_trace_toggle(ct_to_alloc_tag(ct), !!par=
ams.enable);
> > +                     mutex_unlock(&alloc_tag_trace_mutex);
> > +             }
> > +     }
> > +
> > +     if (matches =3D=3D 0)
> > +             /* Nothing matched the filter */
> > +             ret =3D -ENOENT;
> > +     else
> > +             ret =3D 0;
> > +
> > +     codetag_unlock_module_list(alloc_tag_cttype);
> > +
> > +     return ret;
> > +}
> > +
> >  /*
> >   * Entry point ioctl function for /proc/allocinfo routing requests to =
fetch the
> >   * layout content ID, seek to a specific tag, or read sequential tags.
> > @@ -463,6 +553,9 @@ static long allocinfo_ioctl(struct file *file, unsi=
gned int cmd,
> >       case ALLOCINFO_IOC_GET_NEXT:
> >               ret =3D allocinfo_ioctl_get_next(file->private_data, arg)=
;
> >               break;
> > +     case ALLOCINFO_IOC_TOGGLE_TRACE:
> > +             ret =3D allocinfo_ioctl_toggle_trace(file->private_data, =
arg);
> > +             break;
> >       default:
> >               ret =3D -ENOIOCTLCMD;
> >               break;
> > @@ -492,8 +585,6 @@ static const struct proc_ops allocinfo_proc_ops =3D=
 {
> >
> >  void __alloc_tag_trace_hit(struct alloc_tag *tag)
> >  {
> > -     if (unlikely(!tag))
> > -             return;
> >       trace_alloc_tag_hit(tag);
> >  }
> >  EXPORT_SYMBOL(__alloc_tag_trace_hit);
> > @@ -1031,6 +1122,24 @@ static int load_module(struct module *mod, struc=
t codetag *start, struct codetag
> >       return 0;
> >  }
> >
> > +static void unload_module(struct module *mod, struct codetag *start, s=
truct codetag *stop)
> > +{
> > +     struct alloc_tag *start_tag =3D ct_to_alloc_tag(start);
> > +     struct alloc_tag *stop_tag =3D ct_to_alloc_tag(stop);
> > +     struct alloc_tag *tag;
> > +
> > +     /*
> > +      * Turn tracing off for the tags of the module being unloaded. Wi=
thout
> > +      * this, `alloc_tag_trace_cnt` would never reach zero and tracing=
 would
> > +      * stay enabled forever.
> > +      *
> > +      * `alloc_tag_trace_mutex` is not needed here as this code path i=
s
> > +      * protected by a `down_write(&cttype->mod_lock)`.
> > +      */
> > +     for (tag =3D start_tag; tag < stop_tag; tag++)
> > +             alloc_tag_trace_toggle(tag, false);
> > +}
> > +
> >  static void replace_module(struct module *mod, struct module *new_mod)
> >  {
> >       MA_STATE(mas, &mod_area_mt, 0, module_tags.size);
> > @@ -1357,6 +1466,7 @@ static int __init alloc_tag_init(void)
> >               .alloc_section_mem      =3D reserve_module_tags,
> >               .free_section_mem       =3D release_module_tags,
> >               .module_load            =3D load_module,
> > +             .module_unload          =3D unload_module,
> >               .module_replaced        =3D replace_module,
> >  #endif
> >       };
