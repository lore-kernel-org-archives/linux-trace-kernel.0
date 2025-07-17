Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8372222B6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737106; cv=none; b=D0accFqtZsXDYlCzBEhccuLA701xK41SrGy3mRqjhgXiEUAEUYUHL9+Oh8PY/exJX33UzXYvBhvGWe2fc1p8sqBgmQ4zckWn6HMPXLf+u1ojkiBxWDPmvQJHzS9DZoUTjE+Z9RVblSy5Gv7iSBxXiSX5Cux50RC0ueM57oIcpJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737106; c=relaxed/simple;
	bh=9kHfXee+l1f3WBIb17fZFnfoMusSnT4/I0tbxUSeS2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TzqqD35Ts96/2lGWGb3QqjvLYUEvS81E/szEvTa8BWG7yt6ssJ2szdFBm+j2f+lEh8O4oFIyN4qH6cPbaOX5BCGMDBEv+JuKDzJdWjzqZyiYJamf7mMa91XfWB/N3eSP8hTyadV246ixZKsFRsaGBYSURln8o3llaMP+1fwciYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2Fc2ZhZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2Fc2ZhZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752737103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXWuYbNH70VJqXrCI+4o6n8tdlArYOj0orE3QrAHL2o=;
	b=T2Fc2ZhZNzaWXtjZNSvSF1MbS7pv4uyCA/4kS93nD/Hyds5wOUa3JdvEvk3UCKZSnII4dQ
	xHwB52VmfW5j+tfNEg7Th4XWNEmq8OYHmVwUsrBPSVQJhRO002SQJGRfe518JvdPMk5B8U
	u7CAjb4v9RYXEJ1zpBxaMo4m8BMnAog=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-J0ZxfySwNFyKl_EoCXw1vw-1; Thu, 17 Jul 2025 03:25:02 -0400
X-MC-Unique: J0ZxfySwNFyKl_EoCXw1vw-1
X-Mimecast-MFC-AGG-ID: J0ZxfySwNFyKl_EoCXw1vw_1752737102
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-714052e5103so7424297b3.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752737102; x=1753341902;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXWuYbNH70VJqXrCI+4o6n8tdlArYOj0orE3QrAHL2o=;
        b=rLSrJ1kRLZlkKnJGHVrm5s0kfjafXvDgM4ze91ZlutF49vmfX6qSNhY6H4btbfC7SS
         d7vcIrzdxzyIVUSQMPfb9OP06Anjgxopg9ZI/MIlCDwNIpcEejeUx7hZtqzjXrkS1jMP
         6+QD9GyY+y6DAwu6KsxYb7dpVBBogPAn75rzKXGsGh+tsDsiiGoVV2KMhIbxCUXEM8Mj
         yaMHb+yM4u09ZI1foicAdmBuz2doSshWjCwUJQrFezMpLaP3yL0feKuhDy0MRpZAhf5D
         oouTkrt647oCuFz5DZ71LrJgNfgHIPSSNq8EgICwJLGoz4YdXesoKa633XFmRWvPBVa1
         Dwyw==
X-Forwarded-Encrypted: i=1; AJvYcCVn6YIHRcFLH2c7psokcFwMSBTm9Ooiih82DRgPrgGoCTdZW99zMIaTkLuFqmm1A6htmZArWTYLpR4Y3KtWGC9MIHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT38xOXxOtbvrms9N4B/Pwb4rIC6q6hyrvmzdLhwgpVvML+v7t
	lImbpeKxl8WKQCGa+LLNJehQ+ptxFRh9kv4LIHcrdSGcNgO70RiMaKTq6SH3yjYhXw4KwBT5Fml
	WhwkkEGImrDmf2N22sen37Nrv1avFWVTV9mlu6JEJNz67fFzHpNPCmqZFZ7VuGizkWkuzKX6fN1
	DOm4zt/pgNIbfap66mOFswJMjRFACUT/Mo8fS8URKToLxd+Wjd
X-Gm-Gg: ASbGncvWDPrr+i4JvJUWYDJarJ5hfjVYtWwjL55SH98zLv4hdFMIZnO7RkMyXd+arWx
	BVju0KBVbeJeyhnKG8wm+8JFvyt1waXTxhwgNwWuKEY5JjH9JE6q+a+/Fi8bRgbFcV8gXp51WF0
	Bsy1tOEmHIi2FnfjpZxWiokdk=
X-Received: by 2002:a05:690c:1c:b0:70d:f237:6a6a with SMTP id 00721157ae682-71834fd3745mr68332617b3.11.1752737101653;
        Thu, 17 Jul 2025 00:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKeRD3xCAGWa+dzntrbPMbsWyFZut7J2kc0oL6u2GZt3zXbRx6x0p+nqxW/PS1DVmbc3Wz61TqafQnGiZLg5E=
X-Received: by 2002:a05:690c:1c:b0:70d:f237:6a6a with SMTP id
 00721157ae682-71834fd3745mr68332027b3.11.1752737100915; Thu, 17 Jul 2025
 00:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-7-npache@redhat.com>
 <omxfj73o756gyd2kbdggbcxnk6xomtxwrgr7p6j4gvts4272tj@zuklefzbuotf>
