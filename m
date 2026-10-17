Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1CF49365D
	for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792240401; cv=pass; b=kJQPqcafFTNSwE09lZ1spTAnPSkOrcR9KOnUX+EjgGDBxmP/dxwf2TFwGTCyIPeGPvQvbAVO2zIT8uHOjKm4f1wpyjvrWk0IwE6H+SNXETrJ5YnbvTr+4DBLZZ2qq61HOW1Wt99cq1GTpnaJCqz3lP/FwUu19YgNx4awEV/JbRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792240401; c=relaxed/simple;
	bh=bsDY7kcuUFJXzQtzuBxfeTgpNtJ9ZLJDQPcIfpL24us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQAj/ksIv8PTaRt8S0WlYgwBwiabVki2NnfuAI8WN8CHTofnf1LlsN7IzgOltb+YTF1KVyJFZKG6Iq2sh9LyusxYXrj/PlWDBJK4lrNl4C7ApmrKltuJ+R8bLDjg5GgF3hES6+S2MwAl+PPrLq9iqUNWgfwCpXjOlprFZiykqgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JnhprHvM; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnhprHvM"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-535f598d126so103771cf.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 05:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792240398; cv=none;
        d=google.com; s=arc-20260327;
        b=CDmE9GfOFUBGQsPM6dra3xjtwAzq9DEUo8S25iX5rMye+xxgDgrg8OgmkpzjsnmkYo
         bVVA62UxRC5peiWFTHTwmrX9hM3PntRojbpEd2x6nGoaPOwFVID99yI3FFa9i8MdWGJ+
         mkD5zTKTmdsaEXCZfe+FBpzH/R8FfMYRGKky1M6VrK64qhhd5tFCmxeCFYx7gb3Gny+f
         Fm1Y2LnjzuGmHvSQ55zMoB91G8mcOA6ZU5R2qJmM8gZh6VlNgKR1GHzEylNFEaL/k3gA
         DkM48VCJ2mi8zDu7tE5dcH9BthmBuK7jNdSulevaqV26CYI7OBME6KlECPWcgxRx87OA
         IKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BD/BGi4w7AOQx91nN9Nm5JcXCzVoRwXvXH3yAs2NWbA=;
        fh=TWPmtgQmFG5Rm2HNMut/JP620zd+p7av0cQsw5ItOOg=;
        b=laYS1VBtUEcAOH6Ry+xmQJ3NyRibxi6aMWIIFvIZLhG7Ir6e2DSjxV3gam/Dq6adBM
         CEgrDa9KzcsRJGG7Clw6PNbbFJaOzZjYQgkdgSLOjQedCvNUrIO6m+XxnJONGEYsegiS
         wPolccuxWKLFl+BbeJ02BMgcDpylqB2nE6KggbbO2f4tXEiEeo9xbisV0RRkOMT8Y6cY
         BhPeu9w/IkMRFBHyI9Q5UAhBfxOpTgVNw+PL4bkZNBJqtdR0hoSVZDD6M5DRA0+tOX4E
         KSzCJUjIWddAPSOBgaER7Bc9rVgV7tVaARL//u/l3aRjWmnU2t7wrFmtALP2+gpr9jKa
         /Tug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792240398; x=1792845198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BD/BGi4w7AOQx91nN9Nm5JcXCzVoRwXvXH3yAs2NWbA=;
        b=JnhprHvMw2B5AoJFOfpYndcGfPgutxjh25ew9gGanVOFpKcH1eXDQgEiPl94uhRHb1
         jSD2SduTpKp60/DNIjPtk1NZ3Y7zbrP5nlYB04JNLkRPvP2zyUPjzD03FADJ/teklJ8s
         teJ+IgMhtJ/kcDkvbN5D+0FzvJinFMRXtW7ftzw3ajk/kz+V1fHPrXL7NZxsQoHaLGiD
         1XvCeVRPeugKj8I12SJybWz6Z8umgaToOSCPlR5yx+NIA4a6lyGtNsq3GVHIXG6LqlhW
         ToNH8VdJMLmDrhSuiSLhTICiezP2RxAFTb9RuNwUT3HoidsGibbLZ2MNIrFGHjUfAQKw
         pl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792240398; x=1792845198;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BD/BGi4w7AOQx91nN9Nm5JcXCzVoRwXvXH3yAs2NWbA=;
        b=x38KTXpV1Of0/9/f6wKFZDJeuNcrcRZVd6gkqsotoaOn406/hyVQotNlbFZ0MdNAOR
         ++NpmO37NqDJNeoM1xjoSsLb348SSXqwiP0iG33te7eoLjuPMr6i0/DphElwFIW6oWhL
         +Oh4kqtcQt8vZ62lxmRbGKum0F1IM8KL6BE+u7R8+2nZltUSCC4LnVxk0KYLetpIZEHU
         MIi0OVp0YXdmtbbexBf28wTlMSBq5wchLIkgcTkI9d+0zk16byIGWPc/sPY0J10Bkl01
         41xDVvzCq75ozIoU26297oHCK7bj7k7b/A7nFvwhJe5J1Nop+5uE6VM6syFKRxNKBqG7
         dVdg==
