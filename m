Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928A1FFC59
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739475602; cv=none; b=TZocFlPIPPO+PjOiREv6lD8QdfBp8J93VpZpMKUh95Fo1BmS0jKshq0LgXTV4NuKusYV4p90I1YS7N/qfkWR1nxl1URJXtQe6ipOrJYzSTZ6w8W+0Y5b6ds8sq/PJABV+6RBIbhl+OH4EHHZYCgNFgFdybBEHSg22nTCeOHrSGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739475602; c=relaxed/simple;
	bh=mBtUNyOMMbsKw8iHJKq3/ku1fI8mpdnzRali3R3HMEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCs3duyYVEH4xiJavKyz0LvbGrGv4Bi8fLOm/oYvqyFys0QJbj7vsfGuKhuhL+NX8Afvrmjo4j8dB56kAoE51hFmhAf/RVKDQErVxzQggK7V9jNboxq1QRhqby+6g4ZS3JxV1s9m8Rb7AtpXPgQge/1wRG/aJ41t3IADk2cWxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hO8oXwH2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hO8oXwH2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739475598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boxr+nl3iRxI8kwf7+INrSdGJaLkpDQVEcqU+I9NPyg=;
	b=hO8oXwH2Ft8nMikq0fZ7SqKwR7KSxOZScTyTjJFpJ2jmjhFlJLFwtxUnSpWx5pYTj9fYmk
	b1cJ9vGznDDVTjTjwTa/dDF8a3XyNfgNVUtBC3jR+n0dP8LAnJPRxVaK/+wstN7J7YxBPu
	FA/WxSmvcQgR/aF5g6D+AvrvMoLKBF0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-Xp5sUhQDOIa4QMg_Fv0Lbw-1; Thu, 13 Feb 2025 14:39:57 -0500
X-MC-Unique: Xp5sUhQDOIa4QMg_Fv0Lbw-1
X-Mimecast-MFC-AGG-ID: Xp5sUhQDOIa4QMg_Fv0Lbw
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e582bfcada6so1863951276.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739475597; x=1740080397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boxr+nl3iRxI8kwf7+INrSdGJaLkpDQVEcqU+I9NPyg=;
        b=Uxi8hXAUDbaZ5CpvT9UYIAsPyNozBzOlZfKkyJByG0vVPPGCSbnmdATzcsmZUZFtcj
         SyZfe6297gxYfC/CPFnGbKGxL7XqHU8BS4+onNOEx1ZQQgMA/2Qf8fNroKzbRo4iySyi
         bQTZJdhVlMoEtnSQmshidNCBoO3ZfDSPGn+ydWDltjk9HRBMskGlorblXP0MGS54slnT
         98VeLlKrzqL0l0YYMoqj/hM0H4YAHsfJM1SRo20hnplPizAcM/AQXVAxohNhVNNTXYWv
         A7S6yBgR+UXcKCWbAFQ0Gj3bA2cCBAeEnK7aWbfhFdU7el/7NIgla6JWRiSIydEX4s/m
         6noQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDk0TZjTlGa0E0+lu1MLjFP6HvDtmgzSb18xR8/IUAcMYUHsTVnK/w4iPPnfgZzf9+8sJP5UHlFLbl7pwaAahOuRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9WlGlroy8qd1hdYrdos4j3Mgf257RH3wEPaHWpOFPdKr7JVyU
	Z3Wb25m+HSYREqVlDFYyU/v4Kcw3i4UDlZzdbPQxvffu5Nvqdb5HfOkalt7VnoYuuYk4iNTh7Xi
	0po4RCFrhrh4Uk3tz1Gn0jryIewOmJnUMuHf8fVUofJ4nqqKIN7ty6ssXtGK1S4CZipkNWU47UA
	uDm4OsoGig4uAh2neyAPOwkwEhRPeB4AqnuBbWltN1JCOk
X-Gm-Gg: ASbGncsPcfkKiu/YIqEYPQ//HTMBlaxJhkd9jr8D8i5OVkd2FnzHF+woPgK4OMebYHC
	aDZkh7l81Stff0lum3WauzxTkgSE8mPdBBi7XFIU7JWcHh1X0VTr2R0ZwL5rYNCF+KeDWH6NQ3e
	c=
X-Received: by 2002:a05:6902:13c6:b0:e5b:4080:ad89 with SMTP id 3f1490d57ef6-e5da81e9e95mr4522306276.38.1739475597130;
        Thu, 13 Feb 2025 11:39:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfp2KDNuPnNnUtf/P7iXlml3POI4m+epxhSgL0vVylmbj3I2dY+iGX0H+VqmLQZwtrr+P5xL+59PtJpBPimPg=
