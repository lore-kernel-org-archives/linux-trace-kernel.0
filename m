Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA0199947
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Jun 2025 06:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751179717; cv=none; b=VqMiMQUGh8+fTeiqFfH95TqKZjDsKe0mkemAfWO8XP7Zv912+iXAtqR663AJSO/rDAlFbUBFy/BmsO6qGY0kAOCYEtojTQFcS4motv9dbuOP013aXKqSFn9GIwgKUhpWnAbYiRXHuiNCNwDOJUHYbt5UMRlOSuA3KbfqtE1ag+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751179717; c=relaxed/simple;
	bh=y6pc3Ck9wcyktCxDHZ1BSvQaied06tclqR2EnHXpptg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Z/huN8Nt2CxL3a4VyCwpJMiJJTippBGcSP+K2OZw2gnHc8pYvj2UgUw1hwPy1ZQDWpc1Us+r0MzijxgSS+pbtKxMTlv2XXnFjHBkz6mj2d+5wxt0zajdeyXdblUUTX7126tDWm0t/zIwo+WcSyBqe+LXfZek/j1aze1fTsTbl5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=io1bts7F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="io1bts7F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751179714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6mktgM6+MmVaHytEpAMM+qdx8QznZfzldVcD0zz/aI=;
	b=io1bts7FHtdREl1DeOLyW+Hou6eYGOgqQyCd9p3Xa5kcf1p5WhWehSimiQgPyIcFGjFOJa
	Psken4sdx/jEvZwLPV4tlL1lrXmQutidUdP1zB8yTRsdvE9O/bvGu+OzgGO3aMAyHcL7Dw
	jpXHXaUuuKF1LXG3MXZJkAdh8raSIYA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-Uffux-uCNJm0BM4_Ok5uKw-1; Sun, 29 Jun 2025 02:48:32 -0400
X-MC-Unique: Uffux-uCNJm0BM4_Ok5uKw-1
X-Mimecast-MFC-AGG-ID: Uffux-uCNJm0BM4_Ok5uKw_1751179712
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7111d608131so16701197b3.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Jun 2025 23:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751179712; x=1751784512;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6mktgM6+MmVaHytEpAMM+qdx8QznZfzldVcD0zz/aI=;
        b=hX4JrwYfKfiSqlY8uUQoBfYYbSPvqkbUlL2+7IuI7aRKVhgZu6oBZFQ/Sr6SlFSPCY
         34ISxEK6OAlQioAuZFjNNuGc1W2DDYT2tyRHtQLLvzr1UIEcNHFKckdNNZN/IH5gfYVI
         BDKH4D3NRsT3LOtCUk2sl5/k48BbCRORZghzb4+Vz4Ay6cC5Ay0VdMt0Jcyl+Rfo3jY8
         LgBlB1H2UM+aRDfuDHkgwSlbmqKQC2V7icmfS6Jy4XKZLZqXXDDUAuc3m/qyhXS/Nnk0
         ZsSh9Vyr7cxgdJGu2vVLJhFGKkACLFdM70NGU3XJVmW4f633WOdct3Nrb95gNs4kZJEQ
         Wg6A==
X-Forwarded-Encrypted: i=1; AJvYcCVU7erJKa8UDIt2wEK240QHQ9c8u2sa6GU09ISOlmiCtIC9zNYF1VlOyG6Pp7SsxPrfoLfsKkbBb7X5PDALtZpzH/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/A7eGcRz6z4R6zHyfmVqSyclyNNW5tYgiqUf7nYrQn4k2NjZ
	6RMFFO/SiIyXp123Qruf4Snyj985E2DDsxxqyzbgqfE6QyuUhPyAdGhiBn+Zk01rgtQLB2+zgNi
	0heVXNPb6x0wXqTiCUXnHVRo7V5zXqvmm/juO07Y8X26CoRXRP5cEKYdShA5Sf9XKlhCT3p5+gK
	kHUMLi2juulCMOtCI0k+uMfvlp21qM+bJ+51eSRo7XcLehFTuW
