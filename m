Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792682729;
	b=OGxmZE2twyEI18CnPP98XlqOfqgchFwIiIhQHHqOoCLui4l7ezRNtld6PH1dl3Dhd02r
	 LlPpcBU+v4TlRtmQDq8cyQ2PN7hPnde2FR4yU3/xPtaarxkJBtILNLBS71ECBiK/F+qEM
	 CWI5FMP3FBHusQ5AMnTHsb4QxKaWgW7InjcfDLopTaP8vWdUHCVq3weBMQ7kcMME3wHqT
	 p117mPpK19zkADeUD07P5iTsFh4PNAvKZialEwHaxUfYX6nRZxuteJMC0zyYYgWvArO71
	 Z+6tqwhTFBhQWMO7LBryYCX5bYIkVrPNhzK0sYkKW6yXU8CppdC5wGS9fbKPXG8y9aA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JL+EtjTbu4/GOHMbznDDh7H7gtgLjQGYAVh/r05cQNw=;
	b=lA1HY4Yzf2NCWJKiGfcKBvCNuresQpTURRSDJWJq+ttj3rU/lULVA5uLyFcbHuVa9Bhr
	 q5tr/yd3M3rq/XdxQ2tpw7OhA4AvIMYV3exzq9fzgPMz5QmVWdq5Uo2BBzNt/R79TxazZ
	 TzWeVh22rpy/Fki8w47NCBcBemZdZ9G0PyNuKHgcjnpTpoUxZvebsuNtmxp+ElHh6nblX
	 EzYYz95ZVHBn5zK6b0uEEt4txph734BXsU4aSeIUUrInUta8XK+i9QGjMSDd37Zgi+EJo
	 usMXPDopupnDMVEHhryc1B6mjoZRZxFJhGWGkTF1kPpsH5o9DTfPo9zYzkVB2YigfDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=voXUoa69;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F61606A31A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 15:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49F61606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=voXUoa69
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-533202fe429so433501cf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 08:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792682728; cv=none;
        d=google.com; s=arc-20260327;
        b=Hcx3gA6aj207/GJUnR/Ff7YmvGMLBGEbnyE9LvmCRRbAM+tfgIXOxHa/lBlHaR2nST
         QqzKRZ/XKHMtkFlm/55St5Wt0T1vjd4M+j001vXh3SM7w0Hwruc2C3ssfBm5OBOPNfIb
         G8eK7VCnFyyArSlNsWq5IHSKpszh76NU0J+R2ZVLsbXbhP2g+Fnwu09WP1IvR2kctbiW
         t7MnDCHEcgO1R2AnQ9lDllo/KOFCbru8+Nyl5S9/JBsQBUEvxfEztP/KpWdEwT+eu71L
         FNFA4HbGrzQvd41O6LmrZbOoKb1EWj/cAmVpNIPglI4n0LyuOoO6QRa2YrlNi3w8Ero9
         FRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JL+EtjTbu4/GOHMbznDDh7H7gtgLjQGYAVh/r05cQNw=;
        fh=8I53nUZNz6BrQ8poGFL4y34Sc6PiOmm6triCuPTCpaY=;
        b=U8pRDUhAJlC5Gw1gJUpz/q/ycK42iV6hdFqADR045/EHBnfnOOHS32FKx/K6hHO+Fg
         10BB57sv6KVu1/6nqZo1Yu7SDavw+TEkxpKSGFdwezn/nC7PFQ4MtiKJD+n5KOADzZBo
         NL6kLtySvhommF60DD2fja9r5Db50msdmDKS4Ts2sXI0FDgp/POkIGldRjFIrQN9fd7r
         auEPwQI+4jCZAJWWaiONOBbb0qCKSuZuQZki4hcjlKppWD4CaViVIZQzb/0CnN5DBo0t
         t9NuL754+DLCoAaGsAKK6KrdjTi2yt1E5pbuVzs/n1JCXQgqXoa6ulxfBjvOouzFkFO3
         3XeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792682728; x=1793287528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JL+EtjTbu4/GOHMbznDDh7H7gtgLjQGYAVh/r05cQNw=;
        b=voXUoa69fA4iyQ/v78uUJ6mpSqgLrcBsninTtUwearpH2g83SBiwZvrlBLclC4Zc0N
         3BpicyAZI7xjfxNfR9rMUr+5G7wKA32m3uU+FBn/ffUSkrfpk8AX/CijoLeAPB+2W2lo
         NGq+gYcGXeARSfVDL34/IpHjtF96ySSLWLUeqtmJlQ/+35nXsKdBz9dM/EvyLtjZgnRw
         vsA6+u/pf6K8gZEI5eHYhm7g1F88B13Xqt2yIQTd8jlObluCsCZPBV1e1Fe5snvm6365
         nhpBZJgpQlftJ2M135ZiX84sViS6W2O9fAieSEyVXDsHqSrjS2pfpi24a81vmIOheFZi
         6g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682728; x=1793287528;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JL+EtjTbu4/GOHMbznDDh7H7gtgLjQGYAVh/r05cQNw=;
        b=ga8AkQERE7Ep9E2+IgjEHC7W+VICIEh2mWaLdQ5hRKxjgqZGD++0TPKyJMhNrhL+0v
         70zsh3ZuvjPSvJZDlONETAvL1IRVTAu77cAnQQZiNuxHwXy8aeKUr7XclF6RGiThkfhs
         YwIY7GZyBsdGJMAkepIAvXwPuIRf+MUobGy0tjmuhDz0MsFMpe2Ia0iUcn/L5Tg1k2D7
         fsjU3vniRaKhGeUmLJEqPCbJ0fNESzsWBtPnIO3VqCXXTW71xHLQfOMxvIxVxU+wWYkO
         aCeaM9I70Q1tQqKNPAffE+8Xw7L278ZOZjjc0ixQXbDNHTjgu8lfCesHomis8goHTXNZ
         FjPg==
