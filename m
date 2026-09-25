Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2F4FDE79
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371562; cv=pass; b=t/P/GiUjAdaEFFhMYHex1b1+qzN4XQTxm+/ecGUG4H7Zxg7UZ2usdviURna/+Q9w095wYdD8Bf9y+T2UU31GPpVLq6/FPQDxd05gUl7C+3KJrfoas/ICy9u7oaxJCDCBPRx+r35y7932PDHCPiUzMcmOB65TfNk8x4CDmf/k0IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371562; c=relaxed/simple;
	bh=EgAxy4kpjBVQQ2738FYwaOivZL/e18shYvd0o/qxdcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oStBRDq7G8/PnkjNMY4an27Ky7n9L7DzRrT6mrEzap0oqUdcEfdr9CapOdbDPrLDTsUVCnEe3JXt6NpgG5eqy9q7HvAd4uXYQE2s2+pJIthGiIP5q1bfGGyCphRbAqGcJ/J8P0dzfRthaiKhM1qrOxTXG9yXCVMcJ1WWi5hYL+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nMM3nPdg; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMM3nPdg"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so9225ad.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 14:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790371550; cv=none;
        d=google.com; s=arc-20260327;
        b=l5aKHx0T8wB0CdHiQf2B2nhXP/ujcrBIZnJOg374J/3av1BJBECWYP1MEPQQB5jXgV
         1YAB8NPs60mSgcWyw5lUmcSrW5pxAezHYWCgqqNjiyV6K7gePfK0a1T8PXJV26fXnaYN
         cNyWUbSdE17hxp24Hq+1RTMsWLpC9Lbet1niJLT2+e1ZoIWnYpqksr4kcVgG6f+kRrI4
         9BVRvXrLRn5n4nzw+THFBXfSJXukPEaNVslveiwVGYRB3tGF/4hoio2L5XpYeBC/Kyga
         wVzcMBniT2MuPMnj5r4kWtAL1ti5INOpFp6tZlyvkXmoiMUPrt1IabYqNSPEiIhRasUN
         Emig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DoNZO0aDUfkzxaVvIvd0LTu0xEPlhvL2HKoxngaxH14=;
        fh=E97iulc533HNxGYFfPNrJGLAE4Sl560DNlJ+RyHJqNw=;
        b=Hc/7e58pUTUkIgvQeB9RtmtX3jzycpcYsP/l4NttZdH8hG/SY0XEhKtsmROPoQ1Ugm
         9Wu/W8HuPjrGktf1wVsGr9DtObHRgNS/PyWxjCD6eoVnjaAdfcPxRB/RD3YTJpffXrWc
         fYfH6Xk33ErNzec6oBngbnnoP6zA1//6hf3sh9/VYxYSNaNSq8QTETA9YNMtxdMfIvNa
         mmpy5gFbsll35lIe8usCp+owpSDBC/npOexSy49jaTng0c+HtLGP7hv5Z5lhz5bDPz/+
         XmVmw0FGjyMStLY8UJZbb5/SqmK0pCvt9JTZ4NzrHKY0klWJsbpiirkhYj2lWN7DHvE6
         UeNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790371550; x=1790976350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DoNZO0aDUfkzxaVvIvd0LTu0xEPlhvL2HKoxngaxH14=;
        b=nMM3nPdg8qXGI6g1rkxVrzw6jqibH0G892d/fyAb0SQ0R9jL+eAghUZ/e5X9+SBTzO
         3kffsRXkJ009psFbP3OCU7zcsav4+ekmhLa/Fc0Y1j+5EXkQNIib43aV6eZ1XZ8hs01A
         9KITRazlmoSZyXrs4BwVLLFBy9UBx1DzECEDmyGhrWn7rMoUIlxTa/lQXb35by04tyK2
         GSYp0WLhuf+QQuCddgXtZhr1UOlR5Lqn68m6aDYt0HEB+MpWTCJjuTXE/A+nJNZksNKH
         VDjwPdxnk9PptSqevKXP8I2zAO4vubsjmo9bg18f0E9QcuB1h1O9N8pb7awkBP4jJ6Wm
         E6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790371550; x=1790976350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DoNZO0aDUfkzxaVvIvd0LTu0xEPlhvL2HKoxngaxH14=;
        b=ox/PfyB46/8ZUWrZZRsAX/KCkUBsjviT2/9Y0ObTFNTbO2wpk83EGt8HM9ENXHRAfS
         kASdsnGlFmwwA+Mdl0WqEu8Vl9l8QVi1iVsU3P0FfGOviie/Oy2yqrpjxP9gZKO+N+Bj
         B+MjsN3g9dcIH9BJhZgosQyPPPG1b5guyxoA+tV9XHkAS8ieczG+A4BnaCsMxeMwEDgI
         oxUnOqyc5MQtB6Tkok75QvSVvNq8x0hFjOmGQaA0i5S7l/hBPkXyTuf57fAeLsaej9mg
         ALoQ3u0JwMf6cJzXE0YVSGSD2PgJF/a0t6pHnwPs5VG8tI80pC0B6Tkl38x0A+ePVmP0
         5WJA==
