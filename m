Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CD42FDC20
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932658; cv=none; b=NrzSUPEyeK/hQMxSFLlCWdAn5ba4d+HCBhETYhuPu/gXst011Poj0yIr3wUcX/rCRuJ1HvHWhj6CFzry4XFt0hEnrFFMP5Zjrsu3Kd7hvEPhBElUSlBdCBM05TfSCyMXF8iFF+4E0LZZzc0bl1KVZdms1CQBcy4Hm9KuzhWfMB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932658; c=relaxed/simple;
	bh=tdj6MeX8UWprv0GiMeEJ4QSHunldRrELX1VJ2VKtwuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oov1gkOWWoV1HvkudQCtQQPqbkWRM32oJdI0G0WZM60q78ixZQPrGuV/wlZ8XJusodc3Mtjs+Ebjw2ZGpgbiNMQ0axDLplQbZxv8BkQbbmGcbbu559zUmeeBT13fJu3ZropVgYoxOY+KXalSDyOVNK/W5Bt9FxX+g4zBtaDNstQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTYItZUz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTYItZUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757932655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AE1mZo5dM28REMNEPIlpmNiMCj/YW4kRPZdnAEmZK3w=;
	b=VTYItZUzyQBFJPrxG2BJk1Dafs3gZI6Zdw03pJup/lMG6zVaMTqM3K1w07xCKFv9NSEmpt
	oHfeM6s0hzG3j5Xmv79zlpzmyL51ybn0rgc5xunot3vqJx1JdVu807DJfpZ4vlEmxRfw/x
	HKjFpBpgvaGouv1pZxJUUq8AtXplekM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-lZMaIprcOcSljhdFkLAqzw-1; Mon, 15 Sep 2025 06:37:34 -0400
X-MC-Unique: lZMaIprcOcSljhdFkLAqzw-1
X-Mimecast-MFC-AGG-ID: lZMaIprcOcSljhdFkLAqzw_1757932653
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45deddf34b9so29324325e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757932653; x=1758537453;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AE1mZo5dM28REMNEPIlpmNiMCj/YW4kRPZdnAEmZK3w=;
        b=l0H6jHEVhxWjTuyP214uq1FEtuXmK8hDzdkQcQtC0oV/ZZv9NMI02Smh9F7mgYURni
         WhjhNUcas0NwQpFptK+sJf8Q3tU/Xxx7hoCWaEkBuAENkLiPSLGkUh/Nwvq/F6WwaVid
         mpz10VQWrshO8YaSa8YPNAFgiPKvvKxRx6x6ZeQWhfFDBxi9omdqa0cNs0nuElvh4o7O
         Abssl0PYSijiY4FbAcDKiI+tgcSJN7+B/Q4/7bqXgpt6U8AgDjPxHY1rG+WRrtCuS5jA
         SiV9Tmavfupcq5HiTUIOwM0JwPxvEWlojUeQemo+Iatyw9os0q5iLXNERbj+fMYnA+4g
         HT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoUvCESpSH9bUbLNqUMWAU6BD6KGieSKTRf8kq3WIn3cnjZvfAwtLVGRktg2pZ72o8c+ZL7HfobtHmA7QaKB8wWvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPpbLU5VmY7rBBQO9GXCNeE6kCUJjVh/IFnLd6FpmwJkq0ZQ6w
	5wSj7XGIEzemEpKQ9rZCRAekLpp1CPhwKSXmWvnpBuel3imkUgESb0S9bFcG4+jcQmJ22AEncMf
	MUUmV1uR3hscdGATotaLhNke5NWE2odgVSY7/0IoqNFdMfYE0X8w5kcHPCa4ZNixtF+5M/J/0GA
	==
