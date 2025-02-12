Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A78254B09
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379002; cv=none; b=OVkhAnjEXB+DRCT3h1Scypa1+YSRs4I/RSkRo4p4jucuRFQURxEb1Td0C4v2NcqoxaZo1+kop5jCXagd57VqjRNyTm0u7eJu20qH8tvk81oord8ZYImIGJ7jolGvoTS+UINARMcVDbc7+7dzIDTyBXxW8fIBs7BpxbYDcKy+ewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379002; c=relaxed/simple;
	bh=EZsQp4ww9+8FDitQ4h/lp1cNx+MSZV9M41/RDxB9N60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+xJ/sJVlUye6JrCQT4gztnecHSTTlJTpOtE36/YbtP7HWx+YZSX1uayh52LM9upoxlaoDYmc2zN3P4g0NamZS1+TPEUskzKZXDINa19E/G7upkzBm37KEEEuJFeZBBxMfYQCCx+tF2zRtJ0Dw48xf0brpx5lPnQPFyMz4s20xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHFAU7pe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHFAU7pe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739378999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPnsWp+uVadB0fIbvemTi3mHnbvU4Gf2i6YtDyhOUfg=;
	b=OHFAU7pe+Ak5toT6V/Qwav0EmshwxXCkVQWRimTB+aYbbRxp9QQDLigMoAsXo9H1wBUxT6
	mE2WBmKkUMuxajetqVUn6VZjsndLRQ/WUxBUD1j4JVbQ4jvyRvPVDirNLKo4r3IZaUlUFp
	uez9PNjPp5AzK824NwYbi/qAqhfkRw0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-1YZXP6MyPPGslMWpg3bCvw-1; Wed, 12 Feb 2025 11:49:58 -0500
X-MC-Unique: 1YZXP6MyPPGslMWpg3bCvw-1
X-Mimecast-MFC-AGG-ID: 1YZXP6MyPPGslMWpg3bCvw
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6f2b386136aso100956487b3.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378997; x=1739983797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPnsWp+uVadB0fIbvemTi3mHnbvU4Gf2i6YtDyhOUfg=;
        b=FLUI+vhK3OrbfJ0elUxaBhyaI8MUTRmyDPaxBGFB14Y6PB6TEvfn1VEqu6Au0eO034
         j+D2y/ezvvpWqOkG+cEfxPYTUROaXRkbovHyUOO87fpR2WxvBw1rOx0bwssT819KlulC
         5lz0IML9EX8ESOYbEzVqlMX1seMpmqQHp7/rk71wsN6Aq35tZw9owTBgSjdJRjn60XvR
         Fa5UXg64fp0+r/1Ain20SLu8sTAv64AMEc4YR2AfaRQ8fUI3bAKfzBg7KqATbKatLIS0
         wWIWuKwDJOobKrdNr9aNaUxvOQFZBz2gSCA53Vf9hiMdIH41peZ4tfmKRx+4X8h3zUZG
         Yy8A==
X-Forwarded-Encrypted: i=1; AJvYcCUbmHwJrRB780s+ZC8YC2YQD/YY6PIPoQ+PhfopxrGNLhl1PZyL+qsu0fFjc/wmw0hbi+oIbVHARhPyQHoJkwAcaUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXMeqrx6tgtz3f7M4xvMHhhhsd0BpY2s4eEiEdvBDc6rrJV6xO
	aFrDbZmlyBOKzOKFNOQcuWQQhoXYIOB2QsPTnD2eJDkXPwyGg9407zTBpeZKMEtoda0lwMplZGZ
	orsbGGXjX0OaET4n577tQVdrUYtCFBABHnwZm/u4b8uT7wuZi+k8XrpqfDJY18nObO3taiuajb+
	0bw6AnDkcNLg8oFizbo/wHxiS2NEQb3jm8OXx8Qykxz/pB
X-Gm-Gg: ASbGncsQaGlRe8u1M5FSBlBPnKhGlq3QtQw5Lz1Z/e0ftOIJ9KGzoJTa4QVK0f5h1OY
	dQVog5kHs+rFBsPN2LD3yPSWj0hjmGZQzUp6Z2wT35ZMFNqTzM8bLBDVol5TZTb28UCoSWoDq09
	g=
X-Received: by 2002:a05:6902:c0f:b0:e5b:3af0:d4b6 with SMTP id 3f1490d57ef6-e5d9f177b0dmr3693009276.39.1739378997474;
        Wed, 12 Feb 2025 08:49:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFr+Hr/PiVfn3FXUMlE+63a6PGVj7So6+xFWHOYXeUydSTxRONJiUBSP04mHmt4hrxEkxGTKY672V1DpUF87tE=
X-Received: by 2002:a05:6902:c0f:b0:e5b:3af0:d4b6 with SMTP id
 3f1490d57ef6-e5d9f177b0dmr3692985276.39.1739378997157; Wed, 12 Feb 2025
 08:49:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211003028.213461-1-npache@redhat.com> <5a995dc9-fee7-442f-b439-c484d9de1750@arm.com>
In-Reply-To: <5a995dc9-fee7-442f-b439-c484d9de1750@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 12 Feb 2025 09:49:31 -0700
X-Gm-Features: AWEUYZkUQXup4w4I6JGkySBAdTJoh13pZXv8Cq59n4Sa4gnQ7P9zDt7JYRCHl0c
Message-ID: <CAA1CXcCo3eCH-5axnw3WUqPfL-EPCbLVFo_AFYXkbnExfX=KLQ@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: LLeOQB8R7fzRglcWKrJD93UJFyrKPlNAHVRDYihR10w_1739378997
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 5:50=E2=80=AFAM Dev Jain <dev.jain@arm.com> wrote:
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
> Does this patchset suffer from the problem described here:
> https://lore.kernel.org/all/8abd99d5-329f-4f8d-8680-c2d48d4963b6@arm.com/
Hi Dev,

Sorry I meant to get back to you about that.

I understand your concern, but like I've mentioned before, the scan
with the read lock was done so we dont have to do the more expensive
locking, and could still gain insight into the state. You are right
that this info could become stale if the state changes dramatically,
but the collapse_isolate function will verify it and not collapse.
From my testing I found this to rarely happen.

Also, khugepaged, my changes, and your changes are all a victim of
this. Once we drop the read lock (to either allocate the folio, or
right before acquiring the write_lock), the state can change. In your
case, yes, you are gathering more up to date information, but is it
really that important/worth it to retake locks and rescan for each
instance if we are about to reverify with the write lock taken?

So in my eyes, this is not a "problem"

Cheers,
-- Nico


>

