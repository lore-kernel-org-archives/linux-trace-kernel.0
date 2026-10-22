Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792681856;
	b=srpRVoU3KtlKQxRtpkVDvWvNK900ZNPZXdIwNO/YPRSGz9zsJQV4DwBQTPJngOF8guDb
	 BAlx3BAJWtDHMWgaEs2CZkOYMO9nOoMJZoK1DqmiMz/TdGi3/DoT0Ir/5bpsuBp+tpr0e
	 /Vlqc23ALcnTjxQp6nY6nany6wGGoGAzt/8C71oGJNRk7sssGOrm0F/XsTN4vkjJ2kRVg
	 ZNxTUk3z4UgaA2t0MigprF6U6kARVCwDN+QJvmzxkz5BD/QbqUFeVXZ3IwlKTSA1OH++W
	 Ed7qSOZvToCID7/JU9JbGRy/fPZBlg8GM5D4tdp5Ws5jwElqxk8V5UINwGQCixJ4Cjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2B5vza+jbwkGAZonP3DChsQgZkW/jPoj7zNLZG98cpg=;
	b=mfstGwQ1kLQdLUdafwd03ML057GVpvQC5hK1RF+80PFtHm/xFijflst6oap0JVLzQ9FG
	 Bbm15+jlr9nOMugdXNS1CXvuImpGWzdvHk4Xr6YIcye5UeGxHfxrt48CG6ZsAhFhcT+od
	 dRAjyh24WWgZh7TGZksfow5aDe76mI+38g/ioeACYfEjMsIqFGl0ExPjiIT5xi8T5ieHl
	 vEijl0pov+oI4MyWAlVql6/Aj/1q5w5o3mDw1+OvnRS56wO2bsiPMs7u84b08V6cAlhe1
	 V4Y+il5MHUn/9HmfxpIp2YuzKU7yl3pGXIHP3hdHVEFm6XWpeaaYZwmV4Y6FNwvOCVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=d8I5YV+G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A0560A5BE7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 15:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86A0560A5BE7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=d8I5YV+G
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5337c7b9937so374471cf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 08:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792681854; cv=none;
        d=google.com; s=arc-20260327;
        b=Tz5CSalyIhmDwv+59Q1Pf7gkIxO4h/ZE9yXXeB3vdTcrDkEeOXt0zOMrN9B88JknL5
         lmp5uMEueIDKEev4RdpK4V4ValXs/dl0CA2WXY8+p/aPE/iketWR4LuqGwcjEuErTIL6
         DAiqK8ATzw2Nceoa8xRLr+Re8h5GFUBiZBKHuPu8xs9QAwWZ25cfNCz2k74kJHZd2jTV
         55NuNloMS37bAHeQ8fzoCM67krH466bGD+hA7Vkuy4eg97qSKixzwJXDePyw0ecB2rop
         z0pomHu3+4wC36/mazWtxb9i2kUvG5Jil3wsdUfNzgH5DZsjZo75+pnDlX/TLzsrWdwP
         02bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2B5vza+jbwkGAZonP3DChsQgZkW/jPoj7zNLZG98cpg=;
        fh=AMoJO7Bq6hJSvR1qbxA9wjPvq6zSXw8SJh04uYr24mE=;
        b=FDFhsRIHNnSVEtaTEjbCnlXHhS4lZZwxLnZlGWVT0+RrjcstIyp4QpTAqpZIyNxhja
         Bqk0UYnADHGBlPk3uLKTOxYE0oECeSvg58fAhQd2bvuDIdM5CAoUHhNAl/3E3RoOYf6e
         zaQ+8QQyLgUJ1+WCr1xV7ImC58p/aLH8cTStYs2yq3z4g0FzRJn/621X4mKqE8jwNOND
         zIY4D7CU9jeZ7ESLWlMAJAHyGaW84+GCnWP86GNQBRrGIg26KocC25LNpGm6pkL0uRZq
         W8/tOpuokpUaJMZTNW+euqRL9jSfcHqjJ11bidSHPP8l8Es0EExlVm4nT5oIbD4IN7ys
         A2ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792681854; x=1793286654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2B5vza+jbwkGAZonP3DChsQgZkW/jPoj7zNLZG98cpg=;
        b=d8I5YV+GF3VHqV31uyhkM7PerHoqs79+/NmR7bLc0/ixdlrwv6eEne4fctrnrrhJo0
         LTCkP+4Cexz0eJwe0r0dq7yEd30ISSavFLvZUpEzg4vJmbNDWcX+mgmUWUPd8QxMk/bY
         Wmz7tpGNET6nIZXqx457zbAothdcc7xrSpLO87rh02RmFS+x5biECr/2pOmr3vaqXEsS
         kE3u24CrL452ekPD5p4CPDA8+vDPhuUBXLHoYhaoGtW8gGAMjuZBLiI2ySxyBFXnd6Eu
         XRChr1sL72lxZ06uHxaZtAUc1P/3AFgVjAkjjFzTGclqBcBDNxQafHmNpK0MVU4rW229
         AeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792681854; x=1793286654;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2B5vza+jbwkGAZonP3DChsQgZkW/jPoj7zNLZG98cpg=;
        b=FN/dRaHAfF4R4tnS2cSatIeohaZWUTQBZuMGaIQC8B16eUG9dNFeRaAfNKG+XR5fMY
         Yeop3Ttqemge8UPPb0pRhGrR8vMrtiveDyApEA7VXGvU+9/R0I2Bd8cSCzF8cUoOKOoE
         +AIyHlt04O1dz2WwaGL+Q+x7LPh3RdR30dZbQdS35SYasxkDYreTClnzXvoqDxyuSli/
         D0G+OHkpD1Hqb3a9Uq2UgB0OiYMGlIOYRDj7XDB9DqawmmEEG0sZ3YYUBqyDutDSweCJ
         +shM9hyVXYZAXbrQftnEzaBReICfD9BbnPiS0OrhMRVch11/qPfXLozYBrvj/J0Ver8z
         dRSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlruwC0UJTZ1DdlDW4XrI1gqqqEl4jg99wXHpGFRJZ/7YePhO8NmuR3bi8ohrjG3Tl+GG+y6VBjAxRoeK2kyYEdMw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcLtwrOYeyV0YA2X6GkSFmTZdn8/ffp/Msq+iUsL79pYF4AsQ3
	F9gNQSMyVE40IpSUdNwAbVkLoCd9K70DK5d1fpYqkWUXSlPDe/VqEMGLZb4tYThpk0+8Nd3URDW
	BdCch7tWYXmVgjA2M0aYhHK5ZBzdinytf/Xu3gkOD
