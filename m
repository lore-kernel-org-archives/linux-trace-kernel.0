Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C5B70814
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819974; cv=none; b=qlz5F+7Z89XdTAtOBHWOtHm/rjobL4uIxWpaM9c2Fx2k9eohlrXZJe+NX6kCqdJFw61pvohM2y38R9UuMhu+jTIywqLZ0DHYvVIigr3X7HME9zHtgPTXJ5vp7wo+1Ybbvm4PCnbDU1w+LyV/bbANsn/pXmKDqYwGpCqiodr9uH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819974; c=relaxed/simple;
	bh=PkturaSwUFH3ezQLauNHYP8tWD0UJngj9K3EQG7/nBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQh6CSVCO/gSN+/o6ScCaavurfSPilTVLBrkpq6bPYE1spLqsn0AMaTd8zpT4woTfoKyLhkVxX5blv+9ZkyNFVBl9e8hYg2JpLbdCC0oLmFxsxADu3DfGn0ok6NwTRCvBggZpLOez+X2Kparmbax3Kq2aAnFRB7TRqcHNZDmWog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f1pXAtPX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1pXAtPX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739819970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4RTmagCtQ7L8fOrNlgAR8YOXAP1OFqBaFYkx7yQAZg=;
	b=f1pXAtPXRxqYhpLS22AH6G1h25P2RLOXkO/t2SlPqq5pkFqDFIbflQrOwR3LScenUiNghe
	b65Jns5KxskfUNdtB1jtbbbe+Qgw1VLelDrDRUyMyv5goMkklu45ihnrFNB/Q6loe125dK
	ZOn/Y4e9ngtRm2UADJptPTpwCNMhWgE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-wQFCCe74PTGw6vcdsVNKvQ-1; Mon, 17 Feb 2025 14:19:29 -0500
X-MC-Unique: wQFCCe74PTGw6vcdsVNKvQ-1
X-Mimecast-MFC-AGG-ID: wQFCCe74PTGw6vcdsVNKvQ_1739819969
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6f46924f63eso73559517b3.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739819969; x=1740424769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4RTmagCtQ7L8fOrNlgAR8YOXAP1OFqBaFYkx7yQAZg=;
        b=BXtLOSuqBjCBcm+RqAYBT7dPwSWb8uhthzs+s9uW4Z0c339fE6col3MZhwOL4bFcEt
         O/haY8YahYbVC8zYj/FV+xaKNQTlF7w8NjbQossozsPBWE5p3+o3pJd1NymSqYP9x5/M
         Bkltol7Z+qHyXQKZIOntUmAVVL6ui80WBp1pfrJ+ZpIFH8tIH1+eTGWJ8nxUuPnnXNDo
         qmBGwWGwKPVbCJ2uyIUQd11+VxTi2gCYeSTft6a74O0wTcGZr0lLdFTsshXCcVG3M4zT
         nul59QvPniQNRmRmEClndz3zm9JR4gYcGutDQmJqOgQ2Yp+nopY1gfmvLI+tBlMDom+d
         ZFlA==
X-Forwarded-Encrypted: i=1; AJvYcCVaywaymEBsy0YeXbafJdbG29a9RQrNuZc0BroZppfElvAMc7l7iFQWkupVLpbt8Hu90+WxSA+x0lXD6cj2QaL3Fe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypO0jWwz+Cost/n/WoPLG3FlNkWDDsJG8Y4rTa5+EMmrrjRJb7
	UfgKWsVxs+cdZdcQAdR5mvG8hec/PPTxJucFw4D9WB4dDtj6QFRFmSozAvGNNDdsT3Ap4Zkb3rd
	Y94CxeqoexxVpt7/K4oydvhxYb4TlzEC6k4K+SAoCJa/Ivxge4p3njKtKJBiyHJvECsWA1SIOO/
	nat+FgOWvkx3EVT/rMS4WbFMDwx56G/7IV4xxp8JzQ6zAz
