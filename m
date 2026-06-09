Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26593A6F1B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995664; cv=none; b=geTYVL5uGRMnaTNs5aUxrXfZZSxkpuce9UWz11D2ztPHzsMqhc1KEOS12tK2BKp4S4umWUT/ufCx4mgUOOHry9slFySsOEZGamRLDhz0nl5s7TRe3v96sM+03Hi3QWQEr+4kUtPpGIlVzTnu7vnL7+MgnQ5iWkynVlFLCKsP0H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995664; c=relaxed/simple;
	bh=HXIFuGB/G3Gv0XFcP5OG11UIhiNPhNFFgQpVqecxxVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msM+whBVxDMmFzwpkPFztEJzoQMy0/36xoZkdBxNGOVXrr3fQJ8UvvleHyqfPMtm3l5hNwkgzwupJtrGagj27S2tjVudfD9JBphWh7Bll5kkxjdzjv5Wt2kjqKiNqkv8syWAPkq9qrJN6Mhamy/7jLr3gMTPSgNrgDzcLyFMkKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D47Vo5nM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D47Vo5nM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780995661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjCzWhaSCTVXHkacb15DHG/H0gGLa5q4EBPfTFRAYrs=;
	b=D47Vo5nMT4gxl/xC02ocaC9apf14LwhIKVKjeNxJBR8/AIP/99+9ltcUVUZ1c4fpn7Bfft
	K2nKkfb8JA0YhrpBv06CCIx83ByzUtYQ15oBxuRzOI7Ohxwc4xjSiD5eEpmyw4PJmBihai
	zALKB67Iebyq3mTmu6kB9PDWI0kh+yA=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-fiG_ota3Mku_paA4OV_uKQ-1; Tue, 09 Jun 2026 05:00:53 -0400
X-MC-Unique: fiG_ota3Mku_paA4OV_uKQ-1
X-Mimecast-MFC-AGG-ID: fiG_ota3Mku_paA4OV_uKQ_1780995649
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-6603b45ec02so4455914d50.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Jun 2026 02:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780995649; x=1781600449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CjCzWhaSCTVXHkacb15DHG/H0gGLa5q4EBPfTFRAYrs=;
        b=OabgQ5IxuvIJi1ki4QJU7MbyYKIZstIikw/EPtTWDCtcDx2SLG5VNTipOSlDFNRqxp
         lLFM0fd/1z+b+o+sg4hiKEDDC8KqDWttRqrmWU6xvWNYM+ylKk0bwbceewB0W5tagfeI
         0ZzKOcrggHKKH0lSMAfmZdT5GK3B1OyzWgwkwoZQNtIs5zPW5xJ7ur08OwepphrPmwZj
         yCg+bO5ztTbgZbfnTocsXXD2AlnfwsRjszYLiSRdiqgp98hsFbAb4QOopPmcEfRPA85J
         v5T2xy8T9XeM/7VXiFskrwACeUvzBE3SES9fX+jctWUu2+/eWMzPiFssA2Q39ZvkLsTb
         06jg==
X-Forwarded-Encrypted: i=1; AFNElJ/NazgQUjWnhOClT0oCWvRD6SwRSTAUOF0GKtKT9znFtuqGLrcf98tR/gDZtu8kXPsm2Nvb6ERcx70vWR7q3R5Du3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPTgw9NUbTVHU71pG8Toayip78B33qH5Ukxgjhnz4Jw7mNfbL3
	fg76z4QkDROisfZEwmSsO/2qYNEbgIBq4n6LFcOtwhz2fh1SDwvwvl8c0nuyqI39do83KN6n1Oc
	LwfMNijsoGj8OA5VukMOPan9GTBUCmmD4VyAheCKxbykoqOlCVK96vHYtCYjgo2ucbmw2jQpD+x
	DQZWepxuXrPf/feTDymibx3H1BZ4cSUWTot0d1rKL3tV2ZU7UN
X-Gm-Gg: Acq92OEemPIhxU/9K0XI0+ksYxXvTpt8IOQjL7rqg/r10dl7h2hkeN3gmG9jft6MaRc
	KPB8obxa3EjR3350zZM+n51Uan3JGFrPSTAvRWf88YcgZ4oWL4ut/i+gWeZ8LxnjEwsTmo1BNnL
	d3mBzR4GqRFYiEm/Dkq08vt3p5IYboER9sOB9QxGdrqsOcJw4lN4PrxCnuSSQhtJkXVq+4V5tfm
	wj6ej8svNCk3J5W
