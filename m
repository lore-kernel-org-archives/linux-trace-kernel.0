Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37CA366577
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860556; cv=none; b=ovzloBtLmyJUyjWeRHi576dsNTUjGdj6DCgkeM6W8wJCerUr0yXVhRz48wv5ImF9goN4hsrYTg/ljdE9Go/kVvGdSk3Gu5FhNGlUKHjFNMUOcXG58Wyye8CjUnWfkoDv1zz7sMOCLNNU6g7eaoMmuaebT2sCFS5hBGvOJO7sKh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860556; c=relaxed/simple;
	bh=aAgozX4R+IZyqKAXRD7JlxsV9lv1s+K8McpE21VRhPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rod1V9shn1Jtcqs2vHccItOEKi4JhpF0JAODbaPTxc3TVgpnWP7XfjR8mo6No8jxiG5EOFpkK8IpZJACJDUbY7j2REWn5S8Iqt27DxzJbpCy10XkD5H9V0EX2N285rdPfKTjbvHxASdPQRBa2je6PIFwEhhwnI3WxMJm5t9wuMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6FoBjCm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6FoBjCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773860554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g357sMeT7BRwzLdbf5CPPDzwji1TblDvyv5xWwQUqo4=;
	b=Y6FoBjCmMud04efLGk1k+8ccAJqt77wj6gHtdxVsXh3Shlvnj3DhfH1Ou7+p+0/ho4Rjh9
	obll5YmRsm7F7Nc5nzGODJWEZZwVZ5YQYYoCBmM6JSuzPIPI+xUW6RhjZuSoMAOQk0r0q/
	PDnZOHawPNtmX32wjW8VsrRGpMsgeOk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-SuScjrYRPsGz3ZOkAQ13FQ-1; Wed, 18 Mar 2026 15:02:32 -0400
X-MC-Unique: SuScjrYRPsGz3ZOkAQ13FQ-1
X-Mimecast-MFC-AGG-ID: SuScjrYRPsGz3ZOkAQ13FQ_1773860552
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7774be64so159734385a.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 12:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773860552; x=1774465352;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g357sMeT7BRwzLdbf5CPPDzwji1TblDvyv5xWwQUqo4=;
        b=WxQJMiygPDqP/qTgbPXOQok7cGywDv470u6gpaWB8uIBQFrmO55STdO/Lehdf9nLhH
         KUScY3qQhNH0Tt0ZOgYCysq7+JD1POEiJvZJulCfD4P2zIOwhV/PAoAiR0FMOoZsQ/hS
         2eSgZQ6K0hg7MU1v6QImtp3tF9OeYvjI/ESDQHgrA00UXSSOsuy0AyBEdSfQ7i7nCfOK
         1SQ0+xIr8tnpUONZuTe4ua6CwWv0bdmYOt9yjmL8vGjh9UQZxKePK4+xq1d/MObyt5aF
         /g+hVgUsNY8gvM0gHcHy7MGbO7xBovTD6xDbCO3+e2jUHEbkT5yXEOIVSlbkxq4YROc7
         xkCA==
X-Forwarded-Encrypted: i=1; AJvYcCWby5x+U57XlRauepiCFCniVrQr5J3p3UA+K+jacRbLGXtb6iRhZw21HFEGumhOJ34TBBW4YbRZNEa+n26flo9hRU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqGLkXxgDoL/CC/LtBRQMaYPjZJIN//UNvgdDZmtww3Ax2NMlw
	M1yIW/q5Pggc6beho0WIcXBfLyeWyF1uWsJ4ao39MLsKpGxUcUH9ixEjN2aPH3tYCcp6KYEtJuB
	yeuoFOOYogOs2MzvehLlcl7OYJfpVHqpNFVP5SdWpddIb4MLZV+20gK9jHLSZK9hPivZJ6r43fg
	==
