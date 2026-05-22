Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F252B375AC6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462428; cv=none; b=tGyWkS6lKiVTtb5viJi7VT9vWfOLXCbx5KC9EoM2JoUGr1H6SgyTZ+aBnrGgaDo+gH/07E02leoYRNjo2i4lT+f/YeYflg5dx1kN8XGPzBTLDb3TzZi1CWabhBI+MJDLx0D9HyeagmcYJNcxgtagw8LRzpI4hW9bOJG9YhJ0bVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462428; c=relaxed/simple;
	bh=kxzl6UubIzWwCbZVoF3sVMuj17rJrjk7Gh0Qp+BoDos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bs4KTqJvaD3hlSPMs+MgrB6UZtwuhoy84SaZ3+PLxW3/pKDesoAG0MGWZ/1Wohr49fky4TMDqHRBQe+7z+uqOH9r5UzlIACqVcR3Fj2xIpypaYadh5d0BntnuM8swMmxqItIaujWtzmN7SUv3U43siJpVMy1nRaMBfS1Mi2XWuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/fsvzmJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/fsvzmJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779462425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C8vDvm5iESvVgdUD7id3MqbrPnPABwU+5C7h6hrTleA=;
	b=a/fsvzmJOsas6n3uROA/M1tBCwn/mwMOL0UvK7WA6XyvOO58SJg8RvN716zlV80OYrakcX
	zrAzrUe0EeChc29kfzJahqC3kbdwCDoAIWLkxha5YEuCdc1Qsw1TJLSPqV+gdRb3IHT03Y
	HA2x106H1bl/Pn/zawvo88ijn++Dy9g=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-IcD7Mk0DMTaIOHJue0SVKA-1; Fri, 22 May 2026 11:07:04 -0400
X-MC-Unique: IcD7Mk0DMTaIOHJue0SVKA-1
X-Mimecast-MFC-AGG-ID: IcD7Mk0DMTaIOHJue0SVKA_1779462423
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-65d9e66d0e1so2671270d50.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 08:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779462423; x=1780067223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C8vDvm5iESvVgdUD7id3MqbrPnPABwU+5C7h6hrTleA=;
        b=s+UrgD76gRxoR9h9v8Vu76ibKYTZr4emuvBr0ifee9B3tS+UrR1UjrVBv/BWO9iWQ3
         gNu5ciULD7oKfgULzDWCFGimqQ9viqvWH+xr0KAoUTA7hka/iDs/Y9KX3A3hskpOObrh
         1fYircjx7Ho6MnXzftGb9Bm0NXmF0gXq2S71dtixmRprGL6qGJv5PLkw7mgXFLXMtsZu
         I07FVdg1C1/2BcynZ/At8VUqEcOLAWrf9gWYNcZAY5BZt4J5ND3WV1Qvax4ZNJrrEFAa
         gxknOpzekqWZcWAUUbvz2tFRsXzwPzuahs19xH/L+pwk364kGMxeM9Kd71tV+0uhBw4z
         NJnw==
X-Forwarded-Encrypted: i=1; AFNElJ8g0vpPOhjYs9puYzP5G3Dz0re7aC2WNyVYfI6PEC8eTIVq9C/DcbpCbhj6vb2S3kkpub1elPLJUvXbxg1BF1B5eLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3H4o9ivbcAxfJo68GZzraNLqyI3dV3SJVG3C6IfLjnBmMs4Xo
	4xrcmcUvPY3g9cajOXbDZB4sit9j9biM3JO9NvvWavSEZ3HDKiiZL0WvFWTC9DOqUSIYkY/ZG6r
	Rhp2RTv763TTyX24ViT3encp9f6Hyw4NARiQrKdpZlDezQpgUI16UGlu1pSxuLi7782AGfEIz4w
	9oxZr8+/hS63fTNqAlbFTXGDLnQtwrZENh5XfNQd4aUu6dMWBUIcBNujhpdkDv2Q==
X-Gm-Gg: Acq92OGeS0Jw4DAQeSaheBySE0kUSyDuauzN4G42xzP776aASDsHEXNP3paetznmYUz
	NtD4yef9zQAvE8AGYVNFSOt1vU98K7JA88IgYjnZYRxlOyWEF0kTFUGv09yoGBBAAry/cvQJYYE
	/N2VvwqL805/UVc7e2OaaXnER1/QAh+U1nZivubIU0TOy7QOq9H9244ph80YSzN52I/Zwv4VKo0
	ZmJeg==
X-Received: by 2002:a53:cc4f:0:b0:65d:6eed:4a48 with SMTP id 956f58d0204a3-65ec98043f0mr3360982d50.28.1779462421542;
        Fri, 22 May 2026 08:07:01 -0700 (PDT)
