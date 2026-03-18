Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414AC3D3332
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860860; cv=none; b=HZyeJjESBGx8r33pNeu//A5Z6Djic4q3h76pIKsfkyYYgElhZSDvc9AkVR/znZJh/f2c/HIn4rm0K9PZhb7KB5Bg2SwrgvPw5EzL6M8aCJd+JVwz3Ohxco9l7yN/MThBirIKDKJfHR4ZXgpRoPvFG5DobExjN+lGIm83Bpd5ulk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860860; c=relaxed/simple;
	bh=bjBP+5pv9q2khBiY6QNLhppdPiTu1grx2pp5fu1Tnys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ce79kJ3vri1Qq/FU4b3eWZ7jDEB8q9h/PPgGfh1IvTE+18fd9gvLvIefNG/78Dkg30v9bZIMSu8PjJJfTWhwjqtNgyHd/kunlgtayr/ZZWE+/hG+Rd4q05CeQLqiX+VNxdbE7seEHGmWqg9we6GNAsZeeHKGotygyEwCgOWTXWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYyZcODS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYyZcODS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773860858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WixAoxfcL5jhhT83Dfur4OdwyV5TsF5FITSYI32Dans=;
	b=TYyZcODSiQETxMPeH0RKqcylH3csKchKQbd8mCKgNAc4Sh+TUzuXC75BrPFhEGB9OMSTHk
	Bd0DB1idYQhoKr3LMfvGmwKJNb/cMX3VU0Tzx+ChIdUTggTZqCmvDHBo9XIUVhBYClCmUI
	gL211EgCoyM7aaSc0d2VIs2+5/AetFc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-oiafGx-_P5O4WuAvUufOvQ-1; Wed, 18 Mar 2026 15:07:37 -0400
X-MC-Unique: oiafGx-_P5O4WuAvUufOvQ-1
X-Mimecast-MFC-AGG-ID: oiafGx-_P5O4WuAvUufOvQ_1773860857
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89c56a7e610so23909456d6.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 12:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773860857; x=1774465657;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WixAoxfcL5jhhT83Dfur4OdwyV5TsF5FITSYI32Dans=;
        b=mWpXQPv//sOMy/0FaRQ75yoycrpWprpWL6/SvAgmOTkzw9RxZ+3dgkujDer5SMhOxH
         vSDHTRFUT8nV7ICVGi+SK5tZ3HLZouQZru5qlNNoYe1m7BFKkp5F5glvEGHV+WScpj2R
         fpW+h3/t0s7RZJT//pZXwd5CpReIeRJyV3sndVEHr+w7sz4dDQok/5Yc/tq8EEwF1PLx
         OVGWRznqrp2x70JV3zPoAyB4e5HLCs6yv2Xzt1czBSFC2ZbVUm/EwUwzc7xRbAnVdjFm
         uoY33P7IyFrqnD8FBP+/rywR/zyzHhOpQG2gQXgIzYir5S/nSIN2LpTS7dEi3/ElcWiY
         iKkw==
X-Forwarded-Encrypted: i=1; AJvYcCW32lof4ZraGS5Uk0JHLMRs13hBTvESR8TZPiH2m3N2sn0nI2PtAkJle4HkdsCdQctJeBsphjpmlZxKE1Ub6m6+0SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9T/m2pbG0HxSu+wpEkl3n9ZSLmuDSq7caxIry7H1P7dMdrxuQ
	YQe8l3/yyHBhY03cqkiAr2SRmtLIa+V8KNGJ5mGVOCfTOO53sLXyAhTE8WK6YpN8xk8pjzOtl9l
	dHIWB5M5gWXwOoJo7zG6m5MXnDZo5cYWQDr3mRsu9bj73rEGCc3x7HmLqYDgZGDr7ftrIIN1RYg
	==
