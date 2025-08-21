Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03D35E4DE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755809024; cv=none; b=s3Y+ucUg/yHktRGBJj9OoamapX1VGpA6MG2DkSN4oCQrY00RIkb5yfkt29bZa0RdgvC6bIF26Mhdf7ZNv4O3M+R0ytQW2KlgizT4nAMFAAbH7pKjdrynCs2CQ5fOIT03qbP1ZFFGA9eclycjo0Ah5jLoVz0/0XN0vjSaSxZm6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755809024; c=relaxed/simple;
	bh=6uFSmbinVkEFLrrGHB1ZwGY2fBbLdOPoyQB/GveJ0Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3mll1zGC6cEZ05Ggz0zHmqE97uhimRtdu6B29evrj+qfM8ab6fReA51MdwTsVNeCtY7ighsOic/YZRkSJ20/a4ftZy+TPuz3Z6N1sSIho1Y7134dbuEvVJWBZF0ZqwZJJgFh/Z87cLyGeoNFGVlgyYLmEUfHcaIXCVcCih61w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFhOeYbT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFhOeYbT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755809021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h/fo68/IS9K7j0Ewx5SO22U2/CaLZSJBW37TgxTQuZY=;
	b=bFhOeYbT1n0MQdkahblIIES2Iz4ba9Z3xNJ1ixOE9oiz5Dv3DJT2AVPAAr3bnB/woMs4mM
	cUsyuBaPfUg8ukSrm7WnK+5i0KLMdZ3WLxM++JGI3LsOftbUDIFBMr4mvTl4wlN55kK9KL
	D4y+IsxVDHDv1VqtImmd5jqClys8wPI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-mMLvZ96BMw6fgkne3PtyhA-1; Thu, 21 Aug 2025 16:43:40 -0400
X-MC-Unique: mMLvZ96BMw6fgkne3PtyhA-1
X-Mimecast-MFC-AGG-ID: mMLvZ96BMw6fgkne3PtyhA_1755809018
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b00149cso6449085e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755809018; x=1756413818;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/fo68/IS9K7j0Ewx5SO22U2/CaLZSJBW37TgxTQuZY=;
        b=sCJongQSykVgpFKgV4mCdh3kBU3d4nbf5W3ddt9jSxyW33id20Q6VQHx4RasAxYr4M
         qviGakL9ofU9sNAvgdTPUf89qjEXnpkoZ604oUzFsvDs1cIRYfbgvdq0jVemB3UAwWJC
         ghbf9/X1iiguxettbUBkfNv+LJ0UU1LgZM8+6ZKiqOQh/158KA6+Nvd/ZR08XhrjCDao
         XCNom5WiDOFY+HBXj6UejbKKRgJ++U/G9k+UfKeqg/hl5a2NCMjTD/4Ion/OOLaYyFU6
         jgWunnITiqbsPi38hq22IfIPwJACTQY6VroVq8LecsyvsoBhupceIpQyT+5AGsTGioa8
         oP/w==
X-Forwarded-Encrypted: i=1; AJvYcCV79Y83k6sKQ/nMYx0Kcpz48oN3CaZU8ftZKUnD3TN2qqxBXbeG1ipxcrWWUs9ZFgy5+HUwNAYjfVNBEsk+zBxiqzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW06McYoweCNmi2ImMJRWlwzwx1eiPKTYhlKS8Bmdj4fAWNeiq
	XUDRQbkPTUQgr4zF3SIpu1GFg+woUBunxd3qKR8q3vba7ThJoSzLx8JN4AaSkCNEpvWBQ0P6Mvn
	pm6e8lfDYYka0t3uV1JWnNxlY5C9mfY0c6Q0YUyEyHBu4FvMW50fvO/Z3/swpydERZ3rM6JSzWQ
	==
