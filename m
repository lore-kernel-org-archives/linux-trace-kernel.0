Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E6123717C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747396499; cv=none; b=cUq0Pj/NTBj4R2HTEBOuL67Q27IAID8YnmDa9AFHP0zB/Re2ivvSWtEbEMcLFXlhFZJmaSkDcpMfQb6eB3HF61B70ZA4YAMhbMZSsgIqPbL8PwI4gkN+//BxosKEkTrNYZMf4IDkpAjJz7CwIQKdaBe/sP9MO+alCWeVM3MH5No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747396499; c=relaxed/simple;
	bh=clYPUPIr3cAooukEE41QTGk8aqFh2oXTyXRPTTkWqfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4aq8KuAModvpAi3l1zCdlGarFiSAk5WCr6cbPD88sOVudXnkir6AUfOZzAm1JTZiNBEBiKF8HDbLtCziklkdyeT2bfLidrsdkbdUZuKOAdh5LzRcZ72a9ArkdjDk/Sj9MDKV0QsiBeX03+BxQj9TbhoB9q72Xw/WRS2brrywYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPc2dO1/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPc2dO1/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747396496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16Jg+8bAXH1i+LxBAD34ZM0SrFpYUvJXVipJZYjH7AU=;
	b=GPc2dO1/8f+EuL94RLlXYf2cWzqduyHbA/zR6Zzxf91CdL01sG4JzwzaFWKd7X69dY1ip7
	xbb7+XVlG2TRVOIffQcC8ibOef3jwWCWAwEl/c16qmaqahtHFCgfnvG1gKXMKjH97N4t+I
	jr6iS93+Z9nmCXomofMHggUT1YwtV5M=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-yF8441mcPC65km77XOxXFA-1; Fri, 16 May 2025 07:54:55 -0400
X-MC-Unique: yF8441mcPC65km77XOxXFA-1
X-Mimecast-MFC-AGG-ID: yF8441mcPC65km77XOxXFA_1747396495
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-70a53b5802cso28731847b3.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 04:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747396495; x=1748001295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16Jg+8bAXH1i+LxBAD34ZM0SrFpYUvJXVipJZYjH7AU=;
        b=wGVAge/K76m1RKwWiyOKFSHYq3AqQ/v4Wiwmi99BCGUNpSa8ROi71CDM6dgAnNf6Ps
         /acob6IU4csopjZaTNaU4MZe57QZ+fDDqG32g8f77WCiM3oirOvVskFq+WbdBlCd2ygo
         mIinSQM9XtD2A+M9e1fRbXhluL8s63hHuntsu+wzvQPZyftvEFGlV9iQ3oigZeZCj82w
         vd3tqETcO9ACtVD6Z+pkErZAdldA0adbxUB0I3AshKFH68ppPPqZ3lWcTFbNglui9lzR
         MH9yXw+s/kV+/VYQdc66rI6kepAOoQLka4ZeKRhSHpowvj0d1dTHNwIe8ClyiOvbYfWe
         w8fw==
X-Forwarded-Encrypted: i=1; AJvYcCXKIbGw3AwiHmMB2nRZj8IshMpVVUvKx466cbhFzRhSdcNaMmmnzDZf6UFT0XYTwmJTDK2QPzVKuzhnyc2+z6/IQ30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMw//epgREfhCP1k35k9hlU+Yy+cLOHM4hLkTyxaGYM5M7abdu
	PtIv7NbGZ9zQldM4gxTDQMW9KTBPHosudwluuJbOwfGOxYmJUMRXFY0TdSTlPaKRvV0SOPHF+oi
	kcZ+/7Rw2fp/MS+TH2j2IX4n+E7rfLY/e5noxLxWdIwpRxvznghQ2TYu5snU6MLo6MH2Nk53KE1
	FgcKPT8ILZ9ivcfAuCINPDAPejNqGQGenLliQUdpu0xebOPp8Y
X-Gm-Gg: ASbGncsfvsdrWRYzUOwIIVxIbvc8EdB+zxZB37voyO+hm0G5ZMin6p6uQUa4HPNj3yA
	6xwVUR55XFkt5Mup2GpRe60QiFhwyRZZ3ynn6H4T3MdvnnMe4lI0hV+nW2QWM85gnB2KN4Wc=