X-Gm-Gg: ASbGncuRHd725P0Zhv4f5pA3hX+zLt+QjxEDTFQrtAW37BDzwN7pGZ61w6oZlXtFdy2
	bpx5behr1SgueOwOAecM/MWeYb7Pk24xntZPra2hPyezzpWigWyNqXE5gqMjF/qp0fEM/yQJeV4
	8s4qx3RpQlW7FusGjFiLLLrJdOUGRLYGvE/9S6hr4oi8W8OXKtsbP8qbfMDCgRO+QBj22y6/wOW
	KsLcNjM480Qbac4+Ep6AYI9VXkPIDsoEZPVF6gW1NBJv4k8l06X/MINyW4Ff49ViB20c39lBpcU
	WqmO4eqAySH10u8LzKktLdQ19LWFXBC3Ip7o6SqydiK9o9TKsTkKgeDuOv3E6j81SFcJiLzU1WB
	XtRyFs1AqeySX3xeBULbhpVAsDUIJZdW+pz2ssGKtYvBVQJ6Z85tPt3DYfdA+y0fA+Jo=
X-Received: by 2002:a05:600c:3414:b0:45d:f680:3140 with SMTP id 5b1f17b1804b1-45dfd5ab209mr99450685e9.2.1757932653214;
        Mon, 15 Sep 2025 03:37:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKqPx+HEJeLSB1hCo0z7zZzUc9au6zeGG4k2n2MG+k85CvLdXKo6KoDdaStSnTH9xLtijK0g==
X-Received: by 2002:a05:600c:3414:b0:45d:f680:3140 with SMTP id 5b1f17b1804b1-45dfd5ab209mr99450255e9.2.1757932652781;
        Mon, 15 Sep 2025 03:37:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e41b6dbdbsm158366625e9.22.2025.09.15.03.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 03:37:32 -0700 (PDT)
Message-ID: <f1d36416-bb96-4ed1-bf0a-5e1445fbbdd6@redhat.com>
Date: Mon, 15 Sep 2025 12:37:28 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Nico Pache <npache@redhat.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <43f42d9d-f814-4b54-91a6-3073f7c7cedf@redhat.com>
 <ab8c2e03-53fb-402c-a674-c2c6ab11f54e@redhat.com>
 <rapl4xr55zv2nq3jh5ulk4wvfyxa2kmbnnb4uram6q43y4cbwn@dv5m52ocyqne>
 <80c50bf4-27b1-483c-9977-2519369c2630@redhat.com>
 <7ri4u7uxsv6elyohqiq2w5oxv4yhk2tyniwglfxtiueiyofb3n@l4exlmlf5ty4>
 <59641180-a0d9-400c-aaeb-0c9e93954bf5@redhat.com>
 <c5bcecb8-13e7-4db5-849e-2120c69b2af5@lucifer.local>
 <ed784d6c-6c2a-4e0b-ad2f-e953bf310ce8@redhat.com>
 <dcfc7e27-d3c8-4fd0-8b7b-ce8f5051d597@lucifer.local>
 <78d75263-e0ab-4dcd-ae97-5c5c9bb10193@redhat.com>
 <85aa2020-5b5e-4bfc-aade-581d20aeff87@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <85aa2020-5b5e-4bfc-aade-581d20aeff87@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F4pCHu_EabCaWhZtc8dCTY__MjGJ3OG2l7AkiF23GjU_1757932653
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 12:32, Lorenzo Stoakes wrote:
> On Mon, Sep 15, 2025 at 12:25:54PM +0200, David Hildenbrand wrote:
>>>>
>>>> I would just say "The kernel might decide to use a more conservative approach
>>>> when collapsing smaller THPs" etc.
>>>>
>>>>
>>>> Thoughts?
>>>
>>> Well I've sort of reviewed oppositely there :) well at least that it needs to be
>>> a hell of a lot clearer (I find that comment really compressed and I just don't
>>> really understand it).
>>
>> Right. I think these are just details we should hide from the user. And in
>> particular, not over-document it so we can more easily change semantics
>> later.
> 
> And when we change semantics we can't change comments?
> 
> I mean maybe we're talking across purposes here, I'm talking about code
> comments, not the documentation.
> 
> I agree the documentation should not mention any of this.

Yes, I was talking about patch #15 ("It's just when it comes to 
documenting all that stuff in patch #15").

Comments we can adjust as we please of course :)

-- 
Cheers

David / dhildenb

