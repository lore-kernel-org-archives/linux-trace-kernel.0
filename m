Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F4D3403FF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217493; cv=none; b=qqGstHiJSEmtnebpPVHq9Rb7842isHSvwhMwvv1Dt6HwD8UHWTDlQNexh0f+NP+yX/faAImd5F3I1OMyFhtdyi6X1cImgm4B65OCV53uKyDbq6yRNpnaTD4VjMjsYB8SEuLoChHuq1HoNcI8HymUkyH1IaeN7/Iqd9X7kAdksNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217493; c=relaxed/simple;
	bh=QfTtzYfmqDmMMMUFFZFVVPoFFhsAn1eLD8s+N4VERkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKa6KEgyAW1otog7usYRUb524dy9JJdAAQy3QYbjIHHAU7Z6r+S/xBVzWdGvx5OCJkCMNJ7vd64i4bAMKBA4k2KXUhfFQOaLCWlTZ2l4Jyg+jfo9MoNH2AhqPHRRYn+vbbfOHdUcqWE39hbx8hYy2ooW8o/yTfGezud0AGYpwXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7/eRn3c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7/eRn3c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779217490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdK8pqH2D0m9mcbmDtYLUTUETzL6tUWdDDlDwj+C1AA=;
	b=Z7/eRn3chMMxVNwmXIAM4g0kPRRT73uNirZIvbp3snXF1nczaCpy1RGE4n87feOXrnxNE8
	OMv3VBU3gjeFijUY4MbH2OafBiif1v43sIT0hsCe83AyoNHgPNYcs8uqNVa6hQMhmyxepo
	lerM6U6q6SXlvrjT84+F9W5+vir0yxw=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-NnS5DHRLODKowWb9GXWLZg-1; Tue, 19 May 2026 15:04:48 -0400
X-MC-Unique: NnS5DHRLODKowWb9GXWLZg-1
X-Mimecast-MFC-AGG-ID: NnS5DHRLODKowWb9GXWLZg_1779217488
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-651bd07888eso7922657d50.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 12:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217488; x=1779822288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EdK8pqH2D0m9mcbmDtYLUTUETzL6tUWdDDlDwj+C1AA=;
        b=WgpBTog54+LiS6tkM9J6jJ93YqFQ/P7DVYIUYy+2bQv1Vw4DlzTzZmaWGrwjUUXqPr
         LvS916B2pAyPGyvEjbyK5oJjZuy59ZAxFLO3xq8Rfz4IyL9lRyBwSOOQbygqz/fFMRzo
         H/Cl+ymMtNaEX+9K8yWjsb6Jb1E3USUl7oSEw3WlrjfKnAJUXGyPy9keEW+UWLtv2RYN
         e8jgN0N8aVSMTyAxKsAXrRexIP35+xHXQmWBJ4R6FJbmgFDes/lTudpDAhoJClE9IOSd
         Qi3LksMwW290KTJaiquGL8QI+Lfy/jzgsqIGoCR4G6HL8vtnQ1D8EDQtcyAjki0GpVRL
         CVjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9iodkIK4CVBa+50kRpobRjowhMIyOEiwdqoEMEfoTQytDI8VS6XPjl2gZvKlGTKmBh8s31iiKpBbMJciaqj6VvOAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp/1R57zOcNVgUv4Pw4hnuvBVwA3g7PxSVfg+fnKdDW5YnVA/7
	WPfsOfBlkUmNi9YNH/XQLmFaSTJtq3EvCvIcC65qCxRSpci+IhL54Ex04HZRsXKp3d5hukzP86V
	DRO6uykoN+IsdsGtTKxqDuf+v7zXgGxMaTAgZ0aeLu60O7Qwipxkjcl20mcxAoKywGGjONYljg/
	36LgmUjEQjqzPpVEv4Rw6DLTSG08B61U3Ql6GtHiP2yec5oVuo
