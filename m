Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A79A214801
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078773; cv=none; b=R+S4wu4ro65nRNJPAkzPoQSKD6J0gwwLbDTWaROPEiBihN5V1hAfv/3d/MY0fVR+mHeR1PDaaV9fPXVB1HgvktiDO4wHqM+a1kPavUKO1Ku3ZCcE+jNcKSdQoHEt9ZcfzGt8a/ao4HGXXrDaDt+9Gv6GvbjG9nHNF900zImx88k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078773; c=relaxed/simple;
	bh=i7InEJo0QoqguH59MoJBCAg3zPEFvCN7RFgwHaov8JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAg8bsBoeK2WlzhaGDWNrycxEVdWgB4ik3oVBFWicJTiWq6obRI+eyDHQ9Atkcjcrvp24+4oVhzlpBHG5Zxl3wHjAdMM8PONl7qlFPvF1Rf4SwyexKDg6vpDW09kzcCBpXaMF/MZyOYzgpwDcBOeTjqy8C4kJRlQpcwTq9pCeR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4k9cEtF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4k9cEtF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740078770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=teGbFbQCAgK9Vtqm/aL+SoxWoy7ReGtoP+ktYWo+3GU=;
	b=X4k9cEtFaFCiyL5kbjvAv5mHxqphPVuXeTqTBem2gvQ8wRxiEw4nto3FZo7k7uSJJSsf9b
	+DYcyPyCN/GSSl9m6S4YAKN87pYl2hezFo35e5y28t7XTFTgZqNNyB9hT9KjAz7mCEbdhn
	YY46zqzKglBll7BmKzFcqb3JBu14ptg=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-kJOm83MOPMq-gNqzBlcIHg-1; Thu, 20 Feb 2025 14:12:49 -0500
X-MC-Unique: kJOm83MOPMq-gNqzBlcIHg-1
X-Mimecast-MFC-AGG-ID: kJOm83MOPMq-gNqzBlcIHg_1740078769
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e5dddac2c56so1772197276.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:12:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740078769; x=1740683569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teGbFbQCAgK9Vtqm/aL+SoxWoy7ReGtoP+ktYWo+3GU=;
        b=ErLTpotslGDsBJqeSXgS3sN32MhYXMQiuhx0Hz1WEPulJ7uVpfllXz+jOrIKtVrH3+
         /boCUiHWX2/ljtn17U7e0lWEAJHSsnaru3rAO+LDjl6wSJQOMSUsVjVAzTnJRjoNLUhU
         s9uNfvHZ4v2X32m8Z61wkNdFxsmMqlK7kpBXd4tGBLD1Wq86ZJOoYpHj3DSbMnvXHqyH
         YgRYSgxNQSiAQppxh9Djkk+Bpyl1yKMb5SFL7gVwByexMLh5CtMtOBzyW2AVoegNkLNk
         arNHyjaersZ6Im5wCv78QzdI9P+5pHMB3i/3qQQX5ttHnAf5/DQwVUqWxys8Z1mAjrxq
         fxow==
X-Forwarded-Encrypted: i=1; AJvYcCXEZGA00kGPUmqV2MciLhKrcBAeCrHkKsqaX5F65YgVhMhwkz53OjUERsF4SQWJvcmM1ZJyMGude9MgoY1mZboJuqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY9sSgDgaygSq4TUfTasvCr+tImDbmLR6dzIbo68NGK3BdBYi3
	6wPDmP+ttsFoIkaZHUBObceAc22+hr6xgYFpBJ6ANNGIhFAxLF1jkrB6cG5RES0KfZ+rpo+SVcT
	ntZ6ixboi0nASwiLU41raLk9yzqOrXBWcdqI/KOeo9phUe8U/Pppv8LfVZeTu/aQ0pJZDYvTurV
	p2dXQAuhHcdp1F/fIDsAfUGhZYmsGpXC/pw+xDJPHCl8MH
X-Gm-Gg: ASbGncuRAtgOylANDpJyzCKHQRovYblD5W7Arum5GL97bOSbTC5pwynbg5Q9FJBVzZ3
	cK5DHu1lGLTaeY6VIkZsEV2uqxNN5PPI4Rwxne1tSm48iGaK/ADtETDpPCnlyRLkfFkZy/LHIDQ
	A=
X-Received: by 2002:a05:6902:c0c:b0:e5d:bcc5:c33a with SMTP id 3f1490d57ef6-e5e246965b3mr389601276.43.1740078768435;
        Thu, 20 Feb 2025 11:12:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKEzMpzqKFnmUHDbmFHHx0POOMA7K9PRdfB6UTYqZuNiF8zvZUKre8zCYsmr6u9qJNJU8ik4l40TwWMaqcjOA=
X-Received: by 2002:a05:6902:c0c:b0:e5d:bcc5:c33a with SMTP id
 3f1490d57ef6-e5e246965b3mr389564276.43.1740078767960; Thu, 20 Feb 2025
 11:12:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211003028.213461-1-npache@redhat.com> <8a37f99b-f207-4688-bc90-7f8e6900e29d@arm.com>
 <CAA1CXcDHCesahmZs21rVP=xai9C=-TpK_7=_8DMqxGJRJzyKSA@mail.gmail.com> <867280bf-2ba1-4e83-8e16-9d93e1c41e08@arm.com>