X-Gm-Gg: AYBFou0bAzT/OrC6GEIPgJK7xfRgQYdKqIW/7529cKUMWIIF6D6UaAhRTePcFf+xqHT
	+ch0pj0CJ+pAMRuW/z2ckTqVOJQYAdGoBaG2+he4XifVcMjgwBd17K3WNH+PB5U/vtPRp+IVa7a
	3llIqG0nuUHcZt94DvzDpyWNjeiuN+MxA5+uCRh/pwxYhOJpX0Ne0uu6yT2AkLS1jrBkArLd8/9
	ucWOU16wqoi36DODakT7LSHsRjLwqv1BIyi9s/tQAqBhTk6ubG0ZTobekGE22yNtv3xaroNiVJo
	n9rCdm2u3Rn9QcLIt6/z7wCXk19jyum8uODEtixrbakxkg7ZFQiZejr9T+t83LkcWzJnxIUPkgH
	NZKHkB+Gm1BW34XyB31Yis1RkWlakhZ0NIfEFtSLb/MI4U3UH44+13BzfTp6S7Eev
X-Received: by 2002:ac8:5d8e:0:b0:532:8423:1e78 with SMTP id
 d75a77b69052e-536b062b3damr17529581cf.10.1792681852565; Thu, 22 Oct 2026
 08:10:52 -0700 (PDT)
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
 <323077f96bca23b512a86a6781ebc9dfe6ae9ec1.1792439751.git.abhishekbapat@google.com>
 <79568d55-705d-466c-8a3a-c2ec3143e5c2@linux.dev>