X-Gm-Gg: ATEYQzxBb07H+sCOt+dFNwhms1BZGO3kg1XmiHD2ekF6+6NcV9ul+jGM5JLzyBBJP1B
	DjKmTNA8midgYgVQ7tQIMZSSgFT0MzLMJv9Auik8BIMAwzd/A4YkUFUdriiZBlB/Re+KONgJJPc
	Caqxc9ONRg3eI6Nmw60lQ5ICTrUxKZLQQ9YPQN/TtU6CQy2cwO4jzafPPA3Uc9wSqLxm9XJm8/n
	A1KA5O6yI1aQ3Jh9eyXku5xRVsVoILv0t5OOXaP4g8LagGFnIN33gNtK4PQS1dmNa2k0ULm40CP
	Hn8vwaosCbVIQXB3xCi+hQ8FvZn+8gHxauuCCmloEmH3ozmVhRoeEW/6hwLqX/NQ9YnBsGWqIq9
	MqEVqj40aExMdhBzcmj9jmqK54wer3DHkpNS87gmqmhLSfHETut21Z3SNaequ
X-Received: by 2002:a05:620a:2682:b0:8cd:7811:941c with SMTP id af79cd13be357-8cfad35822cmr628902985a.54.1773860552216;
        Wed, 18 Mar 2026 12:02:32 -0700 (PDT)
X-Received: by 2002:a05:620a:2682:b0:8cd:7811:941c with SMTP id af79cd13be357-8cfad35822cmr628895485a.54.1773860551581;
        Wed, 18 Mar 2026 12:02:31 -0700 (PDT)