X-Received: by 2002:a05:6902:13c6:b0:e5b:4080:ad89 with SMTP id
 3f1490d57ef6-e5da81e9e95mr4522251276.38.1739475596599; Thu, 13 Feb 2025
 11:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211003028.213461-1-npache@redhat.com> <5a995dc9-fee7-442f-b439-c484d9de1750@arm.com>
 <CAA1CXcCo3eCH-5axnw3WUqPfL-EPCbLVFo_AFYXkbnExfX=KLQ@mail.gmail.com> <4ba52062-1bd3-4d53-aa28-fcbbd4913801@arm.com>
In-Reply-To: <4ba52062-1bd3-4d53-aa28-fcbbd4913801@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 13 Feb 2025 12:39:30 -0700
X-Gm-Features: AWEUYZltvpqxvurvt8_8gd179zfEGjGrl_F1jfl5niXu58DgsMbTO7GZCLo_WGk
Message-ID: <CAA1CXcCeFjCx-6VDCjOUUniLHXMUYpjesOhcHQapMS5i7=RR4A@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: tusVphgJMd39WPP7txhBFFkruwvYT9pXbSnneSB752w_1739475597
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 1:26=E2=80=AFAM Dev Jain <dev.jain@arm.com> wrote:
>
>
>
> On 12/02/25 10:19 pm, Nico Pache wrote:
> > On Tue, Feb 11, 2025 at 5:50=E2=80=AFAM Dev Jain <dev.jain@arm.com> wro=
te:
> >>
> >>
> >>
> >> On 11/02/25 6:00 am, Nico Pache wrote:
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
> >>> constantly promote mTHPs to the next available size.
> >>>
> >>> Patch 1:     Some refactoring to combine madvise_collapse and khugepa=
ged
> >>> Patch 2:     Refactor/rename hpage_collapse
> >>> Patch 3-5:   Generalize khugepaged functions for arbitrary orders
> >>> Patch 6-9:   The mTHP patches
> >>>
> >>> ---------
> >>>    Testing
> >>> ---------
> >>> - Built for x86_64, aarch64, ppc64le, and s390x
> >>> - selftests mm
> >>> - I created a test script that I used to push khugepaged to its limit=
s while
> >>>      monitoring a number of stats and tracepoints. The code is availa=
ble
> >>>      here[1] (Run in legacy mode for these changes and set mthp sizes=
 to inherit)
> >>>      The summary from my testings was that there was no significant r=
egression
> >>>      noticed through this test. In some cases my changes had better c=
ollapse
> >>>      latencies, and was able to scan more pages in the same amount of=
 time/work,
> >>>      but for the most part the results were consistant.
> >>> - redis testing. I tested these changes along with my defer changes
> >>>     (see followup post for more details).
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
> >>>      the same max_ptes_none scaling principle to achieve this.
> >>> - Skip mTHP collapse that requires swapin or shared handling. This he=
lps prevent
> >>>      some of the "creep" that was discovered in v1.
> >>>
> >>> [1] - https://gitlab.com/npache/khugepaged_mthp_test
> >>> [2] - https://lore.kernel.org/lkml/20250108233128.14484-1-npache@redh=
at.com/
> >>>
> >>> Nico Pache (9):
> >>>     introduce khugepaged_collapse_single_pmd to unify khugepaged and
> >>>       madvise_collapse
> >>>     khugepaged: rename hpage_collapse_* to khugepaged_*
> >>>     khugepaged: generalize hugepage_vma_revalidate for mTHP support
> >>>     khugepaged: generalize alloc_charge_folio for mTHP support
> >>>     khugepaged: generalize __collapse_huge_page_* for mTHP support
> >>>     khugepaged: introduce khugepaged_scan_bitmap for mTHP support
> >>>     khugepaged: add mTHP support
> >>>     khugepaged: improve tracepoints for mTHP orders
> >>>     khugepaged: skip collapsing mTHP to smaller orders
> >>>
> >>>    include/linux/khugepaged.h         |   4 +
> >>>    include/trace/events/huge_memory.h |  34 ++-
> >>>    mm/khugepaged.c                    | 422 +++++++++++++++++++------=
----
> >>>    3 files changed, 306 insertions(+), 154 deletions(-)
> >>>
> >>
> >> Does this patchset suffer from the problem described here:
> >> https://lore.kernel.org/all/8abd99d5-329f-4f8d-8680-c2d48d4963b6@arm.c=
om/
> > Hi Dev,
> >
> > Sorry I meant to get back to you about that.
> >
> > I understand your concern, but like I've mentioned before, the scan
> > with the read lock was done so we dont have to do the more expensive
> > locking, and could still gain insight into the state. You are right
> > that this info could become stale if the state changes dramatically,
> > but the collapse_isolate function will verify it and not collapse.
>
> If the state changes dramatically, the _isolate function will verify it,
> and fallback. And this fallback happens after following this costly
> path: retrieve a large folio from the buddy allocator -> swapin pages
> from the disk -> mmap_write_lock() -> anon_vma_lock_write() -> TLB flush
> on all CPUs -> fallback in _isolate().
> If you do fail in _isolate(), doesn't it make sense to get the updated
> state for the next fallback order immediately, because we have prior
> information that we failed because of PTE state? What your algorithm
> will do is *still* follow the costly path described above, and again
> fail in _isolate(), instead of failing in hpage_collapse_scan_pmd() like
> mine would.