In-Reply-To: <79568d55-705d-466c-8a3a-c2ec3143e5c2@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Oct 2026 15:10:39 +0000
X-Gm-Features: AclHuK_Rmc-NbWkeOVT6nTn4JWdc32YtkiptWfkY5rv6RBPXlNIz1Wu8Ig0EHk0
Message-ID: <CAJuCfpFtqM+kvt+N7Ou4BJ+hR6qb3R8GC3_FxdJKHboQyBFWgg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] alloc_tag: Add trace events for tracing allocations
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
> >    generated `ptr` value which is `codetag_ref` for slab and percpu
> >    allocators and the pointer to the head `struct page` for the page
> >    allocator.
> > 3. `alloc_tag_mem_freed`: Fired in alloc_tag_sub right before memory is
> >    freed, yielding the same `ptr` value to allow tracing tools to find
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
> >    new active allocation record, mapping the new provided `ptr` value
> >    to this cached stack trace and the newly returned allocation size.
> > 3. On `alloc_tag_mem_freed`: When the memory is freed, the event yields
> >    the same `ptr` value. The tool uses this reference to look up the
> >    original allocation record, correlates the free, and safely retires
> >    the tracking entry.
> >
> > Modify `alloc_tag_add()` and `alloc_tag_sub()` with a `ptr` argument to
> > map frees to allocations in the trace events. Slab and percpu pass the
> > address of the object's `codetag_ref`. The page allocator passes the
> > head `struct page` because its `codetag_ref` is a temporary copy on the
> > stack.
> >
> > Also, introduce `alloc_tag_trace_key` static key to minimize the
> > overhead when no tags are being traced (the usual case). Once tracing
> > for any tag is requested, the key is set, opening the path to check
> > whether tracing is enabled for the current tag.
> > Note that the mechanism to enable tag tracing is implemented in the nex=
t
> > patch, therefore for now, `alloc_tag_trace_key` stays always unset.
> >
> > Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
> > Acked-by: Hao Ge <hao.ge@linux.dev>
> > Acked-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  Documentation/mm/allocation-profiling.rst |  53 ++++++++++
> >  MAINTAINERS                               |   1 +
> >  include/linux/alloc_tag.h                 |  67 +++++++++---
> >  include/trace/events/alloc_tag.h          | 122 ++++++++++++++++++++++
> >  mm/alloc_tag.c                            |  28 +++++
> >  mm/page_alloc.c                           |   4 +-
> >  mm/percpu.c                               |  13 ++-
> >  mm/slub.c                                 |   6 +-
> >  8 files changed, 269 insertions(+), 25 deletions(-)
> >  create mode 100644 include/trace/events/alloc_tag.h
> >
> > diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/=
mm/allocation-profiling.rst
> > index b11ea77c0673..b241450394df 100644
> > --- a/Documentation/mm/allocation-profiling.rst
> > +++ b/Documentation/mm/allocation-profiling.rst
> > @@ -129,6 +129,59 @@ To do so:
> >  - Then, use the following form for your allocations:
> >    alloc_hooks_tag(ht->your_saved_tag, kmalloc_noprof(...))
> >
> > +Tracing
> > +=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Three trace events are available under `/sys/kernel/tracing/events/all=
oc_tag` to
> > +expose the full call stack and the lifetime of individual allocations:
> > +
> > +- `alloc_tag_hit`: Fired at the exact call site, before the allocation=
 happens.
> > +  Can be used to capture the call stack of the caller.
> > +
> > +- `alloc_tag_mem_alloced`: Fired once the allocation succeeds. Carries=
 the `ptr`,