Received: from [192.168.10.111] (c-76-154-99-94.hsd1.co.comcast.net. [76.154.99.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfad162839sm260663285a.25.2026.03.18.12.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 12:02:31 -0700 (PDT)
Message-ID: <4a1e2d0a-1b8e-4850-bb8b-465841aa7779@redhat.com>
Date: Wed, 18 Mar 2026 13:02:26 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v15 12/13] mm/khugepaged: run khugepaged for
 all orders
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com,
 akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com,
 catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
 dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com,
 gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz,
 jackmanb@google.com, jannh@google.com, jglisse@google.com,
 joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
 mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
 mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de,
 rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org,
 richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org,
 rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com,
 sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com,
 tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz,
 vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org,
 willy@infradead.org, yang@os.amperecomputing.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
References: <20260226031741.230674-1-npache@redhat.com>
 <20260226032650.234386-1-npache@redhat.com>
 <a74178af-54f3-44ba-a007-4eaf49e40ab3@lucifer.local>
From: Nico Pache <npache@redhat.com>
In-Reply-To: <a74178af-54f3-44ba-a007-4eaf49e40ab3@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vQYmN9x_GS6lbkXXTxsH7skm5btnXWUhHkyQGFqYcnM_1773860552
X-Mimecast-Originator: redhat.com
Content-Language: en-US, en-ZM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/17/26 4:58 AM, Lorenzo Stoakes (Oracle) wrote:
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
> 
> This looks good to me, so:
> 
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Thanks!

> 
>> ---
>>  mm/khugepaged.c | 30 ++++++++++++++++++------------
>>  1 file changed, 18 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 388d3f2537e2..e8bfcc1d0c9a 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -434,23 +434,23 @@ static inline int collapse_test_exit_or_disable(struct mm_struct *mm)
>>  		mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);
>>  }
>>
>> -static bool hugepage_pmd_enabled(void)
>> +static bool hugepage_enabled(void)
>>  {
>>  	/*
>>  	 * We cover the anon, shmem and the file-backed case here; file-backed
>>  	 * hugepages, when configured in, are determined by the global control.
>> -	 * Anon pmd-sized hugepages are determined by the pmd-size control.
>> +	 * Anon hugepages are determined by its per-size mTHP control.
> 
> Well also PMD right? I mean this terminology sucks because in a sense mTHP
> includes PMD... :)

yeah kinda hard with our verbiage being so broad and overlapping some times.

> 
>>  	 * Shmem pmd-sized hugepages are also determined by its pmd-size control,
>>  	 * except when the global shmem_huge is set to SHMEM_HUGE_DENY.
>>  	 */
>>  	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>  	    hugepage_global_enabled())
>>  		return true;
>> -	if (test_bit(PMD_ORDER, &huge_anon_orders_always))
>> +	if (READ_ONCE(huge_anon_orders_always))
>>  		return true;
>> -	if (test_bit(PMD_ORDER, &huge_anon_orders_madvise))
>> +	if (READ_ONCE(huge_anon_orders_madvise))
>>  		return true;
>> -	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
>> +	if (READ_ONCE(huge_anon_orders_inherit) &&
>>  	    hugepage_global_enabled())
>>  		return true;
>>  	if (IS_ENABLED(CONFIG_SHMEM) && shmem_hpage_pmd_enabled())
>> @@ -521,8 +521,14 @@ static unsigned int collapse_max_ptes_none(unsigned int order)
>>  static unsigned long collapse_allowable_orders(struct vm_area_struct *vma,
>>  			vm_flags_t vm_flags, bool is_khugepaged)
>>  {
>> +	unsigned long orders;
>>  	enum tva_type tva_flags = is_khugepaged ? TVA_KHUGEPAGED : TVA_FORCED_COLLAPSE;
>> -	unsigned long orders = BIT(HPAGE_PMD_ORDER);
>> +
>> +	/* If khugepaged is scanning an anonymous vma, allow mTHP collapse */
>> +	if (is_khugepaged && vma_is_anonymous(vma))
>> +		orders = THP_ORDERS_ALL_ANON;
>> +	else
>> +		orders = BIT(HPAGE_PMD_ORDER);
>>
>>  	return thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
>>  }
>> @@ -531,7 +537,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>>  			  vm_flags_t vm_flags)
>>  {
>>  	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
>> -	    hugepage_pmd_enabled()) {
>> +	    hugepage_enabled()) {
>>  		if (collapse_allowable_orders(vma, vm_flags, /*is_khugepaged=*/true))
>>  			__khugepaged_enter(vma->vm_mm);
>>  	}
>> @@ -2929,7 +2935,7 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, enum scan_result *
>>
>>  static int khugepaged_has_work(void)
>>  {
>> -	return !list_empty(&khugepaged_scan.mm_head) && hugepage_pmd_enabled();
>> +	return !list_empty(&khugepaged_scan.mm_head) && hugepage_enabled();
>>  }
>>
>>  static int khugepaged_wait_event(void)
>> @@ -3002,7 +3008,7 @@ static void khugepaged_wait_work(void)
>>  		return;
>>  	}
>>
>> -	if (hugepage_pmd_enabled())
>> +	if (hugepage_enabled())
>>  		wait_event_freezable(khugepaged_wait, khugepaged_wait_event());
>>  }
>>
>> @@ -3033,7 +3039,7 @@ static void set_recommended_min_free_kbytes(void)
>>  	int nr_zones = 0;
>>  	unsigned long recommended_min;
>>
>> -	if (!hugepage_pmd_enabled()) {
>> +	if (!hugepage_enabled()) {
>>  		calculate_min_free_kbytes();
>>  		goto update_wmarks;
>>  	}
>> @@ -3083,7 +3089,7 @@ int start_stop_khugepaged(void)
>>  	int err = 0;
>>
>>  	mutex_lock(&khugepaged_mutex);
>> -	if (hugepage_pmd_enabled()) {
>> +	if (hugepage_enabled()) {
>>  		if (!khugepaged_thread)
>>  			khugepaged_thread = kthread_run(khugepaged, NULL,
>>  							"khugepaged");
>> @@ -3109,7 +3115,7 @@ int start_stop_khugepaged(void)
>>  void khugepaged_min_free_kbytes_update(void)
>>  {
>>  	mutex_lock(&khugepaged_mutex);
>> -	if (hugepage_pmd_enabled() && khugepaged_thread)
>> +	if (hugepage_enabled() && khugepaged_thread)
>>  		set_recommended_min_free_kbytes();
>>  	mutex_unlock(&khugepaged_mutex);
>>  }
>> --
>> 2.53.0
>>
> 

