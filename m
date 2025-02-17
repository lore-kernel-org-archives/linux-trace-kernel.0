Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEF1187858
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819736; cv=none; b=jBYscPkTclsyzdqXr7MHqbi8sYcY+6JaSXvfFNMR+Qj5z8oacnqiuGM9qEU02OHa3Awk2RthwyC2kZrCDzAkFtoBnNo+k0M4vGLTN6k2NV/fLgKdIqRyAZOg9wNqSNRcioCRcEiVvLtaRcAtzPmGUGJe3myqxntBeDADGywYdzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819736; c=relaxed/simple;
	bh=AUnmC6HvnePuquPnarMTCt2pqh/jO60NTPH2bwJFhKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5tpQYMH1q3a2e31WGWcNaE9gYF3u+6tsi2y2acL36/ARHCJ8UDSVx4xOEPp078ASottTv2jAjyxKQKlWKVSlrrMT7ppBR8QltRNPz1A2I3TUvKnZ71Uf+wi+OAPP5oG6Ih//cZnWN5HhGTvSrtsneAxSjq1Rk7bPKPigch5pOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8hXvQvN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8hXvQvN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739819733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EvpXst+rZfDGL4PzrI37Z2I4SolqEpZglIJqp2fRh/c=;
	b=F8hXvQvNf3s+7znR5NOW5zDWtL76wmw6kTtsqI8b6i5v2dNiCIus4NnVvAtZJmu67H0FQf
	XYCPwnHvsdV2ipOxGNJNtPEqqDafpoHbP0jmszAUrlU+TrFWcQixhMiCgeJCyDxPyo9v5S
	mkd9QYBJBMy/13fQACRrh1E2IWBYUU4=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-PggqymndMSiOEmVgw7aJhA-1; Mon, 17 Feb 2025 14:15:32 -0500
X-MC-Unique: PggqymndMSiOEmVgw7aJhA-1
X-Mimecast-MFC-AGG-ID: PggqymndMSiOEmVgw7aJhA_1739819732
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e572cd106f7so5904635276.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739819732; x=1740424532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvpXst+rZfDGL4PzrI37Z2I4SolqEpZglIJqp2fRh/c=;
        b=P/FLi+hffPnIGNCgTxgzYEtMWeNtKXsD9iawMkfKcymGrXbI5dkRWgYWWf4bwlcjnx
         WGYQxUCFAa/JJhKSmd9meG7dwFSXdmVTAoKSlvuEkCKwx9TQxrtEe1tv4pxRSecpGiZG
         G7Z7myaItyjBDR0ORZv9erWC32Er71sQX35w+4ZtKkDT0/mhiShSC/h0koVpfV3psIfe
         I1JwtM2UgUWV/CJTimogmPVhkPyVsOK9xmmcfrh2uOFabyyCON9V9CZGOWK/TMEeQ5d0
         KrWdfatogfCmGv2XEdPEFzLakM8GA2xkaRr4ucWCyizBtAj17iPTggX6nQ9MSB2Jd4+t
         rJLA==
X-Forwarded-Encrypted: i=1; AJvYcCVFfOb5mG8h0yB4yNa5sA+PACFF86mleVjA4oRqm7uljZCduNeB8z5xpxybU8Zsr9VkSQWSA/q2tltDpushuGFKqo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjhnSmQKkklKXj2VlhTUm9OOkFebPmYuXy64JhMuRzY2PARfiV
	lkipBZBkb2ZK38vsk8CxOd7IceAnSQa37pXbCHg0V4YMxVdLvrp04itD2pA4eExMmXBk+v/0GZU
	a+c5PIvCs4Ex8qU2APoUFRi6g6Uz6t30+yj9VpIBVsEH/qz1rBBovJqxTdChbevZdFHUShWGNGA
	GRUp1GKvBe7qo/Tm2O6GIfWO0Urek5uMoOcihtwnbCSlPb