X-Forwarded-Encrypted: i=1; AKwUvBy82NzE3CbQiQ4IIe1V9ufgBcQpC9H9SVwZesfu2sJLlUK0DtAUq1W+t7KAx+VwU4G0lE5APsZk5Fyd8PCuHG1+4HA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMnac0zzRD61VGxVDga/652PAQAC7GbqzYVBj6beSWJNNN/nC9
	b9mqndfmgvxiky8+2dULjnFzFDv0IygMwtvHUMU7hIaw0rLTzh7CYICLNkl+lRitY8cHuvLGiES
	8FYapfA8VtNAoUy8vyyHB5N1zoB+Tpo3Z1qYbrDhd
X-Gm-Gg: AYBFou1gtrus7cF8O7ahfGFnjIqwL4gzAqoP5xV+PF4w/ldcmub8Ux66NF9iJzW1oQV
	QYkBP7k8chmyV6dL1SlmJ5ku/WV8mz9k0tJz9uK3HO7d1VnJOqJfruKogY3YBKOPGPcgglU67C8
	QhEOQAno0ohl5o7UltWCVCKvBXZypI/WnnwqUObHu8TFeZYATR4QJpJWIyDnTqdgHbELMR+3SCe
	AZihWTxxHkpHpRtZfEWiYmBRrEYGhnmEF68uarjZaQwYga36/xJaun4jTn5HeykDvz1NF9a3hhL
	SsgND3yPbGP0N550eMPhCcTcY4pz9IV3wsqDIAdtyM4vSvUJ8rAysQJP6CjSzu/cMjPPoctqtMB
	jHDyYHtxvMp7cnDnz2Z01Zx8raDyUAjduamDKHg==
X-Received: by 2002:a05:622a:250a:b0:535:852e:a94a with SMTP id
 d75a77b69052e-53645fdb57cmr15571471cf.7.1792240397089; Sat, 17 Oct 2026
 05:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791410885.git.abhishekbapat@google.com>
 <ba9bee624103492dde1c8bf57943b691b4f1596b.1791410886.git.abhishekbapat@google.com>
 <39c3cf3f-4b3c-4c80-9210-279e2bf2f5c0@linux.dev>
In-Reply-To: <39c3cf3f-4b3c-4c80-9210-279e2bf2f5c0@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 17 Oct 2026 16:33:04 +0400
X-Gm-Features: AclHuK8TLOtm2pW-9a1hyBZnb2eDUc8NK3T3sWHJ8oVqcO7yVmQrgnyHVZIQ0yc
Message-ID: <CAJuCfpEbt-_TBjDJTNKtFTGCvPRvnAf8qewo+ppxKywORWrOpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] alloc_tag: Add trace events for tracing allocations
To: Hao Ge <hao.ge@linux.dev>
Cc: Abhishek Bapat <abhishekbapat@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 10:12=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Abhishek
>
>
>
> On 2026/10/8 06:39, Abhishek Bapat wrote:
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
>
> Acked-by: Hao Ge <hao.ge@linux.dev>

Acked-by: Suren Baghdasaryan <surenb@google.com>

>
> > ---
> >  Documentation/mm/allocation-profiling.rst |  53 ++++++++++
> >  MAINTAINERS                               |   1 +
> >  include/linux/alloc_tag.h                 |  67 +++++++++---
> >  include/trace/events/alloc_tag.h          | 122 ++++++++++++++++++++++
> >  mm/alloc_tag.c                            |  28 +++++
> >  mm/page_alloc.c                           |   4 +-
> >  mm/percpu.c                               |  12 ++-
> >  mm/slub.c                                 |   6 +-
> >  8 files changed, 269 insertions(+), 24 deletions(-)
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
> > index 5c38da7090db..751ce786a378 100644
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
> > index 7f2d80a59792..49825177d8c8 100644
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
> > index 000000000000..b79efb7dd25c
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

nit: Is there a case when we pass tag=3DNULL here?

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
> > index 7682aecc2c07..5e3e411d4ffe 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1239,7 +1239,7 @@ void __pgalloc_tag_add(struct page *page, struct =
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
> > @@ -1268,7 +1268,7 @@ void __pgalloc_tag_sub(struct page *page, unsigne=
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
> > index 3eff382e565a..12b6c97d1596 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -1695,15 +1695,19 @@ static void pcpu_alloc_tag_alloc_hook(struct pc=
pu_chunk *chunk, int off,
> >                                     size_t size)
> >  {
> >       if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts)) {
> > -             alloc_tag_add(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIF=
T].tag,
> > -                           current->alloc_tag, size);
> > +             union codetag_ref *ref =3D &chunk->obj_exts[off >> PCPU_M=
IN_ALLOC_SHIFT].tag;
> > +
> > +             alloc_tag_add(ref, current->alloc_tag, size, ref);
> >       }
> >  }
> >
> >  static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off=
, size_t size)
> >  {
> > -     if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts))
> > -             alloc_tag_sub(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIF=
T].tag, size);
> > +     if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts)) {
> > +             union codetag_ref *ref =3D &chunk->obj_exts[off >> PCPU_M=
IN_ALLOC_SHIFT].tag;
> > +
> > +             alloc_tag_sub(ref, size, ref);
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