In-Reply-To: <867280bf-2ba1-4e83-8e16-9d93e1c41e08@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 20 Feb 2025 12:12:22 -0700
X-Gm-Features: AWEUYZn3bvApq5wnJVjitUP2TTAeZiCSPYc4qenbmcEy35s_FKOXcEISpBrGRok
Message-ID: <CAA1CXcDLU-ZQJiF2pXH_=EtqXcqaZKLS+gJ7SGtTq7+2HA47QA@mail.gmail.com>
Subject: Re: [RFC v2 0/9] khugepaged: mTHP support
To: Dev Jain <dev.jain@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org, 
	vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, 
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org, jack@suse.cz, 
	srivatsa@csail.mit.edu, haowenchao22@gmail.com, hughd@google.com, 
	aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com, 
	ioworker0@gmail.com, wangkefeng.wang@huawei.com, ziy@nvidia.com, 
	jglisse@google.com, surenb@google.com, vishal.moola@gmail.com, 
	zokeefe@google.com, zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 
	21cnbao@gmail.com, willy@infradead.org, kirill.shutemov@linux.intel.com, 
	david@redhat.com, aarcange@redhat.com, raquini@redhat.com, 
	sunnanyong@huawei.com, usamaarif642@gmail.com, audra@redhat.com, 
	akpm@linux-foundation.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, tiwai@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ob-m5oIFT9jVTzujGZnFV4alpjTyyzaWI9XByE-9qKs_1740078769
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 2:01=E2=80=AFAM Dev Jain <dev.jain@arm.com> wrote:
>
>
>
> On 19/02/25 4:00 am, Nico Pache wrote:
> > On Tue, Feb 18, 2025 at 9:07=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 11/02/2025 00:30, Nico Pache wrote:
> >>> The following series provides khugepaged and madvise collapse with th=
e
> >>> capability to collapse regions to mTHPs.
> >>>
> >>> To achieve this we generalize the khugepaged functions to no longer d=
epend
> >>> on PMD_ORDER. Then during the PMD scan, we keep track of chunks of pa=
ges
> >>> (defined by MTHP_MIN_ORDER) that are utilized. This info is tracked
> >>> using a bitmap. After the PMD scan is done, we do binary recursion on=
 the
> >>> bitmap to find the optimal mTHP sizes for the PMD range. The restrict=
ion
> >>> on max_ptes_none is removed during the scan, to make sure we account =
for
> >>> the whole PMD range. max_ptes_none will be scaled by the attempted co=
llapse
> >>> order to determine how full a THP must be to be eligible. If a mTHP c=
ollapse
> >>> is attempted, but contains swapped out, or shared pages, we dont perf=
orm the
> >>> collapse.
> >>>
> >>> With the default max_ptes_none=3D511, the code should keep its most o=
f its
> >>> original behavior. To exercise mTHP collapse we need to set max_ptes_=
none<=3D255.
> >>> With max_ptes_none > HPAGE_PMD_NR/2 you will experience collapse "cre=
ep" and
> >>
> >> nit: I think you mean "max_ptes_none >=3D HPAGE_PMD_NR/2" (greater or =
*equal*)?
> >> This is making my head hurt, but I *think* I agree with you that if
> >> max_ptes_none is less than half of the number of ptes in a pmd, then c=
reep
> >> doesn't happen.
> > Haha yea the compressed bitmap does not make the math super easy to
> > follow, but i'm glad we arrived at the same conclusion :)
> >>
> >> To make sure I've understood;
> >>
> >>   - to collapse to 16K, you would need >=3D3 out of 4 PTEs to be prese=
nt
> >>   - to collapse to 32K, you would need >=3D5 out of 8 PTEs to be prese=
nt
> >>   - to collapse to 64K, you would need >=3D9 out of 16 PTEs to be pres=
ent
> >>   - ...
> >>
> >> So if we start with 3 present PTEs in a 16K area, we collapse to 16K a=
nd now
> >> have 4 PTEs in a 32K area which is insufficient to collapse to 32K.
> >>
> >> Sounds good to me!
> > Great! Another easy way to think about it is, with max_ptes_none =3D
> > HPAGE_PMD_NR/2, a collapse will double the size, and we only need half
> > for it to collapse again. Each size is 2x the last, so if we hit one
> > collapse, it will be eligible again next round.
>
> Please someone correct me if I am wrong.
>

max_ptes_none =3D 204
scaled_none =3D (204 >> 9 - 3) =3D ~3.1
so 4 pages need to be available in each chunk for the bit to be set, not 5.

at 204 the bitmap check is
512 - 1 - 204 =3D 307
(PMD) 307 >> 3 =3D 38
(1024k) 307 >> 4 =3D 19
(512k) 307 >> 5 =3D 9
(256k) 307 >> 6 =3D 4