X-Gm-Gg: ASbGncuSlFjXNvTlZg+RwM8S1FrKurepJrJMtocRH70IXJtvfNkjpyE06IFXFisuius
	vEZ/IUThSKExoddisHCNUZqHPg5NQE0y05bjQwYN0QDGUd4Dx/PWBqsGum/qfu0XrRyth5CUlqe
	A=
X-Received: by 2002:a05:6902:3382:b0:e5d:d514:3b60 with SMTP id 3f1490d57ef6-e5dd5143c25mr6693746276.45.1739819731960;
        Mon, 17 Feb 2025 11:15:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHT4paiemZ86vXndA+HkGnhaF9K+NfVYOxhyRGV98QsqoalKgLZxySKwL1zpfSC8bFGomuPzxpURm7mvoEjuk=
X-Received: by 2002:a05:6902:3382:b0:e5d:d514:3b60 with SMTP id
 3f1490d57ef6-e5dd5143c25mr6693708276.45.1739819731547; Mon, 17 Feb 2025
 11:15:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211003028.213461-1-npache@redhat.com> <fae7019f-517f-4ad2-a5c2-2e839e5087ce@arm.com>
In-Reply-To: <fae7019f-517f-4ad2-a5c2-2e839e5087ce@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 17 Feb 2025 12:15:05 -0700
X-Gm-Features: AWEUYZk14MsChO_5ztfy8rk35BtlvoPYNhFflLefA3-KjLio3vEZ3MOlgL-43Do
Message-ID: <CAA1CXcDiGLD=dZpFRyAuz4TLrVZZYGp=u7=Z9Q+g9RXbf-s2nA@mail.gmail.com>
Subject: Re: [RFC v2 0/9] khugepaged: mTHP support
To: Dev Jain <dev.jain@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryan.roberts@arm.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, 
	apopple@nvidia.com, dave.hansen@linux.intel.com, will@kernel.org, 
	baohua@kernel.org, jack@suse.cz, srivatsa@csail.mit.edu, 
	haowenchao22@gmail.com, hughd@google.com, aneesh.kumar@kernel.org, 
	yang@os.amperecomputing.com, peterx@redhat.com, ioworker0@gmail.com, 
	wangkefeng.wang@huawei.com, ziy@nvidia.com, jglisse@google.com, 
	surenb@google.com, vishal.moola@gmail.com, zokeefe@google.com, 
	zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 21cnbao@gmail.com, 
	willy@infradead.org, kirill.shutemov@linux.intel.com, david@redhat.com, 
	aarcange@redhat.com, raquini@redhat.com, sunnanyong@huawei.com, 
	usamaarif642@gmail.com, audra@redhat.com, akpm@linux-foundation.org, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, tiwai@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 46ae-R8Pe5DtDFoaTlF_rNvMpKzqPNAGfHHUEq0k2q0_1739819732
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 11:39=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
>
>
> On 11/02/25 6:00 am, Nico Pache wrote:
> > The following series provides khugepaged and madvise collapse with the
> > capability to collapse regions to mTHPs.
> >
> > To achieve this we generalize the khugepaged functions to no longer dep=
end
> > on PMD_ORDER. Then during the PMD scan, we keep track of chunks of page=
s
> > (defined by MTHP_MIN_ORDER) that are utilized. This info is tracked
> > using a bitmap. After the PMD scan is done, we do binary recursion on t=
he
> > bitmap to find the optimal mTHP sizes for the PMD range. The restrictio=
n
> > on max_ptes_none is removed during the scan, to make sure we account fo=
r
> > the whole PMD range. max_ptes_none will be scaled by the attempted coll=
apse
> > order to determine how full a THP must be to be eligible. If a mTHP col=
lapse
> > is attempted, but contains swapped out, or shared pages, we dont perfor=
m the
> > collapse.
> >
> > With the default max_ptes_none=3D511, the code should keep its most of =
its
> > original behavior. To exercise mTHP collapse we need to set max_ptes_no=
ne<=3D255.
> > With max_ptes_none > HPAGE_PMD_NR/2 you will experience collapse "creep=
" and
> > constantly promote mTHPs to the next available size.
>
> How does creep stop when max_ptes_none <=3D 255?