X-Gm-Gg: ASbGncu9bjhTFyOqHvzQir/Vb6xAvLrRFf+beIio+zvo0hawQDwvqUY04KuYHj1jziW
	PRR4B7LauI3S+De3BRfQFqM85FlSY8rFkTx4qqBX9UKDhJa8oG9ZVDanKsODimhAIbE5tSj38ky
	P5yd6n+A==
X-Received: by 2002:a05:690c:61c2:b0:70f:84c8:311a with SMTP id 00721157ae682-7151713d1a6mr133727487b3.5.1751179711758;
        Sat, 28 Jun 2025 23:48:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRQbpojGgiAkQ7Ac7AxkhV+xB+GtuRKr4Wp9yAF0gg/Z4YFPBXAMv/fqRNF7JnWSSQbIuDAanbsoTvVZAp10g=
X-Received: by 2002:a05:690c:61c2:b0:70f:84c8:311a with SMTP id
 00721157ae682-7151713d1a6mr133727177b3.5.1751179711336; Sat, 28 Jun 2025
 23:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515032226.128900-1-npache@redhat.com> <20250515032226.128900-2-npache@redhat.com>
 <gsk47hv4pkqjstkb6mfiv2muon6yj3vp5rsho6rufq5qjfweow@scdzrvph5ah6>
In-Reply-To: <gsk47hv4pkqjstkb6mfiv2muon6yj3vp5rsho6rufq5qjfweow@scdzrvph5ah6>
From: Nico Pache <npache@redhat.com>
Date: Sun, 29 Jun 2025 00:48:04 -0600
X-Gm-Features: Ac12FXwPRqqeSXJYrLqYRGBqWORzrJk_aeEbyURWs0vjZvlYe2C0Hz_e3si4Y_M
Message-ID: <CAA1CXcC74aYLC2YHgziCim0+ZXog1VfyVqEbL7v9TAUx0k8q6g@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] khugepaged: rename hpage_collapse_* to khugepaged_*
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
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BEI0Ukgtd8IZcXSMSB2L2r8irVYOUG-Kk9F4K48JfjA_1751179712
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 11:36=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Nico Pache <npache@redhat.com> [250514 23:23]:
> > functions in khugepaged.c use a mix of hpage_collapse and khugepaged
> > as the function prefix.
> >
> > rename all of them to khugepaged to keep things consistent and slightly
> > shorten the function names.
>
> I don't like what was done here, we've lost the context of what these
> functions are used for (collapse). Are they used for other things
> besides collapse?
Hi Liam,

Most of the renamed functions are used by the daemon to determine the
state of the khugepaged operations. You could argue that
madvise_collapse is not part of the daemon, and a couple of them are
both khugepaged and madvise_collapse, but what I do in the subsequent
patch is *mostly* unify madvise_collapse and khugepaged.

I personally believe this rename makes sense (and it was recommended
by David H.)



-- Nico

>
> I'd rather drop the prefix entirely than drop collapse from them all.
> They are all static, so do we really need khugepaged_ at the start of
> every static function in khugepaged.c?
>
>
> >
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 42 +++++++++++++++++++++---------------------
> >  1 file changed, 21 insertions(+), 21 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index cdf5a581368b..806bcd8c5185 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -402,14 +402,14 @@ void __init khugepaged_destroy(void)
> >       kmem_cache_destroy(mm_slot_cache);
> >  }
> >
> > -static inline int hpage_collapse_test_exit(struct mm_struct *mm)
> > +static inline int khugepaged_test_exit(struct mm_struct *mm)
> >  {
> >       return atomic_read(&mm->mm_users) =3D=3D 0;
> >  }
> >
> > -static inline int hpage_collapse_test_exit_or_disable(struct mm_struct=
 *mm)
