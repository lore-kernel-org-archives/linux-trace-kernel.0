Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC74D33DECA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765927648; cv=none; b=VH68wbayaNcKbVYnHdltPO06/IytHwpSQptYGKHvp5Mj59k59cEWvk9BgnnKzUqt2EEG0vaBid1z1UbJlxfqkc2gzHPNXnVf3Vuy9glBZj0KDWS6urVK4coePQvnqjraCE6pEN4InHXiKr0suSg+YV97bDFfID5X7PdliAxwCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765927648; c=relaxed/simple;
	bh=S80CTe8C8G4EZZfdKz3GrrAxw7VwbVcuVBJSMn//kP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rro1dLLI5E6IVU7t8h9QPB3hqgiyyyGBp2Q1UyOv7RCUnP+hJuvj7G4dv8eI36UfhvN1r3hOjIUnX3c67ZWzGV4fX5HIuLtVu94tuo5tJ8lCd3UGlubEACa7qC+eWz5FMdZgc5aPiq/J+lGj+09oXkmCcLIzyatI8EceMtBySdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WbpMveA0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbpMveA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765927645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EKXCsKPTv+XkNeXWtY2Ss72qFYFJMdd6YX+r4JT7Hy0=;
	b=WbpMveA0v7vkkZvqw42EPc1C4Cr/AdMq6PIhRYiQacn6S3sKZaayzoYiJNws8jR8xsfxaf
	n4himtxnOR24r7AGFnrw6Tc/w7jG2/zE8W/eNapMsTjn2iZk2RP8DOCScWitV9OHWh+EZz
	qUhJ83UiP6BDyg7jE5Qn4YjHUHcb0AQ=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-ZfohgMPIPsqPf3i4wc36WQ-1; Tue, 16 Dec 2025 18:27:24 -0500
X-MC-Unique: ZfohgMPIPsqPf3i4wc36WQ-1
X-Mimecast-MFC-AGG-ID: ZfohgMPIPsqPf3i4wc36WQ_1765927644
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-645528427b4so8470647d50.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 15:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765927644; x=1766532444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EKXCsKPTv+XkNeXWtY2Ss72qFYFJMdd6YX+r4JT7Hy0=;
        b=YNjn1SfM2efCRhLI8NDeM3lFhCjymOjBQsb2YiXHOPfecYFA7GTxe958pqLjYkHTIj
         3wEtRgCszSjIcURR7V7VFxn7ncycAGSe+d09aQ1raCzk7l2u1K6Sh671zQxTX5FgvB40
         jkaaAfkxDPzqcnPWY7MlzXis33TYNr9i3PMTgpBa1E/3DZQP0s27x7lGtUKg3tehW3jX
         6fMxHotB2reaZXPTcPyIIHpqv6huoq06BeAT3aGMwo9hn4A+JgLc2h2RGXloGxgSsL5A
         KrfztxMDGyOY4VJ37zM1sczHAymfIuPrV7U3jkm9vfgA8ryiDITDPSthlb6v4hSe0mk2
         Jd9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV29kr2AzD4tccIwocDlybvDecY8cMrinLyg9WiFSQo9KcgZnMFsRXdd7pWr9JotUI6EnI/YjVku1CeJqn3D1Ikh0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlptZ73o0iXEZ/AWhYvvhKQupDqLngBnfCzt1bp+f8GNLGW+6P
	eoryawRaMbiRdJDHkYAXSpNiHkzwiKglZgb/00C1fVbRa/Saoz0SnLyeVbjDwdIDtPpNbHn+xa9
	U8u70YEIQbneKEfEBwfmqwbkd+nCrXV9YLPwQWawKhcAvs6Q+pqhNpqvBqgwatjt1zXx57K4m86
	8PqMpYiMt2Xw1y60HrEP7wscs8O1fhReBN9zsospAdrul5EA2S
X-Gm-Gg: AY/fxX5FF6aLpLQBm2iUWeYRKJzk7HfhyM7BgxZ/BEJgLfPYLd7HfTlmNIa9ilOl5vZ
	461DGsFBhQBWUNHJFv0HeR803W3KR3SKphoKqcz96kDS8+QhlZ9IqMhrRniTqEedVk8IqO+Dm15
	6bqXUJmxT7VKl166GD0ELAb2L/KT0fGH6Np9BT4yYjupJvZ8eo1dmxA3oXf/x6w77vaIc=
