Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002F262FC5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198801; cv=none; b=hd5jUTckek7wD91dPEH+8nelgM4XsLThzeDdXhG1G+lnNvRoyRtPNDlH3n7sDHzIdzcSdb7fV3yE4HkKVRABU+gpr66QLXiumZMPDDczAzQYuNKm1rMkxNyLBm3Hoyon1wJiAfqbxfiBiSES6ES9fMWln4LLk/OGaI+3dq0jxNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198801; c=relaxed/simple;
	bh=epIEIo7FudljAuaXwgcFKA+1ibb56TwGH7ax9CSaLvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAC09mt9fm0Zc0DXDRH9lNEdly1Ju4srJs272py9wfqF9839CGHYjJqs1d9K4AlNI4h6NxUhqX7S9VfRUUL2Lxed/KpWw+moLyJcpGtE0sPhH6d1IwgQvS5fLrDIxHtSLZRBESRejI/6WgmeXDQZUPhcxVasj25uitgpj+tKw6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAJhiVbC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAJhiVbC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753198798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P6oftsaw/Y8o1NDs+0pBZv6sXSPAX61Y+1sP2c3kKIk=;
	b=UAJhiVbCqyMOAbrvmpi/DA4VqkYlZTGzh51tvC2r4FWw3hxU/OCG0pW44q53oZQSMmoPFk
	JAwHNlFFIgqHMapoMNn7mNSkd34klZuYC8zzY8GdirVKAvpttE3rin806lksmXGRYbez8j
	MMETEfHFdlXPjs+XdTbY6W3ldwZGULQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345--yRRb7f4PgOH4_LdY-zUpQ-1; Tue, 22 Jul 2025 11:39:56 -0400
X-MC-Unique: -yRRb7f4PgOH4_LdY-zUpQ-1
X-Mimecast-MFC-AGG-ID: -yRRb7f4PgOH4_LdY-zUpQ_1753198796
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4562985ac6aso57912025e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753198795; x=1753803595;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P6oftsaw/Y8o1NDs+0pBZv6sXSPAX61Y+1sP2c3kKIk=;
        b=NZ/igZoxyr0H91t4TNyh7KNRF0cbPBEJVNotOvEjweN0rjj89rcg6OKuct9ago4HZo
         aMHVSG7uCeg5Cn2BCUrshaQKPBmLqivgCEXygsdZJVextMsQ8GePVPu4UO/e/+tkvuwJ
         cgXKD/MjbkwhNz0FwpbgPdgvJGCUNf3CeUv4cHnXtOFYb0fCPtZNrFF7ik/VfT91jSGV
         dM4PfJnS4vf58jc8/rqaV4HX4IeQmvRYBlRVGpEDoPLnV+lqAHHl5BkTU4bwtG9R7WNw
         /SB6c9Sb0RB/QtiSXh/bJ/HA150Nng6YooCQ7hjvF3e3EmV3FG41SGNjzD4u5wMxsslC
         NqbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuSWutQP0TNvW1jfh5+arCHYVv9pCMH44f56hUdzfAYNCQmFPAuTPMqlr6gPj3Z5lIKsxLezePhAcCh1/4QS//EIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+nNIPlZ5DNotb7svPvzIP9DWKJ27vOnUxBWZSRgXAFxKBSpQG
	heQhJew3aN1IO7kkpENoTw0nxXWxJK5q0RD8i182Avnqv0udW+E4xvJlAYFccvOH83nmZXkC/3W
	q2Uj9KFXnQDgsicupg4M4o0b2/3XGkVZjLl6eA/vgfRBiJtQjTbDrJ83634HtOW1SdgAwHUP0PA
	==
X-Gm-Gg: ASbGncv3x3uYMsjLcMjWTZrRZUC0mkHDFL+99rzrJ1y7Bf7zOs1f/tetypIQT6Z4wq7
	AqxPB5eoDxnSKqd5qwmY72hAaqwTzZge9GfOi3ptSeGsIUDz3zrhwhe2FteyQSEOcO+P11MIR/x
	ZgeFpXD6jlbmMLrxpH8wZNzStW4Iad1PWAz1J+chcfFdYZ3BhWARQHGPq0nZvo1NM03Cas/Mm6I
	D4PRssVFZSF31lYpnLyZ6ZcUoW/u9KQsM2iO1H5U00WKYy0z1EYGxNfJsxkCypwGLxN9gFeXl4K
	bX1LVJYcdkG32c41EmN19H6te93CRlZa3Er8wCGVbDSN6bG5BlPCeGenI8xXpfQ6+5Ryy+7Tkgk
	6XlGKfCM8eLP2cziOCA/YnpmC/Zeyguu7/D0C6N58Twi+bK63+mXmo4rrjevKBMz2CXI=
X-Received: by 2002:a05:600c:6097:b0:456:302:6dc3 with SMTP id 5b1f17b1804b1-4562e3c4b98mr196621485e9.26.1753198795539;
        Tue, 22 Jul 2025 08:39:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrkg4gxbARCuQj3vafGP/BU7uT0jLAHHDQrZ/pOOEsCiRZnt7P6SzdJq8yMA4UuzgS9LM8bQ==
X-Received: by 2002:a05:600c:6097:b0:456:302:6dc3 with SMTP id 5b1f17b1804b1-4562e3c4b98mr196621245e9.26.1753198794985;
        Tue, 22 Jul 2025 08:39:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:de00:1efe:3ea4:63ba:1713? (p200300d82f28de001efe3ea463ba1713.dip0.t-ipconnect.de. [2003:d8:2f28:de00:1efe:3ea4:63ba:1713])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74f9c0sm135998155e9.28.2025.07.22.08.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 08:39:54 -0700 (PDT)
Message-ID: <0ab2aebd-a43d-4ef2-a91e-10eae593de67@redhat.com>
Date: Tue, 22 Jul 2025 17:39:52 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/14] khugepaged: improve tracepoints for mTHP orders
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
 <20250714003207.113275-13-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250714003207.113275-13-npache@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2OgWApVsj7JlSutsQHaacYnZYcwFJIX0GX_YNPI8rsw_1753198796
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 02:32, Nico Pache wrote:
> Add the order to the tracepoints to give better insight into what order
> is being operated at for khugepaged.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---

[...]

>   
>   TRACE_EVENT(mm_collapse_huge_page_swapin,
>   
> -	TP_PROTO(struct mm_struct *mm, int swapped_in, int referenced, int ret),
> +	TP_PROTO(struct mm_struct *mm, int swapped_in, int referenced, int ret,
> +			int order),


Indentation.

[...]

> +++ b/mm/khugepaged.c
> @@ -711,13 +711,14 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   	} else {
>   		result = SCAN_SUCCEED;
>   		trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
> -						    referenced, writable, result);
> +						    referenced, writable, result,
> +						    order);
>   		return result;
>   	}
>   out:
>   	release_pte_pages(pte, _pte, compound_pagelist);
>   	trace_mm_collapse_huge_page_isolate(folio, none_or_zero,
> -					    referenced, writable, result);
> +					    referenced, writable, result, order);
>   	return result;
>   }
>   
> @@ -1097,7 +1098,8 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   
>   	result = SCAN_SUCCEED;
>   out:
> -	trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, result);
> +	trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, result,
> +						order);

Dito.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