X-Gm-Gg: Acq92OHoNyIcumUa4JD/4Knd+YyCgXLRUBO6jfrDnIEuonL6C28GSxmdbnsTWyaBtZi
	GeG1xHiiKWLMjs2PFBzHx9qjMExpjnwUen4fQEQsN4AgOOvaF01HOpVMBT7UZM/l0Iv1RK4cWy4
	RTa178DM5OiExTEbld0BBGm4f/qun/l/N9jcVD0Ser46V3e9LUGRB4CYEfhEL3a5+UrSf8AP8s+
	t03Cw==
X-Received: by 2002:a05:690e:2501:10b0:65c:47ad:26bf with SMTP id 956f58d0204a3-65e2273392cmr16423699d50.26.1779217487466;
        Tue, 19 May 2026 12:04:47 -0700 (PDT)
X-Received: by 2002:a05:690e:2501:10b0:65c:47ad:26bf with SMTP id
 956f58d0204a3-65e2273392cmr16423607d50.26.1779217486858; Tue, 19 May 2026
 12:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511185817.686831-5-npache@redhat.com> <20260512074202.10253-1-lance.yang@linux.dev>
 <20260514031009.f66cgop3ctgiqxz3@master> <9b33339e-157a-45b7-942e-3be3418a5142@kernel.org>
 <agtpK1x27B-E7mMo@lucifer>
In-Reply-To: <agtpK1x27B-E7mMo@lucifer>
From: Nico Pache <npache@redhat.com>
Date: Tue, 19 May 2026 13:05:13 -0600
X-Gm-Features: AVHnY4LuRYw_wlCmtpeGYvsNgJpUKgBu0LIIMlaqigtwM5P2pHzw9Gmm6LpfRD0
Message-ID: <CAA1CXcCNT51jeXh6Kwg1QN9e+AJB-1hg21kmeY6fTTKr2GACug@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v17 04/14] mm/khugepaged: generalize
 __collapse_huge_page_* for mTHP support
To: Lorenzo Stoakes <ljs@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Lance Yang <lance.yang@linux.dev>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	liam@infradead.org, mathieu.desnoyers@efficios.com, matthew.brost@intel.com, 
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, 
	rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, 
	surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de, 
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IQWgsiUCCxbrDZl9skoUw8l3r3NEE8qk3wg3HlEUVMo_1779217488
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 1:33=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> On Mon, May 18, 2026 at 03:16:11PM +0200, David Hildenbrand (Arm) wrote:
> > On 5/14/26 05:10, Wei Yang wrote:
> > > On Tue, May 12, 2026 at 03:42:02PM +0800, Lance Yang wrote:
> > >>
> > >> On Mon, May 11, 2026 at 12:58:04PM -0600, Nico Pache wrote:
> > >>> generalize the order of the __collapse_huge_page_* and collapse_max=
_*
> > >>> functions to support future mTHP collapse.
> > >>>
> > >>> The current mechanism for determining collapse with the
> > >>> khugepaged_max_ptes_none value is not designed with mTHP in mind. T=
his
> > >>> raises a key design issue: if we support user defined max_pte_none =
values
> > >>> (even those scaled by order), a collapse of a lower order can intro=
duces
> > >>> an feedback loop, or "creep", when max_ptes_none is set to a value =
greater
> > >>> than HPAGE_PMD_NR / 2. [1]
> > >>>
> > >>> With this configuration, a successful collapse to order N will popu=
late
> > >>> enough pages to satisfy the collapse condition on order N+1 on the =
next
> > >>> scan. This leads to unnecessary work and memory churn.
> > >>>
> > >>> To fix this issue introduce a helper function that will limit mTHP
> > >>> collapse support to two max_ptes_none values, 0 and HPAGE_PMD_NR - =
1.
> > >>> This effectively supports two modes: [2]
> > >>>
> > >>> - max_ptes_none=3D0: never collapses if it encounters an empty PTE =
or a PTE
> > >>>  that maps the shared zeropage. Consequently, no memory bloat.
> > >>> - max_ptes_none=3D511 (on 4k pagesz): Always collapse to the highes=
t
> > >>>  available mTHP order.
> > >>>
> > >>> This removes the possiblilty of "creep", while not modifying any uA=
PI
> > >>> expectations. A warning will be emitted if any non-supported
> > >>> max_ptes_none value is configured with mTHP enabled.
> > >>>
> > >>> mTHP collapse will not honor the khugepaged_max_ptes_shared or
> > >>> khugepaged_max_ptes_swap parameters, and will fail if it encounters=
 a