X-Forwarded-Encrypted: i=1; AKwUvBxf6gglggI++Axfd0X7/tu35HugXpwWN5P6+j+f2pLR/C3jqGTPGq0MKZuGi2Wmtj8aWJzU2pbAr1Xse46BUsENVJ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpXgXAA6UpZRmVhK9cIiQT9M/j0JCI5f+H3lDMZYMqZX9W05NC
	5ZAkcIbGUJWLK1oAG/DOND5CybvZAmuPRLRBV2qPSzQh7hipmyZ/tIh/SU4TDXQFIevGeE1LfXw
	oYRZ7rM8DoFRlzt4hKibONkmH1af/DEIjT2XWswUZ
X-Gm-Gg: AYBFou3Y7xbhnnShAnExFUx54x3kDONpQYB8R52orhcAq7uetvix0fSeoyThLvoB50H
	xjPw8vQIqGuW/idsB+dtBmwYH5IURrwccB6MQpPdlGQ2I6m4gyCG/jBj1cjcnOX03EeizgthpB/
	a3Uk/WhhlsyqKMCRmkxdE66t7W1XKzK+LRFFFNKTa+CXGiE5QKdW0WUTLDQ6NVSKa53caML6PSX
	M+w+wxUfjXkpnv3k3tgMwTh/NEOHo8ekrpYP9sLJmsh65O7dHFcGRKRiW8TbG9BWxOVYEbPxSgW
	f3DRrAumf3QC/RtxxFfPFAuQCL6aEiUdD5UbH4D/6GNrfm0ZSmOcyxzuVLiqgFbedS1XaeoUSZ5
	Dn1+KXD8w/XKAzodzG4uOnOfbA0BjRnjEo3FnMHMwZ09830JUEnp5UJuscKXZ6ztk
X-Received: by 2002:a05:622a:4c05:b0:536:3d22:fb83 with SMTP id
 d75a77b69052e-536b0673ed7mr17924741cf.13.1792682726982; Thu, 22 Oct 2026
 08:25:26 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792439751.git.abhishekbapat@google.com>
 <6f243b0d48e541b35e31a49841ea02cb9a328d99.1792439751.git.abhishekbapat@google.com>
 <3df6f0ee-c6ef-4fa4-90d4-bb251cae3e2e@linux.dev>
