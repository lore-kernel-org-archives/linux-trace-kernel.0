Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D252030E830
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689017; cv=none; b=auTOvOWGsnD1wQfo9kZVFerNoNaGF6Xe5RLA45ZEC8mUVT8XwcYoioDshUmO98lIVeA+oUpwXhZgZ5J7woIzx82BQjL6xLe2KIN7/JFNWb2H09NPNZB8sWkCzVk8+ayswGVGjyWW6CHjI/zxPbJLB4vdAeXHuz5OW0z8g4T2tX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689017; c=relaxed/simple;
	bh=5YFcNL0j+KlhfodVQHYZ956tzfW6ZfDaE5zEM1VfifA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DwVhv6Nv29+Kmfks4ON0IXvcnjv4GAZNOVcbjRd/zZn3tyfi/SeFeZxujMqUmdlH0TVc/eqxvoTp5v5LqnoAa/WnO6nvXdJ7g7HGt0bxHceHDI5Lso4qfdhA2f9L1jCqjKrDg0Wl5Duhjpr6gTkMjhMs/Ahx43EQB0/5C1Sv4yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTr4iGVu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTr4iGVu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757689014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1zQFPvxy2+1YP++cSOxn0igG/hT4rPdSgkdxAwV7qG8=;
	b=BTr4iGVuowYaFcCz6UuoLDrGWwThroIpBd3fZ3AarWZWkD2ynQbyFJUykrKzvkkbRtu4mg
	vSUHM1JSCOdhXDfzfC8L6Vwyv/SkVPLQFnORwtdUDaMvwsVIpwgDa+bhRDtgEqM8hjUUnr
	QeB+uQnXx6oa9qjj4ER+fXS2dPKzQHU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-Me6wH2RFOY2BMS8FH37T8g-1; Fri, 12 Sep 2025 10:56:52 -0400
X-MC-Unique: Me6wH2RFOY2BMS8FH37T8g-1
X-Mimecast-MFC-AGG-ID: Me6wH2RFOY2BMS8FH37T8g_1757689011
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45de18e7eccso10876825e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689011; x=1758293811;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zQFPvxy2+1YP++cSOxn0igG/hT4rPdSgkdxAwV7qG8=;
        b=XG6O8o8CQdIuP1ZU+3cRD+FKBFl6mV4yTlxRCHSHNO0WwLSgkdkYAWFWZDmO2mHD7y
         3YTPeMAlDa+6hAu47kFzQ2ly9f3gAXPA0zh5CwMXit4UovtCWdNe/7pUDiqWh0WMbMkW
         DwbDz5Hx6iacHmTanrsAQHEaYKCQ1N/mwosId8RPqsrRljtaolYTMFCjvz0uUVPXDXOJ
         LypmAlg3FI7aDQ0ag9A3tT0Uj3aK7+DgPL/JJGxX8qJ8cPspkxqRgTyzS5LJME6tjaV3
         YnrqvMQq+sAKMFWIxnhQuSpUnNwtV5NRFbx25NqiaNgmIcK5sHIMDcRwDrxWegZeTLH9
         NdmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPxGTiHUbld2Npu6w7tXa/2s9SwLMOpqtWEWJ6vIFE7G//TnI09eE2mMRwW0ST4D743rPnDkGy/OoeoalvQACejWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBW3uDGqYnUJTRUqY1Vq5Km+BVgqxAEkpQ2kEigLGRFBtR3rD9
	QobVo29ewTCQpxxuwhctjlptKO+x8mkMrh18/GNFtiyy0DshpVhT/WAbWYGvu0rlPrtEtmQONda
	Ae7fuFAePUtBtWYBnSG4j7HlV9ScOeVPvqQzh/ZVTQlC+PEcwtHBKMwglReHEv7tV60VKslcFuQ
	==
X-Gm-Gg: ASbGncvn3z2Q5LlvD+mX8LgAkCvdAoVF5iyT6vDRoj3GLOD2mvn0sI0+vgfZijqLXWm
	H3S42YQnstpwqVlKzDEB4W4mN+5gL9FoXUwKF6MJ7z3ODWXYw5HIC9bPtTsM8sSN+6LGxxuM8Jw
	GWgx3By99fUuu9I91+NJoRm0H5dsHfYZvEN0TBH8Ytjiqj46YSSJBxofJhAzaKKu/D6Eon86LbZ
	IhKW5TMfPjPGoinACpNVOMygjr6o+Z0I5sL6Ch+XRGBgAuVTx+Zj9M1Jaj9lwCjZ4eVOI4aBHcM
	py8djwBquuZ4CoZj0ri0R5c1FS/5SrkM032y4hs0BAgWpNg7moaxjKcIvYtBEk5PD6JgMa0gyxL
	ZJZXk+nsl+IdMH0wt8WOrJNUenG4vn1sc1jVwZNh42UYXKPWgMYpgTjgVWR+5lWCmU0M=
