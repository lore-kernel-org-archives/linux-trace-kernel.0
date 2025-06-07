Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F441E8335
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Jun 2025 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749300539; cv=none; b=jmGH3Jq0KjzxKhme9BxkgANl69E1aw4IQ+wIMN544g9E0UIUkRXGMGCu9ilrHlV/HVBEWHVxpWUiK+yMiCSOW55xasdjXuuvWvGOEVKhlVT2fuiGAuhBM5CDcjMCAWvexlE/pLG36/JfLdHYZot0ywSumHXwAHF7CXMKxYgp4J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749300539; c=relaxed/simple;
	bh=8JxDdazW9W5NSLfbK19/gdTfF5oIkILldLz77qjZv+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4yTN7AWWaS9A090qCvFKseeL6xFimo82/tEP1Wdj//H5DgWmzbNNZwJmITdvRi2NOv7YOnNfELImH4h3gFRbQtEUCeLfrzI3uFIOJOK3G4fvM2SvhnYWdUTuRz/BcqNJzJgCG1phwLyhngm2YL4DAuhfN79KfCHflH/9JMDYSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7zHzxOV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7zHzxOV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749300536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RAp9UmqNf4IWuT2izfPoDb3NMX2RBGe64dHvKM0TnY=;
	b=g7zHzxOV4bO5VK3H3H9rLYdZV1ydNitW/g48OPgRbqer6nF8jgGWEZLYTHwNS1vh31RZOB
	SbFkSP3CxYiPqxAtv8UzsnVD3c5LKOqrsAYg5Km25msAhRcKsIDa3kHcmUBDUUghQUgNH3
	blAUA0aHTR+2Amd3lv1qApsCMkKimU4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-fIm-JieNPl62wvJgv0q_Bw-1; Sat, 07 Jun 2025 08:48:55 -0400
X-MC-Unique: fIm-JieNPl62wvJgv0q_Bw-1
X-Mimecast-MFC-AGG-ID: fIm-JieNPl62wvJgv0q_Bw_1749300535
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-707cf1b0ecbso41652077b3.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Jun 2025 05:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749300535; x=1749905335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RAp9UmqNf4IWuT2izfPoDb3NMX2RBGe64dHvKM0TnY=;
        b=clBThrwmG6P9cjhuZgYhksA7DkGI0eLX88krs1ZvISHMmRWpB9aYIoBB11d+Mr9Ld0
         f7DqL51AYGeGGZ/EjzeU78snFigifVQ9rfcq0PvP4BqS0ggspnN0tqTuYrJPsvXtKPms
         jrVsrzAEWqPGTFlC5ftJ7ZX+oAY/xnY+3tyYkE++XVRHvP+AlhGRYOSWdtaoRnihK1Td
         hryyBu9DArD6gPmvCdst3s3vmybsH2D6S6mqf+uia5cd8Jbjc3u4r7Iv6Hf2kB99tE21
         zldsfYQRKGSO3K7wVZnFMQdH04QQZOVDTic4pV/pJ60rWft8DbGhjz4wKNd0FNzMeuyO
         +rFA==
X-Forwarded-Encrypted: i=1; AJvYcCXc/HUccAu5evAtZ8QbWtfaBytQgenntNMBukpF0+2474WamolP3L6kwe0DnOKK6dPgluRSndTK70IcAWdg7arsYTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYHMnR1vk1yVUxdMap/LHpDRdExfBW8HsAPI+BjbBofd2o7WHn
	8ksBugL55BAhgrvNURnBEor4Qw6LUscGWqkJT0eItJcmhFtfyceNpC0pPeUmVASPwNVB40EYE+C
	tiwKak4C0QJUdfZ27ltKN2x9jx4LK1LBpF5SihuCeJG1lUL0BLXCGl92kiE4CMxjkPnRAZX8ZxV
	QDXaDOHjb6KMV+Rf2hdl6vOkwfkMB1BwoUySRWQ7RvUiPRNor6
X-Gm-Gg: ASbGncsMebFrMEBD42aAqqiDxA+RJp7uBpi9caRxpZt4prblAx73lYmKOjDcz8/qeTq
	UcVPldwB33/hvBkOVpF3CtNlCPtPx7ZPlbty5N07sZzteZLUQORI8F+Z13cycqoIMgh6tfhRZX+
	ZCzx8kig==
X-Received: by 2002:a05:690c:6e12:b0:70e:2cba:868c with SMTP id 00721157ae682-710f766a7f8mr115020227b3.11.1749300534782;
        Sat, 07 Jun 2025 05:48:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEd9DSb8F6yMCa3MP8JWlyBkx7270jerJumD5JUFQQx5RE2XCH/cQ/Di2e7HslP9Toakx+z8d+7Z969Me0ffI=