In-Reply-To: <omxfj73o756gyd2kbdggbcxnk6xomtxwrgr7p6j4gvts4272tj@zuklefzbuotf>
From: Nico Pache <npache@redhat.com>
Date: Thu, 17 Jul 2025 01:24:34 -0600
X-Gm-Features: Ac12FXxyfnb4_RV9eEcRUqSxUtI2u4uwq8rBJNr3J875h2as7uY9eFcbia4dCv8
Message-ID: <CAA1CXcBZcSB=jQ5xCg1F9UuFgSA3k0WpCwiUE2nHB9fah1anRQ@mail.gmail.com>
Subject: Re: [PATCH v9 06/14] khugepaged: introduce collapse_scan_bitmap for
 mTHP support
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com, 
	sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k1iZU73a2aSdilG3KEkAS4-LXRv0uLQux1rZm7DECSk_1752737102
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 9:39=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Nico Pache <npache@redhat.com> [250713 20:34]:
> > khugepaged scans anons PMD ranges for potential collapse to a hugepage.
> > To add mTHP support we use this scan to instead record chunks of utiliz=
ed
> > sections of the PMD.
> >
> > collapse_scan_bitmap uses a stack struct to recursively scan a bitmap
> > that represents chunks of utilized regions. We can then determine what
> > mTHP size fits best and in the following patch, we set this bitmap whil=
e
> > scanning the anon PMD. A minimum collapse order of 2 is used as this is
> > the lowest order supported by anon memory.
> >
> > max_ptes_none is used as a scale to determine how "full" an order must
> > be before being considered for collapse.
> >
> > When attempting to collapse an order that has its order set to "always"
> > lets always collapse to that order in a greedy manner without
> > considering the number of bits set.
> >
>
> v7 had talks about having selftests of this code.  You mention you used
> selftests mm in the cover letter but it seems you did not add the
> reproducer that Baolin had?
This was in relation to the MADV_COLLAPSE issue, which we decided to
put off for now.
I can add mTHP tests to my list of future work!