X-Received: by 2002:a05:690e:1505:b0:644:60d9:8679 with SMTP id 956f58d0204a3-645556807a8mr10997288d50.94.1765927643892;
        Tue, 16 Dec 2025 15:27:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGPptQk13QsvmOa5ZHpogOK1FLJvsnDQ3rrdzWxnJedT+7pDWOuGlSfHFv7sLII7QbkA9GW4MowA4H4/Vq3XI=
X-Received: by 2002:a05:690e:1505:b0:644:60d9:8679 with SMTP id
 956f58d0204a3-645556807a8mr10997248d50.94.1765927643468; Tue, 16 Dec 2025
 15:27:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201174627.23295-1-npache@redhat.com> <20251201174627.23295-8-npache@redhat.com>
 <95b1403f-3ddb-43ff-b481-2ecc6ab8352f@linux.alibaba.com>
In-Reply-To: <95b1403f-3ddb-43ff-b481-2ecc6ab8352f@linux.alibaba.com>
From: Nico Pache <npache@redhat.com>
Date: Tue, 16 Dec 2025 16:26:57 -0700
X-Gm-Features: AQt7F2p-rngtJz0og9IaebCiPEhh7WjpdRAgI0DfLNPmmyQ8daD3M_WcJSO7CnI
Message-ID: <CAA1CXcCtp2OwTmm-1EYUpOhsey1sv7CRFu8454m16C=k9iaN6g@mail.gmail.com>
Subject: Re: [PATCH v13 mm-new 07/16] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com, 
	ziy@nvidia.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com, 
	sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, kas@kernel.org, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pHFvsGeIs1K0DXu70AgEITLWycqOeurg0hYyL7B1_1Y_1765927644
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 1:12=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Hi Nico,

Hi Baolin! Thanks for testing :)

Did you happen to test with the changes I asked Andrew to append to
this commit?

Either way, I think your fixup makes more sense than mine.

Cheers,
-- Nico