> Consider this; you are collapsing a 256K folio. =3D> #PTEs =3D 256K/4K =
=3D 64
> =3D> #chunks =3D 64 / 8 =3D 8.
>
> Let the PTE state within the chunks be as follows:
>
> Chunk 0: < 5 filled   Chunk 1: 5 filled   Chunk 2: 5 filled   Chunk 3: 5
> filled
>
> Chunk 4: 5 filled   Chunk 5: < 5 filled   Chunk 6: < 5 filled   Chunk 7:
> < 5 filled
>
> Consider max_ptes_none =3D 40% (512 * 40 / 100 =3D 204.8 (round down) =3D=
 204
> < HPAGE_PMD_NR/2).
> =3D> To collapse we need at least 60% of the PTEs filled.
>
> Your algorithm marks chunks in the bitmap if 60% of the chunk is filled.
> Then, if the number of chunks set is greater than 60%, then we will
> collapse.
>
> Chunk 0 will be marked zero because less than 5 PTEs are filled =3D>
> percentage filled <=3D 50%
>
> Right now the state is
> 0111 1000
> where the indices are the chunk numbers.
> Since #1s =3D 4 =3D> percent filled =3D 4/8 * 100 =3D 50%, 256K folio col=
lapse
> won't happen.
>
> For the first 4 chunks, the percent filled is 75%.  So the state becomes
> 1111 1000
> after 128K collapse, and now 256K collapse will happen.
>
> Either I got this correct, or I do not understand the utility of
> maintaining chunks :) What you are doing is what I am doing except that
> my chunk size =3D 1.

Ignoring all the math, and just going off the 0111 1000
We do "creep", but its not the same type of "creep" we've been
describing. The collapse in the first half will allow the collapse in
order++ to collapse but it stops there and doesnt keep getting
promoted to a PMD size. That is unless the adjacent 256k also has some
bits set, then it can collapse to 512k. So I guess we still can creep,
but its way less aggressive and only when there is actual memory being
utilized in the adjacent chunk, so it's not like we are creating a
huge waste.


>
> >>
> >>> constantly promote mTHPs to the next available size.
> >>>
> >>> Patch 1:     Some refactoring to combine madvise_collapse and khugepa=
ged
> >>> Patch 2:     Refactor/rename hpage_collapse
> >>> Patch 3-5:   Generalize khugepaged functions for arbitrary orders
> >>> Patch 6-9:   The mTHP patches
> >>>
> >>> ---------
> >>>   Testing
> >>> ---------
> >>> - Built for x86_64, aarch64, ppc64le, and s390x
> >>> - selftests mm
> >>> - I created a test script that I used to push khugepaged to its limit=
s while
> >>>     monitoring a number of stats and tracepoints. The code is availab=
le
> >>>     here[1] (Run in legacy mode for these changes and set mthp sizes =
to inherit)
> >>>     The summary from my testings was that there was no significant re=
gression
> >>>     noticed through this test. In some cases my changes had better co=
llapse
> >>>     latencies, and was able to scan more pages in the same amount of =
time/work,
> >>>     but for the most part the results were consistant.
> >>> - redis testing. I tested these changes along with my defer changes
> >>>    (see followup post for more details).
> >>> - some basic testing on 64k page size.
> >>> - lots of general use. These changes have been running in my VM for s=
ome time.
> >>>
> >>> Changes since V1 [2]:
> >>> - Minor bug fixes discovered during review and testing
> >>> - removed dynamic allocations for bitmaps, and made them stack based
> >>> - Adjusted bitmap offset from u8 to u16 to support 64k pagesize.
> >>> - Updated trace events to include collapsing order info.
> >>> - Scaled max_ptes_none by order rather than scaling to a 0-100 scale.
> >>> - No longer require a chunk to be fully utilized before setting the b=
it. Use
> >>>     the same max_ptes_none scaling principle to achieve this.
> >>> - Skip mTHP collapse that requires swapin or shared handling. This he=
lps prevent
> >>>     some of the "creep" that was discovered in v1.
> >>>
> >>> [1] - https://gitlab.com/npache/khugepaged_mthp_test
> >>> [2] - https://lore.kernel.org/lkml/20250108233128.14484-1-npache@redh=
at.com/
> >>>
> >>> Nico Pache (9):
> >>>    introduce khugepaged_collapse_single_pmd to unify khugepaged and
> >>>      madvise_collapse
> >>>    khugepaged: rename hpage_collapse_* to khugepaged_*
> >>>    khugepaged: generalize hugepage_vma_revalidate for mTHP support
> >>>    khugepaged: generalize alloc_charge_folio for mTHP support
> >>>    khugepaged: generalize __collapse_huge_page_* for mTHP support
> >>>    khugepaged: introduce khugepaged_scan_bitmap for mTHP support
> >>>    khugepaged: add mTHP support
> >>>    khugepaged: improve tracepoints for mTHP orders
> >>>    khugepaged: skip collapsing mTHP to smaller orders
> >>>
> >>>   include/linux/khugepaged.h         |   4 +
> >>>   include/trace/events/huge_memory.h |  34 ++-
> >>>   mm/khugepaged.c                    | 422 +++++++++++++++++++-------=
---
> >>>   3 files changed, 306 insertions(+), 154 deletions(-)
> >>>
> >>
> >
> >
>