-- Nico
>
> Maybe I missed that?
>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  include/linux/khugepaged.h |  4 ++
> >  mm/khugepaged.c            | 94 ++++++++++++++++++++++++++++++++++----
> >  2 files changed, 89 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > index ff6120463745..0f957711a117 100644
> > --- a/include/linux/khugepaged.h
> > +++ b/include/linux/khugepaged.h
> > @@ -1,6 +1,10 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> >  #ifndef _LINUX_KHUGEPAGED_H
> >  #define _LINUX_KHUGEPAGED_H
> > +#define KHUGEPAGED_MIN_MTHP_ORDER    2
> > +#define KHUGEPAGED_MIN_MTHP_NR       (1<<KHUGEPAGED_MIN_MTHP_ORDER)
> > +#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE) - KHUGEPA=
GED_MIN_MTHP_ORDER))
> > +#define MTHP_BITMAP_SIZE  (1 << (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP=
_ORDER))
> >
> >  extern unsigned int khugepaged_max_ptes_none __read_mostly;
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index ee54e3c1db4e..59b2431ca616 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -94,6 +94,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, M=
M_SLOTS_HASH_BITS);
> >
> >  static struct kmem_cache *mm_slot_cache __ro_after_init;
> >
> > +struct scan_bit_state {
> > +     u8 order;
> > +     u16 offset;
> > +};
> > +
> >  struct collapse_control {
> >       bool is_khugepaged;
> >
> > @@ -102,6 +107,18 @@ struct collapse_control {
> >
> >       /* nodemask for allocation fallback */
> >       nodemask_t alloc_nmask;
> > +
> > +     /*
> > +      * bitmap used to collapse mTHP sizes.
> > +      * 1bit =3D order KHUGEPAGED_MIN_MTHP_ORDER mTHP
> > +      */
> > +     DECLARE_BITMAP(mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> > +     DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
> > +     struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_SIZE];
> > +};
> > +
> > +struct collapse_control khugepaged_collapse_control =3D {
> > +     .is_khugepaged =3D true,
> >  };
> >
> >  /**
> > @@ -838,10 +855,6 @@ static void khugepaged_alloc_sleep(void)
> >       remove_wait_queue(&khugepaged_wait, &wait);
> >  }
> >
> > -struct collapse_control khugepaged_collapse_control =3D {
> > -     .is_khugepaged =3D true,
> > -};
> > -
> >  static bool collapse_scan_abort(int nid, struct collapse_control *cc)
> >  {
> >       int i;
> > @@ -1115,7 +1128,8 @@ static int alloc_charge_folio(struct folio **foli=
op, struct mm_struct *mm,
> >
> >  static int collapse_huge_page(struct mm_struct *mm, unsigned long addr=
ess,
> >                             int referenced, int unmapped,
> > -                           struct collapse_control *cc)
> > +                           struct collapse_control *cc, bool *mmap_loc=
ked,
> > +                               u8 order, u16 offset)
> >  {
> >       LIST_HEAD(compound_pagelist);
> >       pmd_t *pmd, _pmd;
> > @@ -1134,8 +1148,12 @@ static int collapse_huge_page(struct mm_struct *=
mm, unsigned long address,
> >        * The allocation can take potentially a long time if it involves
> >        * sync compaction, and we do not need to hold the mmap_lock duri=
ng
> >        * that. We will recheck the vma after taking it again in write m=
ode.
> > +      * If collapsing mTHPs we may have already released the read_lock=
.
> >        */
> > -     mmap_read_unlock(mm);
> > +     if (*mmap_locked) {
> > +             mmap_read_unlock(mm);
> > +             *mmap_locked =3D false;
> > +     }
> >
> >       result =3D alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
> >       if (result !=3D SCAN_SUCCEED)
> > @@ -1272,12 +1290,72 @@ static int collapse_huge_page(struct mm_struct =
*mm, unsigned long address,
> >  out_up_write:
> >       mmap_write_unlock(mm);
> >  out_nolock:
> > +     *mmap_locked =3D false;
> >       if (folio)
> >               folio_put(folio);
> >       trace_mm_collapse_huge_page(mm, result =3D=3D SCAN_SUCCEED, resul=
t);
> >       return result;
> >  }
> >
> > +/* Recursive function to consume the bitmap */
> > +static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long ad=
dress,
> > +                     int referenced, int unmapped, struct collapse_con=
trol *cc,
> > +                     bool *mmap_locked, unsigned long enabled_orders)
> > +{
> > +     u8 order, next_order;
> > +     u16 offset, mid_offset;
> > +     int num_chunks;
> > +     int bits_set, threshold_bits;
> > +     int top =3D -1;
> > +     int collapsed =3D 0;
> > +     int ret;
> > +     struct scan_bit_state state;
> > +     bool is_pmd_only =3D (enabled_orders =3D=3D (1 << HPAGE_PMD_ORDER=
));
> > +
> > +     cc->mthp_bitmap_stack[++top] =3D (struct scan_bit_state)
> > +             { HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER, 0 };
> > +
> > +     while (top >=3D 0) {
> > +             state =3D cc->mthp_bitmap_stack[top--];
> > +             order =3D state.order + KHUGEPAGED_MIN_MTHP_ORDER;
> > +             offset =3D state.offset;
> > +             num_chunks =3D 1 << (state.order);
> > +             // Skip mTHP orders that are not enabled
> > +             if (!test_bit(order, &enabled_orders))
> > +                     goto next;
> > +
> > +             // copy the relavant section to a new bitmap
> > +             bitmap_shift_right(cc->mthp_bitmap_temp, cc->mthp_bitmap,=
 offset,
> > +                               MTHP_BITMAP_SIZE);
> > +
> > +             bits_set =3D bitmap_weight(cc->mthp_bitmap_temp, num_chun=
ks);
> > +             threshold_bits =3D (HPAGE_PMD_NR - khugepaged_max_ptes_no=
ne - 1)
> > +                             >> (HPAGE_PMD_ORDER - state.order);
> > +
> > +             //Check if the region is "almost full" based on the thres=
hold
> > +             if (bits_set > threshold_bits || is_pmd_only
> > +                     || test_bit(order, &huge_anon_orders_always)) {
> > +                     ret =3D collapse_huge_page(mm, address, reference=
d, unmapped, cc,
> > +                                     mmap_locked, order, offset * KHUG=
EPAGED_MIN_MTHP_NR);
> > +                     if (ret =3D=3D SCAN_SUCCEED) {
> > +                             collapsed +=3D (1 << order);
> > +                             continue;
> > +                     }
> > +             }
> > +
> > +next:
> > +             if (state.order > 0) {
> > +                     next_order =3D state.order - 1;
> > +                     mid_offset =3D offset + (num_chunks / 2);
> > +                     cc->mthp_bitmap_stack[++top] =3D (struct scan_bit=
_state)
> > +                             { next_order, mid_offset };
> > +                     cc->mthp_bitmap_stack[++top] =3D (struct scan_bit=
_state)
> > +                             { next_order, offset };
> > +                     }
> > +     }
> > +     return collapsed;
> > +}
> > +
> >  static int collapse_scan_pmd(struct mm_struct *mm,
> >                                  struct vm_area_struct *vma,
> >                                  unsigned long address, bool *mmap_lock=
ed,
> > @@ -1444,9 +1522,7 @@ static int collapse_scan_pmd(struct mm_struct *mm=
,
> >       pte_unmap_unlock(pte, ptl);
> >       if (result =3D=3D SCAN_SUCCEED) {
> >               result =3D collapse_huge_page(mm, address, referenced,
> > -                                         unmapped, cc);
> > -             /* collapse_huge_page will return with the mmap_lock rele=
ased */
> > -             *mmap_locked =3D false;
> > +                                         unmapped, cc, mmap_locked, HP=
AGE_PMD_ORDER, 0);
> >       }
> >  out:
> >       trace_mm_khugepaged_scan_pmd(mm, folio, writable, referenced,
> > --
> > 2.50.0
> >
>

