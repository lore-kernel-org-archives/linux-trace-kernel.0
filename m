Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D260E41C30A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486905; cv=none; b=DcPZ0a/RRcl8VSrdVv5M/u815S9I2FVtWGfGmixhsFdGUWm69S3ZYEXAWiwbbHNxHjwBKTWQngXnUNr4WZxS1sp1mvyOi3CQtfi3ki+J2rNiF7Fmr7fHc7cXUo307jElIyXaOASr1cjorTdklodZWF3CEdKsUWn/yH20kTQZL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486905; c=relaxed/simple;
	bh=zOH4706QFtvPpHCn7hxOyOFo31Xjg5Ci7H1MCZS6+GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBtZW3dyRvVHb1Im6vGlah2hqaErb6sE2BX8nV4Tq/G0QyW55PL4NVnZ4vdZiYSjAwle7bF52ae8Kk0jNtrCW6hq5UgNxjz+/VZtTOICFX25wDzj6udOIpV+vUoZ5VRkll+W84VyDbvyKG7fxpqyob/b97g2tv8qGIQNExC2+V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KAs2Mady; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAs2Mady"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777486902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dxp2OvQZDPavnweLX6lwyfQ94IEOmBtp4q9eBxrMuPM=;
	b=KAs2Madys8XHdJCOMOvp/H/va/oJaHBVf7G6WRjO9C3UsYjFPj2CXjST8g6KA+RvEKwixu
	1gLyqqoOweMJhohwOHQ+OE5lUgxP9/ByDUodoirabpcRy7knDbBzJsZ+zxJKlF+7g0Zv4S
	8yUbZaanxwOa7f4mCox0kDT6GGpI5so=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-BDhhy-eqPv-cDpoQgVYffg-1; Wed, 29 Apr 2026 14:21:39 -0400
X-MC-Unique: BDhhy-eqPv-cDpoQgVYffg-1
X-Mimecast-MFC-AGG-ID: BDhhy-eqPv-cDpoQgVYffg_1777486899
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-651bd9b4bccso51595d50.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Apr 2026 11:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777486899; x=1778091699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dxp2OvQZDPavnweLX6lwyfQ94IEOmBtp4q9eBxrMuPM=;
        b=frt0yitTBm/DTi2ItKqi0MuSQyZ8Cah5cRgILjj50wycGGyMa3LS7g6BQKOgegntbL
         QRKBANar71X0Ds3T86o8IQAgrHPy+D8HkZC3eRxyDyc8rAokU8AalBd831/mq/b9SWde
         ebRQ6ZFuoBiP4LnnHoh6mzUwMqOOV0NOeWtEEku3ChBciBHLq3qxbQclMl9sZLWx2rVv
         ZNv5syqvsZYjTpF62aatQd6bI5SoHSqkGBRhQVD2t0ns6BUKtYgCZppNuokcM9cOinJf
         r9DQnPHTaKbyPCzVkMkQpyPo8b1IG4yYWtr5f7xhSaYvCsC7rdIxonz+34tYMEVy876B
         RxJw==
X-Forwarded-Encrypted: i=1; AFNElJ9t5JwSxNOnJQc6kqF+AlrYIKKv9xL+SLxAJjmZxk/T9xZ8miNFbG0KjgzKw9/CG8E8E8bpQNYmDpHObA2KYxXDmSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfVK/cn2tVw1I1PDnhV5y/CjvIktg3LiJ4gbQXLX7X1kqspM2o
	KtNO3TXLg751Y8c0HYD3ep4efLEyrNboeoQGGX00601z7g3biWOECXU8U4+ORwVLKmVGsS6M4Xg
	nBIkvDVyi64fjPeCKS9nt/lHUpPLGhktoWaAl1zX182RuXhpeyZsyKalUspFFFLRjoByQWNt0I3
	s/HWsEGBi0YBW31iuxChXWW8daWiibMCKbz4inmPMOucaIFeYo
X-Gm-Gg: AeBDietiWPlWgOzeUL0A+zMLzRkiM6WdCZZob2IR7Ds6JUxaWdDXJji8h1+zZsVtKXT
	DivflUh6iHrMd0CxB4L9PxXLHmvGBgBXm1MbIQ+0xTJ45hRzL7+SD59KngQj0mzwO6qDllcqhKF
	EDgGdYRcvNH6KuMAa/INxmetdcQgFLyIkSImqS3m3wU6gLoAD5TeTbLiYYJdzilEfR/rKPxKmfW
	FpYbsI/dvuPZ7uLDW4oA7TFdWNpYpAfdqcVIm0j70WID7/Z3pc=
X-Received: by 2002:a05:690e:118a:b0:651:d047:caf5 with SMTP id 956f58d0204a3-65beeba82dbmr8444912d50.0.1777486899067;
        Wed, 29 Apr 2026 11:21:39 -0700 (PDT)
X-Received: by 2002:a05:690e:118a:b0:651:d047:caf5 with SMTP id
 956f58d0204a3-65beeba82dbmr8444840d50.0.1777486898433; Wed, 29 Apr 2026
 11:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419185750.260784-1-npache@redhat.com> <20260419185750.260784-8-npache@redhat.com>
 <f05f4506-2930-44ba-918a-e0e5bcb9d0f9@kernel.org>