X-Gm-Gg: ATEYQzyNNNv6WjsiH0H4iBku+3lmuGYzxcLwZuEWV9iwryGya19TDVzv5ZHV3Sreg6j
	6ubYMNIT7rEccjttut6Av2vKXp+uoBVDgqpK1Ve8ZsEoj55kVzaoHfOuPm00l9OCUipYeG9MdUi
	zHjgCYspasvoguu0GAqFhnyR6WW20gbZMs9XyWmKQXF3PfssJfiBeSFm1CodRXYTpXx8siCE0j0
	NBFq6rSfd15jJBV46lO5sJzxoblOYBs7vX6DTfkrFvbT9ET1tPwlNv1Xri8I+m3w/89DMH33vcG
	dXNizMCdufbv22HUXFzvtFRJyyyE5tYTrceRaouPNDswHhqsE1OAgUfqwXn38hiWrLUaUuoa4wG
	30pvrsqBIoVxGnD3UPoIAjXbBwus7wbMTtBWrg/KaZ8fbtSc9mDd0YULbuWIG
X-Received: by 2002:a0c:f08f:0:b0:899:fb4e:47aa with SMTP id 6a1803df08f44-89c6b557273mr60066346d6.39.1773860856735;
        Wed, 18 Mar 2026 12:07:36 -0700 (PDT)
X-Received: by 2002:a0c:f08f:0:b0:899:fb4e:47aa with SMTP id 6a1803df08f44-89c6b557273mr60065406d6.39.1773860856280;
        Wed, 18 Mar 2026 12:07:36 -0700 (PDT)
