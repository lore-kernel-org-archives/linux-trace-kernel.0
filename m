Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D63ED5B3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860384; cv=none; b=r3bQfae0OgG+wVQLDKyvjpKydteKrKSPyup5p0zoi5aOOlXUnN1jmYh0toC7wjuZ6WMKUqE7/CXdAEENhT+WuRoMqXqSI/ZUImxFeQxPepnpFUFtTQvvvXdnia2MS+8bxNxgNW4ame2QOf3zmRMXVIf319J06Ls2/dOtapRu1do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860384; c=relaxed/simple;
	bh=CurqXuQ/vp6aNN3iHT1OjoAxg6zX+Hf2ZpBNspx7VYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxQtfrL0eRLj84Avp+2r9TkLwUs+AnTlJHngmdh6krFb4dJgQT07N39bg0YfZyLw85exTBFPqlS+/JO9Nop5Yuq4F6vYUN9BKqeuG0+aZAJ8qT6yjzSc/8tpEeiomRDXWyFmyr2NySKhmgWEDWv4P0dLcvFVyQg91M2oCX1TzGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8XasKqU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8XasKqU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773860382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fuwby0KHsweEWRKxCnMlD+TvTgOd6VacPqQH1y0xBQ=;
	b=B8XasKqUYkPxlinzpE9EKUwbeWnJCc1JYWzRkfyvm3AfpLuqrovCaA89HmrZxPPC2KDXVw
	AoS1zcjpGCmoL0RhJwYr5jSQw/3Ydg1q1wUAIXwhEIJAmgl/Kb4B9cDBFHkwTbfDyf6sFH
	cOCtTKBt3sfnWZBiTEtr90Ec7lUNmCY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-8qAuol9eMTmNYz-QujSkig-1; Wed, 18 Mar 2026 14:59:40 -0400
X-MC-Unique: 8qAuol9eMTmNYz-QujSkig-1
X-Mimecast-MFC-AGG-ID: 8qAuol9eMTmNYz-QujSkig_1773860380
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89c3d3f5799so21710626d6.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 11:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773860380; x=1774465180;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fuwby0KHsweEWRKxCnMlD+TvTgOd6VacPqQH1y0xBQ=;
        b=FyDjC4SmrL52vI1XS1akDDEPo3bgE3tdLWRiyzCYYPo1t7pNF4FZ0Oq7AFFqML0hD5
         RN2ll9ZjoWUxU0aTqAwCO8vyGvIkTz9i7CJtnEc8haS20u3ZyXvEUksTFP1cAbKehxQe
         IJ87NwAqt9DuCd6lV2ujz4U1Nf131JroEJAle/grmY83wEytjffk6kBCIHxZcER7Xnjt
         GuF1XUQV6u33e4Tr8U2gKbd7kV7e+L8kXChJI8zkOAHUxeuqqZh+90R7PD95Sr1V4mBa
         dX2aRePQCXSLgUVgO3hxBjrHTf/L1cL5DkUltUJHfqlONNVeC7sUiX8o+9E2nVk1i3RA
         TblA==
X-Forwarded-Encrypted: i=1; AJvYcCV0DPbhmVPwq3VcHdDBvxU7OjpFAC+1gpOPhPaWmC9y2XKS+rMudgsVEKfE3ODiaDG7HRQdTEjZPhbKAbX1plkNK/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMXthrShdhArM2E8pxCGylfQG2K0Et+oJRiduS2gZmFoO/3y8J
	u17EwnhnjvPgZmXBnpyBNHeeuX7SDNhDlUaWRPfnXjx3hL0ucVluEFR2pw/xcKma8FvAsjlQ+yN
	NmencmMoYCPhOiXFnyw/z3lHwomTKG8jnZjVUEOm8rJG/PgXNGlesUrtHlA/ir5yhmJTFm+rz9g
	==
X-Gm-Gg: ATEYQzyXxkKtAkgLfFU0J98CH5D7ynxDYUrt8ub5WUez7tQzZ5lasCG21s2aDdzw55g
	aljK1L5SmtgNWlOUQu3FCsZrGw7Dlq4ccSsuF3JH6v0USUcTOuJYpyspjKHnwmpWvtn6TY26gKI
	W0MP1q7mBO8CBGGsYk9I9aC+mtHaKGHlrTENXg9QEAfak+B2ZmY5keWnkUDS+wl/evqObdsXA8R
	q89mNa9YyyDNAfQS/hmuham1okxzJCJHb5mwzpHkDAXloiJJODPavtRaVvQ7Xu7YCq8JdC8GLCn
	i8XSx2v7FeTZc8vAqzHdIBOlEC1/oW0y0L2pEsX7Ypa9JlaezQ9IKA3O/cC6epFYNoLgREyv5Fc
	eT+e9wOGhiE9K2N3F1KFhsGScjTUvYFDaHWMkzBu63jdS6lzNpgPt7bYmuRh6