X-Received: by 2002:a53:cc4f:0:b0:65d:6eed:4a48 with SMTP id
 956f58d0204a3-65ec98043f0mr3360911d50.28.1779462420768; Fri, 22 May 2026
 08:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522150009.121603-1-npache@redhat.com>
In-Reply-To: <20260522150009.121603-1-npache@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 22 May 2026 09:07:29 -0600
X-Gm-Features: AVHnY4J5qmdjKp5TI3UGWiO02TMrdukroSBQHh9ZQnZ42zy9Br5VFR_OymGl7kk
Message-ID: <CAA1CXcCoDU_pnp0SmMzRi8wPGB1OBjbbokevq2X_03X1vpWtOw@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes-unstable v18 00/14] khugepaged: add mTHP
 collapse support
To: linux-doc@vger.kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Cc: aarcange@redhat.com, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	liam@infradead.org, ljs@kernel.org, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3kuQENUeBe0Bahqwq3FU6WI3w2hMK3yPIdperMPbk1g_1779462423
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 8:59=E2=80=AFAM Nico Pache <npache@redhat.com> wrot=
e:
>
> The following series provides khugepaged with the capability to collapse
> anonymous memory regions to mTHPs.
>
> To achieve this we generalize the khugepaged functions to no longer depen=
d
> on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individu=
al
> pages that are occupied (!none/zero). After the PMD scan is done, we use
> the bitmap to find the optimal mTHP sizes for the PMD range. The
> restriction on max_ptes_none is removed during the scan, to make sure we
> account for the whole PMD range in the bitmap. When no mTHP size is
> enabled, the legacy behavior of khugepaged is maintained.
>
> We currently only support max_ptes_none values of 0 or HPAGE_PMD_NR - 1
> (ie 511). If any other value is specified, the kernel will emit a warning
> and mTHP collapse will default to max_ptes_none=3D0. If a mTHP collapse i=
s
> attempted, but contains swapped out, or shared pages, we don't perform
> the collapse.
> It is now also possible to collapse to mTHPs without requiring the PMD TH=
P
> size to be enabled. These limitations are to prevent collapse "creep"
> behavior. This prevents constantly promoting mTHPs to the next available
> size, which would occur because a collapse introduces more non-zero pages
> that would satisfy the promotion condition on subsequent scans.
>
> Patch 1-2:   Generalize hugepage_vma_revalidate and alloc_charge_folio
>              for arbitrary orders.
> Patch 3:     Rework max_ptes_* handling into helper functions
> Patch 4:     Generalize __collapse_huge_page_* for mTHP support
> Patch 5:     Require collapse_huge_page to enter/exit with the lock dropp=
ed
> Patch 6:     Generalize collapse_huge_page for mTHP collapse
> Patch 7:     Skip collapsing mTHP to smaller orders
> Patch 8-9:   Add per-order mTHP statistics and tracepoints
> Patch 10:    Introduce collapse_allowable_orders helper function
> Patch 11-13: Introduce bitmap and mTHP collapse support, fully enabled
> Patch 14:    Documentation
>
> Testing:
> - Built for x86_64, aarch64, ppc64le, and s390x
> - ran all arches on test suites provided by the kernel-tests project
> - internal testing suites: functional testing and performance testing
> - selftests mm
> - I created a test script that I used to push khugepaged to its limits
>    while monitoring a number of stats and tracepoints. The code is
>    available here[1] (Run in legacy mode for these changes and set mthp
>    sizes to inherit)
>    The summary from my testings was that there was no significant
>    regression noticed through this test. In some cases my changes had
>    better collapse latencies, and was able to scan more pages in the same
>    amount of time/work, but for the most part the results were consistent=
.
> - redis testing. I did some testing with these changes along with my defe=
r
>   changes (see followup [2] post for more details). We've decided to get
>   the mTHP changes merged first before attempting the defer series.
> - some basic testing on 64k page size.
> - lots of general use.
>
> [1] - https://gitlab.com/npache/khugepaged_mthp_test
> [2] - https://lore.kernel.org/lkml/20250515033857.132535-1-npache@redhat.=
com/
>
> V18 Changes:
> - Added RBs/Acks
> - [patch 02] Guard count_memcg_folio_events with is_pmd_order() to keep
>   THP_COLLAPSE_ALLOC PMD-only (Usama, Lance)
> - [patch 03] Convert C++ comments to C-style; fix "none-page" terminology
>   to "empty PTEs or PTEs mapping the shared zeropage"; drop unnecessary
>   userfaultfd comment; add const to local max_ptes_* variables; fix
>   "repect" typo (Lance, David)
> - [patch 04] collapse_max_ptes_none() now returns 0 instead of -EINVAL fo=
r
>   unsupported values; remove SCAN_INVALID_PTES_NONE; change return type
>   from int to unsigned int and propagate to all callers; add comment abov=
e
>   __collapse_huge_page_swapin explaining mTHP swap bail-out (David,
>   Lorenzo, Lance, Wei Yang, Usama)
> - [patch 05] Rewrite collapse_huge_page lock comment to David's suggested
>   wording (David)
> - [patch 11] Propagate unsigned int return type for max_ptes_none; remove
>   the now-unnecessary negative return check (consequence of patch 04);
>   Add optimization to the next_order goto that will prevent unnecessary
>   iterations if there are no lower orders enabled (Vernon); update lockin=
g
>   comment; pass VMA to mthp_collapse to improve uffd-armed detection, and
>   prevent unnecessary work. (Wei)
> - [patch 14] Update documentation to reflect fallback-to-0 behavior
>
> V17: https://lore.kernel.org/all/20260511185817.686831-1-npache@redhat.co=
m
> V16: https://lore.kernel.org/all/20260419185750.260784-1-npache@redhat.co=
m
> V15: https://lore.kernel.org/all/20260226031741.230674-1-npache@redhat.co=
m
> V14: https://lore.kernel.org/all/20260122192841.128719-1-npache@redhat.co=
m
> V13: https://lore.kernel.org/all/20251201174627.23295-1-npache@redhat.com
> V12: https://lore.kernel.org/all/20251022183717.70829-1-npache@redhat.com
> V11: https://lore.kernel.org/all/20250912032810.197475-1-npache@redhat.co=
m
> V10: https://lore.kernel.org/all/20250819134205.622806-1-npache@redhat.co=
m
> V9 : https://lore.kernel.org/all/20250714003207.113275-1-npache@redhat.co=
m
> V8 : https://lore.kernel.org/all/20250702055742.102808-1-npache@redhat.co=
m
> V7 : https://lore.kernel.org/all/20250515032226.128900-1-npache@redhat.co=
m
> V6 : https://lore.kernel.org/all/20250515030312.125567-1-npache@redhat.co=
m
> V5 : https://lore.kernel.org/all/20250428181218.85925-1-npache@redhat.com
> V4 : https://lore.kernel.org/all/20250417000238.74567-1-npache@redhat.com
> V3 : https://lore.kernel.org/all/20250414220557.35388-1-npache@redhat.com
> V2 : https://lore.kernel.org/all/20250211003028.213461-1-npache@redhat.co=
m
> V1 : https://lore.kernel.org/all/20250108233128.14484-1-npache@redhat.com
>
> Baolin Wang (1):
>   mm/khugepaged: run khugepaged for all orders
>
> Dev Jain (1):
>   mm/khugepaged: generalize alloc_charge_folio()
>
> Nico Pache (12):
>   mm/khugepaged: generalize hugepage_vma_revalidate for mTHP support
>   mm/khugepaged: rework max_ptes_* handling with helper functions
>   mm/khugepaged: generalize __collapse_huge_page_* for mTHP support
>   mm/khugepaged: require collapse_huge_page to enter/exit with the lock
>     dropped
>   mm/khugepaged: generalize collapse_huge_page for mTHP collapse
>   mm/khugepaged: skip collapsing mTHP to smaller orders
>   mm/khugepaged: add per-order mTHP collapse failure statistics
>   mm/khugepaged: improve tracepoints for mTHP orders
>   mm/khugepaged: introduce collapse_allowable_orders helper function
>   mm/khugepaged: Introduce mTHP collapse support
>   mm/khugepaged: avoid unnecessary mTHP collapse attempts
>   Documentation: mm: update the admin guide for mTHP collapse
>
>  Documentation/admin-guide/mm/transhuge.rst |  72 ++-
>  include/linux/huge_mm.h                    |   5 +
>  include/trace/events/huge_memory.h         |  34 +-
>  mm/huge_memory.c                           |  11 +
>  mm/khugepaged.c                            | 634 ++++++++++++++++-----
>  5 files changed, 584 insertions(+), 172 deletions(-)
>
>
> base-commit: 6c8cb505a5634594b3ea159fd1c71bce2acf3346

Whoops I manually changed the coverletter subject to reflect that this
in on mm-hotfixes-unstable but never updated the others...

Hopefully that is ok. Just a small mistake. Base commit is referenced here.

-- Nico


> --
> 2.54.0
>