X-Received: by 2002:a05:600c:1f8b:b0:45b:47e1:ef71 with SMTP id 5b1f17b1804b1-45f21221db1mr33669825e9.36.1757689010907;
        Fri, 12 Sep 2025 07:56:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGJ1Aw/IAsL+oNlxxyXrPuhksMuIHj7PST3ENH0Asl27SC4zC5fiOjdJn0+QusczB4ps/nWQ==
X-Received: by 2002:a05:600c:1f8b:b0:45b:47e1:ef71 with SMTP id 5b1f17b1804b1-45f21221db1mr33669145e9.36.1757689010362;
        Fri, 12 Sep 2025 07:56:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e014ac468sm38862175e9.0.2025.09.12.07.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 07:56:49 -0700 (PDT)
Message-ID: <80c50bf4-27b1-483c-9977-2519369c2630@redhat.com>
Date: Fri, 12 Sep 2025 16:56:47 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <43f42d9d-f814-4b54-91a6-3073f7c7cedf@redhat.com>
 <ab8c2e03-53fb-402c-a674-c2c6ab11f54e@redhat.com>
 <rapl4xr55zv2nq3jh5ulk4wvfyxa2kmbnnb4uram6q43y4cbwn@dv5m52ocyqne>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <rapl4xr55zv2nq3jh5ulk4wvfyxa2kmbnnb4uram6q43y4cbwn@dv5m52ocyqne>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DwxSNeIs_85V7yryJUZLTBm8JlFR8d6sNWTZ0Bjr0Ng_1757689011
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 16:35, Kiryl Shutsemau wrote:
> On Fri, Sep 12, 2025 at 04:28:09PM +0200, David Hildenbrand wrote:
>> On 12.09.25 15:47, David Hildenbrand wrote:
>>> On 12.09.25 14:19, Kiryl Shutsemau wrote:
>>>> On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
>>>>> The following series provides khugepaged with the capability to collapse
>>>>> anonymous memory regions to mTHPs.
>>>>>
>>>>> To achieve this we generalize the khugepaged functions to no longer depend
>>>>> on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
>>>>> pages that are occupied (!none/zero). After the PMD scan is done, we do
>>>>> binary recursion on the bitmap to find the optimal mTHP sizes for the PMD
>>>>> range. The restriction on max_ptes_none is removed during the scan, to make
>>>>> sure we account for the whole PMD range. When no mTHP size is enabled, the
>>>>> legacy behavior of khugepaged is maintained. max_ptes_none will be scaled
>>>>> by the attempted collapse order to determine how full a mTHP must be to be
>>>>> eligible for the collapse to occur. If a mTHP collapse is attempted, but
>>>>> contains swapped out, or shared pages, we don't perform the collapse. It is
>>>>> now also possible to collapse to mTHPs without requiring the PMD THP size
>>>>> to be enabled.
>>>>>
>>>>> When enabling (m)THP sizes, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on
>>>>> 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 for
>>>>> mTHP collapses to prevent collapse "creep" behavior. This prevents
>>>>> constantly promoting mTHPs to the next available size, which would occur
>>>>> because a collapse introduces more non-zero pages that would satisfy the
>>>>> promotion condition on subsequent scans.
>>>>
>>>> Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
>>>> all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.
>>>
>>> BTW, I thought further about this and I agree: if we count zero-filled
>>> pages towards none_or_zero one we can avoid the "creep" problem.
>>>
>>> The scanning-for-zero part is rather nasty, though.
>>
>> Aaand, thinking again from the other direction, this would mean that just
>> because pages became zero after some time that we would no longer collapse
>> because none_or_zero would then be higher. Hm ....
>>
>> How I hate all of this so very very much :)
> 
> This is not new. Shrinker has the same problem: it cannot distinguish
> between hot 4k that happened to be zero from the 4k that is there just
> because of we faulted in 2M a time.

Right. And so far that problem is isolated to the shrinker.

To me so far "none_or_zero" really meant "will I consume more memory 
when collapsing". That's not true for zero-filled pages, obviously.

-- 
Cheers

David / dhildenb

