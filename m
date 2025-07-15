Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2412517B9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594847; cv=none; b=HY+TnYtJM5dd3LYAkDt+jHuQOTkAVAcD+DnH8/dZKWM5f79iHz5HkQrR8TphKUrytkGkQiOcxWbUDBFaf5/fLCVXi6XltHzcBf2ZLe/IcJHFuZGlXfQAcNFgcht0lJlBC2OgVVz3iygDDMU2oLBXYG12GVElvLr/Eqi49X/izUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594847; c=relaxed/simple;
	bh=7p3MlzNMPnV+yP1R/oFLSAlsSu8M2X9v99aIDTC+pKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIFK0m3hueAOlKSluXZDzTFAetH8q/RQIy0fW09Had3nYipcfIrFKxwIO1OWLxguOYfhFlQYCv4TEgK+9D00S85nI1CVk8AX9P6nMzCZ/1DMjIEAuWK3HGLXw91ViC+MdpfFtd9l3LRyd/fttOC5HOIyQVWlQkw4M5bkL2Yp5Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKUK4fot; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKUK4fot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752594844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qmv50NS1VuZTN4/dyOMhlcYCw9wZ76zAdhcUU4LU8Ts=;
	b=EKUK4fotXpoORuJOzg6g6OAvN335tqbOZ/QosQavZuU8UWqK7QRRapLv9sX7qx4Ygu8PnN
	472Z008jVTZ77ySJ4+qIskPzIMcxIAEIQLIZyedEuL+mloBoWm4ArJrt7GQwI8pSh5XhEd
	c6XGRNVENTxd1dqoY1BWo89gzQUKWd0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-SvrQA_2rMoq9LLD1918c9A-1; Tue, 15 Jul 2025 11:54:01 -0400
X-MC-Unique: SvrQA_2rMoq9LLD1918c9A-1
X-Mimecast-MFC-AGG-ID: SvrQA_2rMoq9LLD1918c9A_1752594840
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4561c67daebso43275e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594840; x=1753199640;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmv50NS1VuZTN4/dyOMhlcYCw9wZ76zAdhcUU4LU8Ts=;
        b=dzCVgZgnbYZBwt/I6zjoEtRRdELQJilDU8iGaLWhu36U7vjIdyWHTQVe6FVX1Ooagu
         ZWdobDWdN6fWPg94krEN8UfpPxaW4BZpnTumBsMcG9vbVp5yWtNIpGAsGfLrLI55bQBE
         wW8Y3mBXKl+PWmY/Heeg9FXSJFHzI6nOVo81YDyn8QyStL5bBDqnLp23rLFbZrxu6DqG
         WYhtjjyhjtN6RQOTrAdBbeS9hm3yaBQRkR9DTLIzPKINoA26QwaO6tWhAM36a/lIdTgY
         jTwvHJb/kvkwIOb2habIXUrWeCCfwCPdiqukNbl5i6ghDu5UtYkcNyBZVWEEuFRuFwJB
         h39A==
X-Forwarded-Encrypted: i=1; AJvYcCXJJsxal534Tt5dKe3RX4e7S0hX+Kbb+v/lMwUD6z7/ZthJI6Jl6WUrgefbHG5f96nSSyXIwCSA7C/dcsGSwZZI0yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV0+0lsJcUxUHuSHLRyzU9dgm6RPPdNl4hO1eDsT0340qY6V9h
	rSIQJwTGHDC4UcbsJYwmO0xz2qopS8rJtOm+kh20wZIP02FO/c8/W5FKhnotmpjEZ3P4YmmIap0
	h2EJjmbT/N0UEeDnCw77AEGyMlkN70GogDKptqmXxuGlft7aBbAPBsfCums1uz4CfQqKrpojv6A
	==
X-Gm-Gg: ASbGnctaFicLqpFEJt1jAIf/X/j8IZ3VPEv9I3YCDnK83xgXevPlr/FQTR61zq64e1X
	d3uDXoNHRSpx8v36/1pWJl1r5FhCzdAQI9tvrh1ZPnjEP2zpgQoM49CYl2i4hL8z9tfUUIqzcLw
	rgy4yT2acln0ZZOamWWWb/aQku7KCOyWNQlvLzlSbp5yCc38OL+K3QguFWyvAFIMLsV5Trg7o6j
	Ccvfou5j38DoSxCfzxdO6g/Ef11B3ZDEovNIiFck8aU/ucNyeb/fBzyEmq6BLzcWCnYadlcP0UG
	o01wTaU9YDrVwB4iCNfYamMGUhJTCr6QM+c0CtaChQVc80FbL06HlKW5Koy1O69RgHWu684OR0O
	3/zgoi1oj0gv44eH/yzUU+xTG+i9+TsNjaB3O3kyyxJd9lS6a1VevtbJv9G6dB6Ovnk0=
X-Received: by 2002:a05:600c:5296:b0:455:f7d5:1224 with SMTP id 5b1f17b1804b1-45625e60a5dmr42794175e9.9.1752594839844;
        Tue, 15 Jul 2025 08:53:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjvMQLgGZNyoZsqz8MCuvOcue7LYnZbngEgbjMQqc91Vf50+c2mJ+v6bzN/+cLK2wOg4k8uQ==
X-Received: by 2002:a05:600c:5296:b0:455:f7d5:1224 with SMTP id 5b1f17b1804b1-45625e60a5dmr42793555e9.9.1752594839295;
        Tue, 15 Jul 2025 08:53:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d77asm15798899f8f.58.2025.07.15.08.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:53:58 -0700 (PDT)
Message-ID: <d8474462-a90d-4b35-bfd2-dc1a641cc837@redhat.com>
Date: Tue, 15 Jul 2025 17:53:56 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/14] introduce collapse_single_pmd to unify
 khugepaged and madvise_collapse
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
 <20250714003207.113275-3-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20250714003207.113275-3-npache@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N7mjYlaRAv_pA9-mIiLT8ypbNRXKyNoCsYY6tgHE_8c_1752594840
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 02:31, Nico Pache wrote:
> The khugepaged daemon and madvise_collapse have two different
> implementations that do almost the same thing.
> 
> Create collapse_single_pmd to increase code reuse and create an entry
> point to these two users.
> 
> Refactor madvise_collapse and collapse_scan_mm_slot to use the new
> collapse_single_pmd function. This introduces a minor behavioral change
> that is most likely an undiscovered bug. The current implementation of
> khugepaged tests collapse_test_exit_or_disable before calling
> collapse_pte_mapped_thp, but we weren't doing it in the madvise_collapse
> case. By unifying these two callers madvise_collapse now also performs
> this check.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/khugepaged.c | 95 +++++++++++++++++++++++++------------------------
>   1 file changed, 49 insertions(+), 46 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index eb0babb51868..47a80638af97 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2362,6 +2362,50 @@ static int collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>   	return result;
>   }
>   
> +/*
> + * Try to collapse a single PMD starting at a PMD aligned addr, and return
> + * the results.
> + */
> +static int collapse_single_pmd(unsigned long addr,
> +				   struct vm_area_struct *vma, bool *mmap_locked,
> +				   struct collapse_control *cc)

Nit: we tend to use two-tabs indent here.

Nice cleanup!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