X-Forwarded-Encrypted: i=1; AKwUvBzW/h7Aipq37sw+XR3WgG3hRVbrimUEBH056VqVvcKyYjDqTPuzA0Xnqk3pt8p88Gmu9qMVXUQycEDZn3RlLh8ECmo=@vger.kernel.org
X-Gm-Message-State: AFuF++lEIOhyJyhy30o2HaW4GSx6TeyPjZNec20zuuCln1r4yeaCSNx1
	H02d/iCsgwbLsMOSg/jw3aBCebFF6eYi9doxb6itLBXkA+g5EioCcsPh8AC2tH5dot/hC/SYMeh
	myhlniUoxB8DJ3m8Srik73JwxPhMW5b03ropMORWx
X-Gm-Gg: AYBFou12NzjusY6W18/ktVjg9NNLq1m8+6g8AbBqsFRyeRa7IavtfJUNXLhC3U9oCia
	O+wKv4OxhtxFP0fL8UVizfmIQcWnqR9WOA34yVpesCD5jkuGpoLsrxTsHVCL0YMMJXdQG51B4jb
	D3jQ+Xoilbaun8JcTi/ToA9NvkZ5gTCdaadoEbF12rfk+U0u4Jt8x59Kt6kvk5bAeLNlL7LkKSD
	WK6OOot94gIbLg8/tObEKNbIPBISkPjcg3ZCzCpLt1dlLr7oBDolIjbtYn462sjouSXEIfIyfA2
	RbnibbcyGJvz8Q3WjMiCphEDN4czGi8iJcZFtGjJUwsMOzYARkVXLAW+cQQQ8FdjViEEmna9cOP
	BlP2M/Omi4g==
X-Received: by 2002:a17:902:f691:b0:2d7:2a35:d14 with SMTP id
 d9443c01a7336-2dfa97778bfmr385335ad.11.1790371549788; Fri, 25 Sep 2026
 14:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790025465.git.abhishekbapat@google.com>
 <95bf63d2b9ef14f6610d6543b6892d266e4dc5c6.1790025465.git.abhishekbapat@google.com>
 <0e2db0a0-663e-45fc-b073-126b8e80b625@linux.dev> <CAJuCfpFXky7Rj5ghPXGuL59PtG-cmXQywK3ttOHWx_v-pSSN9w@mail.gmail.com>