> > +  `tag` and `bytes` for each allocation.
> > +
> > +- `alloc_tag_mem_freed`: Fired before memory is freed. Carries the sam=
e
> > +  `ptr`, `tag` and `bytes` as the matching alloc event.
> > +
> > +`ptr` identifies the allocation, and its meaning depends on the alloca=
tor:
> > +
> > +- slab and percpu: the address of the object's `codetag_ref`
> > +- page allocator: the `struct page` pointer of the head page
> > +
> > +Correlating the events
> > +----------------------
> > +
> > +`alloc_tag_hit` and `alloc_tag_mem_alloced` come from different points=
 in the
> > +call stack, so they have to be stitched together by the user consuming=
 the
> > +events. Here's a typical flow:
> > +
> > +1. On `alloc_tag_hit`: Capture the stack trace and cache it keyed by `=
(pid, tag)`.
> > +
> > +2. On `alloc_tag_mem_alloced`: Look up the cached stack trace by `(pid=
, tag)`,
> > +   then create an active allocation record keyed by `ptr` that holds t=
he stack
> > +   trace and `bytes`.
> > +
> > +3. On `alloc_tag_mem_freed`: Look up the record by `ptr` and retire it=
.
> > +
> > +Limitations
> > +-----------
> > +
> > +- For the page allocator, events are generated for the original alloca=
tion and
> > +  the free only. If the tag reference is split or moved to another fol=
io in
> > +  between, no event is generated for that. As a result:
> > +
> > +  - a free event may carry a `ptr` that never appeared in an alloc eve=
nt;
> > +  - `bytes` in a free event may be smaller than in the matching alloc =
event.
> > +
> > +  Tools should correlate on `ptr` but must not assume that freed bytes=
 equal
> > +  allocated bytes, or that every free has a matching alloc.
> > +
> > +- Freeing a non-compound high-order page with `__free_pages()` while a=
nother CPU
> > +  holds a reference frees the tail pages immediately and the head page=
 later when
> > +  the reference is dropped. The free event is emitted at the second po=
int and
> > +  reports `PAGE_SIZE` rather than the full size.
> > +
> >  Notes
> >  =3D=3D=3D=3D=3D
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6f1f35a017a6..fb2df7b8e9ee 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17100,6 +17100,7 @@ S:    Maintained
> >  F:   Documentation/mm/allocation-profiling.rst
> >  F:   include/linux/alloc_tag.h
> >  F:   include/linux/pgalloc_tag.h
> > +F:   include/trace/events/alloc_tag.h
> >  F:   include/uapi/linux/alloc_tag.h
> >  F:   mm/alloc_tag.c
> >  F:   tools/testing/selftests/alloc_tag/
> > diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> > index 7f2d80a59792..0319c2f1e4e2 100644
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
> > +static inline bool alloc_tag_trace_enabled(void)
> > +{
> > +     return static_branch_unlikely(&alloc_tag_trace_key);
> > +}
> > +
> > +void alloc_tag_trace_mem_alloc(const void *ptr, struct alloc_tag *tag,
> > +                            size_t bytes);
> > +
> > +void alloc_tag_trace_mem_free(const void *ptr, struct alloc_tag *tag,
> > +                           size_t bytes);
> > +
> > +void __alloc_tag_trace_hit(struct alloc_tag *tag);
> > +
> > +static __always_inline void alloc_tag_trace_hit(struct alloc_tag *tag)
> > +{
> > +     if (alloc_tag_trace_enabled())
> > +             __alloc_tag_trace_hit(tag);
> > +}
> > +
> >  bool mem_alloc_profiling_permanently_disabled(void);
> >
> >  static inline struct alloc_tag_counters alloc_tag_read(struct alloc_ta=
g *tag)
> > @@ -198,13 +219,19 @@ static inline bool alloc_tag_ref_set(union codeta=
g_ref *ref, struct alloc_tag *t
> >       return true;
> >  }
> >
> > -static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_=
tag *tag, size_t bytes)
> > +static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_=
tag *tag, size_t bytes,
> > +                              const void *ptr)
> >  {
> > -     if (likely(alloc_tag_ref_set(ref, tag)))
> > +     if (likely(alloc_tag_ref_set(ref, tag))) {
> >               this_cpu_add(tag->counters->bytes, bytes);
> > +
> > +             if (alloc_tag_trace_enabled())
> > +                     /* Trace successful allocs with their unique ptr =
*/
> > +                     alloc_tag_trace_mem_alloc(ptr, tag, bytes);
> > +     }
> >  }
> >
> > -static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
> > +static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes,=
 const void *ptr)