In-Reply-To: <3df6f0ee-c6ef-4fa4-90d4-bb251cae3e2e@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Oct 2026 15:25:15 +0000
X-Gm-Features: AclHuK9TU-oFOeQlMdOiEny3JKxyZH7hb4P4gGTTA_u83VN8K4GPlXjRLath230
Message-ID: <CAJuCfpFfnGem4ewqzD1XAi07DVOJVe4nDr5_G-sf6Bk2-hArEw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] alloc_tag: Introduce IOCTLs to toggle allocation tracepoints
To: Hao Ge <hao.ge@linux.dev>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 7:35=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
>
>
> On 2026/10/20 04:00, Abhishek Bapat wrote:
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
>
> Acked-by: Hao Ge <hao.ge@linux.dev>

Acked-by: Suren Baghdasaryan <surenb@google.com>

>
> > ---
> >  Documentation/mm/allocation-profiling.rst |  20 ++++
> >  include/linux/alloc_tag.h                 |  47 +++++---
> >  include/linux/codetag.h                   |   5 +-
> >  include/uapi/linux/alloc_tag.h            |  13 +++
> >  mm/alloc_tag.c                            | 127 ++++++++++++++++++++--
> >  5 files changed, 186 insertions(+), 26 deletions(-)
> >
> > diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/=
mm/allocation-profiling.rst
> > index b241450394df..b855f8ac87fd 100644
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
> > +ioctl on `/proc/allocinfo` (requires `CAP_SYS_ADMIN`, returns `-EPERM`
> > +otherwise). It takes the same filter as used by `ALLOCINFO_IOC_GET_AT`=
; an
> > +empty mask selects all tags. Size limits in the filter are checked onc=
e,
> > +against the tag's size at the time of the call. Tags already in the re=
quested
> > +state are skipped and a -ENOENT is returned if no tag matched.
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
> > index 0319c2f1e4e2..4e72c96f31ea 100644
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
> > index ca2412a67312..9ff9dd04d692 100644
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
> > @@ -443,6 +464,74 @@ static int allocinfo_ioctl_get_next(struct seq_fil=
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
> > + * Requires CAP_SYS_ADMIN.
> > + */
> > +static int allocinfo_ioctl_toggle_trace(struct seq_file *m, void __use=
r *arg)
> > +{
> > +     struct allocinfo_toggle_traces params;
> > +     struct codetag_iterator iter;
> > +     struct codetag *ct;
> > +     struct alloc_tag_counters counters;
> > +     bool fetched_counters;
> > +     int ret =3D 0;
> > +     int matches =3D 0;
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
> > +     mutex_lock(&alloc_tag_trace_mutex);
> > +     /* Toggle tracing on all codetags that match */
> > +     while ((ct =3D codetag_next_ct(&iter))) {
> > +             fetched_counters =3D false;
> > +             if (matches_filter(ct, &params.filter, &counters, &fetche=
d_counters)) {
> > +                     matches++;
> > +                     alloc_tag_trace_toggle(ct_to_alloc_tag(ct), !!par=
ams.enable);
> > +             }
> > +     }
> > +     mutex_unlock(&alloc_tag_trace_mutex);
> > +
> > +     if (matches =3D=3D 0)
> > +             /* Nothing matched the filter */
> > +             ret =3D -ENOENT;
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
> > @@ -463,6 +552,9 @@ static long allocinfo_ioctl(struct file *file, unsi=
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
> > @@ -492,8 +584,6 @@ static const struct proc_ops allocinfo_proc_ops =3D=
 {
> >
> >  void __alloc_tag_trace_hit(struct alloc_tag *tag)
> >  {
> > -     if (unlikely(!tag))
> > -             return;
> >       trace_alloc_tag_hit(tag);
> >  }
> >  EXPORT_SYMBOL(__alloc_tag_trace_hit);
> > @@ -1031,6 +1121,24 @@ static int load_module(struct module *mod, struc=
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
> > @@ -1357,6 +1465,7 @@ static int __init alloc_tag_init(void)
> >               .alloc_section_mem      =3D reserve_module_tags,
> >               .free_section_mem       =3D release_module_tags,
> >               .module_load            =3D load_module,
> > +             .module_unload          =3D unload_module,
> >               .module_replaced        =3D replace_module,
> >  #endif
> >       };