X-Received: by 2002:a53:e10c:0:b0:65c:6220:5fca with SMTP id 956f58d0204a3-66106f5d8b5mr13373176d50.47.1780995648760;
        Tue, 09 Jun 2026 02:00:48 -0700 (PDT)
X-Received: by 2002:a53:e10c:0:b0:65c:6220:5fca with SMTP id
 956f58d0204a3-66106f5d8b5mr13373123d50.47.1780995647934; Tue, 09 Jun 2026
 02:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605161422.213817-1-npache@redhat.com> <20260605161422.213817-12-npache@redhat.com>
 <aiMTuXKQ5qxKYo60@lucifer>
In-Reply-To: <aiMTuXKQ5qxKYo60@lucifer>
From: Nico Pache <npache@redhat.com>
Date: Tue, 9 Jun 2026 03:01:34 -0600
X-Gm-Features: AVVi8Ceb-6YJHdLO-Do9on3gYeTalQbWiy2iQSDdl1jmDvd6DrN3iUNFll2LRL0
Message-ID: <CAA1CXcDo-UduPyTvzxXwCaheBebsuYnPcHanqfK-tLn4EeBGxQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v19 11/14] mm/khugepaged: Introduce mTHP
 collapse support
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	liam@infradead.org, mathieu.desnoyers@efficios.com, matthew.brost@intel.com, 
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, 
	rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org, 
	rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b6ThJVPHgD2k38QNj9XW8VLUUqo4wG1vufMic0R-M0c_1780995649
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 12:38=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> On Fri, Jun 05, 2026 at 10:14:18AM -0600, Nico Pache wrote:
> > Enable khugepaged to collapse to mTHP orders. This patch implements the
> > main scanning logic using a bitmap to track occupied pages and the
> > algorithm to find optimal collapse sizes.
> >
> > Previous to this patch, PMD collapse had 3 main phases, a light weight
> > scanning phase (mmap_read_lock) that determines a potential PMD
> > collapse, an alloc phase (mmap unlocked), then finally heavier collapse
> > phase (mmap_write_lock).
> >
> > To enabled mTHP collapse we make the following changes:
> >
> > During PMD scan phase, track occupied pages in a bitmap. When mTHP
> > orders are enabled, we remove the restriction of max_ptes_none during t=
he
> > scan phase to avoid missing potential mTHP collapse candidates. Once we
> > have scanned the full PMD range and updated the bitmap to track occupie=
d
> > pages, we use the bitmap to find the optimal mTHP size.
> >
> > Implement mthp_collapse() to walk forward through the bitmap and
> > determine the best eligible order for each naturally-aligned region. Th=
e
> > algorithm starts at the beginning of the PMD range and, for each offset=
,
> > tries the highest order that fits the alignment. If the number of
> > occupied PTEs in that region satisfies the max_ptes_none threshold for
> > that order, a collapse is attempted. On failure, the order is
> > decremented and the same offset is retried at the next smaller size. On=
ce
> > the smallest enabled order is exhausted (or a collapse succeeds), the
> > offset advances past the region just processed, and the next attempt
> > starts at the highest order permitted by the new offset's natural
> > alignment.
>
> I think still it might have been nice to discuss why we are not
> e.g. greedily trying to find the biggest possible mTHP size (if we did, w=
e
> would try the highest offset first), but we can save that for adding some
> documentation somewhere later tbh.

We are, the algorithm tries PMD, then order 8, then order 7, and so
on. Due to the required alignment, if the N-1 order succeeds, we try
the same order at the neighboring offset.

So if we collapse a order 8, the following collapse attempt will be
order 8 at 256. We always try the highest order allowed for a given
offset :)