You do raise a valid point here, I can optimize my solution by
detecting certain collapse failure types and jump to the next scan.
I'll add that to my solution, thanks!

As for the disagreement around the bitmap, we'll leave that up to the
community to decide since we have differing opinions/solutions.

>
> The verification of the PTE state by the _isolate() function is the "no
> turning back" point of the algorithm. The verification by
> hpage_collapse_scan_pmd() is the "let us see if proceeding is even worth
> it, before we do costly operations" point of the algorithm.
>
> >  From my testing I found this to rarely happen.
>
> Unfortunately, I am not very familiar with performance testing/load
> testing, I am fairly new to kernel programming, so I am getting there.
> But it really depends on the type of test you are running, what actually
> runs on memory-intensive systems, etc etc. In fact, on loaded systems I
> would expect the PTE state to dramatically change. But still, no opinion
> here.

Yeah there are probably some cases where it happens more often.
Probably in cases of short lived allocations, but khugepaged doesn't
run that frequently so those won't be that big of an issue.

Our performance team is currently testing my implementation so I
should have more real workload test results soon. The redis testing
had some gains and didn't show any signs of obvious regressions.

As for the testing, check out
https://gitlab.com/npache/khugepaged_mthp_test/-/blob/master/record-khuge-p=
erformance.sh?ref_type=3Dheads
this does the tracing for my testing script. It can help you get
started. There are 3 different traces being applied there: the
bpftrace for collapse latencies, the perf record for the flamegraph
(not actually that useful, but may be useful to visualize any
weird/long paths that you may not have noticed), and the trace-cmd
which records the tracepoint of the scan and the collapse functions
then processes the data using the awk script-- the output being the
scan rate, the pages collapsed, and their result status (grouped by
order).

You can also look into https://github.com/gormanm/mmtests for
testing/comparing kernels. I was running the
config-memdb-redis-benchmark-medium workload.

>
> >
> > Also, khugepaged, my changes, and your changes are all a victim of
> > this. Once we drop the read lock (to either allocate the folio, or
> > right before acquiring the write_lock), the state can change. In your
> > case, yes, you are gathering more up to date information, but is it
> > really that important/worth it to retake locks and rescan for each
> > instance if we are about to reverify with the write lock taken?
>
> You said "reverify": You are removing the verification, so this step
> won't be reverification, it will be verification. We do not want to
> verify *after* we have already done 95% of latency-heavy stuff, only to
> know that we are going to fail.
>
> Algorithms in the kernel, in general, are of the following form: 1)
> Verify if a condition is true, resulting in taking a control path -> 2)
> do a lot of stuff -> "no turning back" step, wherein before committing
> (by taking locks, say), reverify if this is the control path we should
> be in. You are eliminating step 1).
>
> Therefore, I will have to say that I disagree with your approach.
>
> On top of this, in the subjective analysis in [1], point number 7 (along
> with point number 1) remains. And, point number 4 remains.

for 1) your worst case of 1024 is not the worst case. There are 8
possible orders in your implementation, if all are enabled, that is
4096 iterations in the worst case.
This becomes WAY worse on 64k page size, ~45,000 iterations vs 4096 in my c=
ase.
>
> [1]
> https://lore.kernel.org/all/23023f48-95c6-4a24-ac8b-aba4b1a441b4@arm.com/
>
> >
> > So in my eyes, this is not a "problem"
>
> Looks like the kernel scheduled us for a high-priority debate, I hope
> there's no deadlock :)
>
> >
> > Cheers,
> > -- Nico
> >
> >
> >>
> >
>