X-Gm-Gg: ASbGncuf7yhOIYjn5gmY2FzSTXF8xSk/ZLYDHy8aMIGpQ/GSlBNSMsWA3zJoYy5ZHcK
	ZBqwGKYoxF62UIelNVOVPcFdC70UUc47IxVrMYQOMPrOIsKKUYv0TUCOcUYXhzkAJE1fE551Jza
	Q=
X-Received: by 2002:a05:690c:2a45:b0:6f9:5a36:577d with SMTP id 00721157ae682-6fb33c9fac9mr132516077b3.9.1739819968753;
        Mon, 17 Feb 2025 11:19:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmlyIiuMkLareBFH5LjuAeLUQ1wKHJM87kI6clK2Ft6vIF6GOF1dYdefMy+CfQa0XnHJ3M+8dvznnYefTu1Lc=
X-Received: by 2002:a05:690c:2a45:b0:6f9:5a36:577d with SMTP id
 00721157ae682-6fb33c9fac9mr132515797b3.9.1739819968302; Mon, 17 Feb 2025
 11:19:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211003028.213461-1-npache@redhat.com> <5a995dc9-fee7-442f-b439-c484d9de1750@arm.com>
 <CAA1CXcCo3eCH-5axnw3WUqPfL-EPCbLVFo_AFYXkbnExfX=KLQ@mail.gmail.com>
 <4ba52062-1bd3-4d53-aa28-fcbbd4913801@arm.com> <CAA1CXcCeFjCx-6VDCjOUUniLHXMUYpjesOhcHQapMS5i7=RR4A@mail.gmail.com>
 <71490f8c-f234-4032-bc2a-f6cffa491fcb@arm.com> <CAA1CXcCkbxe_D4cSroBTu3E4dn6SaaDDk6xo9y4O9cWW-9Rc9Q@mail.gmail.com>
 <5445bc55-6bd2-46fd-8107-99eb31aee172@arm.com> <7c2b0248-1153-4ce1-9170-56eeb0511ff1@arm.com>