In-Reply-To: <CAJuCfpFXky7Rj5ghPXGuL59PtG-cmXQywK3ttOHWx_v-pSSN9w@mail.gmail.com>
From: Abhishek Bapat <abhishekbapat@google.com>
Date: Fri, 25 Sep 2026 14:25:38 -0700
X-Gm-Features: AclHuK9aRfjh29Ivs7dP2LmFKlpdkfzrBFVOfllhvMysTuwZjBqFr7QwPJ-WxeI
Message-ID: <CAL41Mv5REKRLUwSZ9ViTKpBwtEEaE-A3VOK-A0pDTORVNQjeVg@mail.gmail.com>
Subject: Re: [PATCH 2/4] alloc_tag: Introduce IOCTLs to toggle allocation tracepoints
To: Suren Baghdasaryan <surenb@google.com>
Cc: Hao Ge <hao.ge@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 11:18=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Thu, Sep 24, 2026 at 1:16=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
> >
> > Hi Abhishek
> >
> > On 2026/9/22 05:26, Abhishek Bapat wrote:
> > > Introduce a new IOCTL (`ALLOCINFO_IOC_TOGGLE_TRACE`) to selectively
> > > toggle tracing on exact allocation call sites. Userspace tools can
> > > use the existing filtering mechanism to specify the set of tags to
> > > toggle tracing for.
> > >
> > > To facilitate low overhead execution for non-targeted call sites, add=
 a