> >  {
> >       struct alloc_tag *tag;
> >
> > @@ -222,6 +249,10 @@ static inline void alloc_tag_sub(union codetag_ref=
 *ref, size_t bytes)
> >       this_cpu_sub(tag->counters->bytes, bytes);
> >       this_cpu_dec(tag->counters->calls);
> >
> > +     if (alloc_tag_trace_enabled())
> > +             /* Trace frees with their unique ptr */
> > +             alloc_tag_trace_mem_free(ptr, tag, bytes);
> > +
> >       ref->ct =3D NULL;
> >  }
> >
> > @@ -243,25 +274,29 @@ static inline bool alloc_tag_is_inaccurate(struct=
 alloc_tag *tag)
> >  static inline bool mem_alloc_profiling_enabled(void) { return false; }
> >  static inline bool mem_alloc_profiling_permanently_disabled(void) { re=
turn true; }
> >  static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_=
tag *tag,
> > -                              size_t bytes) {}
> > -static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)=
 {}
> > +                              size_t bytes, const void *ptr) {}
> > +static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes,
> > +                              const void *ptr) {}
> >  static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag) {}
> >  static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag) { re=
turn false; }
> > +#define alloc_tag_trace_hit(_tag)    /* NOOP */
>
> I'd rather this follow the code style below.