X-Received: by 2002:a05:690c:4485:b0:6d4:4a0c:fcf0 with SMTP id 00721157ae682-70caafe9a72mr35139137b3.20.1747396494535;
        Fri, 16 May 2025 04:54:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO933KL//yKd9EAbqCltzsYv9mGexjo76OMS6kNwwoXbUhc29kxatND0065IUUezm3J+crstyZYAT7krMjU9A=
X-Received: by 2002:a05:690c:4485:b0:6d4:4a0c:fcf0 with SMTP id
 00721157ae682-70caafe9a72mr35138877b3.20.1747396494191; Fri, 16 May 2025
 04:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515030312.125567-1-npache@redhat.com> <CAA1CXcAKk5z+gTrQDe-eLsxkrsNrf8G9HD5KBPTJv_EECei_Mg@mail.gmail.com>
 <55e5169b-2cba-47e0-8e16-ced29ad4d879@arm.com>
In-Reply-To: <55e5169b-2cba-47e0-8e16-ced29ad4d879@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 16 May 2025 05:54:27 -0600
X-Gm-Features: AX0GCFsHX2JXakhYDpEmibc368WjOeo41bDkQIInm9W6AizPHuLbno06hIV02uw
Message-ID: <CAA1CXcDRx94xsqcAHnkxNUB6u2Z_T3tRp4uDeZsMShJgHcLmyA@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] khugepaged: mTHP support
To: Dev Jain <dev.jain@arm.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3_HnnwUaulyb4PmdI7cPHCdIADa5WsWg9SUQPG9uV4g_1747396495
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 12:45=E2=80=AFAM Dev Jain <dev.jain@arm.com> wrote:
>
>
>
> On 15/05/25 8:51 am, Nico Pache wrote:
> > Ugh... So sorry, I forgot to turn off the chain-reply-to.
> >
> > resending V7 *facepalm*
>
> In the future you can just send the same version again with [RESEND]
> prefixed in the subject, that prevents confusion.
Thanks I'll do that next time.
>
> >
> > On Wed, May 14, 2025 at 9:03=E2=80=AFPM Nico Pache <npache@redhat.com> =
wrote:
> >>
> >> The following series provides khugepaged and madvise collapse with the
> >> capability to collapse anonymous memory regions to mTHPs.
> >>
> >> To achieve this we generalize the khugepaged functions to no longer de=
pend
> >> on PMD_ORDER. Then during the PMD scan, we keep track of chunks of pag=
es
> >> (defined by KHUGEPAGED_MTHP_MIN_ORDER) that are utilized. This info is
> >> tracked using a bitmap. After the PMD scan is done, we do binary recur=
sion
> >> on the bitmap to find the optimal mTHP sizes for the PMD range. The
> >> restriction on max_ptes_none is removed during the scan, to make sure =
we
> >> account for the whole PMD range. When no mTHP size is enabled, the leg=
acy
> >> behavior of khugepaged is maintained. max_ptes_none will be scaled by =
the
> >> attempted collapse order to determine how full a THP must be to be
> >> eligible. If a mTHP collapse is attempted, but contains swapped out, o=
r
> >> shared pages, we dont perform the collapse.
> >>
> >> With the default max_ptes_none=3D511, the code should keep its most of=
 its