X-Received: by 2002:a05:690c:6e12:b0:70e:2cba:868c with SMTP id
 00721157ae682-710f766a7f8mr115019547b3.11.1749300534297; Sat, 07 Jun 2025
 05:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428181218.85925-1-npache@redhat.com> <20250428181218.85925-7-npache@redhat.com>
 <5feb1d57-e069-4469-9751-af4fb067e858@linux.alibaba.com> <CAA1CXcDWX7zsW03Wwg_OHRhJ2nrt6OaLd5bn8ccX0StoN1kGUQ@mail.gmail.com>
 <b2e0b383-d28f-436e-a83c-ab58b0eae995@arm.com>
In-Reply-To: <b2e0b383-d28f-436e-a83c-ab58b0eae995@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Sat, 7 Jun 2025 06:48:27 -0600
X-Gm-Features: AX0GCFsVx3-BIBWWiKH7KRUsC2qZTp3R0FtpRW4lWTfgsPCpvnkjlq_8ABeItq4
Message-ID: <CAA1CXcA4DXA875+C3-pHjZMtS332Jdwe2eWQbxOqQD80F43rVQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/12] khugepaged: introduce khugepaged_scan_bitmap for
 mTHP support
To: Dev Jain <dev.jain@arm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	david@redhat.com, baohua@kernel.org, ryan.roberts@arm.com, 
	willy@infradead.org, peterx@redhat.com, ziy@nvidia.com, 
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
	vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, 
	yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IXNyC6992jC3UKOjwLguvLlfVwc5iHdmo9lV9wpruJY_1749300535
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 10:38=E2=80=AFAM Dev Jain <dev.jain@arm.com> wrote:
>
>
> On 01/05/25 12:26 am, Nico Pache wrote:
> > On Wed, Apr 30, 2025 at 4:08=E2=80=AFAM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >>
> >>
> >> On 2025/4/29 02:12, Nico Pache wrote:
> >>> khugepaged scans anons PMD ranges for potential collapse to a hugepag=
e.
> >>> To add mTHP support we use this scan to instead record chunks of util=
ized
> >>> sections of the PMD.
> >>>
> >>> khugepaged_scan_bitmap uses a stack struct to recursively scan a bitm=
ap
> >>> that represents chunks of utilized regions. We can then determine wha=
t
> >>> mTHP size fits best and in the following patch, we set this bitmap wh=
ile
> >>> scanning the anon PMD.
> >>>
> >>> max_ptes_none is used as a scale to determine how "full" an order mus=
t
> >>> be before being considered for collapse.
> >>>
> >>> When attempting to collapse an order that has its order set to "alway=
s"
> >>> lets always collapse to that order in a greedy manner without
> >>> considering the number of bits set.
> >>>
> >>> Signed-off-by: Nico Pache <npache@redhat.com>
> >>> ---
> >>>    include/linux/khugepaged.h |  4 ++
> >>>    mm/khugepaged.c            | 94 ++++++++++++++++++++++++++++++++++=
----
> >>>    2 files changed, 89 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> >>> index 1f46046080f5..18fe6eb5051d 100644
> >>> --- a/include/linux/khugepaged.h
> >>> +++ b/include/linux/khugepaged.h
> >>> @@ -1,6 +1,10 @@
> >>>    /* SPDX-License-Identifier: GPL-2.0 */
> >>>    #ifndef _LINUX_KHUGEPAGED_H
> >>>    #define _LINUX_KHUGEPAGED_H
> >>> +#define KHUGEPAGED_MIN_MTHP_ORDER    2
> >> Still better to add some comments to explain explicitly why choose 2 a=
s
> >> the MIN_MTHP_ORDER.
> > Ok i'll add a note that explicitly states that the min order of anon mT=
HPs is 2
> >>> +#define KHUGEPAGED_MIN_MTHP_NR       (1<<KHUGEPAGED_MIN_MTHP_ORDER)
> >>> +#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE) - KHUGE=
PAGED_MIN_MTHP_ORDER))
> >>> +#define MTHP_BITMAP_SIZE  (1 << (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MT=
HP_ORDER))
> >>>
> >>>    extern unsigned int khugepaged_max_ptes_none __read_mostly;
> >>>    #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >>> index e21998a06253..6e67db86409a 100644
> >>> --- a/mm/khugepaged.c
> >>> +++ b/mm/khugepaged.c
> >>> @@ -94,6 +94,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash,=
 MM_SLOTS_HASH_BITS);
