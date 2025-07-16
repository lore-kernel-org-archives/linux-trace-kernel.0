Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A965C28BA8D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679729; cv=none; b=CqCFt+IAnM+k9RhOXs/bLvk9YJ51yZTRGEazvDZNVgloU81rx7tjNtk5caoyR38wgfi13Akedw7alGxNm8yH9Hb8KN1iHBQeQEXuYnI6OUcSt+CDXP7WmNdeLJ2kTSN5aijilN7h9Hcrgz48VfgazGZpMAVi9nlApz02q5Ip1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679729; c=relaxed/simple;
	bh=/5CfB2A12LDeJKCGmDi9/diDz7khZu+BKzJSqKXUUlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+yEsefk3OeBNbPJ3r328zLUPq3YmlfSHf/kWhfoGBzwjypPS9H8qf+gpEIzbFAgFV7aoRHCa11K4uqzyG3Yd5fnbkhkFxv+BOuqGNBCdKxvDN78c1Xfm/bdMuoNDQ8Wtka7i92FG5AhF6gnS4cjx9WDsZSDVPAWHJ1FjlNX66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YuBpSUN2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuBpSUN2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752679726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b9muf3y2moPaIuS6pt5tTbdr04dlviAIBJWO4rVo/Lo=;
	b=YuBpSUN2FRJw60QxpZ/Xz0QYaMjq2p1+ZhnPE+6ZAw0PfNBZrkNpJlAx3Z6S/D4PuZ0eRV
	hS0qD66tHv4Fm/6QE30OUf7HJMct0PRzidp0PzXF4u7ZuGI+a7HVzYxpNebC6gNGlpRrLe
	dTaV2O4G3EV3SvwxbMpf9Di9xMgHac8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-iG6QPJRAOPO9w-_plJK-Tw-1; Wed, 16 Jul 2025 11:28:45 -0400
X-MC-Unique: iG6QPJRAOPO9w-_plJK-Tw-1
X-Mimecast-MFC-AGG-ID: iG6QPJRAOPO9w-_plJK-Tw_1752679724
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so4971116f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679724; x=1753284524;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b9muf3y2moPaIuS6pt5tTbdr04dlviAIBJWO4rVo/Lo=;
        b=XmS2wIfIyT6VrHEhSY37s/0hWoCd05z+JhQQE0blaOA3npmKv5TmxB6PbMjTstW1tb
         ZlW/i967oJcE7z+/XctDCkImKjJ6hiuCk82joqE2A+w4AYIOOwusmIkNCwUeyegzCCva
         Gzf/em873N08iQY2d571woGBYzDsANzh2apYV5xxyh6H7FJD1WU74zRa0/dpUnXS9CT4
         rxwSXfh5um2cqA1ppXXzWeEXt5vxYBlHtK/iF1cpDCCARvqEKY+eAiQFC+DEbXUCTObN
         yKn1+CdZODP5j91HzOoNnHDRhFCKDtJm8sb5vqyvr6kHC0Jlp+HZ/ZrHIMJ+Toqg/eyo
         6LsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq14J5KjszsUKvmAjaZ2FCNXdQEKBPAHFn/V1jeRkzPSD9pEkA6d7kP2YsXnoTeSS9tWef1vI5Fj+frLr/pFeQ2O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQHIm9wf0TdpjTTQgNvoUZ83xbmc1PC2YRFQc4TIehquw0+wr
	tdmf+dE+Ayv6tvSh8R4VFtL6eSlRjoAfm4FubXhMZgwj+J+XeVhGVZvAMHHQN1qBM/KX+OiMOvu
	+OhQ9eBFMhfHfjQq+hPV/gIiBFM1YplsAi+HDQsYJolw0reVJpzhaUm4A2ImxdthyuT69X51Vsg
	==