> > > new `CODETAG_FLAG_TRACE_ON` flag to `struct codetag` to track per-sit=
e
> > > activation. Protect these conditional branch evaluations using a glob=
al
> > > `alloc_tag_trace_key` static branch and an inline static key check
> > > pattern in the allocator hooks (`alloc_tag_add`, `alloc_tag_sub`, etc=
).
> > > This ensures that the trace events are entirely skipped when no
> > > allocation call sites are being actively traced, leaving only a NOP o=
n
> > > the allocation fast path.
> > >
> > > Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
> > > ---
> > >  include/linux/alloc_tag.h      |  39 ++++++++----
> > >  include/linux/codetag.h        |   5 +-
> > >  include/uapi/linux/alloc_tag.h |   9 +++
> > >  mm/alloc_tag.c                 | 110 +++++++++++++++++++++++++++++++=
+-
> > >  4 files changed, 147 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> > > index 2994934cf44a..dc86f8997476 100644
> > > --- a/include/linux/alloc_tag.h
> > > +++ b/include/linux/alloc_tag.h
> > > @@ -136,9 +136,36 @@ static inline bool mem_alloc_profiling_enabled(v=
oid)
> > >                                  &mem_alloc_profiling_key);
> > >  }
> > >
> > > +static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag)
> > > +{
> > > +     atomic_or(CODETAG_FLAG_INACCURATE, &tag->ct.flags);
> > > +}
> > > +
> > > +static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
> > > +{
> > > +     return !!(atomic_read(&tag->ct.flags) & CODETAG_FLAG_INACCURATE=
);
> > > +}
> > > +
> > > +static inline void alloc_tag_set_traced(struct alloc_tag *tag)
> > > +{
> > > +     atomic_or(CODETAG_FLAG_TRACE_ON, &tag->ct.flags);
> > > +}
> > > +
> > > +static inline void alloc_tag_clear_traced(struct alloc_tag *tag)
> > > +{
> > > +     atomic_andnot(CODETAG_FLAG_TRACE_ON, &tag->ct.flags);
> > > +}
> > > +
> > > +static inline bool alloc_tag_is_traced(const struct alloc_tag *tag)
> > > +{
> > > +     return !!(atomic_read(&tag->ct.flags) & CODETAG_FLAG_TRACE_ON);
> > > +}
> > > +
> > >  static inline bool alloc_tag_trace_enabled(const struct alloc_tag *t=
ag)
> > >  {
> > > -     return static_branch_unlikely(&alloc_tag_trace_key);
> > > +     if (static_branch_unlikely(&alloc_tag_trace_key))
> > > +             return tag && alloc_tag_is_traced(tag);
> > > +     return false;
> > >  }
> > >
> > >  void alloc_tag_trace_mem_alloc(union codetag_ref *ref, struct alloc_=
tag *tag,
> > > @@ -255,16 +282,6 @@ static inline void alloc_tag_sub(union codetag_r=
ef *ref, size_t bytes)
> > >       ref->ct =3D NULL;
> > >  }
> > >
> > > -static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag)
> > > -{
> > > -     tag->ct.flags |=3D CODETAG_FLAG_INACCURATE;
> > > -}
> > > -
> > > -static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
> > > -{
> > > -     return !!(tag->ct.flags & CODETAG_FLAG_INACCURATE);
> > > -}
> > > -
> > >  #define alloc_tag_record(p)  ((p) =3D current->alloc_tag)
> > >
> > >  #else /* CONFIG_MEM_ALLOC_PROFILING */
> > > diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> > > index a25a085c2df1..f728295d50c0 100644
> > > --- a/include/linux/codetag.h
> > > +++ b/include/linux/codetag.h
> > > @@ -18,6 +18,7 @@ struct module;
> > >
> > >  /* codetag flags */
> > >  #define CODETAG_FLAG_INACCURATE      (1 << 0)
> > > +#define CODETAG_FLAG_TRACE_ON        (1 << 1)
> > >
> > >  /*
> > >   * An instance of this structure is created in a special ELF section=
 at every
> > > @@ -25,7 +26,7 @@ struct module;
> > >   * an array of these.
> > >   */
> > >  struct codetag {
> > > -     unsigned int flags;
> > > +     atomic_t flags;
> > >       unsigned int lineno;
> > >       const char *modname;
> > >       const char *function;
> > > @@ -71,7 +72,7 @@ struct codetag_iterator {
> > >       .function       =3D __func__,                     \
> > >       .filename       =3D __FILE__,                     \
> > >       .lineno         =3D __LINE__,                     \
> > > -     .flags          =3D 0,                            \
> > > +     .flags          =3D ATOMIC_INIT(0),               \
> > >  }
> > >
> > >  void codetag_lock_module_list(struct codetag_type *cttype);
> > > diff --git a/include/uapi/linux/alloc_tag.h b/include/uapi/linux/allo=
c_tag.h
> > > index 7d4618bea043..069ab8341e87 100644
> > > --- a/include/uapi/linux/alloc_tag.h
> > > +++ b/include/uapi/linux/alloc_tag.h
> > > @@ -85,9 +85,16 @@ struct allocinfo_get_at {
> > >       struct allocinfo_tag_data data;
> > >  };
> > >
> > > +struct allocinfo_toggle_traces {
> > > +     /* inputs */
> > > +     struct allocinfo_tag fields;
> > > +     __u64 enable;
> > > +};
> > > +
> > >  #define _ALLOCINFO_IOC_CONTENT_ID    0
> > >  #define _ALLOCINFO_IOC_GET_AT                1
> > >  #define _ALLOCINFO_IOC_GET_NEXT              2
> > > +#define _ALLOCINFO_IOC_TOGGLE_TRACE  3
> > >
> > >  #define ALLOCINFO_IOC_BASE           0xA6
> > >  #define ALLOCINFO_IOC_CONTENT_ID     _IOR(ALLOCINFO_IOC_BASE, _ALLOC=
INFO_IOC_CONTENT_ID,     \
> > > @@ -96,5 +103,7 @@ struct allocinfo_get_at {
> > >                                             struct allocinfo_get_at)
> > >  #define ALLOCINFO_IOC_GET_NEXT               _IOR(ALLOCINFO_IOC_BASE=
, _ALLOCINFO_IOC_GET_NEXT,       \
> > >                                            struct allocinfo_tag_data)
> > > +#define ALLOCINFO_IOC_TOGGLE_TRACE   _IOW(ALLOCINFO_IOC_BASE, _ALLOC=
INFO_IOC_TOGGLE_TRACE,   \
> > > +                                         struct allocinfo_toggle_tra=
ces)
> > >
> > >  #endif /* _UAPI_ALLOC_TAG_H */
> > > diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> > > index a5339767efd5..fb179321a2a1 100644
> > > --- a/mm/alloc_tag.c
> > > +++ b/mm/alloc_tag.c
> > > @@ -61,6 +61,15 @@ DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
> > >  DEFINE_STATIC_KEY_FALSE(alloc_tag_trace_key);
> > >  EXPORT_SYMBOL(alloc_tag_trace_key);
> > >
> > > +static atomic_t alloc_tag_trace_cnt =3D ATOMIC_INIT(0);
> > > +
> > > +/*
> > > + * As `codetag_lock_module_list` is a read lock, we need an addition=
al mutex
> > > + * to protect against the race conditions involved in the alloc tag =
trace
> > > + * toggle path.
> > > + */
> > > +static DEFINE_MUTEX(alloc_tag_trace_mutex);
> > > +
> > >  struct alloc_tag_kernel_section kernel_tags =3D { NULL, 0 };
> > >  unsigned long alloc_tag_ref_mask;
> > >  int alloc_tag_ref_offs;
> > > @@ -297,7 +306,7 @@ static bool matches_filter(struct codetag *ct, st=
ruct allocinfo_filter *filter,
> > >               return false;
> > >
> > >       if (filter->mask & ALLOCINFO_FILTER_MASK_INACCURATE) {
> > > -             inaccurate =3D !!(ct->flags & CODETAG_FLAG_INACCURATE);
> > > +             inaccurate =3D alloc_tag_is_inaccurate(ct_to_alloc_tag(=
ct));
> > >               if (inaccurate !=3D !!(filter->inaccurate))
> > >                       return false;
> > >       }
> > > @@ -444,6 +453,81 @@ static int allocinfo_ioctl_get_next(struct seq_f=
ile *m, void __user *arg)
> > >       return ret;
> > >  }
> > >
> > > +static bool alloc_tag_trace_toggle(struct alloc_tag *tag, bool enabl=
e)
> > > +{
> > > +     if (enable) {
> > > +             if (alloc_tag_is_traced(tag))
> > > +                     return false;
> > > +
> > > +             alloc_tag_set_traced(tag);
> > > +             if (atomic_fetch_inc(&alloc_tag_trace_cnt) =3D=3D 0)
> > > +                     static_branch_enable(&alloc_tag_trace_key);
> > > +     } else {
> > > +             if (!alloc_tag_is_traced(tag))
> > > +                     return false;
> > > +
> > > +             alloc_tag_clear_traced(tag);
> > > +             if (atomic_dec_and_test(&alloc_tag_trace_cnt))
> > > +                     static_branch_disable(&alloc_tag_trace_key);
> > > +     }
> > > +
> > > +     return true;
> > > +}
> > > +
> > > +/*
> > > + * Toggles context capture for a specified allocation.
> > > + */
> > > +static int allocinfo_ioctl_toggle_trace(struct seq_file *m, void __u=
ser *arg)
> > > +{
> > > +     struct allocinfo_toggle_traces params;
> > > +     struct codetag_iterator iter;
> > > +     struct codetag *ct;
> > > +     int matches =3D 0, successes =3D 0, ret;
> > > +
> > > +     if (!capable(CAP_SYS_ADMIN))
> > > +             return -EPERM;
> > > +
> > > +     if (copy_from_user(&params, arg, sizeof(params)))
> > > +             return -EFAULT;
> > > +
> > > +     codetag_lock_module_list(alloc_tag_cttype);
> > > +
> > > +     struct allocinfo_filter filter =3D {
> > > +             .mask =3D ALLOCINFO_FILTER_MASK_MODNAME |
> > > +                    ALLOCINFO_FILTER_MASK_FUNCTION |
> > > +                    ALLOCINFO_FILTER_MASK_FILENAME |
> > > +                    ALLOCINFO_FILTER_MASK_LINENO,
> > > +             .fields =3D params.fields,
> > > +     };
> > > +
> > > +     iter =3D codetag_get_ct_iter(alloc_tag_cttype);
> > > +
> > > +     /* Toggle tracing on all codetags that match */
> > > +     while ((ct =3D codetag_next_ct(&iter))) {
> > > +             if (matches_filter(ct, &filter, NULL, NULL)) {
> > > +                     matches++;
> > > +
> > > +                     mutex_lock(&alloc_tag_trace_mutex);
> > > +                     if (alloc_tag_trace_toggle(ct_to_alloc_tag(ct),=
 !!params.enable))
> > > +                             successes++;
> > > +                     mutex_unlock(&alloc_tag_trace_mutex);
> > > +             }
> > > +     }
> > > +
> > > +     if (matches =3D=3D 0)
> > > +             /* Nothing matched the filter */
> > > +             ret =3D -ENOENT;
> > > +     else if (successes =3D=3D 0)
> > > +             /* Items matched, but were already in the requested sta=
te */
> > > +             ret =3D -EINVAL;
> >
> > Why do we return -EINVAL in this path?
> > -EINVAL can mislead users into thinking their arguments are wrong.
> > That's not the case; the trace request they want is already active.
> > Maybe -EEXIST ?
>
> Or even 0 since the configuration already matches what the user requested=
.
>
Ack, will modify in v2.
> >
> > Thanks
> > Best Regards
> > Hao
> >
> > > +     else
> > > +             ret =3D 0;
> > > +
> > > +     codetag_unlock_module_list(alloc_tag_cttype);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > >  /*
> > >   * Entry point ioctl function for /proc/allocinfo routing requests t=
o fetch the
> > >   * layout content ID, seek to a specific tag, or read sequential tag=
s.
> > > @@ -464,6 +548,9 @@ static long allocinfo_ioctl(struct file *file, un=
signed int cmd,
> > >       case ALLOCINFO_IOC_GET_NEXT:
> > >               ret =3D allocinfo_ioctl_get_next(file->private_data, ar=
g);
> > >               break;
> > > +     case ALLOCINFO_IOC_TOGGLE_TRACE:
> > > +             ret =3D allocinfo_ioctl_toggle_trace(file->private_data=
, arg);
> > > +             break;
> > >       default:
> > >               ret =3D -ENOIOCTLCMD;
> > >               break;
> > > @@ -493,8 +580,6 @@ static const struct proc_ops allocinfo_proc_ops =
=3D {
> > >
> > >  void __alloc_tag_trace_hit(struct alloc_tag *tag)
> > >  {
> > > -     if (unlikely(!tag))
> > > -             return;
> > >       trace_alloc_tag_hit(tag);
> > >  }
> > >  EXPORT_SYMBOL(__alloc_tag_trace_hit);
> > > @@ -1043,6 +1128,24 @@ static int load_module(struct module *mod, str=
uct codetag *start, struct codetag
> > >       return 0;
> > >  }
> > >
> > > +static void unload_module(struct module *mod, struct codetag *start,=
 struct codetag *stop)
> > > +{
> > > +     struct alloc_tag *start_tag =3D ct_to_alloc_tag(start);
> > > +     struct alloc_tag *stop_tag =3D ct_to_alloc_tag(stop);
> > > +     struct alloc_tag *tag;
> > > +
> > > +     /*
> > > +      * Turn tracing off for the tags of the module being unloaded. =
Without
> > > +      * this, `alloc_tag_trace_cnt` would never reach zero and traci=
ng would
> > > +      * stay enabled forever.
> > > +      *
> > > +      * `alloc_tag_trace_mutex` is not needed here as this code path=
 is
> > > +      * protected by a `down_write(&cttype->mod_lock)`.
> > > +      */
> > > +     for (tag =3D start_tag; tag < stop_tag; tag++)
> > > +             alloc_tag_trace_toggle(tag, false);
> > > +}
> > > +
> > >  static void replace_module(struct module *mod, struct module *new_mo=
d)
> > >  {
> > >       MA_STATE(mas, &mod_area_mt, 0, module_tags.size);
> > > @@ -1369,6 +1472,7 @@ static int __init alloc_tag_init(void)
> > >               .alloc_section_mem      =3D reserve_module_tags,
> > >               .free_section_mem       =3D release_module_tags,
> > >               .module_load            =3D load_module,
> > > +             .module_unload          =3D unload_module,
> > >               .module_replaced        =3D replace_module,
> > >  #endif
> > >       };