>
> This commit message is long enough as it is :>)
>
> >
> > The algorithm works as follows:
> >     1) set offset=3D0 and order=3DHPAGE_PMD_ORDER
> >     2) if the order is not enabled, go to step (5)
> >     3) count occupied PTEs in the (offset, order) range using
> >        bitmap_weight_from()
> >     4) if the count satisfies the max_ptes_none threshold, attempt
> >        collapse; on success, advance to step (6)
> >     5) if a smaller enabled order exists, decrement order and retry
> >        from step (2) at the same offset
> >     6) advance offset past the current region and compute the next
> >        order from the new offset's natural alignment via __ffs(offset),
> >        capped at HPAGE_PMD_ORDER
> >     7) repeat from step (2) until the full PMD range is covered
> >
> > mTHP collapses reject regions containing swapped out or shared pages.
> > This is because adding new entries can lead to new none pages, and thes=
e
> > may lead to constant promotion into a higher order mTHP. A similar
> > issue can occur with "max_ptes_none > HPAGE_PMD_NR/2" due to a collapse
> > introducing at least 2x the number of pages, and on a future scan will
> > satisfy the promotion condition once again. This issue is prevented via
> > the collapse_max_ptes_none() function which imposes the max_ptes_none
> > restrictions above.
> >
> > We currently only support mTHP collapse for max_ptes_none values of 0
> > and HPAGE_PMD_NR - 1. resulting in the following behavior:
> >
> >     - max_ptes_none=3D0: Never introduce new empty pages during collaps=
e
> >     - max_ptes_none=3DHPAGE_PMD_NR-1: Always try collapse to the highes=
t
> >       available mTHP order
> >
> > Any other max_ptes_none value will emit a warning and default mTHP
> > collapse to max_ptes_none=3D0. There should be no behavior change for P=
MD
> > collapse.
> >
> > Once we determine what mTHP sizes fits best in that PMD range a collaps=
e
> > is attempted. A minimum collapse order of 2 is used as this is the lowe=
st
> > order supported by anon memory as defined by THP_ORDERS_ALL_ANON.
> >
> > Currently madv_collapse is not supported and will only attempt PMD
> > collapse.
> >
> > We can also remove the check for is_khugepaged inside the PMD scan as
> > the collapse_max_ptes_none() function handles this logic now.
>
> It'd be nice to have kept the ASCII diagram here too :'( but this is fine=
,
>
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
>
> This all LGTM, and we can fix up any issues that arise later if anything
> does break. So:
>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

Thanks for reviewing :)

>
> > ---
> >  mm/khugepaged.c | 146 +++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 138 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index ec886a031952..430047316f43 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -99,6 +99,8 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM=
_SLOTS_HASH_BITS);
> >
> >  static struct kmem_cache *mm_slot_cache __ro_after_init;
> >
> > +#define KHUGEPAGED_MIN_MTHP_ORDER    2
> > +
> >  struct collapse_control {
> >       bool is_khugepaged;
> >
> > @@ -110,6 +112,9 @@ struct collapse_control {
> >
> >       /* nodemask for allocation fallback */
> >       nodemask_t alloc_nmask;
> > +
> > +     /* Each bit represents a single occupied (!none/zero) page. */
> > +     DECLARE_BITMAP(mthp_present_ptes, MAX_PTRS_PER_PTE);
> >  };
> >
> >  /**
> > @@ -1440,20 +1445,130 @@ static enum scan_result collapse_huge_page(str=
uct mm_struct *mm, unsigned long s
> >       return result;
> >  }
> >
> > +/* Return the highest naturally aligned order that fits at @offset wit=
hin a PMD. */
> > +static unsigned int max_order_from_offset(unsigned int offset)
> > +{
> > +     if (offset =3D=3D 0)
> > +             return HPAGE_PMD_ORDER;
> > +
> > +     return min_t(unsigned int, __ffs(offset), HPAGE_PMD_ORDER);
> > +}
>
> Thanks this is better! I wonder if we can ever actually see an
> __ffs(offset) that's > HPAGE_PMD_ORDER but probably better safe than sorr=
y
> here with the min_t.

I don't think so unless offset somehow exceeds 512 (it shouldn't), but
like you said, better safe than sorry.