> >>>
> >>>    static struct kmem_cache *mm_slot_cache __ro_after_init;
> >>>
> >>> +struct scan_bit_state {
> >>> +     u8 order;
> >>> +     u16 offset;
> >>> +};
> >>> +
> >>>    struct collapse_control {
> >>>        bool is_khugepaged;
> >>>
> >>> @@ -102,6 +107,18 @@ struct collapse_control {
> >>>
> >>>        /* nodemask for allocation fallback */
> >>>        nodemask_t alloc_nmask;
> >>> +
> >>> +     /*
> >>> +      * bitmap used to collapse mTHP sizes.
> >>> +      * 1bit =3D order KHUGEPAGED_MIN_MTHP_ORDER mTHP
> >>> +      */
> >>> +     DECLARE_BITMAP(mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> >>> +     DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
> >>> +     struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_SIZE];
> >>> +};
> >>> +
> >>> +struct collapse_control khugepaged_collapse_control =3D {
> >>> +     .is_khugepaged =3D true,
> >>>    };
> >>>
> >>>    /**
> >>> @@ -851,10 +868,6 @@ static void khugepaged_alloc_sleep(void)
> >>>        remove_wait_queue(&khugepaged_wait, &wait);
> >>>    }
> >>>
> >>> -struct collapse_control khugepaged_collapse_control =3D {
> >>> -     .is_khugepaged =3D true,
> >>> -};
> >>> -
> >>>    static bool khugepaged_scan_abort(int nid, struct collapse_control=
 *cc)
> >>>    {
> >>>        int i;
> >>> @@ -1118,7 +1131,8 @@ static int alloc_charge_folio(struct folio **fo=
liop, struct mm_struct *mm,
> >>>
> >>>    static int collapse_huge_page(struct mm_struct *mm, unsigned long =
address,
> >>>                              int referenced, int unmapped,
> >>> -                           struct collapse_control *cc)
> >>> +                           struct collapse_control *cc, bool *mmap_l=
ocked,
> >>> +                               u8 order, u16 offset)
> >>>    {
> >>>        LIST_HEAD(compound_pagelist);
> >>>        pmd_t *pmd, _pmd;
> >>> @@ -1137,8 +1151,12 @@ static int collapse_huge_page(struct mm_struct=
 *mm, unsigned long address,
> >>>         * The allocation can take potentially a long time if it invol=
ves
> >>>         * sync compaction, and we do not need to hold the mmap_lock d=
uring
> >>>         * that. We will recheck the vma after taking it again in writ=
e mode.
> >>> +      * If collapsing mTHPs we may have already released the read_lo=
ck.
> >>>         */
> >>> -     mmap_read_unlock(mm);
> >>> +     if (*mmap_locked) {
> >>> +             mmap_read_unlock(mm);
> >>> +             *mmap_locked =3D false;
> >>> +     }
> >>>
> >>>        result =3D alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER)=
;
> >>>        if (result !=3D SCAN_SUCCEED)
> >>> @@ -1273,12 +1291,72 @@ static int collapse_huge_page(struct mm_struc=
t *mm, unsigned long address,
> >>>    out_up_write:
> >>>        mmap_write_unlock(mm);
> >>>    out_nolock:
> >>> +     *mmap_locked =3D false;
> >>>        if (folio)
> >>>                folio_put(folio);
> >>>        trace_mm_collapse_huge_page(mm, result =3D=3D SCAN_SUCCEED, re=
sult);
> >>>        return result;
> >>>    }
> >>>
> >>> +// Recursive function to consume the bitmap
> >> Nit: please use '/* Xxxx */' for comments in this patch.
> >>
> >>> +static int khugepaged_scan_bitmap(struct mm_struct *mm, unsigned lon=
g address,
> >>> +                     int referenced, int unmapped, struct collapse_c=
ontrol *cc,
> >>> +                     bool *mmap_locked, unsigned long enabled_orders=
)
> >>> +{
> >>> +     u8 order, next_order;
> >>> +     u16 offset, mid_offset;
> >>> +     int num_chunks;
> >>> +     int bits_set, threshold_bits;
> >>> +     int top =3D -1;
> >>> +     int collapsed =3D 0;
> >>> +     int ret;
> >>> +     struct scan_bit_state state;
> >>> +     bool is_pmd_only =3D (enabled_orders =3D=3D (1 << HPAGE_PMD_ORD=
ER));
> >>> +
> >>> +     cc->mthp_bitmap_stack[++top] =3D (struct scan_bit_state)
> >>> +             { HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER, 0 };
> >>> +
> >>> +     while (top >=3D 0) {
> >>> +             state =3D cc->mthp_bitmap_stack[top--];
> >>> +             order =3D state.order + KHUGEPAGED_MIN_MTHP_ORDER;
> >>> +             offset =3D state.offset;
> >>> +             num_chunks =3D 1 << (state.order);
> >>> +             // Skip mTHP orders that are not enabled
> >>> +             if (!test_bit(order, &enabled_orders))
> >>> +                     goto next;
> >>> +
> >>> +             // copy the relavant section to a new bitmap
> >>> +             bitmap_shift_right(cc->mthp_bitmap_temp, cc->mthp_bitma=
p, offset,
> >>> +                               MTHP_BITMAP_SIZE);
> >>> +
> >>> +             bits_set =3D bitmap_weight(cc->mthp_bitmap_temp, num_ch=
unks);
> >>> +             threshold_bits =3D (HPAGE_PMD_NR - khugepaged_max_ptes_=
none - 1)
> >>> +                             >> (HPAGE_PMD_ORDER - state.order);
> >>> +
> >>> +             //Check if the region is "almost full" based on the thr=
eshold
> >>> +             if (bits_set > threshold_bits || is_pmd_only
> >>> +                     || test_bit(order, &huge_anon_orders_always)) {
> >> When testing this patch, I disabled the PMD-sized THP and enabled
> >> 64K-sized mTHP, but it still attempts to collapse into a PMD-sized THP
> >> (since bits_set > threshold_bits is ture). This doesn't seem reasonabl=
e?
> > We are still required to have PMD enabled for mTHP collapse to work.
> > It's a limitation of the current khugepaged code (it currently only
> > adds mm_slots when PMD is enabled).
> > We've discussed this in the past and are looking for a proper way
> > forward, but the solution becomes tricky.
>
> Not sure if this is still a problem, but does this patch solve
> it?
>
> https://lore.kernel.org/all/20250211111326.14295-12-dev.jain@arm.com/

Hi Dev,

Baolin sent out a patch to do something similar to what you did here
based on my changes. I was going to keep the original behavior of
activating khugepaged only if the PMD size is enabled, and make that
change separately (outside this series), but I've gone ahead and
applied/tested Baolin's patch.

Sorry I had forgotten you already had a solution for this.

Cheers,
-- Nico
>
> >
> > However I'm surprised that it still collapses due to the code below.
> > I'll test this out later today.
> >      +             if (!test_bit(order, &enabled_orders))
> >      +                     goto next;
> >>> +                     ret =3D collapse_huge_page(mm, address, referen=
ced, unmapped, cc,
> >>> +                                     mmap_locked, order, offset * KH=
UGEPAGED_MIN_MTHP_NR);
> >>> +                     if (ret =3D=3D SCAN_SUCCEED) {
> >>> +                             collapsed +=3D (1 << order);
> >>> +                             continue;
> >>> +                     }
> >>> +             }
> >>> +
> >>> +next:
> >>> +             if (state.order > 0) {
> >>> +                     next_order =3D state.order - 1;
> >>> +                     mid_offset =3D offset + (num_chunks / 2);
> >>> +                     cc->mthp_bitmap_stack[++top] =3D (struct scan_b=
it_state)
> >>> +                             { next_order, mid_offset };
> >>> +                     cc->mthp_bitmap_stack[++top] =3D (struct scan_b=
it_state)
> >>> +                             { next_order, offset };
> >>> +                     }
> >>> +     }
> >>> +     return collapsed;
> >>> +}
> >>> +
> >>>    static int khugepaged_scan_pmd(struct mm_struct *mm,
> >>>                                   struct vm_area_struct *vma,
> >>>                                   unsigned long address, bool *mmap_l=
ocked,
> >>> @@ -1445,9 +1523,7 @@ static int khugepaged_scan_pmd(struct mm_struct=
 *mm,
> >>>        pte_unmap_unlock(pte, ptl);
> >>>        if (result =3D=3D SCAN_SUCCEED) {
> >>>                result =3D collapse_huge_page(mm, address, referenced,
> >>> -                                         unmapped, cc);
> >>> -             /* collapse_huge_page will return with the mmap_lock re=
leased */
> >>> -             *mmap_locked =3D false;
> >>> +                                         unmapped, cc, mmap_locked, =
HPAGE_PMD_ORDER, 0);
> >>>        }
> >>>    out:
> >>>        trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, refer=
enced,
>