think of a 512kB mTHP region that is half utilized (but not
collapsed), and max_ptes_none =3D 255.

threshold_bits =3D (HPAGE_PMD_NR - khugepaged_max_ptes_none - 1)
                               >> (HPAGE_PMD_ORDER - state.order);

threshold_bits =3D 512 - 1 - 255 >> 9 - 4 =3D 256 >> 5 =3D 8

So >8 bits must be set, where the bitmap length for this section is a
max of 16 bits.
This means more than half of the mTHP has to be utilized before
collapse. If we collapse and introduce half of an empty mTHP then the
mTHP will be available next round for another promotion.
When max_ptes_none is 256, the threshold_bits =3D 7 and collapsing will
make enough non-none pages to collapse again.

>
> >
> > Patch 1:     Some refactoring to combine madvise_collapse and khugepage=
d
> > Patch 2:     Refactor/rename hpage_collapse
> > Patch 3-5:   Generalize khugepaged functions for arbitrary orders
> > Patch 6-9:   The mTHP patches
> >
> > ---------
> >   Testing
> > ---------
> > - Built for x86_64, aarch64, ppc64le, and s390x
> > - selftests mm
> > - I created a test script that I used to push khugepaged to its limits =
while
> >     monitoring a number of stats and tracepoints. The code is available
> >     here[1] (Run in legacy mode for these changes and set mthp sizes to=
 inherit)
> >     The summary from my testings was that there was no significant regr=
ession
> >     noticed through this test. In some cases my changes had better coll=
apse
> >     latencies, and was able to scan more pages in the same amount of ti=
me/work,
> >     but for the most part the results were consistant.
> > - redis testing. I tested these changes along with my defer changes
> >    (see followup post for more details).
> > - some basic testing on 64k page size.
> > - lots of general use. These changes have been running in my VM for som=
e time.
> >
> > Changes since V1 [2]:
> > - Minor bug fixes discovered during review and testing
> > - removed dynamic allocations for bitmaps, and made them stack based
> > - Adjusted bitmap offset from u8 to u16 to support 64k pagesize.
> > - Updated trace events to include collapsing order info.
> > - Scaled max_ptes_none by order rather than scaling to a 0-100 scale.
> > - No longer require a chunk to be fully utilized before setting the bit=
. Use
> >     the same max_ptes_none scaling principle to achieve this.
> > - Skip mTHP collapse that requires swapin or shared handling. This help=
s prevent
> >     some of the "creep" that was discovered in v1.
> >
> > [1] - https://gitlab.com/npache/khugepaged_mthp_test
> > [2] - https://lore.kernel.org/lkml/20250108233128.14484-1-npache@redhat=
.com/
> >
> > Nico Pache (9):
> >    introduce khugepaged_collapse_single_pmd to unify khugepaged and
> >      madvise_collapse
> >    khugepaged: rename hpage_collapse_* to khugepaged_*
> >    khugepaged: generalize hugepage_vma_revalidate for mTHP support
> >    khugepaged: generalize alloc_charge_folio for mTHP support
> >    khugepaged: generalize __collapse_huge_page_* for mTHP support
> >    khugepaged: introduce khugepaged_scan_bitmap for mTHP support
> >    khugepaged: add mTHP support
> >    khugepaged: improve tracepoints for mTHP orders
> >    khugepaged: skip collapsing mTHP to smaller orders
> >
> >   include/linux/khugepaged.h         |   4 +
> >   include/trace/events/huge_memory.h |  34 ++-
> >   mm/khugepaged.c                    | 422 +++++++++++++++++++---------=
-
> >   3 files changed, 306 insertions(+), 154 deletions(-)
> >
>