In-Reply-To: <7c2b0248-1153-4ce1-9170-56eeb0511ff1@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 17 Feb 2025 12:19:02 -0700
X-Gm-Features: AWEUYZkfVBNHyGTMNmagUCtMciQTKfDZkfi_KIUrOqFuSxC6aFOxJcfKCdHgzNQ
Message-ID: <CAA1CXcBDp3=QLPW3V6OOrPtpXt-XHnG5766O5PV5+esDiW9v-Q@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: JjtneVP30WVD3-0tMK273X8Nljb5t_EVJ02_S0hF24g_1739819969
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 1:06=E2=80=AFAM Dev Jain <dev.jain@arm.com> wrote:
>
>
>
> On 15/02/25 12:08 pm, Dev Jain wrote:
> >
> >
> > On 15/02/25 6:22 am, Nico Pache wrote:
> >> On Thu, Feb 13, 2025 at 7:02=E2=80=AFPM Dev Jain <dev.jain@arm.com> wr=
ote:
> >>>
> >>>
> >>>
> >>> On 14/02/25 1:09 am, Nico Pache wrote:
> >>>> On Thu, Feb 13, 2025 at 1:26=E2=80=AFAM Dev Jain <dev.jain@arm.com> =
wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 12/02/25 10:19 pm, Nico Pache wrote:
> >>>>>> On Tue, Feb 11, 2025 at 5:50=E2=80=AFAM Dev Jain <dev.jain@arm.com=
> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 11/02/25 6:00 am, Nico Pache wrote:
> >>>>>>>> The following series provides khugepaged and madvise collapse
> >>>>>>>> with the
> >>>>>>>> capability to collapse regions to mTHPs.
> >>>>>>>>
> >>>>>>>> To achieve this we generalize the khugepaged functions to no
> >>>>>>>> longer depend
> >>>>>>>> on PMD_ORDER. Then during the PMD scan, we keep track of chunks
> >>>>>>>> of pages
> >>>>>>>> (defined by MTHP_MIN_ORDER) that are utilized. This info is trac=
ked
> >>>>>>>> using a bitmap. After the PMD scan is done, we do binary
> >>>>>>>> recursion on the
> >>>>>>>> bitmap to find the optimal mTHP sizes for the PMD range. The
> >>>>>>>> restriction
> >>>>>>>> on max_ptes_none is removed during the scan, to make sure we
> >>>>>>>> account for
> >>>>>>>> the whole PMD range. max_ptes_none will be scaled by the
> >>>>>>>> attempted collapse
> >>>>>>>> order to determine how full a THP must be to be eligible. If a
> >>>>>>>> mTHP collapse
> >>>>>>>> is attempted, but contains swapped out, or shared pages, we dont
> >>>>>>>> perform the
> >>>>>>>> collapse.
> >>>>>>>>
> >>>>>>>> With the default max_ptes_none=3D511, the code should keep its
> >>>>>>>> most of its
> >>>>>>>> original behavior. To exercise mTHP collapse we need to set
> >>>>>>>> max_ptes_none<=3D255.
> >>>>>>>> With max_ptes_none > HPAGE_PMD_NR/2 you will experience collapse
> >>>>>>>> "creep" and
> >>>>>>>> constantly promote mTHPs to the next available size.
> >>>>>>>>
> >>>>>>>> Patch 1:     Some refactoring to combine madvise_collapse and
> >>>>>>>> khugepaged
> >>>>>>>> Patch 2:     Refactor/rename hpage_collapse
> >>>>>>>> Patch 3-5:   Generalize khugepaged functions for arbitrary order=
s
> >>>>>>>> Patch 6-9:   The mTHP patches
> >>>>>>>>
> >>>>>>>> ---------
> >>>>>>>>      Testing
> >>>>>>>> ---------
> >>>>>>>> - Built for x86_64, aarch64, ppc64le, and s390x
> >>>>>>>> - selftests mm
> >>>>>>>> - I created a test script that I used to push khugepaged to its
> >>>>>>>> limits while
> >>>>>>>>        monitoring a number of stats and tracepoints. The code is
> >>>>>>>> available
> >>>>>>>>        here[1] (Run in legacy mode for these changes and set
> >>>>>>>> mthp sizes to inherit)
> >>>>>>>>        The summary from my testings was that there was no
> >>>>>>>> significant regression
> >>>>>>>>        noticed through this test. In some cases my changes had
> >>>>>>>> better collapse
> >>>>>>>>        latencies, and was able to scan more pages in the same
> >>>>>>>> amount of time/work,
> >>>>>>>>        but for the most part the results were consistant.
> >>>>>>>> - redis testing. I tested these changes along with my defer chan=
ges
> >>>>>>>>       (see followup post for more details).
> >>>>>>>> - some basic testing on 64k page size.
> >>>>>>>> - lots of general use. These changes have been running in my VM
> >>>>>>>> for some time.
> >>>>>>>>
> >>>>>>>> Changes since V1 [2]:
> >>>>>>>> - Minor bug fixes discovered during review and testing
> >>>>>>>> - removed dynamic allocations for bitmaps, and made them stack
> >>>>>>>> based
> >>>>>>>> - Adjusted bitmap offset from u8 to u16 to support 64k pagesize.
> >>>>>>>> - Updated trace events to include collapsing order info.
> >>>>>>>> - Scaled max_ptes_none by order rather than scaling to a 0-100
> >>>>>>>> scale.
> >>>>>>>> - No longer require a chunk to be fully utilized before setting
> >>>>>>>> the bit. Use
> >>>>>>>>        the same max_ptes_none scaling principle to achieve this.
> >>>>>>>> - Skip mTHP collapse that requires swapin or shared handling.
> >>>>>>>> This helps prevent
> >>>>>>>>        some of the "creep" that was discovered in v1.
> >>>>>>>>
> >>>>>>>> [1] - https://gitlab.com/npache/khugepaged_mthp_test
> >>>>>>>> [2] - https://lore.kernel.org/lkml/20250108233128.14484-1-
> >>>>>>>> npache@redhat.com/
> >>>>>>>>
> >>>>>>>> Nico Pache (9):
> >>>>>>>>       introduce khugepaged_collapse_single_pmd to unify
> >>>>>>>> khugepaged and
> >>>>>>>>         madvise_collapse
> >>>>>>>>       khugepaged: rename hpage_collapse_* to khugepaged_*
> >>>>>>>>       khugepaged: generalize hugepage_vma_revalidate for mTHP
> >>>>>>>> support
> >>>>>>>>       khugepaged: generalize alloc_charge_folio for mTHP support
> >>>>>>>>       khugepaged: generalize __collapse_huge_page_* for mTHP
> >>>>>>>> support
> >>>>>>>>       khugepaged: introduce khugepaged_scan_bitmap for mTHP supp=
ort
> >>>>>>>>       khugepaged: add mTHP support
> >>>>>>>>       khugepaged: improve tracepoints for mTHP orders
> >>>>>>>>       khugepaged: skip collapsing mTHP to smaller orders
> >>>>>>>>
> >>>>>>>>      include/linux/khugepaged.h         |   4 +
> >>>>>>>>      include/trace/events/huge_memory.h |  34 ++-
> >>>>>>>>      mm/khugepaged.c                    | 422 ++++++++++++++++++
> >>>>>>>> +----------
> >>>>>>>>      3 files changed, 306 insertions(+), 154 deletions(-)
> >>>>>>>>
> >>>>>>>
> >>>>>>> Does this patchset suffer from the problem described here:
> >>>>>>> https://lore.kernel.org/all/8abd99d5-329f-4f8d-8680-
> >>>>>>> c2d48d4963b6@arm.com/
> >>>>>> Hi Dev,
> >>>>>>
> >>>>>> Sorry I meant to get back to you about that.
> >>>>>>
> >>>>>> I understand your concern, but like I've mentioned before, the sca=
n
> >>>>>> with the read lock was done so we dont have to do the more expensi=
ve
> >>>>>> locking, and could still gain insight into the state. You are righ=
t
> >>>>>> that this info could become stale if the state changes dramaticall=
y,
> >>>>>> but the collapse_isolate function will verify it and not collapse.
> >>>>>
> >>>>> If the state changes dramatically, the _isolate function will
> >>>>> verify it,
> >>>>> and fallback. And this fallback happens after following this costly
> >>>>> path: retrieve a large folio from the buddy allocator -> swapin pag=
es
> >>>>> from the disk -> mmap_write_lock() -> anon_vma_lock_write() -> TLB
> >>>>> flush
> >>>>> on all CPUs -> fallback in _isolate().
> >>>>> If you do fail in _isolate(), doesn't it make sense to get the upda=
ted
> >>>>> state for the next fallback order immediately, because we have prio=
r
> >>>>> information that we failed because of PTE state? What your algorith=
m
> >>>>> will do is *still* follow the costly path described above, and agai=
n
> >>>>> fail in _isolate(), instead of failing in hpage_collapse_scan_pmd()
> >>>>> like
> >>>>> mine would.
> >>>>
> >>>> You do raise a valid point here, I can optimize my solution by
> >>>> detecting certain collapse failure types and jump to the next scan.
> >>>> I'll add that to my solution, thanks!
> >>>>
> >>>> As for the disagreement around the bitmap, we'll leave that up to th=
e
> >>>> community to decide since we have differing opinions/solutions.
> >>>>
> >>>>>
> >>>>> The verification of the PTE state by the _isolate() function is the
> >>>>> "no
> >>>>> turning back" point of the algorithm. The verification by
> >>>>> hpage_collapse_scan_pmd() is the "let us see if proceeding is even
> >>>>> worth
> >>>>> it, before we do costly operations" point of the algorithm.
> >>>>>
> >>>>>>    From my testing I found this to rarely happen.
> >>>>>
> >>>>> Unfortunately, I am not very familiar with performance testing/load
> >>>>> testing, I am fairly new to kernel programming, so I am getting the=
re.
> >>>>> But it really depends on the type of test you are running, what
> >>>>> actually
> >>>>> runs on memory-intensive systems, etc etc. In fact, on loaded
> >>>>> systems I
> >>>>> would expect the PTE state to dramatically change. But still, no
> >>>>> opinion
> >>>>> here.
> >>>>
> >>>> Yeah there are probably some cases where it happens more often.
> >>>> Probably in cases of short lived allocations, but khugepaged doesn't
> >>>> run that frequently so those won't be that big of an issue.
> >>>>
> >>>> Our performance team is currently testing my implementation so I
> >>>> should have more real workload test results soon. The redis testing
> >>>> had some gains and didn't show any signs of obvious regressions.
> >>>>
> >>>> As for the testing, check out
> >>>> https://gitlab.com/npache/khugepaged_mthp_test/-/blob/master/record-
> >>>> khuge-performance.sh?ref_type=3Dheads
> >>>> this does the tracing for my testing script. It can help you get
> >>>> started. There are 3 different traces being applied there: the
> >>>> bpftrace for collapse latencies, the perf record for the flamegraph
> >>>> (not actually that useful, but may be useful to visualize any
> >>>> weird/long paths that you may not have noticed), and the trace-cmd
> >>>> which records the tracepoint of the scan and the collapse functions
> >>>> then processes the data using the awk script-- the output being the
> >>>> scan rate, the pages collapsed, and their result status (grouped by
> >>>> order).
> >>>>
> >>>> You can also look into https://github.com/gormanm/mmtests for
> >>>> testing/comparing kernels. I was running the
> >>>> config-memdb-redis-benchmark-medium workload.
> >>>
> >>> Thanks. I'll take a look.
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Also, khugepaged, my changes, and your changes are all a victim of
> >>>>>> this. Once we drop the read lock (to either allocate the folio, or
> >>>>>> right before acquiring the write_lock), the state can change. In y=
our
> >>>>>> case, yes, you are gathering more up to date information, but is i=
t
> >>>>>> really that important/worth it to retake locks and rescan for each
> >>>>>> instance if we are about to reverify with the write lock taken?
> >>>>>
> >>>>> You said "reverify": You are removing the verification, so this ste=
p
> >>>>> won't be reverification, it will be verification. We do not want to
> >>>>> verify *after* we have already done 95% of latency-heavy stuff,
> >>>>> only to
> >>>>> know that we are going to fail.
> >>>>>
> >>>>> Algorithms in the kernel, in general, are of the following form: 1)
> >>>>> Verify if a condition is true, resulting in taking a control path -
> >>>>> > 2)
> >>>>> do a lot of stuff -> "no turning back" step, wherein before committ=
ing
> >>>>> (by taking locks, say), reverify if this is the control path we sho=
uld
> >>>>> be in. You are eliminating step 1).
> >>>>>
> >>>>> Therefore, I will have to say that I disagree with your approach.
> >>>>>
> >>>>> On top of this, in the subjective analysis in [1], point number 7
> >>>>> (along
> >>>>> with point number 1) remains. And, point number 4 remains.
> >>>>
> >>>> for 1) your worst case of 1024 is not the worst case. There are 8
> >>>> possible orders in your implementation, if all are enabled, that is
> >>>> 4096 iterations in the worst case.
> >>>
> >>> Yes, that is exactly what I wrote in 1). I am still not convinced tha=
t
> >>> the overhead you produce + 512 iterations is going to beat 4096
> >>> iterations. Anyways, that is hand-waving and we should test this.
> >>>
> >>>> This becomes WAY worse on 64k page size, ~45,000 iterations vs 4096
> >>>> in my case.
> >>>
> >>> Sorry, I am missing something here; how does the number of iterations
> >>> change with page size? Am I not scanning the PTE table, which is
> >>> invariant to the page size?
> >>
> >> I got the calculation wrong the first time and it's actually worst.
> >> Lets hope I got this right this time
> >> on ARM64 64k kernel:
> >> PMD size =3D 512M
> >> PTE=3D 64k
> >> PTEs per PMD =3D 8192
> >
> > *facepalm* my bad, thanks. I got thrown off thinking HPAGE_PMD_NR won't
> > depend on page size, but #pte entries =3D PAGE_SIZE / sizeof(pte) =3D
> > PAGE_SIZE / 8. So it does depend. You are correct, the PTEs per PMD is =
1
> > << 13.
> >
> >> log2(8192) =3D 13 - 2 =3D 11 number of (m)THP sizes including PMD (the
> >> first and second order are skipped)
> >>
> >> Assuming I understand your algorithm correctly, in the worst case you
> >> are scanning the whole PMD for each order.
> >>
> >> So you scan 8192 PTEs 11 times. 8192 * 11 =3D 90112.
> >
> > Yup. Now it seems that the bitmap overhead may just be worth it; for th=
e
> > worst case the bitmap will give us an 11x saving...for the average case=
,
> > it will give us 2x, but still, 8192 is a large number. I'll think of
>
> Clearing on this: the saving is w.r.t the initial scan. That is, if time
> taken by NP is x + y + collapse_huge_page(), where x is the PMD scan and
> y is the bitmap overhead, then time taken by DJ is 2x +
> collapse_huge_page(). In collapse_huge_page(), both perform PTE scans in
> _isolate(). Anyhow, we differ in opinion as to where the max_ptes_*
> check should be placed; I recalled the following:
>
> https://lore.kernel.org/all/20240809103129.365029-2-dev.jain@arm.com/
> https://lore.kernel.org/all/761ba58e-9d6f-4a14-a513-dcc098c2aa94@redhat.c=
om/
>
> One thing you can do to relieve one of my criticisms (not completely) is
> apply the following patch (this can be done in both methods):
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b589f889bb5a..dc5cb602eaad 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1080,8 +1080,14 @@ static int __collapse_huge_page_swapin(struct
> mm_struct *mm,
>                 }
>
>                 vmf.orig_pte =3D ptep_get_lockless(pte);
> -               if (!is_swap_pte(vmf.orig_pte))
> +               if (!is_swap_pte(vmf.orig_pte)) {
>                         continue;
> +               } else {
> +                       if (order !=3D HPAGE_PMD_ORDER) {
> +                               result =3D SCAN_EXCEED_SWAP_PTE;
> +                               goto out;
> +                       }
> +               }
>
>                 vmf.pte =3D pte;
>                 vmf.ptl =3D ptl;
> --
>
> But this really is the same thing being done in the links above :)

Yes my code already does this,
@@ -1035,6 +1039,11 @@ static int __collapse_huge_page_swapin(struct
mm_struct *mm,
                if (!is_swap_pte(vmf.orig_pte))
                        continue;

+               if (order !=3D HPAGE_PMD_ORDER) {
+                       result =3D SCAN_EXCEED_SWAP_PTE;
+                       goto out;
+               }
+
No need for the if/else nesting.
>
>
> > ways to test this out.
> >
> > Btw, I was made aware that an LWN article just got posted on our work!
> > https://lwn.net/Articles/1009039/
> >
> >>
> >> Please let me know if I'm missing something here.
> >>>
> >>>>>
> >>>>> [1]
> >>>>> https://lore.kernel.org/all/23023f48-95c6-4a24-ac8b-
> >>>>> aba4b1a441b4@arm.com/
> >>>>>
> >>>>>>
> >>>>>> So in my eyes, this is not a "problem"
> >>>>>
> >>>>> Looks like the kernel scheduled us for a high-priority debate, I ho=
pe
> >>>>> there's no deadlock :)
> >>>>>
> >>>>>>
> >>>>>> Cheers,
> >>>>>> -- Nico
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>>
> >>
> >
> >
>

