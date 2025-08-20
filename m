Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455F322DBE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707794; cv=none; b=blepvgKi5orzHVH3v4CL/5mSd+faxZULePk1kfo4RcjPobSxvpbFs5AtaimsU9T80TImuh+Qyq8xJhJpiQm85P4kEm0JOvSMFQRu77XfUJQ5tePMWfBT/qsqqVcpXSGXLGm25/aWEwS0Qr+itdZWjE4ZuXOnit3LWidmypgtfV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707794; c=relaxed/simple;
	bh=1cJtr5xnb1uIlwFraPS2r+t6B2j92UPF8n4XcrNZCs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhlTdE2SDYvFC2ut81aRIDLmenJVwKlTd+ex5Eek/oUUKttvJJ5dy6Q5uNdMVwC94nXlGrs0HNGzKRhz0E2HcyxfBbzPJf/sRIIeQ21icSbec9PE5k15V2PWeSVVpaG5InxU8x2FtvqPsSWOxOuzcwtHGEpBoKfXCcMI+bfE0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBlKRJvS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBlKRJvS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755707790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvtlwWUqesIYENKIJjSR0UkLBe3hTSdGUFezNYbbvkY=;
	b=hBlKRJvSPkJYzyggan/mj8184VofEA7StHs1O1Dd0qSMqH2FkaO7JpQ64xROGoMa5S2ODk
	2lWV2u9U6TPdbKLDxOAagnFoswJIYQk1ZAtQRNXDbrVBrayva5qfpoIxzI168jJOAtlw65
	zwjStre1Zg8+MoCzWrdCV9XA7PH+7JE=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-M98xqKOVM9a4KktrPJBEYA-1; Wed, 20 Aug 2025 12:36:27 -0400
X-MC-Unique: M98xqKOVM9a4KktrPJBEYA-1
X-Mimecast-MFC-AGG-ID: M98xqKOVM9a4KktrPJBEYA_1755707787
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-71d603b2fa1so288137b3.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755707787; x=1756312587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvtlwWUqesIYENKIJjSR0UkLBe3hTSdGUFezNYbbvkY=;
        b=sgUFPiXRuMtur5OC4kgKcDU7L5eNcuoAMd6NZlr1C6HHYHDwvYRXWrPt9E5mhrPjHK
         iN/QfjoWkIhPAmSF16VN8CRlpB68TVjxG9NLdQeytRfAv/EdbHfKloBYtTZuKoim1e0h
         aAH3DCmCryIFQym66oRGd2GfADTVlcjbOS/uNDidfa/Hm1MUR4dPbvANKHrYEMihEBc6
         pcibIPeAm+ffFyRVcoqrZnTx+NLUWmRJunPx5R+NXngtgVC5oD01u3I14xsUQOW9ktyj
         A7FWp+r3erByecILMtrZYz7kbUBBhcsmwZGN5kwhp5rnn5/0n/qK4o0rdH0h73W8iS79
         ++Bw==
X-Forwarded-Encrypted: i=1; AJvYcCX5JDTeKK3Ol9jmDTHebcuHB1nFJ9l34WWalw05xrpfGo5ijjvbpQ+cSaSTD+9FoFTy22VJSxNd/HYON2cBH8Ga/1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo9Q/dxoyV6unDazy9ZRXW/42ImTwrKPcoIbG8PyJx6Im858MU
	Off6hS7tLqyigAnUom8BXWIvoo1KbL8Frnfk+zx/r12vqWeQeuTVhCTANTqLcZmpKOcXdhZzd5X
	JfKQ7TwP1Kyk3nUMIEWG6ZlokDJ2Fa0pQkZd/gr2s9/8HDnfmB15D5ENgRF6OLQzFiv03s99zdt
	7xNMJaisrctSg5OVYfuNPmHYAiSi0R04aKY+qTmN9wulSi497T
X-Gm-Gg: ASbGncuZHF17mDhECPf+WcJsrbZ6vbKhp1bO5+OFse1JA++5+VvYnhmlEB2KIvXd4Ks
	P8nkuJAxMl7EiuSGDwTNwNPXNLfW1PF917gCdCyePJR8+FECRKYHJdFlmAmFh3m0q7QPf2L+jhy
	4laggDzBrBK55zUTkPaVXpAU8=
X-Received: by 2002:a05:6902:124c:b0:e94:ffef:f759 with SMTP id 3f1490d57ef6-e94ffeffb71mr1803815276.0.1755707786371;
        Wed, 20 Aug 2025 09:36:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4HcRCJqL9vTQ/7ox3BvjpkrAei2D0oMgx2P0qN9HBDbCGUlv1atq6zFqXMh5NOKuFN79QdAgvfzzh1V38bA8=