In-Reply-To: <f05f4506-2930-44ba-918a-e0e5bcb9d0f9@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Wed, 29 Apr 2026 12:21:44 -0600
X-Gm-Features: AVHnY4J7CcVYR4f6zugXAbo8lWmkYfpdhB-nBSIbQmMf8QVrNFkAXtwT9seofNU
Message-ID: <CAA1CXcA-YtEiWYZaBW05Y9B_JMixu4SXaQO9KZoG-hNCF9oPHA@mail.gmail.com>
Subject: Re: [PATCH 7.2 v16 07/13] mm/khugepaged: add per-order mTHP collapse
 failure statistics
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Cc: aarcange@redhat.com, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	lance.yang@linux.dev, Liam.Howlett@oracle.com, ljs@kernel.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, 
	mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, 
	raquini@redhat.com, rdunlap@infradead.org, richard.weiyang@gmail.com, 
	rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, 
	surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de, 
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NABblgcz816OObPGGuC4XWVoyEj9BXM29BfdUz1MhUY_1777486899
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On 4/27/26 2:21 PM, David Hildenbrand (Arm) wrote:
> On 4/19/26 20:57, Nico Pache wrote:
>> Add three new mTHP statistics to track collapse failures for different
>> orders when encountering swap PTEs, excessive none PTEs, and shared PTEs:
>>
>> - collapse_exceed_swap_pte: Increment when mTHP collapse fails due to swap
>>      PTEs
>>
>> - collapse_exceed_none_pte: Counts when mTHP collapse fails due to
>>      exceeding the none PTE threshold for the given order
>>
>> - collapse_exceed_shared_pte: Counts when mTHP collapse fails due to shared
>>      PTEs
>>
>> These statistics complement the existing THP_SCAN_EXCEED_* events by
>> providing per-order granularity for mTHP collapse attempts. The stats are
>> exposed via sysfs under
>> `/sys/kernel/mm/transparent_hugepage/hugepages-*/stats/` for each
>> supported hugepage size.
>>
>> As we currently dont support collapsing mTHPs that contain a swap or
>
> s/dont/do not/
>
>> shared entry, those statistics keep track of how often we are
>> encountering failed mTHP collapses due to these restrictions.
>>
>> Now that we plan to support mTHP collapse for anon pages, lets also track
>
> "We will add support for mTHP collapse for anonymous pages next; let's also ..."
>
>> when this happens at the PMD level within the per-mTHP stats.
>
> What about file collapse? For example, we do adjust
> count_vm_event(THP_SCAN_EXCEED_SWAP_PTE) and
> count_vm_event(THP_SCAN_EXCEED_NONE_PTE) there.
>
> Wouldn't we want to update the HPAGE_PMD_ORDER side of things there already? or
> would we want to use a different counter for that?

Maybe? My thought process was that because we dont support mTHP in Shmem
that those stats shouldnt be updated? not sure the right answer tbh--
hence why this comment says "now that.. for anon pages, lets track..".

>
>>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>   Documentation/admin-guide/mm/transhuge.rst | 24 ++++++++++++++++++++++
>>   include/linux/huge_mm.h                    |  3 +++
>>   mm/huge_memory.c                           |  7 +++++++
>>   mm/khugepaged.c                            | 21 +++++++++++++++++--
>>   4 files changed, 53 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>> index c51932e6275d..eebb1f6bbc6c 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>> @@ -714,6 +714,30 @@ nr_anon_partially_mapped
>>          an anonymous THP as "partially mapped" and count it here, even though it
>>          is not actually partially mapped anymore.
>>
>> +collapse_exceed_none_pte
>> +       The number of collapse attempts that failed due to exceeding the
>> +       max_ptes_none threshold. For mTHP collapse, Currently only max_ptes_none
>> +       values of 0 and (HPAGE_PMD_NR - 1) are supported. Any other value will
>> +       emit a warning and no mTHP collapse will be attempted. khugepaged will
>> +       try to collapse to the largest enabled (m)THP size; if it fails, it will
>> +       try the next lower enabled mTHP size. This counter records the number of
>> +       times a collapse attempt was skipped for exceeding the max_ptes_none
>> +       threshold, and khugepaged will move on to the next available mTHP size.
>
> Why is everything after the first sentence worth documenting here? This doesn't
> read like it belongs to a failure counter?
>
>> +
>> +collapse_exceed_swap_pte
>> +       The number of anonymous mTHP PTE ranges which were unable to collapse due
>> +       to containing at least one swap PTE. Currently khugepaged does not
>> +       support collapsing mTHP regions that contain a swap PTE. This counter can
>> +       be used to monitor the number of khugepaged mTHP collapses that failed
>> +       due to the presence of a swap PTE.
>
> Can we similarly simplify that (and make it consistent with the one above) to
>
> "The number of collapse attempts that failed due to exceeding the max_ptes_swap
> threshold."
>
>> +
>> +collapse_exceed_shared_pte
>> +       The number of anonymous mTHP PTE ranges which were unable to collapse due
>> +       to containing at least one shared PTE. Currently khugepaged does not
>> +       support collapsing mTHP PTE ranges that contain a shared PTE. This
>> +       counter can be used to monitor the number of khugepaged mTHP collapses
>> +       that failed due to the presence of a shared PTE.
>
> Same here
>
> "The number of collapse attempts that failed due to exceeding the
> max_ptes_shared threshold."

These all used to be very similar to what you have here. But Lorenzo
asked me to expand all this (IIRC) several times. So here we are! I
believe I even mentioned in the V15 that these are probably the "best"
defined counters in the whole doc lol.

Cheers,

-- Nico

>
> ?
>
>> +
>
> [...]
>

