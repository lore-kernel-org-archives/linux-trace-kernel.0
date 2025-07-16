Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCF819AD5C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673587; cv=none; b=d8QMghdprvaLNXNVxVor/Yd66Wz8YcPnI5kqTXEmsIiU/T2MeyKGWwVQm1iEiC62rzHh+OjgWIxhMKjyuinFZco/rJAg/dCFOJCnK0RL7IiZgcXZIZxu7yLdifyBvifCwdqQ3ei0gke1gZUk86kYVI8XhMb/14yi+qpX1HEHxfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673587; c=relaxed/simple;
	bh=RZl3Z+z07kjYvgAvYVfw79tI4O65PNChsNVaunJecQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7mZlx3h+vkfzve/dnQuDWuonbxmRLWf2BGnRYzh20NUsObgTXul0x/IrXAYPV0YimYb/da1oLMB2V6eSoOHB8v10NsoOaIJ1/Pqpl2Xm7pcoQl1TfiqWxFPzvePvachiYbx8neuje2aNn6nF+MIDr+7DcGhRFaLRiVn9BIjq84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2nLh6oz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2nLh6oz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752673584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/1pctBA01/1zkmNnT64qP6k0VirtQtNBqmZ+pkk9rqA=;
	b=X2nLh6ozRWuKtinzMLNI45Z7JJUzCaNq5O7rUdgqyo+XqcXxhn0HSjJIp2rJzWfCTgeUxh
	ChtMgEjUC4vpYlt5GEMimvmYYZmQFVy3qRAk5eA0gz/GbjFxTxpJ2lVjjq/JwOOPK9WvuV
	cMYrNpospO3qNlvQ5bjGQkzBV1DGaOY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-NBk0CkrHNquEPz8o8bCXaQ-1; Wed, 16 Jul 2025 09:46:22 -0400
X-MC-Unique: NBk0CkrHNquEPz8o8bCXaQ-1
X-Mimecast-MFC-AGG-ID: NBk0CkrHNquEPz8o8bCXaQ_1752673582
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4538a2f4212so37650605e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752673581; x=1753278381;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/1pctBA01/1zkmNnT64qP6k0VirtQtNBqmZ+pkk9rqA=;
        b=Vuwjrdi7bBdyuszZrFpsGv2xTPcnR7UKEU/zJehOXrP+Augfo7PhA/zHosKWzsk4kR
         fl2VzOxpheELwbpwmqgWp/p+9wfMB9jaa/8D8/QCtnxxjGQeUbZsbc4T6uA2CLBxjqV1
         jZ/NFtcw+1uPsrqcG90QBPN+BYjWdftIlQswIFuNFbY1gnDfMvvbpumoxw10Hcqusr1R
         PKeZTgl6Zb1pFv6ZqsE/tk3yxxHsD2rNfXS69xt36KjrRSk/Ar4goE9yvmcDePSDDTBm
         1INNLRJku0NRpTS5LLD1sRmmjXS1iTugi7pMV8noNmrj0UEE+QLDmHbXq+a0GLZjFuwO
         1f1w==
X-Forwarded-Encrypted: i=1; AJvYcCUS+1G2Dj/h5VY57CPQaNiWPW4FBZOn9Q2GFx7Bl4NLaamSKGL1pl0cyiW1+sKwvphB0KOgZiZ3rVfBcBMlQQlU5Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNiX+bGTeaNTbiNMRGQtFM9BzbE/Cwfc1kpY80sXW/1gVJhoym
	Z92hvSsO3kmOWlmiWWZe1uWr6wQ97LFdGM3y8IjBye1diNS0zHKxtpXWPI3Txc3bYNzfxrYj3mf
	vPy7bBAqpvYCpo68l/bQtDYE0YNSgwdgf6qEHtWkmce8E/NFQ8lpnsRnXCWdYqOnPty9maWAkQA
	==