X-Gm-Gg: ASbGncsTtivK4IpNb8Z8In8eKb9VJaVoUJng88j6ixobSOYIkZFzEUPmZGCHpEB1EkT
	65uOtjPtvgU6+BbLQlhvapbB40O+7RRBo7IqWKN6/Nem27PSy+6zW5YaRjWlFyZcWOeKI69Cqbb
	yjognC9LTO3nMPDD8FytBQYnqBKvCnEn+TDfDnWoLKSxJGZt6B62/PIQ58KAOLNWJ1FC2cteCAI
	UHIq6PdQz0AEb524GsdKRYu9caoxT1gj6Rmp2ApRrXekiF84reI6H8htvX/ZMTeH0i+3A07cr/e
	kOOoLqQL9n68GthAUkKNGwVDJ2O3HOjzrwbojsbsVN3wJogy2arYs6K3uXsA8ZX7uvNnYA65aPJ
	u5yieiadg3zYSzq5cNkWXNva01wz/cj5JExIVvLM/clphFnAdlbpPBcDl7YGz9tWBNM8=
X-Received: by 2002:a05:6000:440e:b0:3a5:1222:ac64 with SMTP id ffacd0b85a97d-3b60dd7b02dmr1895346f8f.38.1752679723924;
        Wed, 16 Jul 2025 08:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ78SQM/s0rFpWwJyId0Hih86btopCIgnmO+eV3iVi5SnTVg5Chr4inRc9LECMRO+/9cofVg==
X-Received: by 2002:a05:6000:440e:b0:3a5:1222:ac64 with SMTP id ffacd0b85a97d-3b60dd7b02dmr1895313f8f.38.1752679723386;
        Wed, 16 Jul 2025 08:28:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1de0sm18023660f8f.24.2025.07.16.08.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:28:42 -0700 (PDT)
Message-ID: <3b8d32dd-9d40-44b1-a0ab-8185073b9072@redhat.com>
Date: Wed, 16 Jul 2025 17:28:40 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/14] khugepaged: allow khugepaged to check all
 anonymous mTHP orders
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
 <20250714003207.113275-11-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250714003207.113275-11-npache@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HqVBKTr-un90BrkqtE6RB1k64rOL5AD6ffyVkMYBbxE_1752679724
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 02:32, Nico Pache wrote:
> From: Baolin Wang <baolin.wang@linux.alibaba.com>

Should the subject better be

"mm/khugepaged: enable collapsing mTHPs even when PMD THPs are disabled"

(in general, I assume all subjects should be prefixed by "mm/khugepaged:")

> 
> We have now allowed mTHP collapse, but thp_vma_allowable_order() still only
> checks if the PMD-sized mTHP is allowed to collapse. This prevents scanning
> and collapsing of 64K mTHP when only 64K mTHP is enabled. Thus, we should
> modify the checks to allow all large orders of anonymous mTHP.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/khugepaged.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 7a9c4edf0e23..3772dc0d78ea 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -491,8 +491,11 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>   {
>   	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
>   	    hugepage_pmd_enabled()) {
> -		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
> -					    PMD_ORDER))
> +		unsigned long orders = vma_is_anonymous(vma) ?
> +					THP_ORDERS_ALL_ANON : BIT(PMD_ORDER);
> +
> +		if (thp_vma_allowable_orders(vma, vm_flags, TVA_ENFORCE_SYSFS,
> +					    orders))
>   			__khugepaged_enter(vma->vm_mm);
>   	}
>   }
> @@ -2624,6 +2627,8 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, int *result,
>   
>   	vma_iter_init(&vmi, mm, khugepaged_scan.address);
>   	for_each_vma(vmi, vma) {
> +		unsigned long orders = vma_is_anonymous(vma) ?
> +					THP_ORDERS_ALL_ANON : BIT(PMD_ORDER);
>   		unsigned long hstart, hend;
>   
>   		cond_resched();
> @@ -2631,8 +2636,8 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, int *result,
>   			progress++;
>   			break;
>   		}
> -		if (!thp_vma_allowable_order(vma, vma->vm_flags,
> -					TVA_ENFORCE_SYSFS, PMD_ORDER)) {
> +		if (!thp_vma_allowable_orders(vma, vma->vm_flags,
> +			TVA_ENFORCE_SYSFS, orders)) {
>   skip:
>   			progress++;
>   			continue;

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