>
> On 2025/12/2 01:46, Nico Pache wrote:
> > The current mechanism for determining mTHP collapse scales the
> > khugepaged_max_ptes_none value based on the target order. This
> > introduces an undesirable feedback loop, or "creep", when max_ptes_none
> > is set to a value greater than HPAGE_PMD_NR / 2.
> >
> > With this configuration, a successful collapse to order N will populate
> > enough pages to satisfy the collapse condition on order N+1 on the next
> > scan. This leads to unnecessary work and memory churn.
> >
> > To fix this issue introduce a helper function that will limit mTHP
> > collapse support to two max_ptes_none values, 0 and HPAGE_PMD_NR - 1.
> > This effectively supports two modes:
> >
> > - max_ptes_none=3D0: never introduce new none-pages for mTHP collapse.
> > - max_ptes_none=3D511 (on 4k pagesz): Always collapse to the highest
> >    available mTHP order.
> >
> > This removes the possiblilty of "creep", while not modifying any uAPI
> > expectations. A warning will be emitted if any non-supported
> > max_ptes_none value is configured with mTHP enabled.
> >
> > The limits can be ignored by passing full_scan=3Dtrue, this is useful f=
or
> > madvise_collapse (which ignores limits), or in the case of
> > collapse_scan_pmd(), allows the full PMD to be scanned when mTHP
> > collapse is available.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   mm/khugepaged.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 42 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 8dab49c53128..f425238d5d4f 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -463,6 +463,44 @@ void __khugepaged_enter(struct mm_struct *mm)
> >               wake_up_interruptible(&khugepaged_wait);
> >   }
> >
> > +/**
> > + * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for c=
ollapse
> > + * @order: The folio order being collapsed to
> > + * @full_scan: Whether this is a full scan (ignore limits)
> > + *
> > + * For madvise-triggered collapses (full_scan=3Dtrue), all limits are =
bypassed
> > + * and allow up to HPAGE_PMD_NR - 1 empty PTEs.
> > + *
> > + * For PMD-sized collapses (order =3D=3D HPAGE_PMD_ORDER), use the con=
figured
> > + * khugepaged_max_ptes_none value.
> > + *
> > + * For mTHP collapses, we currently only support khugepaged_max_pte_no=
ne values
> > + * of 0 or (HPAGE_PMD_NR - 1). Any other value will emit a warning and=
 no mTHP
> > + * collapse will be attempted
> > + *
> > + * Return: Maximum number of empty PTEs allowed for the collapse opera=
tion
> > + */
> > +static unsigned int collapse_max_ptes_none(unsigned int order, bool fu=
ll_scan)
> > +{
> > +     /* ignore max_ptes_none limits */
> > +     if (full_scan)
> > +             return HPAGE_PMD_NR - 1;
> > +
> > +     if (!is_mthp_order(order))
> > +             return khugepaged_max_ptes_none;
> > +
> > +     /* Zero/non-present collapse disabled. */
> > +     if (!khugepaged_max_ptes_none)
> > +             return 0;
> > +
> > +     if (khugepaged_max_ptes_none =3D=3D HPAGE_PMD_NR - 1)
> > +             return (1 << order) - 1;
> > +
> > +     pr_warn_once("mTHP collapse only supports max_ptes_none values of=
 0 or %d\n",
> > +                   HPAGE_PMD_NR - 1);
> > +     return -EINVAL;
> > +}
> > +
> >   void khugepaged_enter_vma(struct vm_area_struct *vma,
> >                         vm_flags_t vm_flags)
> >   {
> > @@ -550,7 +588,10 @@ static int __collapse_huge_page_isolate(struct vm_=
area_struct *vma,
> >       pte_t *_pte;
> >       int none_or_zero =3D 0, shared =3D 0, result =3D SCAN_FAIL, refer=
enced =3D 0;
> >       const unsigned long nr_pages =3D 1UL << order;
> > -     int max_ptes_none =3D khugepaged_max_ptes_none >> (HPAGE_PMD_ORDE=
R - order);
> > +     int max_ptes_none =3D collapse_max_ptes_none(order, !cc->is_khuge=
paged);
> > +
> > +     if (max_ptes_none =3D=3D -EINVAL)
> > +             goto out;
>
> After testing your patchset, I hit the following crash. The reason is
> that when 'max_ptes_none' is -EINVAL here, it shouldn't goto out to call
> release_pte_pages(), because the '_pte' hasn't been initialized at this
> point, and there's no need to release folios either.
>
> After applying the fix below, the crash issue is resolved. I'm not sure
> whether Andrew will help fix this or if you will send a new version to
> address this issue.
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 8cffaf59ced8..2e8171a6d7df 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -646,7 +646,7 @@ static int __collapse_huge_page_isolate(struct
> vm_area_struct *vma,
>          int max_ptes_none =3D collapse_max_ptes_none(order,
> !cc->is_khugepaged);
>
>          if (max_ptes_none =3D=3D -EINVAL)
> -               goto out;
> +               return result;
>
>          for (_pte =3D pte; _pte < pte + nr_pages;
>               _pte++, addr +=3D PAGE_SIZE) {
>
> "
> [  565.319345] Unable to handle kernel paging request at virtual address
> fffffffffffffffa
> .......
> [  565.319409] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000001f8549=
a000
> [  565.319416] [fffffffffffffffa] pgd=3D0000001f85f2a403,
> p4d=3D0000001f85f2a403, pud=3D0000001f85f2b403, pmd=3D0000000000000000
> [  565.319427] Internal error: Oops: 0000000096000006 [#1]  SMP
> .......
> [  565.326733] pc : release_pte_pages+0x68/0x178
> [  565.326960] lr : __collapse_huge_page_isolate+0xc0/0x748
> [  565.327232] sp : ffff800083593910
> .......
> [  565.331476] Call trace:
> [  565.331664]  release_pte_pages+0x68/0x178 (P)
> [  565.331940]  __collapse_huge_page_isolate+0xc0/0x748
> [  565.332249]  collapse_huge_page+0x4cc/0xa70
> [  565.332510]  mthp_collapse+0x254/0x2a8
> [  565.332754]  collapse_scan_pmd+0x5a0/0x6d8
> [  565.333010]  collapse_single_pmd+0x214/0x288
> [  565.333275]  collapse_scan_mm_slot.constprop.0+0x2ac/0x460
> [  565.333617]  khugepaged+0x204/0x2c8
> [  565.333992]  kthread+0xf8/0x110
> [  565.334368]  ret_from_fork+0x10/0x20
> "
>
> >
> >       for (_pte =3D pte; _pte < pte + nr_pages;
> >            _pte++, addr +=3D PAGE_SIZE) {
>