Yes please. Both alloc_tag_record() and alloc_tag_restore() use "do {}
while (0)" construct. Let's keep this one consistent.

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
> > +             /* Fired here to capture the caller's stack trace */    \
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
> > index 000000000000..58d420e64516
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
> > + * used to capture a stack trace.
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
> > +     TP_PROTO(struct alloc_tag *tag),
> > +
> > +     TP_ARGS(tag),
> > +
> > +     TP_STRUCT__entry(__field(struct alloc_tag *, tag)
> > +                      __string(modname, tag->ct.modname ? tag->ct.modn=
ame : "NONE")
> > +                      __string(filename, tag->ct.filename)
> > +                      __string(function, tag->ct.function)
> > +                      __field(unsigned int, lineno)
> > +     ),
> > +
> > +     TP_fast_assign(__entry->tag =3D tag;
> > +                    __assign_str(modname);
> > +                    __assign_str(filename);
> > +                    __assign_str(function);
> > +                    __entry->lineno =3D tag->ct.lineno;
> > +     ),
> > +
> > +     TP_printk("tag %p, module: %s, filename: %s, function %s, lineno =
%u",
> > +               __entry->tag,
> > +               __get_str(modname),
> > +               __get_str(filename),
> > +               __get_str(function),
> > +               __entry->lineno
> > +     )
> > +);
> > +
> > +/*
> > + * alloc_tag_mem_alloced is generated after memory is successfully all=
ocated.
> > + * It captures the exact byte size.
> > + *
> > + * The `ptr` value identifies the memory chunk for tracking its lifecy=
cle
> > + * (e.g., matching it with alloc_tag_mem_freed).
> > + * - slab and percpu allocators: address of the object's codetag_ref
> > + * - page allocator: the head struct page of the allocation
> > + *
> > + * Because the kernel isolates active allocations within the task stru=
ct
> > + * (current->alloc_tag), this event will always share the same implici=
t PID as
> > + * its corresponding alloc_tag_hit event. Tools should use the combina=
tion
> > + * PID + `tag` to correlate them.
> > + */
> > +TRACE_EVENT(alloc_tag_mem_alloced,
> > +     TP_PROTO(const void *ptr, struct alloc_tag *tag, size_t bytes),
> > +
> > +     TP_ARGS(ptr, tag, bytes),
> > +
> > +     TP_STRUCT__entry(__field(const void *, ptr)
> > +                      __field(struct alloc_tag *, tag)
> > +                      __field(size_t, bytes)
> > +     ),
> > +
> > +     TP_fast_assign(__entry->ptr =3D ptr;
> > +                    __entry->tag =3D tag;
> > +                    __entry->bytes =3D bytes;
> > +     ),
> > +
> > +     TP_printk("ptr %p, tag %p, bytes %zu",
> > +               __entry->ptr,
> > +               __entry->tag,
> > +               __entry->bytes
> > +     )
> > +);
> > +
> > +/*
> > + * alloc_tag_mem_freed event is generated immediately before memory is
> > + * freed. The `ptr` value matches the one emitted during allocation,
> > + * allowing tools to match it to its corresponding allocation and
> > + * call stack.
> > + *
> > + * Page allocator caveat: Pages can be split or moved to another folio
> > + * after the alloc event with no new events generated for that. As a
> > + * result, a free event may carry a `ptr` that never appeared in an
> > + * alloc event, and the `bytes` may be smaller than in the matching
> > + * alloc event. Tools must not assume alloc bytes =3D=3D free bytes, n=
or
> > + * that every free has a matching alloc.
> > + */
> > +TRACE_EVENT(alloc_tag_mem_freed,
> > +     TP_PROTO(const void *ptr, struct alloc_tag *tag, size_t bytes),
> > +
> > +     TP_ARGS(ptr, tag, bytes),
> > +
> > +     TP_STRUCT__entry(__field(const void *, ptr)
> > +                      __field(struct alloc_tag *, tag)
> > +                      __field(size_t, bytes)
> > +     ),
> > +
> > +     TP_fast_assign(__entry->ptr =3D ptr;
> > +                    __entry->tag =3D tag;
> > +                    __entry->bytes =3D bytes;
> > +     ),
> > +
> > +     TP_printk("ptr %p, tag %p, bytes %zu",
> > +               __entry->ptr,
> > +               __entry->tag,
> > +               __entry->bytes
> > +     )
> > +);
> > +
> > +#endif /* _TRACE_ALLOC_TAG_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> > index 82e2c3448dcf..ca2412a67312 100644
> > --- a/mm/alloc_tag.c
> > +++ b/mm/alloc_tag.c
> > @@ -18,6 +18,9 @@
> >  #include <linux/kmemleak.h>
> >  #include <uapi/linux/alloc_tag.h>
> >
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/alloc_tag.h>
> > +
> >  #include "internal.h"
> >  #include "page_alloc.h"
> >
> > @@ -54,6 +57,9 @@ EXPORT_SYMBOL(mem_alloc_profiling_key);
> >
> >  DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
> >
> > +DEFINE_STATIC_KEY_FALSE(alloc_tag_trace_key);
> > +EXPORT_SYMBOL(alloc_tag_trace_key);
> > +
> >  struct alloc_tag_kernel_section kernel_tags =3D { NULL, 0 };
> >  unsigned long alloc_tag_ref_mask;
> >  int alloc_tag_ref_offs;
> > @@ -484,6 +490,28 @@ static const struct proc_ops allocinfo_proc_ops =
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
> > +void alloc_tag_trace_mem_alloc(const void *ptr, struct alloc_tag *tag,
> > +                            size_t bytes)
> > +{
> > +     trace_alloc_tag_mem_alloced(ptr, tag, bytes);
> > +}
> > +EXPORT_SYMBOL(alloc_tag_trace_mem_alloc);
> > +
> > +void alloc_tag_trace_mem_free(const void *ptr, struct alloc_tag *tag,
> > +                           size_t bytes)
> > +{
> > +     trace_alloc_tag_mem_freed(ptr, tag, bytes);
> > +}
> > +EXPORT_SYMBOL(alloc_tag_trace_mem_free);
> > +
> >  size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, b=
ool can_sleep)
> >  {
> >       struct codetag_iterator iter;
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 2daf358269ae..e8bb12a6a721 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1241,7 +1241,7 @@ void __pgalloc_tag_add(struct page *page, struct =
task_struct *task,
> >       union codetag_ref ref;
> >
> >       if (likely(get_page_tag_ref(page, &ref, &handle))) {
> > -             alloc_tag_add(&ref, task->alloc_tag, PAGE_SIZE * nr);
> > +             alloc_tag_add(&ref, task->alloc_tag, PAGE_SIZE * nr, page=
);
> >               update_page_tag_ref(handle, &ref);
> >               put_page_tag_ref(handle);
> >       } else {
> > @@ -1270,7 +1270,7 @@ void __pgalloc_tag_sub(struct page *page, unsigne=
d int nr)
> >       union codetag_ref ref;
> >
> >       if (get_page_tag_ref(page, &ref, &handle)) {
> > -             alloc_tag_sub(&ref, PAGE_SIZE * nr);
> > +             alloc_tag_sub(&ref, PAGE_SIZE * nr, page);
> >               update_page_tag_ref(handle, &ref);
> >               put_page_tag_ref(handle);
> >       }
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index d7883507dc15..16f29020bcad 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -1695,16 +1695,19 @@ static void pcpu_alloc_tag_alloc_hook(struct pc=
pu_chunk *chunk, int off,
> >                                     size_t size)
> >  {
> >       if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts)) {
> > -             alloc_tag_add(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIF=
T].tag,
> > -                           current->alloc_tag, pcpu_obj_full_size(size=
));
> > +             union codetag_ref *ref =3D &chunk->obj_exts[off >> PCPU_M=
IN_ALLOC_SHIFT].tag;
> > +
> > +             alloc_tag_add(ref, current->alloc_tag, pcpu_obj_full_size=
(size), ref);
> >       }
> >  }
> >
> >  static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off=
, size_t size)
> >  {
> > -     if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts))
> > -             alloc_tag_sub(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIF=
T].tag,
> > -                           pcpu_obj_full_size(size));
> > +     if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts)) {
> > +             union codetag_ref *ref =3D &chunk->obj_exts[off >> PCPU_M=
IN_ALLOC_SHIFT].tag;
> > +
> > +             alloc_tag_sub(ref, pcpu_obj_full_size(size), ref);
> > +     }
> >  }
> >  #else
> >  static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int of=
f,
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 544cff39762c..a866576ccb98 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2404,7 +2404,7 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache=
 *s, void *object, gfp_t flags,
> >               obj_ext =3D slab_obj_ext(s, slab, obj_exts, object);
> >               ref =3D slab_obj_ext_codetag_ref(slab, obj_ext);
> >
> > -             alloc_tag_add(ref, current->alloc_tag, s->size);
> > +             alloc_tag_add(ref, current->alloc_tag, s->size, ref);
> >
> >               put_slab_obj_exts(obj_exts);
> >       } else {
> > @@ -2444,9 +2444,11 @@ __alloc_tagging_slab_free_hook(struct kmem_cache=
 *s, struct slab *slab, void **p
> >       get_slab_obj_exts(obj_exts);
> >       for (int i =3D 0; i < objects; i++) {
> >               struct slabobj_ext *ext;
> > +             union codetag_ref *ref;
> >
> >               ext =3D slab_obj_ext(s, slab, obj_exts, p[i]);
> > -             alloc_tag_sub(slab_obj_ext_codetag_ref(slab, ext), s->siz=
e);
> > +             ref =3D slab_obj_ext_codetag_ref(slab, ext);
> > +             alloc_tag_sub(ref, s->size, ref);
> >       }
> >       put_slab_obj_exts(obj_exts);
> >  }