>
> > +
> > +/*
> > + * mthp_collapse() consumes the bitmap that is generated during
> > + * collapse_scan_pmd() to determine what regions and mTHP orders fit b=
est.
> > + *
> > + * Each bit in cc->mthp_present_ptes represents a single occupied (!no=
ne/zero)
> > + * page. We start at the PMD order and check if it is eligible for col=
lapse;
> > + * if not, we check the left and right halves of the PTE page table we=
 are
> > + * examining at a lower order.
> > + *
> > + * For each of these, we determine how many PTE entries are occupied i=
n the
> > + * range of PTE entries we propose to collapse, then we compare this t=
o a
> > + * threshold number of PTE entries which would need to be occupied for=
 a
> > + * collapse to be permitted at that order (accounting for max_ptes_non=
e).
> > + *
> > + * If a collapse is permitted, we attempt to collapse the PTE range in=
to a
> > + * mTHP.
> > + */
> > +static enum scan_result mthp_collapse(struct mm_struct *mm,
> > +             unsigned long address, int referenced, int unmapped,
> > +             struct collapse_control *cc, unsigned long enabled_orders=
)
> > +{
> > +     unsigned int nr_occupied_ptes, nr_ptes, max_ptes_none;
> > +     enum scan_result last_result =3D SCAN_FAIL;
> > +     int collapsed =3D 0;
> > +     bool alloc_failed =3D false;
> > +     unsigned long collapse_address;
> > +     unsigned int offset =3D 0;
> > +     unsigned int order =3D HPAGE_PMD_ORDER;
> > +
> > +     while (offset < HPAGE_PMD_NR) {
> > +             nr_ptes =3D 1UL << order;
> > +
> > +             if (!test_bit(order, &enabled_orders))
> > +                     goto next_order;
> > +
> > +             max_ptes_none =3D collapse_max_ptes_none(cc, NULL, order)=
;
> > +             nr_occupied_ptes =3D bitmap_weight_from(cc->mthp_present_=
ptes, offset,
> > +                                                   offset + nr_ptes);
> > +
> > +             if (nr_occupied_ptes >=3D nr_ptes - max_ptes_none) {
> > +                     enum scan_result ret;
> > +
> > +                     collapse_address =3D address + offset * PAGE_SIZE=
;
> > +                     ret =3D collapse_huge_page(mm, collapse_address, =
referenced,
> > +                                              unmapped, cc, order);
> > +                     switch (ret) {
> > +                     /* Cases where we continue to next collapse candi=
date */
> > +                     case SCAN_SUCCEED:
> > +                             collapsed +=3D nr_ptes;
> > +                             fallthrough;
> > +                     case SCAN_PTE_MAPPED_HUGEPAGE:
> > +                             goto next_offset;
> > +                     /* Cases where lower orders might still succeed *=
/
> > +                     case SCAN_ALLOC_HUGE_PAGE_FAIL:
> > +                             alloc_failed =3D true;
> > +                             last_result =3D ret;
> > +                             goto next_order;
> > +                     /* Cases where no further collapse is possible */
> > +                     case SCAN_PMD_MAPPED:
> > +                             fallthrough;
> > +                     default:
> > +                             last_result =3D ret;
> > +                             goto done;
> > +                     }
> > +             }
> > +
> > +next_order:
> > +             /*
> > +              * Continue with the next smaller order if there is still
> > +              * any smaller order enabled. When at the smallest order
> > +              * we must always move to the next offset.
> > +              */
> > +             if (order > KHUGEPAGED_MIN_MTHP_ORDER &&
> > +                     (enabled_orders & GENMASK(order - 1, 0))) {
>
> Honestly wasn't aware of GENMASK() before :)

I wasn't either! (thanks David ;) )

>
> > +                     order--;
> > +                     continue;
> > +             }
> > +next_offset:
> > +             /*
> > +              * Advance past the region we just processed and determin=
e the
> > +              * highest order we can attempt next. Since huge pages mu=
st be
> > +              * naturally aligned, the max order we can attempt next i=
s
> > +              * limited by the alignment of the new offset.
> > +              * E.g. if we collapsed a order-2 mTHP at offset 0, offse=
t
> > +              * becomes 4 and __ffs(4) =3D=3D 2, so the next attempt s=
tarts at
> > +              * order 2.
> > +              */
>
> Great comment thanks!
>
> > +             offset +=3D nr_ptes;
> > +             order =3D max_order_from_offset(offset);
> > +     }
> > +done:
> > +     if (collapsed)
> > +             return SCAN_SUCCEED;
> > +     if (alloc_failed)
> > +             return SCAN_ALLOC_HUGE_PAGE_FAIL;
> > +     return last_result;
> > +}
> > +
> >  static enum scan_result collapse_scan_pmd(struct mm_struct *mm,
> >               struct vm_area_struct *vma, unsigned long start_addr,
> >               bool *lock_dropped, struct collapse_control *cc)
> >  {
> > -     const unsigned int max_ptes_none =3D collapse_max_ptes_none(cc, v=
ma, HPAGE_PMD_ORDER);
> >       const unsigned int max_ptes_shared =3D collapse_max_ptes_shared(c=
c, HPAGE_PMD_ORDER);
> >       const unsigned int max_ptes_swap =3D collapse_max_ptes_swap(cc, H=
PAGE_PMD_ORDER);
> > +     unsigned int max_ptes_none =3D collapse_max_ptes_none(cc, vma, HP=
AGE_PMD_ORDER);
> > +     enum tva_type tva_flags =3D cc->is_khugepaged ? TVA_KHUGEPAGED : =
TVA_FORCED_COLLAPSE;
> >       pmd_t *pmd;
> > -     pte_t *pte, *_pte;
> > +     pte_t *pte, *_pte, pteval;
> > +     int i;
> >       int none_or_zero =3D 0, shared =3D 0, referenced =3D 0;
> >       enum scan_result result =3D SCAN_FAIL;
> >       struct page *page =3D NULL;
> >       struct folio *folio =3D NULL;
> >       unsigned long addr;
> > +     unsigned long enabled_orders;
> >       spinlock_t *ptl;
> >       int node =3D NUMA_NO_NODE, unmapped =3D 0;
> >
> > @@ -1465,8 +1580,19 @@ static enum scan_result collapse_scan_pmd(struct=
 mm_struct *mm,
> >               goto out;
> >       }
> >
> > +     bitmap_zero(cc->mthp_present_ptes, MAX_PTRS_PER_PTE);
> >       memset(cc->node_load, 0, sizeof(cc->node_load));
> >       nodes_clear(cc->alloc_nmask);
> > +
> > +     enabled_orders =3D collapse_possible_orders(vma, vma->vm_flags, t=
va_flags);
> > +
> > +     /*
> > +      * If PMD is the only enabled order, enforce max_ptes_none, other=
wise
> > +      * scan all pages to populate the bitmap for mTHP collapse.
> > +      */
> > +     if (enabled_orders !=3D BIT(HPAGE_PMD_ORDER))
> > +             max_ptes_none =3D KHUGEPAGED_MAX_PTES_LIMIT;
> > +
> >       pte =3D pte_offset_map_lock(mm, pmd, start_addr, &ptl);
> >       if (!pte) {
> >               cc->progress++;
> > @@ -1474,11 +1600,13 @@ static enum scan_result collapse_scan_pmd(struc=
t mm_struct *mm,
> >               goto out;
> >       }
> >
> > -     for (addr =3D start_addr, _pte =3D pte; _pte < pte + HPAGE_PMD_NR=
;
> > -          _pte++, addr +=3D PAGE_SIZE) {
> > +     for (i =3D 0; i < HPAGE_PMD_NR; i++) {
> > +             _pte =3D pte + i;
> > +             addr =3D start_addr + i * PAGE_SIZE;
> > +             pteval =3D ptep_get(_pte);
> > +
> >               cc->progress++;
> >
> > -             pte_t pteval =3D ptep_get(_pte);
> >               if (pte_none_or_zero(pteval)) {
> >                       if (++none_or_zero > max_ptes_none) {
> >                               result =3D SCAN_EXCEED_NONE_PTE;
> > @@ -1558,6 +1686,8 @@ static enum scan_result collapse_scan_pmd(struct =
mm_struct *mm,
> >                       }
> >               }
> >
> > +             /* Set bit for occupied pages */
> > +             __set_bit(i, cc->mthp_present_ptes);
> >               /*
> >                * Record which node the original page is from and save t=
his
> >                * information to cc->node_load[].
> > @@ -1616,9 +1746,9 @@ static enum scan_result collapse_scan_pmd(struct =
mm_struct *mm,
> >       if (result =3D=3D SCAN_SUCCEED) {
> >               /* collapse_huge_page expects the lock to be dropped befo=
re calling */
> >               mmap_read_unlock(mm);
> > -             result =3D collapse_huge_page(mm, start_addr, referenced,
> > -                                         unmapped, cc, HPAGE_PMD_ORDER=
);
> > -             /* collapse_huge_page will return with the mmap_lock rele=
ased */
> > +             result =3D mthp_collapse(mm, start_addr, referenced,
> > +                                    unmapped, cc, enabled_orders);
> > +             /* mmap_lock was released above, set lock_dropped */
> >               *lock_dropped =3D true;
> >       }
> >  out:
> > --
> > 2.54.0
> >
>
> Cheers, Lorenzo
>