> >> original behavior. To exercise mTHP collapse we need to set
> >> max_ptes_none<=3D255. With max_ptes_none > HPAGE_PMD_NR/2 you will
> >> experience collapse "creep" and constantly promote mTHPs to the next
> >> available size. This is due the fact that it will introduce at least 2=
x
> >> the number of pages, and on a future scan will satisfy that condition =
once
> >> again.
> >>
> >> Patch 1:     Refactor/rename hpage_collapse
> >> Patch 2:     Some refactoring to combine madvise_collapse and khugepag=
ed
> >> Patch 3-5:   Generalize khugepaged functions for arbitrary orders
> >> Patch 6-9:   The mTHP patches
> >> Patch 10-11: Tracing/stats
> >> Patch 12:    Documentation
> >>
> >> ---------
> >>   Testing
> >> ---------
> >> - Built for x86_64, aarch64, ppc64le, and s390x
> >> - selftests mm
> >> - I created a test script that I used to push khugepaged to its limits
> >>     while monitoring a number of stats and tracepoints. The code is
> >>     available here[1] (Run in legacy mode for these changes and set mt=
hp
> >>     sizes to inherit)
> >>     The summary from my testings was that there was no significant
> >>     regression noticed through this test. In some cases my changes had
> >>     better collapse latencies, and was able to scan more pages in the =
same
> >>     amount of time/work, but for the most part the results were consis=
tent.
> >> - redis testing. I tested these changes along with my defer changes
> >>    (see followup post for more details).
> >> - some basic testing on 64k page size.
> >> - lots of general use.
> >>
> >> V6 Changes:
> >> - Dont release the anon_vma_lock early (like in the PMD case), as not =
all
> >>    pages are isolated.
> >> - Define the PTE as null to avoid a uninitilized condition
> >> - minor nits and newline cleanup
> >> - make sure to unmap and unlock the pte for the swapin case
> >> - change the revalidation to always check the PMD order (as this will =
make
> >>    sure that no other VMA spans it)
> >>
> >> V5 Changes [2]:
> >> - switched the order of patches 1 and 2
> >> - fixed some edge cases on the unified madvise_collapse and khugepaged
> >> - Explained the "creep" some more in the docs
> >> - fix EXCEED_SHARED vs EXCEED_SWAP accounting issue
> >> - fix potential highmem issue caused by a early unmap of the PTE
> >>
> >> V4 Changes:
> >> - Rebased onto mm-unstable
> >> - small changes to Documentation
> >>
> >> V3 Changes:
> >> - corrected legacy behavior for khugepaged and madvise_collapse
> >> - added proper mTHP stat tracking
> >> - Minor changes to prevent a nested lock on non-split-lock arches
> >> - Took Devs version of alloc_charge_folio as it has the proper stats
> >> - Skip cases were trying to collapse to a lower order would still fail
> >> - Fixed cases were the bitmap was not being updated properly
> >> - Moved Documentation update to this series instead of the defer set
> >> - Minor bugs discovered during testing and review
> >> - Minor "nit" cleanup
> >>
> >> V2 Changes:
> >> - Minor bug fixes discovered during review and testing
> >> - removed dynamic allocations for bitmaps, and made them stack based
> >> - Adjusted bitmap offset from u8 to u16 to support 64k pagesize.
> >> - Updated trace events to include collapsing order info.
> >> - Scaled max_ptes_none by order rather than scaling to a 0-100 scale.
> >> - No longer require a chunk to be fully utilized before setting the bi=
t.
> >>     Use the same max_ptes_none scaling principle to achieve this.
> >> - Skip mTHP collapse that requires swapin or shared handling. This hel=
ps
> >>     prevent some of the "creep" that was discovered in v1.
> >>
> >> [1] - https://gitlab.com/npache/khugepaged_mthp_test
> >> [2] - https://lore.kernel.org/all/20250428181218.85925-1-npache@redhat=
.com/
> >>
> >> Dev Jain (1):
> >>    khugepaged: generalize alloc_charge_folio()
> >>
> >> Nico Pache (11):
> >>    khugepaged: rename hpage_collapse_* to khugepaged_*
> >>    introduce khugepaged_collapse_single_pmd to unify khugepaged and
> >>      madvise_collapse
> >>    khugepaged: generalize hugepage_vma_revalidate for mTHP support
> >>    khugepaged: generalize __collapse_huge_page_* for mTHP support
> >>    khugepaged: introduce khugepaged_scan_bitmap for mTHP support
> >>    khugepaged: add mTHP support
> >>    khugepaged: skip collapsing mTHP to smaller orders
> >>    khugepaged: avoid unnecessary mTHP collapse attempts
> >>    khugepaged: improve tracepoints for mTHP orders
> >>    khugepaged: add per-order mTHP khugepaged stats
> >>    Documentation: mm: update the admin guide for mTHP collapse
> >>
> >>   Documentation/admin-guide/mm/transhuge.rst |  14 +-
> >>   include/linux/huge_mm.h                    |   5 +
> >>   include/linux/khugepaged.h                 |   4 +
> >>   include/trace/events/huge_memory.h         |  34 +-
> >>   mm/huge_memory.c                           |  11 +
> >>   mm/khugepaged.c                            | 472 ++++++++++++++-----=
--
> >>   6 files changed, 382 insertions(+), 158 deletions(-)
> >>
> >> --
> >> 2.49.0
> >>
> >
>