X-Received: by 2002:a05:6902:124c:b0:e94:ffef:f759 with SMTP id
 3f1490d57ef6-e94ffeffb71mr1803742276.0.1755707785709; Wed, 20 Aug 2025
 09:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819134205.622806-1-npache@redhat.com> <20250819134205.622806-3-npache@redhat.com>
 <248d57e5-8cd5-408b-a6c8-970df6876b6c@lucifer.local>
In-Reply-To: <248d57e5-8cd5-408b-a6c8-970df6876b6c@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Wed, 20 Aug 2025 10:35:57 -0600
X-Gm-Features: Ac12FXzjf4Igr1tHl9lliKUKtFV236tYdnecnsgkQbabWzhsGT93TnmDGE_Rezk
Message-ID: <CAA1CXcC-7MudjF06JaJQUvKkNh4vPHTTeoMDBE-devotyFXjkA@mail.gmail.com>
Subject: Re: [PATCH v10 02/13] introduce collapse_single_pmd to unify
 khugepaged and madvise_collapse
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YlI-DtgQ3AaW9nA8A28YlUgnkphKXjTiIFHfWj6Q-YA_1755707787
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 5:22=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Aug 19, 2025 at 07:41:54AM -0600, Nico Pache wrote:
> > The khugepaged daemon and madvise_collapse have two different
> > implementations that do almost the same thing.
> >
> > Create collapse_single_pmd to increase code reuse and create an entry
> > point to these two users.
> >
> > Refactor madvise_collapse and collapse_scan_mm_slot to use the new
> > collapse_single_pmd function. This introduces a minor behavioral change
> > that is most likely an undiscovered bug. The current implementation of
> > khugepaged tests collapse_test_exit_or_disable before calling
> > collapse_pte_mapped_thp, but we weren't doing it in the madvise_collaps=
e
> > case. By unifying these two callers madvise_collapse now also performs
> > this check.
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 94 ++++++++++++++++++++++++++-----------------------
> >  1 file changed, 49 insertions(+), 45 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 0e7bbadf03ee..b7b98aebb670 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2382,6 +2382,50 @@ static int collapse_scan_file(struct mm_struct *=
mm, unsigned long addr,
> >       return result;
> >  }
> >
> > +/*
> > + * Try to collapse a single PMD starting at a PMD aligned addr, and re=
turn
> > + * the results.
> > + */
> > +static int collapse_single_pmd(unsigned long addr,
> > +                             struct vm_area_struct *vma, bool *mmap_lo=
cked,
> > +                             struct collapse_control *cc)
> > +{
> > +     int result =3D SCAN_FAIL;
>
> You assign result in all branches, so this can be uninitialised.
ack, thanks.
>
> > +     struct mm_struct *mm =3D vma->vm_mm;
> > +
> > +     if (!vma_is_anonymous(vma)) {
> > +             struct file *file =3D get_file(vma->vm_file);
> > +             pgoff_t pgoff =3D linear_page_index(vma, addr);
> > +
> > +             mmap_read_unlock(mm);
> > +             *mmap_locked =3D false;
> > +             result =3D collapse_scan_file(mm, addr, file, pgoff, cc);
> > +             fput(file);
> > +             if (result =3D=3D SCAN_PTE_MAPPED_HUGEPAGE) {
> > +                     mmap_read_lock(mm);
> > +                     *mmap_locked =3D true;
> > +                     if (collapse_test_exit_or_disable(mm)) {
> > +                             mmap_read_unlock(mm);
> > +                             *mmap_locked =3D false;
> > +                             result =3D SCAN_ANY_PROCESS;
> > +                             goto end;
>
> Don't love that in e.g. collapse_scan_mm_slot() we are using the mmap loc=
k being
> disabled as in effect an error code.
>
> Is SCAN_ANY_PROCESS correct here? Because in collapse_scan_mm_slot() you'=
d
> previously:
https://lore.kernel.org/lkml/a881ed65-351a-469f-b625-a3066d0f1d5c@linux.ali=
baba.com/
Baolin brought up a good point a while back that if
collapse_test_exit_or_disable returns true we will be breaking out of
the loop and should change the return value to indicate this. So to
combine the madvise breakout and the scan_slot breakout we drop the
lock and return SCAN_ANY_PROCESS.
>
>         if (*result =3D=3D SCAN_PTE_MAPPED_HUGEPAGE) {
>                 mmap_read_lock(mm);
>                 if (collapse_test_exit_or_disable(mm))
>                         goto breakouterloop;
>                 ...
>         }
>
> But now you're setting result =3D SCAN_ANY_PROCESS rather than
> SCAN_PTE_MAPPED_HUGEPAGE in this instance?
>
> You don't mention that you're changing this, or at least explicitly enoug=
h,
> the commit message should state that you're changing this and explain why
> it's ok.
I do state it but perhaps I need to be more verbose! I will update the
message to state we are also changing the result value too.
>
> This whole file is horrid, and it's kinda an aside, but I really wish we
> had some comment going through each of the scan_result cases and explaini=
ng
> what each one meant.
Yeah its been a huge pain to have to investigate what everything is
supposed to mean, and I often have to go searching to confirm things.
include/trace/events/huge_memory.h has a "good" summary of them
>
> Also I think:
>
>         return SCAN_ANY_PROCESS;
>
> Is better than:
>
>         result =3D SCAN_ANY_PROCESS;
>         goto end;
I agree! I will change that :)
>         ...
> end:
>         return result;
>
> > +                     }
> > +                     result =3D collapse_pte_mapped_thp(mm, addr,
> > +                                                      !cc->is_khugepag=
ed);
>
> Hm another change here, in the original code in collapse_scan_mm_slot()
> this is:
>
>         *result =3D collapse_pte_mapped_thp(mm,
>                 khugepaged_scan.address, false);
>
> Presumably collapse_scan_mm_slot() is only ever invoked with
> cc->is_khugepaged?
Correct, but the madvise_collapse calls this with true, hence why it
now depends on the is_khugepaged variable. No functional change here.
>
> Maybe worth adding a VM_WARN_ON_ONCE(!cc->is_khugepaged) at the top of
> collapse_scan_mm_slot() to assert this (and other places where your chang=
e
> assumes this to be the case).
Ok I will investigate doing that but it would take a huge mistake to
hit that assertion.
>
>
> > +                     if (result =3D=3D SCAN_PMD_MAPPED)
> > +                             result =3D SCAN_SUCCEED;
> > +                     mmap_read_unlock(mm);
> > +                     *mmap_locked =3D false;
> > +             }
> > +     } else {
> > +             result =3D collapse_scan_pmd(mm, vma, addr, mmap_locked, =
cc);
> > +     }
> > +     if (cc->is_khugepaged && result =3D=3D SCAN_SUCCEED)
> > +             ++khugepaged_pages_collapsed;
>
> Similarly, presumably because collapse_scan_mm_slot() only ever invoked
> khugepaged case this didn't have the cc->is_khugepaged check?
Correct, we only increment this when its khugepaged, so we need to
guard it so madvise collapse wont increment this.
>
> > +end:
> > +     return result;
> > +}
>
> There's a LOT of nesting going on here, I think we can simplify this a
> lot. If we make the change I noted above re: returning SCAN_ANY_PROCESS< =
we
> can move the end label up a bit and avoid a ton of nesting, e.g.:
Ah I like this much more, I will try to implement/test it.
>
> static int collapse_single_pmd(unsigned long addr,
>                                 struct vm_area_struct *vma, bool *mmap_lo=
cked,
>                                 struct collapse_control *cc)
> {
>         struct mm_struct *mm =3D vma->vm_mm;
>         struct file *file;
>         pgoff_t pgoff;
>         int result;
>
>         if (vma_is_anonymous(vma)) {
>                 result =3D collapse_scan_pmd(mm, vma, addr, mmap_locked, =
cc);
>                 goto end:
>         }
>
>         file =3D get_file(vma->vm_file);
>         pgoff =3D linear_page_index(vma, addr);
>
>         mmap_read_unlock(mm);
>         *mmap_locked =3D false;
>         result =3D collapse_scan_file(mm, addr, file, pgoff, cc);
>         fput(file);
>         if (result !=3D SCAN_PTE_MAPPED_HUGEPAGE)
>                 goto end;
>
>         mmap_read_lock(mm);
>         *mmap_locked =3D true;
>         if (collapse_test_exit_or_disable(mm)) {
>                 mmap_read_unlock(mm);
>                 *mmap_locked =3D false;
>                 return SCAN_ANY_PROCESS;
>         }
>         result =3D collapse_pte_mapped_thp(mm, addr, !cc->is_khugepaged);
>         if (result =3D=3D SCAN_PMD_MAPPED)
>                 result =3D SCAN_SUCCEED;
>         mmap_read_unlock(mm);
>         *mmap_locked =3D false;
>
> end:
>         if (cc->is_khugepaged && result =3D=3D SCAN_SUCCEED)
>                 ++khugepaged_pages_collapsed;
>
>         return result;
> }
>
> (untested, thrown together so do double check!)
>
> > +
> >  static unsigned int collapse_scan_mm_slot(unsigned int pages, int *res=
ult,
> >                                           struct collapse_control *cc)
> >       __releases(&khugepaged_mm_lock)
> > @@ -2455,34 +2499,9 @@ static unsigned int collapse_scan_mm_slot(unsign=
ed int pages, int *result,
> >                       VM_BUG_ON(khugepaged_scan.address < hstart ||
> >                                 khugepaged_scan.address + HPAGE_PMD_SIZ=
E >
> >                                 hend);
> > -                     if (!vma_is_anonymous(vma)) {
> > -                             struct file *file =3D get_file(vma->vm_fi=
le);
> > -                             pgoff_t pgoff =3D linear_page_index(vma,
> > -                                             khugepaged_scan.address);
> > -
> > -                             mmap_read_unlock(mm);
> > -                             mmap_locked =3D false;
> > -                             *result =3D collapse_scan_file(mm,
> > -                                     khugepaged_scan.address, file, pg=
off, cc);
> > -                             fput(file);
> > -                             if (*result =3D=3D SCAN_PTE_MAPPED_HUGEPA=
GE) {
> > -                                     mmap_read_lock(mm);
> > -                                     if (collapse_test_exit_or_disable=
(mm))
> > -                                             goto breakouterloop;
> > -                                     *result =3D collapse_pte_mapped_t=
hp(mm,
> > -                                             khugepaged_scan.address, =
false);
> > -                                     if (*result =3D=3D SCAN_PMD_MAPPE=
D)
> > -                                             *result =3D SCAN_SUCCEED;
> > -                                     mmap_read_unlock(mm);
> > -                             }
> > -                     } else {
> > -                             *result =3D collapse_scan_pmd(mm, vma,
> > -                                     khugepaged_scan.address, &mmap_lo=
cked, cc);
> > -                     }
> > -
> > -                     if (*result =3D=3D SCAN_SUCCEED)
> > -                             ++khugepaged_pages_collapsed;
> >
> > +                     *result =3D collapse_single_pmd(khugepaged_scan.a=
ddress,
> > +                                                     vma, &mmap_locked=
, cc);
> >                       /* move to next address */
> >                       khugepaged_scan.address +=3D HPAGE_PMD_SIZE;
> >                       progress +=3D HPAGE_PMD_NR;
> > @@ -2799,34 +2818,19 @@ int madvise_collapse(struct vm_area_struct *vma=
, unsigned long start,
> >               mmap_assert_locked(mm);
> >               memset(cc->node_load, 0, sizeof(cc->node_load));
> >               nodes_clear(cc->alloc_nmask);
> > -             if (!vma_is_anonymous(vma)) {
> > -                     struct file *file =3D get_file(vma->vm_file);
> > -                     pgoff_t pgoff =3D linear_page_index(vma, addr);
> >
> > -                     mmap_read_unlock(mm);
> > -                     mmap_locked =3D false;
> > -                     result =3D collapse_scan_file(mm, addr, file, pgo=
ff, cc);
> > -                     fput(file);
> > -             } else {
> > -                     result =3D collapse_scan_pmd(mm, vma, addr,
> > -                                                &mmap_locked, cc);
> > -             }
> > +             result =3D collapse_single_pmd(addr, vma, &mmap_locked, c=
c);
> > +
>
> Ack the fact you noted the behaviour change re:
> collapse_test_exit_or_disable() that seems fine.
>
> >               if (!mmap_locked)
> >                       *lock_dropped =3D true;
> >
> > -handle_result:
> >               switch (result) {
> >               case SCAN_SUCCEED:
> >               case SCAN_PMD_MAPPED:
> >                       ++thps;
> >                       break;
> > -             case SCAN_PTE_MAPPED_HUGEPAGE:
> > -                     BUG_ON(mmap_locked);
> > -                     mmap_read_lock(mm);
> > -                     result =3D collapse_pte_mapped_thp(mm, addr, true=
);
> > -                     mmap_read_unlock(mm);
> > -                     goto handle_result;
>
> One thing that differs with new code her is we filter SCAN_PMD_MAPPED to
> SCAN_SUCCEED.
>
> I was about to say 'but ++thps - is this correct' but now I realise this
> was looping back on itself with a goto to do just that... ugh ye gads.
>
> Anwyay that's fine because it doesn't change anything.
>
> Re: switch statement in general, again would be good to always have each
> scan possibility in switch statements, but perhaps given so many not
> practical :)

Yeah it may be worth investigating for future changes I have for
khugepaged (including the new switch statement I implement later and
you commented on)
>
> (that way the compiler warns on missing a newly added enum val)
>
> >               /* Whitelisted set of results where continuing OK */
> > +             case SCAN_PTE_MAPPED_HUGEPAGE:
> >               case SCAN_PMD_NULL:
> >               case SCAN_PTE_NON_PRESENT:
> >               case SCAN_PTE_UFFD_WP:
> > --

Thanks for the review :)

-- Nico
> > 2.50.1
> >
>