> > >>> shared or swapped entry.
> > >>>
> > >>> No functional changes in this patch; however it defines future beha=
vior
> > >>> for mTHP collapse.
> > >>>
> > >>> [1] - https://lore.kernel.org/all/e46ab3ab-a3d7-4fb7-9970-d0704bd5d=
05a@arm.com
> > >>> [2] - https://lore.kernel.org/all/37375ace-5601-4d6c-9dac-d1c826869=
8e9@redhat.com
> > >>>
> > >>> Co-developed-by: Dev Jain <dev.jain@arm.com>
> > >>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> > >>> Signed-off-by: Nico Pache <npache@redhat.com>
> > >>> ---
> > >>> include/trace/events/huge_memory.h |   3 +-
> > >>> mm/khugepaged.c                    | 117 ++++++++++++++++++++------=
---
> > >>> 2 files changed, 85 insertions(+), 35 deletions(-)
> > >>>
> > >>> diff --git a/include/trace/events/huge_memory.h b/include/trace/eve=
nts/huge_memory.h
> > >>> index bcdc57eea270..443e0bd13fdb 100644
> > >>> --- a/include/trace/events/huge_memory.h
> > >>> +++ b/include/trace/events/huge_memory.h
> > >>> @@ -39,7 +39,8 @@
> > >>>   EM( SCAN_STORE_FAILED,          "store_failed")                 \
> > >>>   EM( SCAN_COPY_MC,               "copy_poisoned_page")           \
> > >>>   EM( SCAN_PAGE_FILLED,           "page_filled")                  \
> > >>> - EMe(SCAN_PAGE_DIRTY_OR_WRITEBACK, "page_dirty_or_writeback")
> > >>> + EM(SCAN_PAGE_DIRTY_OR_WRITEBACK, "page_dirty_or_writeback")     \
> > >>> + EMe(SCAN_INVALID_PTES_NONE,     "invalid_ptes_none")
> > >>>
> > >>> #undef EM
> > >>> #undef EMe
> > >>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > >>> index f68853b3caa7..27465161fa6d 100644
> > >>> --- a/mm/khugepaged.c
> > >>> +++ b/mm/khugepaged.c
> > >>> @@ -61,6 +61,7 @@ enum scan_result {
> > >>>   SCAN_COPY_MC,
> > >>>   SCAN_PAGE_FILLED,
> > >>>   SCAN_PAGE_DIRTY_OR_WRITEBACK,
> > >>> + SCAN_INVALID_PTES_NONE,
> > >>> };
> > >>>
> > >>> #define CREATE_TRACE_POINTS
> > >>> @@ -353,37 +354,60 @@ static bool pte_none_or_zero(pte_t pte)
> > >>>  * PTEs for the given collapse operation.
> > >>>  * @cc: The collapse control struct
> > >>>  * @vma: The vma to check for userfaultfd
> > >>> + * @order: The folio order being collapsed to
> > >>>  *
> > >>>  * Return: Maximum number of none-page or zero-page PTEs allowed fo=
r the
> > >>>  * collapse operation.
> > >>>  */
> > >>> -static unsigned int collapse_max_ptes_none(struct collapse_control=
 *cc,
> > >>> -         struct vm_area_struct *vma)
> > >>> +static int collapse_max_ptes_none(struct collapse_control *cc,
> > >>> +         struct vm_area_struct *vma, unsigned int order)
> > >>> {
> > >>> + unsigned int max_ptes_none =3D khugepaged_max_ptes_none;
> > >>>   // If the vma is userfaultfd-armed, allow no none-page or zero-pa=
ge PTEs.
> > >>
> > >> One thing I still want to call out: kernel code usually uses C-style
> > >> comments :)
> > >>
> > >>>   if (vma && userfaultfd_armed(vma))
> > >>>           return 0;
> > >>>   // for MADV_COLLAPSE, allow any none-page or zero-page PTEs.
> > >>>   if (!cc->is_khugepaged)
> > >>>           return HPAGE_PMD_NR;
> > >>> - // For all other cases repect the user defined maximum.
> > >>> - return khugepaged_max_ptes_none;
> > >>> + // for PMD collapse, respect the user defined maximum.
> > >>> + if (is_pmd_order(order))
> > >>> +         return max_ptes_none;
> > >>> + /* Zero/non-present collapse disabled. */
> > >>> + if (!max_ptes_none)
> > >>> +         return 0;
> > >>> + // for mTHP collapse with the sysctl value set to KHUGEPAGED_MAX_=
PTES_LIMIT,
> > >>> + // scale the maximum number of PTEs to the order of the collapse.
> > >>> + if (max_ptes_none =3D=3D KHUGEPAGED_MAX_PTES_LIMIT)
> > >>> +         return (1 << order) - 1;
> > >>> +
> > >>> + // We currently only support max_ptes_none values of 0 or KHUGEPA=
GED_MAX_PTES_LIMIT.
> > >>> + // Emit a warning and return -EINVAL.
> > >>> + pr_warn_once("mTHP collapse only supports max_ptes_none values of=
 0 or %u\n",
> > >>> +               KHUGEPAGED_MAX_PTES_LIMIT);
> > >>
> > >> Maybe fallback to 0 instead, as David suggested earlier?
> > >>
> > >
> > > It looks reasonable to fallback to 0.
> > >
> > > But as the updated Document says in patch 14:
> > >
> > >   For mTHP collapse, only 0 or (HPAGE_PMD_NR - 1) are supported. Any =
other
> > >   value will emit a warning and no mTHP collapse will be attempted.
> > >
> > > This is why it does like this now.
> > >
> > >     mthp_collapse()
> > >         max_ptes_none =3D collapse_max_ptes_none();
> > >         if (max_ptes_none < 0)
> > >             return collapsed;
> > >
> > >> max_ptes_none is mostly legacy PMD THP behavior. mTHP is new, and an=
y
> > >> intermediate value in (0, KHUGEPAGED_MAX_PTES_LIMIT) would implicitl=
y
> > >> disable it :(
> > >>
> > >
> > > So it depends on what we want to do here :-)
> > >
> > > For me, I would vote for fallback to 0.
> >
> > At this point I'll prefer to not return errors from collapse_max_ptes_n=
one().
> > It's just rather awkward to return an error deep down in collapse code =
for a
> > configuration problem.
> >
> > For mthp collapse, we only support max_ptes_none=3D=3D0 and
> > max_ptes_none=3D=3D"HPAGE_PMD_NR - 1" (default).
> >
> > If another value is specified while collapsing mTHP, print a warning an=
d treat
> > it as 0 (save value, no creep, no memory waste).
> >
> > In a sense, this is similar to how we handle max_ptes_shared + max_ptes=
_swap:
> > for mTHP: we always treat them as being 0 for mTHP collapse (and don't =
issue a
> > warning, because we would issue a warning with the default settings).
> >
> > @Lorenzo, fine with you?
>
> Yes 100%, this sounds sensible both in terms of the error and the default=
. Let's
> keep our lives simple(-ish) please :)

Ok thank you im glad we finally came to consensus on this! phew!

>
> >
> > --
> > Cheers,
> >
> > David
>
> Cheers, Lorenzo
>