> > +static inline int khugepaged_test_exit_or_disable(struct mm_struct *mm=
)
> >  {
> > -     return hpage_collapse_test_exit(mm) ||
> > +     return khugepaged_test_exit(mm) ||
> >              test_bit(MMF_DISABLE_THP, &mm->flags);
> >  }
> >
> > @@ -444,7 +444,7 @@ void __khugepaged_enter(struct mm_struct *mm)
> >       int wakeup;
> >
> >       /* __khugepaged_exit() must not run from under us */
> > -     VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
> > +     VM_BUG_ON_MM(khugepaged_test_exit(mm), mm);
> >       if (unlikely(test_and_set_bit(MMF_VM_HUGEPAGE, &mm->flags)))
> >               return;
> >
> > @@ -503,7 +503,7 @@ void __khugepaged_exit(struct mm_struct *mm)
> >       } else if (mm_slot) {
> >               /*
> >                * This is required to serialize against
> > -              * hpage_collapse_test_exit() (which is guaranteed to run
> > +              * khugepaged_test_exit() (which is guaranteed to run
> >                * under mmap sem read mode). Stop here (after we return =
all
> >                * pagetables will be destroyed) until khugepaged has fin=
ished
> >                * working on the pagetables under the mmap_lock.
> > @@ -851,7 +851,7 @@ struct collapse_control khugepaged_collapse_control=
 =3D {
> >       .is_khugepaged =3D true,
> >  };
> >
> > -static bool hpage_collapse_scan_abort(int nid, struct collapse_control=
 *cc)
> > +static bool khugepaged_scan_abort(int nid, struct collapse_control *cc=
)
> >  {
> >       int i;
> >
> > @@ -886,7 +886,7 @@ static inline gfp_t alloc_hugepage_khugepaged_gfpma=
sk(void)
> >  }
> >
> >  #ifdef CONFIG_NUMA
> > -static int hpage_collapse_find_target_node(struct collapse_control *cc=
)
> > +static int khugepaged_find_target_node(struct collapse_control *cc)
> >  {
> >       int nid, target_node =3D 0, max_value =3D 0;
> >
> > @@ -905,7 +905,7 @@ static int hpage_collapse_find_target_node(struct c=
ollapse_control *cc)
> >       return target_node;
> >  }
> >  #else
> > -static int hpage_collapse_find_target_node(struct collapse_control *cc=
)
> > +static int khugepaged_find_target_node(struct collapse_control *cc)
> >  {
> >       return 0;
> >  }
> > @@ -925,7 +925,7 @@ static int hugepage_vma_revalidate(struct mm_struct=
 *mm, unsigned long address,
> >       struct vm_area_struct *vma;
> >       unsigned long tva_flags =3D cc->is_khugepaged ? TVA_ENFORCE_SYSFS=
 : 0;
> >
> > -     if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> > +     if (unlikely(khugepaged_test_exit_or_disable(mm)))
> >               return SCAN_ANY_PROCESS;
> >
> >       *vmap =3D vma =3D find_vma(mm, address);
> > @@ -992,7 +992,7 @@ static int check_pmd_still_valid(struct mm_struct *=
mm,
> >
> >  /*
> >   * Bring missing pages in from swap, to complete THP collapse.
> > - * Only done if hpage_collapse_scan_pmd believes it is worthwhile.
> > + * Only done if khugepaged_scan_pmd believes it is worthwhile.
> >   *
> >   * Called and returns without pte mapped or spinlocks held.
> >   * Returns result: if not SCAN_SUCCEED, mmap_lock has been released.
> > @@ -1078,7 +1078,7 @@ static int alloc_charge_folio(struct folio **foli=
op, struct mm_struct *mm,
> >  {
> >       gfp_t gfp =3D (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpm=
ask() :
> >                    GFP_TRANSHUGE);
> > -     int node =3D hpage_collapse_find_target_node(cc);
> > +     int node =3D khugepaged_find_target_node(cc);
> >       struct folio *folio;
> >
> >       folio =3D __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nm=
ask);
> > @@ -1264,7 +1264,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >       return result;
> >  }
> >
> > -static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> > +static int khugepaged_scan_pmd(struct mm_struct *mm,
> >                                  struct vm_area_struct *vma,
> >                                  unsigned long address, bool *mmap_lock=
ed,
> >                                  struct collapse_control *cc)
> > @@ -1378,7 +1378,7 @@ static int hpage_collapse_scan_pmd(struct mm_stru=
ct *mm,
> >                * hit record.
> >                */
> >               node =3D folio_nid(folio);
> > -             if (hpage_collapse_scan_abort(node, cc)) {
> > +             if (khugepaged_scan_abort(node, cc)) {
> >                       result =3D SCAN_SCAN_ABORT;
> >                       goto out_unmap;
> >               }
> > @@ -1447,7 +1447,7 @@ static void collect_mm_slot(struct khugepaged_mm_=
slot *mm_slot)
> >
> >       lockdep_assert_held(&khugepaged_mm_lock);
> >
> > -     if (hpage_collapse_test_exit(mm)) {
> > +     if (khugepaged_test_exit(mm)) {
> >               /* free mm_slot */
> >               hash_del(&slot->hash);
> >               list_del(&slot->mm_node);
> > @@ -1740,7 +1740,7 @@ static void retract_page_tables(struct address_sp=
ace *mapping, pgoff_t pgoff)
> >               if (find_pmd_or_thp_or_none(mm, addr, &pmd) !=3D SCAN_SUC=
CEED)
> >                       continue;
> >
> > -             if (hpage_collapse_test_exit(mm))
> > +             if (khugepaged_test_exit(mm))
> >                       continue;
> >               /*
> >                * When a vma is registered with uffd-wp, we cannot recyc=
le
> > @@ -2262,7 +2262,7 @@ static int collapse_file(struct mm_struct *mm, un=
signed long addr,
> >       return result;
> >  }
> >
> > -static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned lon=
g addr,
> > +static int khugepaged_scan_file(struct mm_struct *mm, unsigned long ad=
dr,
> >                                   struct file *file, pgoff_t start,
> >                                   struct collapse_control *cc)
> >  {
> > @@ -2307,7 +2307,7 @@ static int hpage_collapse_scan_file(struct mm_str=
uct *mm, unsigned long addr,
> >               }
> >
> >               node =3D folio_nid(folio);
> > -             if (hpage_collapse_scan_abort(node, cc)) {
> > +             if (khugepaged_scan_abort(node, cc)) {
> >                       result =3D SCAN_SCAN_ABORT;
> >                       break;
> >               }
> > @@ -2391,7 +2391,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned int pages, int *result,
> >               goto breakouterloop_mmap_lock;
> >
> >       progress++;
> > -     if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> > +     if (unlikely(khugepaged_test_exit_or_disable(mm)))
> >               goto breakouterloop;
> >
> >       vma_iter_init(&vmi, mm, khugepaged_scan.address);
> > @@ -2399,7 +2399,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned int pages, int *result,
> >               unsigned long hstart, hend;
> >
> >               cond_resched();
> > -             if (unlikely(hpage_collapse_test_exit_or_disable(mm))) {
> > +             if (unlikely(khugepaged_test_exit_or_disable(mm))) {
> >                       progress++;
> >                       break;
> >               }
> > @@ -2421,7 +2421,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned int pages, int *result,
> >                       bool mmap_locked =3D true;
> >
> >                       cond_resched();
> > -                     if (unlikely(hpage_collapse_test_exit_or_disable(=
mm)))
> > +                     if (unlikely(khugepaged_test_exit_or_disable(mm))=
)
> >                               goto breakouterloop;
> >
> >                       VM_BUG_ON(khugepaged_scan.address < hstart ||
> > @@ -2481,7 +2481,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned int pages, int *result,
> >        * Release the current mm_slot if this mm is about to die, or
> >        * if we scanned all vmas of this mm.
> >        */
> > -     if (hpage_collapse_test_exit(mm) || !vma) {
> > +     if (khugepaged_test_exit(mm) || !vma) {
> >               /*
> >                * Make sure that if mm_users is reaching zero while
> >                * khugepaged runs here, khugepaged_exit will find
> > --
> > 2.49.0
> >
>

