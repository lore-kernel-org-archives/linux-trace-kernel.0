Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1F02D2488
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931737; cv=none; b=e4yFDtHu22d0knxxeQChghxoJgV58rn5uN2VpcuBOWgJJ3RPxz//oqV9pU6MNOM+wETJP2uiCfGfNAgxCVfkOCoc6jAAje/qo/tbmWM105i2PBypWd0m6YlE4EbzVpxl7bh0sstGGKgpP2jsdTpd5RYsQb8SczP7SofwmlFu+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931737; c=relaxed/simple;
	bh=VzjGvqlPF9xCuZFMclIj8GGwc3xClQ69xgAbHknxPLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHTl4P6Jy9XKF7hOJ9omyxTCsViKgQLRAjB29wPgknk+wByxtCZkje3bPv7wlowVr/ckf5D4K4SkTCw46xL03SkYiqewr0MkP3pFHBMmY6T3xC/JpLDmULo3zWuYBlpnduS/DSDC+9PkAibp8tUK7j4L/btnRRsifhvjXjR6zX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JuR1f03T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuR1f03T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757931734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tfmpc2B5EjLEtaoBAE2WUDTDXpz+5rNlMUp/3jDUjRA=;
	b=JuR1f03TUUrT87ZefD9iPUnLQGJj5S3EzEZBAcWFrOKT2e66FeFj5Ps0wuT5XkyyQpvOFJ
	QuFhr9cYNIlPlSFFbvzQu8mvFYcF8zsnCtwYHrvVpSC6KISRNB+HxHrmlMhK0GP3IQFBlo
	vpkNvrzH2upjd5clhpY71Km+D3THT+g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-qjGVYBJyOoKQ63Jfay3mLA-1; Mon, 15 Sep 2025 06:22:13 -0400
X-MC-Unique: qjGVYBJyOoKQ63Jfay3mLA-1
X-Mimecast-MFC-AGG-ID: qjGVYBJyOoKQ63Jfay3mLA_1757931732
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f28552927so15519545e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757931732; x=1758536532;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfmpc2B5EjLEtaoBAE2WUDTDXpz+5rNlMUp/3jDUjRA=;
        b=gAkzHs0ggKTaq4UUwQwXe6rm+4E/6eGKxlkfkqtNHWaRudoenJmoFeodY2V7a3UrYx
         P2MSBLKsSIUyqXgrW4AikHuHfnQCcv51vdEyHjN9afj8FF23cs8jzgXzJlA0nAMejO1n
         9Wsz+8VrLPz0OyYfFOvErCGXjJbvvFZk399XW+UVRm49OpgXDzVbN0pQOqAqQdfUxlMT
         P/ttHpPCrFmc6C89BcDOafsM+bvu2F7VEZUU2Seg+nDOvIupYBWH5uvPXxOrJj0Dzlqq
         Ofx0MM9en0N+GUlp4eCKH79tp3JkUpxDbykFSI9VIRFENsF4yDLtU9/wX8bo32d/WFQE
         +KXA==
X-Forwarded-Encrypted: i=1; AJvYcCUVcuvkVs/r9HCIPxcBwCeuunXbQIdq31VZujtYuU6m+iHJu5LkcsnFsv7/1oWlsKzge5u4P8e1o2tRLgweHa28RJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuyTr9TMIcXOjmrDLgUcr2zFVUzUW4xsnBOOAWPbD7hAin5q91
	bT3iCSlGCDELbhT40ZKEsNJfXhFUtp++xC6mhz8AdZ7DW7hRdOA3xIaO8/UlEZoRN7lLMipJP0u
	ldCVCf4QHanAbBgR6gCXmtPe8Vm9rTAWpVwr3J2K1pq5R8h21Bko7t0SaW0OR8G+qoLXplX09Yg
	==