X-Gm-Gg: ASbGnctwNsR7vJZd5jokrYyLxMdEq5O+9/XMseQQnGqp1rL3QVMGn5ifZEzOsCFuG8O
	9Wr4nmXPEKwsF2LbEHcRvDel4S1TS9O5OFM1UX0EButvg7lbCMe+OUN4HZArPJbK0L5FIfT9Ell
	fOymtPwhSjhYx7IK64K3Tg+engYsqzBLOqShZ8hX7o1LqpHusMwaXYN9XRzL4lmyxWqkbBCSMEo
	KNV0xsffbTwbY3wHrNU2UOAWLVpfKYY6jPImgTefFD78Wzy9+PTuMbB3wzM3kmb+R1Cx2TTo+v3
	baDrWZcDIvP3a1bVCVp1YKK/A3w1Hmk0VOogD91oBc1d3pf0PJweV+71CmVupz9RlzrkGnUj/L/
	EwZQRzZyjTDjSNTG+CooUQwSsh6WkfATSiWhJI/TEwPGIaGkTYNzfZHmoL5dRcQ==
X-Received: by 2002:a05:6000:1acc:b0:3b9:1d32:cf2f with SMTP id ffacd0b85a97d-3c5dd8aafeemr255806f8f.38.1755809018371;
        Thu, 21 Aug 2025 13:43:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKIuRxKND46b3AmB7y/Xw/b9KvWRYzcjy+ul/Xngby02wgViPbY5Y0WYNrMrywVt99HnqEQw==
X-Received: by 2002:a05:6000:1acc:b0:3b9:1d32:cf2f with SMTP id ffacd0b85a97d-3c5dd8aafeemr255783f8f.38.1755809017884;
        Thu, 21 Aug 2025 13:43:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f26:ba00:803:6ec5:9918:6fd? (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50dd02ebsm10113115e9.9.2025.08.21.13.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:43:37 -0700 (PDT)
Message-ID: <95012dfc-d82d-4ae2-b4cd-1e8dcf15e44b@redhat.com>
Date: Thu, 21 Aug 2025 22:43:35 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Nico Pache <npache@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250819134205.622806-1-npache@redhat.com>
 <e971c7e0-70f0-4ce0-b288-4b581e8c15d3@lucifer.local>
 <38b37195-28c8-4471-bd06-951083118efd@arm.com>
 <0d9c6088-536b-4d7a-8f75-9be5f0faa86f@lucifer.local>
 <CAA1CXcCqhFoGBvFK-ox2sJw7QHaFt+-Lw09BDYsAGKg4qc8nSw@mail.gmail.com>
 <CAA1CXcAXTL811VJxqyL18CUw8FNek6ibPr6pKJ_7rfGn-ZU-1A@mail.gmail.com>
 <5bea5efa-2efc-4c01-8aa1-a8711482153c@lucifer.local>
 <CAA1CXcBDq9PucQdfQRh1iqJLPB6Jn6mNy28v_AuHWb9kz1gpqQ@mail.gmail.com>
 <d110a84a-a827-48b4-91c5-67cec3e92874@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <d110a84a-a827-48b4-91c5-67cec3e92874@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VOP_T_iQXqx5VS7IFuwS3JgBh0nQQ8P-yzapcSbTfb0_1755809018
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
> The one thing we absolutely cannot have is a default that causes this
> 'creeping' behaviour. This feels like shipping something that is broken and
> alluding to it in the documentation.
> 
> I spoke to David off-list and he gave some insight into this and perhaps
> some reasonable means of avoiding an additional tunable.
> 
> I don't want to rehash what he said as I think it's more productive for him
> to reply when he has time but broadly I think how we handle this needs
> careful consideration.
> 
> To me it's clear that some sense of ratio is just immediately very very
> confusing, but then again this interface is already confusing, as with much
> of THP.
> 
> Anyway I'll let David respond here so we don't loop around before he has a
> chance to add his input.
> 
> Cheers, Lorenzo
> 

[Resending because Thunderbird decided to use the wrong smtp server]

I've been summoned.

As raised in the past, I would initially only support specific values here like

0 				  : Never collapse with any pte_none/zeropage
511 (HPAGE_PMD_NR - 1) / default  : Always collapse, ignoring pte_none/zeropage

Once could also easily support the value 255 (HPAGE_PMD_NR / 2- 1), but not sure
if we have to add that for now.

Because, as raised in the past, I'm afraid nobody on this earth has a clue how
to set this parameter to values different to 0 (don't waste memory with khugepaged)
and 511 (page fault behavior).


If any other value is set, essentially
	pr_warn("Unsupported 'max_ptes_none' value for mTHP collapse");

for now and just disable it.

-- 
Cheers

David / dhildenb