Received: from [192.168.10.111] (c-76-154-99-94.hsd1.co.comcast.net. [76.154.99.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b9e9babsm25191566d6.38.2026.03.18.12.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 12:07:35 -0700 (PDT)
Message-ID: <587c8b0c-3004-49ee-a2eb-ef74aa8c4abb@redhat.com>
Date: Wed, 18 Mar 2026 13:07:31 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v15 12/13] mm/khugepaged: run khugepaged for
 all orders
To: Lance Yang <lance.yang@linux.dev>, baolin.wang@linux.alibaba.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com,
 akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com,
 baohua@kernel.org, byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org,
 corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org,
 dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com,
 jack@suse.cz, jackmanb@google.com, jannh@google.com, jglisse@google.com,
 joshua.hahnjy@gmail.com, kas@kernel.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com,
 peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com,
 rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com,
 rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com,
 shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com,
 thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com,
 vbabka@suse.cz, vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
 will@kernel.org, willy@infradead.org, yang@os.amperecomputing.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
References: <20260226032650.234386-1-npache@redhat.com>
 <20260317113611.94006-1-lance.yang@linux.dev>
From: Nico Pache <npache@redhat.com>
In-Reply-To: <20260317113611.94006-1-lance.yang@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uRy9Yk8y-o9qQuoxZfOPb27oAR0IrrjIZ_A2QGh-4RA_1773860857
X-Mimecast-Originator: redhat.com
Content-Language: en-US, en-ZM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/17/26 5:36 AM, Lance Yang wrote:
> 
> On Wed, Feb 25, 2026 at 08:26:50PM -0700, Nico Pache wrote:
>> From: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>> If any order (m)THP is enabled we should allow running khugepaged to
>> attempt scanning and collapsing mTHPs. In order for khugepaged to operate
>> when only mTHP sizes are specified in sysfs, we must modify the predicate
>> function that determines whether it ought to run to do so.
>>
>> This function is currently called hugepage_pmd_enabled(), this patch
>> renames it to hugepage_enabled() and updates the logic to check to
>> determine whether any valid orders may exist which would justify
>> khugepaged running.
>>
>> We must also update collapse_allowable_orders() to check all orders if
>> the vma is anonymous and the collapse is khugepaged.
>>
>> After this patch khugepaged mTHP collapse is fully enabled.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>> mm/khugepaged.c | 30 ++++++++++++++++++------------
>> 1 file changed, 18 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 388d3f2537e2..e8bfcc1d0c9a 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -434,23 +434,23 @@ static inline int collapse_test_exit_or_disable(struct mm_struct *mm)
>> 		mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);
>> }
>>
>> -static bool hugepage_pmd_enabled(void)
>> +static bool hugepage_enabled(void)
>> {
>> 	/*
>> 	 * We cover the anon, shmem and the file-backed case here; file-backed
>> 	 * hugepages, when configured in, are determined by the global control.
>> -	 * Anon pmd-sized hugepages are determined by the pmd-size control.
>> +	 * Anon hugepages are determined by its per-size mTHP control.
>> 	 * Shmem pmd-sized hugepages are also determined by its pmd-size control,
>> 	 * except when the global shmem_huge is set to SHMEM_HUGE_DENY.
>> 	 */
>> 	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>> 	    hugepage_global_enabled())
>> 		return true;
>> -	if (test_bit(PMD_ORDER, &huge_anon_orders_always))
>> +	if (READ_ONCE(huge_anon_orders_always))
>> 		return true;
>> -	if (test_bit(PMD_ORDER, &huge_anon_orders_madvise))
>> +	if (READ_ONCE(huge_anon_orders_madvise))
>> 		return true;
>> -	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
>> +	if (READ_ONCE(huge_anon_orders_inherit) &&
>> 	    hugepage_global_enabled())
>> 		return true;
>> 	if (IS_ENABLED(CONFIG_SHMEM) && shmem_hpage_pmd_enabled())
>> @@ -521,8 +521,14 @@ static unsigned int collapse_max_ptes_none(unsigned int order)
>> static unsigned long collapse_allowable_orders(struct vm_area_struct *vma,
>> 			vm_flags_t vm_flags, bool is_khugepaged)
>> {
>> +	unsigned long orders;
>> 	enum tva_type tva_flags = is_khugepaged ? TVA_KHUGEPAGED : TVA_FORCED_COLLAPSE;
>> -	unsigned long orders = BIT(HPAGE_PMD_ORDER);
>> +
>> +	/* If khugepaged is scanning an anonymous vma, allow mTHP collapse */
>> +	if (is_khugepaged && vma_is_anonymous(vma))
>> +		orders = THP_ORDERS_ALL_ANON;
>> +	else
>> +		orders = BIT(HPAGE_PMD_ORDER);
>>
>> 	return thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
>> }
> 
> IIUC, an anonymous VMA can pass collapse_allowable_orders() even if it
> is smaller than 2MB ...
> 
> But collapse_scan_mm_slot() still scans only full PMD-sized windows:
> 
> 		hstart = round_up(vma->vm_start, HPAGE_PMD_SIZE);
> 		hend = round_down(vma->vm_end, HPAGE_PMD_SIZE);
> 		if (khugepaged_scan.address > hend) {
> 			cc->progress++;
> 			continue;
> 		}
> 
> and hugepage_vma_revalidate() still requires PMD suitability:
> 
> 	/* Always check the PMD order to ensure its not shared by another VMA */
> 	if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
> 		return SCAN_ADDRESS_RANGE;
> 
> 
>> @@ -531,7 +537,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>> 			  vm_flags_t vm_flags)
>> {
>> 	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
>> -	    hugepage_pmd_enabled()) {
>> +	    hugepage_enabled()) {
>> 		if (collapse_allowable_orders(vma, vm_flags, /*is_khugepaged=*/true))
>> 			__khugepaged_enter(vma->vm_mm);
> 
> I wonder if we should also require at least one PMD-sized scan window
> here? Not a big deal, just might be good to tighten the gate a bit :)

IIUC, you are worried that we are operating on VMAs smaller than a PMD?
thp_vma_allowable_orders should guard from that via thp_vma_suitable. the
revalidation also checks this in hugepage_vma_revalidate() and is the reason we
must leave the suitable_order check in revalidate() checking the PMD_ORDER than
than the attempted collapse order.

lmk if that clears things up!

Thanks
-- Nico

> 
> Apart from that, LGTM!
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> 