X-Gm-Gg: ASbGncsuKG9Ua8tVB+9qVBwWE4F1K014GyhQAYTFpdZze+jazs91EIFU/XL0a836i01
	3J5RzkWOB+jfzs1iymCBvDILV7ee+YQhZt5loWuBBoqJDmDgxsTiOhXtWiEZ65w/6ebpv+jx8M8
	2onjUdAh7iagebk24WJNR/4weYBlrKCPvjqC/cbzvhZafrLwOaXfdRat4QPFnkj4I2BMiK+IbHY
	vL5vXFKVyoFSrUagFLfevUS9FGRI1znuj6xvuUy/Gqd5HPxt1lRpUPguRHku5yQ14t123M798h8
	6cBesYm9KFdnTX5KCQj8GgjqDODYcqTb5d1kO5i/iwUOpXWLMQfnpsqOY9/kkm8+awmXU786CnO
	htHhV7f5r7munDQaOEdprGVLmSQb2LEeBsyGcDXKFdE+f/nRTL0gXiybI/uUH6ZsdeXQ=
X-Received: by 2002:a05:600c:1387:b0:45c:17a:4c98 with SMTP id 5b1f17b1804b1-45f211f8ed1mr95800955e9.19.1757931731981;
        Mon, 15 Sep 2025 03:22:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy+yAeVMTpk3VfeLuvmpLt8Pnw7jlIdxjQEeHLZ9ljjFZymYPOAoBhKJl9mxQWLD5TBFtZ/w==
X-Received: by 2002:a05:600c:1387:b0:45c:17a:4c98 with SMTP id 5b1f17b1804b1-45f211f8ed1mr95800505e9.19.1757931731471;
        Mon, 15 Sep 2025 03:22:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e76078708bsm17596191f8f.15.2025.09.15.03.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 03:22:10 -0700 (PDT)
Message-ID: <cd8e7f1c-a563-4ae9-a0fb-b0d04a4c35b4@redhat.com>
Date: Mon, 15 Sep 2025 12:22:07 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
To: Kiryl Shutsemau <kas@kernel.org>, Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
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
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <CAA1CXcA+pb5KvEnJJqdf1eSjaFiBZ82MRB+KDmyhj3DbiQqOxg@mail.gmail.com>
 <enrgrocqajwu5d3x34voghja7pbvau45oobxgabawrly44ld4u@ahch3xn6rtq5>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <enrgrocqajwu5d3x34voghja7pbvau45oobxgabawrly44ld4u@ahch3xn6rtq5>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gTDJ6E_H4OOFiQ4BKpsVDqa6eyLpiSzGyf_lrpg3mIk_1757931732
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.09.25 11:22, Kiryl Shutsemau wrote:
> On Fri, Sep 12, 2025 at 05:31:51PM -0600, Nico Pache wrote:
>> On Fri, Sep 12, 2025 at 6:25 AM David Hildenbrand <david@redhat.com> wrote:
>>>
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
>>>>
>>>
>>> I am all for not adding any more ugliness on top of all the ugliness we
>>> added in the past.
>>>
>>> I will soon propose deprecating that parameter in favor of something
>>> that makes a bit more sense.
>>>
>>> In essence, we'll likely have an "eagerness" parameter that ranges from
>>> 0 to 10. 10 is essentially "always collapse" and 0 "never collapse if
>>> not all is populated".
>> Hi David,
>>
>> Do you have any reason for 0-10, I'm guessing these will map to
>> different max_ptes_none values.
>> I suggest 0-5, mapping to 0,32,64,128,255,511
> 
> That's too x86-64 specific.
> 
> And the whole idea is not to map to directly, but give kernel wiggle
> room to play.

Initially we will start out simple and map it directly. But yeah, the 
idea is to give us some more room later.

I had something logarithmic in mind which would roughly be (ignoring the 
the weird -1 for simplicity and expressing it as "used" instead of 
none-or-zero)

0 -> ~100% used (~0% none)
1 -> ~50% used (~50% none)
2 -> ~25% used (~75% none)
3 -> ~12.5% used (~87.5% none)
4 -> ~11.25% used (~88,75% none)
...
10 -> ~0% used (~100% none)

Mapping that to actual THP sizes (#pages in a thp) on an arch will be easy.

-- 
Cheers

David / dhildenb