X-Gm-Gg: ASbGncsbm47yQHTfPQ+u86cWiFNO8wNy2Kbf98B7LCJruAfDiu90A6pGVkqtPA2R6p9
	X+NEVFEmhkPtP+VdRVOzqlLTYfLCMCIvknehNykAoVDzJkmeqNSEQIDsbVi8FQlbkG04wdANG7x
	ptCBVF2ACfmsvuihhfXEJqviSzmGDC6Re66kvbmcnHGOpq1XzaTnJKSim22svESbXK7If+trnuZ
	L9fh12MXwVzI9Ij1TEZMz4tS1p2xg2Rgn6ix2wbNJVM75iouHZ7R4gO1fi7avvXDeP0rpRYs0+y
	iRBZxP3H5LQ05fLrJn2vBsWb/VnVoy5V/3I1YbPUOu8UUPWEq0rkseMuj0MBpDEDd+xO/cQ=
X-Received: by 2002:a05:600c:c09a:b0:456:285b:db3c with SMTP id 5b1f17b1804b1-4562e3b8ccbmr23453935e9.3.1752673581435;
        Wed, 16 Jul 2025 06:46:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLfuwv8hTtlovE4F8p1OZCmeKNmt6dxGC9wD6r8RzyYXtB45fc/AjmHbpd1Pns9lK9tCcfyw==
X-Received: by 2002:a05:600c:c09a:b0:456:285b:db3c with SMTP id 5b1f17b1804b1-4562e3b8ccbmr23453315e9.3.1752673580858;
        Wed, 16 Jul 2025 06:46:20 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0f26d.dip0.t-ipconnect.de. [79.224.242.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e802984sm21535265e9.12.2025.07.16.06.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 06:46:20 -0700 (PDT)
Message-ID: <a337c251-c152-4f57-8ead-6e4419e49f0c@redhat.com>
Date: Wed, 16 Jul 2025 15:46:18 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/14] khugepaged: generalize alloc_charge_folio()
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-5-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250714003207.113275-5-npache@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I97uN5az9sTNM5r84YqXnrboNol-gfP-hjUcFmFFnhk_1752673582
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 02:31, Nico Pache wrote:
> From: Dev Jain <dev.jain@arm.com>
> 
> Pass order to alloc_charge_folio() and update mTHP statistics.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Co-developed-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   Documentation/admin-guide/mm/transhuge.rst |  8 ++++++++
>   include/linux/huge_mm.h                    |  2 ++
>   mm/huge_memory.c                           |  4 ++++
>   mm/khugepaged.c                            | 17 +++++++++++------
>   4 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index dff8d5985f0f..2c523dce6bc7 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -583,6 +583,14 @@ anon_fault_fallback_charge
>   	instead falls back to using huge pages with lower orders or
>   	small pages even though the allocation was successful.
>   
> +collapse_alloc
> +	is incremented every time a huge page is successfully allocated for a
> +	khugepaged collapse.
> +
> +collapse_alloc_failed
> +	is incremented every time a huge page allocation fails during a
> +	khugepaged collapse.
> +
>   zswpout
>   	is incremented every time a huge page is swapped out to zswap in one
>   	piece without splitting.
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 7748489fde1b..4042078e8cc9 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -125,6 +125,8 @@ enum mthp_stat_item {
>   	MTHP_STAT_ANON_FAULT_ALLOC,
>   	MTHP_STAT_ANON_FAULT_FALLBACK,
>   	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> +	MTHP_STAT_COLLAPSE_ALLOC,
> +	MTHP_STAT_COLLAPSE_ALLOC_FAILED,
>   	MTHP_STAT_ZSWPOUT,
>   	MTHP_STAT_SWPIN,
>   	MTHP_STAT_SWPIN_FALLBACK,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bd7a623d7ef8..e2ed9493df77 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -614,6 +614,8 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>   DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +DEFINE_MTHP_STAT_ATTR(collapse_alloc, MTHP_STAT_COLLAPSE_ALLOC);
> +DEFINE_MTHP_STAT_ATTR(collapse_alloc_failed, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
>   DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
>   DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
>   DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
> @@ -679,6 +681,8 @@ static struct attribute *any_stats_attrs[] = {
>   #endif
>   	&split_attr.attr,
>   	&split_failed_attr.attr,
> +	&collapse_alloc_attr.attr,
> +	&collapse_alloc_failed_attr.attr,
>   	NULL,
>   };
>   
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index fa0642e66790..cc9a35185604 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1068,21 +1068,26 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   }
>   
>   static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
> -			      struct collapse_control *cc)
> +			      struct collapse_control *cc, u8 order)

u8, really? :)

Just use an "unsigned int" like folio_order() would or what 
__folio_alloc() consumes.



Apart from that

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