X-Received: by 2002:a0c:f089:0:b0:89c:59d0:b056 with SMTP id 6a1803df08f44-89c6b5ca535mr54557586d6.30.1773860379962;
        Wed, 18 Mar 2026 11:59:39 -0700 (PDT)
X-Received: by 2002:a0c:f089:0:b0:89c:59d0:b056 with SMTP id 6a1803df08f44-89c6b5ca535mr54557206d6.30.1773860379310;
        Wed, 18 Mar 2026 11:59:39 -0700 (PDT)
Received: from [192.168.10.111] (c-76-154-99-94.hsd1.co.comcast.net. [76.154.99.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b9cea7bsm31502716d6.27.2026.03.18.11.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 11:59:38 -0700 (PDT)
Message-ID: <a9ddfa7b-5ee4-4c68-bac0-8a0c6c355bf7@redhat.com>
Date: Wed, 18 Mar 2026 12:59:34 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v15 11/13] mm/khugepaged: avoid unnecessary
 mTHP collapse attempts
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, david@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com,
 akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com,
 catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
 dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net,
 hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com,
 jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com,
 kas@kernel.org, lance.yang@linux.dev, Liam.Howlett@oracle.com,
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
References: <20260226031741.230674-1-npache@redhat.com>
 <20260226032631.234234-1-npache@redhat.com>
 <d8028d32-4791-4993-aae3-66506bf6d1bd@lucifer.local>
From: Nico Pache <npache@redhat.com>
In-Reply-To: <d8028d32-4791-4993-aae3-66506bf6d1bd@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UBOYxz9MnI_KazzRY4KMVomFjX9tyfB3ZUysVLdDsuc_1773860380
X-Mimecast-Originator: redhat.com
Content-Language: en-US, en-ZM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/17/26 4:35 AM, Lorenzo Stoakes (Oracle) wrote:
> On Wed, Feb 25, 2026 at 08:26:31PM -0700, Nico Pache wrote:
>> There are cases where, if an attempted collapse fails, all subsequent
>> orders are guaranteed to also fail. Avoid these collapse attempts by
>> bailing out early.
>>
>> Signed-off-by: Nico Pache <npache@redhat.com>
> 
> With David's concern addressed:
> 
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> 
>> ---
>>  mm/khugepaged.c | 35 ++++++++++++++++++++++++++++++++++-
>>  1 file changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 1c3711ed4513..388d3f2537e2 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1492,9 +1492,42 @@ static int mthp_collapse(struct mm_struct *mm, unsigned long address,
>>  			ret = collapse_huge_page(mm, collapse_address, referenced,
>>  						 unmapped, cc, mmap_locked,
>>  						 order);
>> -			if (ret == SCAN_SUCCEED) {
>> +
>> +			switch (ret) {
>> +			/* Cases were we continue to next collapse candidate */
>> +			case SCAN_SUCCEED:
>>  				collapsed += nr_pte_entries;
>> +				fallthrough;
>> +			case SCAN_PTE_MAPPED_HUGEPAGE:
>>  				continue;
>> +			/* Cases were lower orders might still succeed */
>> +			case SCAN_LACK_REFERENCED_PAGE:
>> +			case SCAN_EXCEED_NONE_PTE:
>> +			case SCAN_EXCEED_SWAP_PTE:
>> +			case SCAN_EXCEED_SHARED_PTE:
>> +			case SCAN_PAGE_LOCK:
>> +			case SCAN_PAGE_COUNT:
>> +			case SCAN_PAGE_LRU:
>> +			case SCAN_PAGE_NULL:
>> +			case SCAN_DEL_PAGE_LRU:
>> +			case SCAN_PTE_NON_PRESENT:
>> +			case SCAN_PTE_UFFD_WP:
>> +			case SCAN_ALLOC_HUGE_PAGE_FAIL:
>> +				goto next_order;
>> +			/* Cases were no further collapse is possible */
>> +			case SCAN_CGROUP_CHARGE_FAIL:
>> +			case SCAN_COPY_MC:
>> +			case SCAN_ADDRESS_RANGE:
>> +			case SCAN_NO_PTE_TABLE:
>> +			case SCAN_ANY_PROCESS:
>> +			case SCAN_VMA_NULL:
>> +			case SCAN_VMA_CHECK:
>> +			case SCAN_SCAN_ABORT:
>> +			case SCAN_PAGE_ANON:
>> +			case SCAN_PMD_MAPPED:
>> +			case SCAN_FAIL:
>> +			default:
> 
> Agree with david, let's spell them out please :)

I believe David is arguing for the opposite. To drop all these spelt out cases
and just leave the default case.

@david is that correct or did I misunderstand that.

-- Nico

> 
>> +				return collapsed;
>>  			}
>>  		}
>>
>> --
>> 2.53.0
>>
> 

