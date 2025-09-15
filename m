Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3CE2EA720
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934881; cv=none; b=aOy7XNETZOiL9tCe99Y5AiolbVxWRbye2ICKxOXJBgaQ6PqiHbBB7SodZNWpxoYH27eRbrGtfeR/AlP8UcH/xwF7jLNlIcDfzqAtr72qe8LgToO7u3PLNvLc4BeCL82HJnrfK1jX0FFBlJMGfQcY/muTHxmR4p25vXLNc7LBRJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934881; c=relaxed/simple;
	bh=glibgmfIYSCjLML68EJCUnAydUdJcT5Idq8yi8PkmZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwS2fDH0thMYwgoO8z5F1HhJRBnEZKMiyRVq90DapN+fV6+qR0vz6awHOGoDi6/WfCI/c8qT2rmMa8an6URK1ex8FDUC26yCIHk7dm7x8NsnfyRdK2yeZcdEf62jOBzOoUjVcnZIQl4L6z/PBA0cS3FZf0mVL5vFSb7qNZx8FnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NS2htQ3Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NS2htQ3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757934879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NdltlWJNVwfT7jYyjG9tAr/dNsT+qpkwvhbKYwL90eA=;
	b=NS2htQ3YU4ZvAdw8T9DgmcBrEZey22akZTSFq3bsNLGolMl9+uxT3X6PReaiR310UKkaVw
	3DnBGFL9ogsi8RK1D4XhVX8/rUTDcd3gWhYVeMGqk9XTiSWYOEknQ0vmvlHj7o14DuXMyT
	LGjjFqCW3A5bUEeQHlbWXSj2gdIxoHs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-agUdYZxdMwOBErol4-cuJQ-1; Mon, 15 Sep 2025 07:14:38 -0400
X-MC-Unique: agUdYZxdMwOBErol4-cuJQ-1
X-Mimecast-MFC-AGG-ID: agUdYZxdMwOBErol4-cuJQ_1757934877
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e98c5adb70so362059f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934877; x=1758539677;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdltlWJNVwfT7jYyjG9tAr/dNsT+qpkwvhbKYwL90eA=;
        b=EyDM5xk2nRacsnj6st7cn3Qk4mFsg7hqA1IINtVfV+ugBfQKavCGsWqmgwu7HfO/vI
         ++PHX7AlZDENs9s229s8wEdRdHX8O4mRtio1msyw2gkGj2ametUt64eYomjZ9o+N+wyB
         juQxGtJaQUK6HqSWrbRe799QsFi61e1MA1nl6F6MbSYjw/TyFqog4Xl2r/YmKSq6982p
         Wgwh/i9ZzkWzHF+N0Z4plLxlkge8rGLp8zDO/3mGpoB5Z+ccn/r0i8CVc2sOtx6O2FAs
         v/VsKLxUR0Hg//CnGrzN+YST1nG4DpEzDyLwlR0MAzheZfVwFK5Ejf39UbDNh1khSmQk
         VYaw==
X-Forwarded-Encrypted: i=1; AJvYcCU8rMOw3oyk/j5aKNUHOraHMTV/xfMg7dAuSVyIWI2KEQA8VgtrbwhvzydiPiapQ1dgQubM1WyTjp8B3/hNEfLRh0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuzb1xUU+/rHBEjo0VY/4o5yWhLAdFUHikPBoEtn2/6ywfd/vx
	MRth1OMlwNT6FiUDm05AUzIEEg5xdG9/LdYhieuWDjGGwTpRaw2bEiXkwsbgKOEMrjtRi7x4eLi
	Q1JPlY5MHHlZ3KW4nMQgThtF5jj2g4YuICv9iwB2GmVBa6e/qeRDw/FQ3PfGciaUlIwHpW61/vA
	==
X-Gm-Gg: ASbGncuILd8CjyHw+Z8BLje+nke4YQUJd4Kh8fmIBLTuHLSW8IrS8hc2JTXjUAvAyNP
	1JjEO2r5PV0q1ZND7FumFWelNW0bXuW0icMkeKcGilQv40Gf36Whlf3QhE+2AM/si2WsKD6W2/Z
	yp2fPlDKcL2qHr43jpY6U9v39lCtYtOfgp1IAiwbABhwGT+dl2q8UCVRFfQjpY+1qzzNtbhe4JS
	u2d5IuHLN7KOLkre+3HJ39v7e9OO49Srv72DW7iwMP9l5jBAtaOlbwPL/pP568m4VYzLBR1IbiL
	kfoJ+xIMddCqDBTdy+GH+7JXktM8TdkZe5ls7Jl6jhDDQkxE/plsFJWmGI/+NT38XbNzIZ9j0Yp
	K+M5kflsDONRXr7hWVhqB6nugtIVO/ilgEfpCXAigjCV7BDeEAkDSpFMpcyukv2epnyk=
X-Received: by 2002:a05:6000:4014:b0:3eb:f3de:1a7c with SMTP id ffacd0b85a97d-3ebf3ed6852mr176688f8f.30.1757934876694;
        Mon, 15 Sep 2025 04:14:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpPe0zFChMftg+HjkuK2bT6qcm5CziG/vjDMR5C66naBGw+ElxT45E1hV/tGJpOC+C4Sqlmw==
X-Received: by 2002:a05:6000:4014:b0:3eb:f3de:1a7c with SMTP id ffacd0b85a97d-3ebf3ed6852mr176658f8f.30.1757934876114;
        Mon, 15 Sep 2025 04:14:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607878c9sm17450445f8f.26.2025.09.15.04.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:14:35 -0700 (PDT)
Message-ID: <e450009a-56c9-4820-bd0c-da1d782d3962@redhat.com>
Date: Mon, 15 Sep 2025 13:14:32 +0200
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
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <CAA1CXcA+pb5KvEnJJqdf1eSjaFiBZ82MRB+KDmyhj3DbiQqOxg@mail.gmail.com>
 <enrgrocqajwu5d3x34voghja7pbvau45oobxgabawrly44ld4u@ahch3xn6rtq5>
 <cd8e7f1c-a563-4ae9-a0fb-b0d04a4c35b4@redhat.com>
 <155c821d-402c-4627-a723-6f8c88a2f65c@lucifer.local>
 <ae9d88e2-bab9-49fc-a459-d7b9a8fe9351@redhat.com>
 <ff4b6935-fd13-478e-9187-219fb612aac3@lucifer.local>
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
In-Reply-To: <ff4b6935-fd13-478e-9187-219fb612aac3@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TVCJU_0veZ9oCfN5DjMECA31pm2aQoQ5dGs1HqMEZ9s_1757934877
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 13:02, Lorenzo Stoakes wrote:
> On Mon, Sep 15, 2025 at 12:52:03PM +0200, David Hildenbrand wrote:
>> On 15.09.25 12:43, Lorenzo Stoakes wrote:
>>> On Mon, Sep 15, 2025 at 12:22:07PM +0200, David Hildenbrand wrote:
>>>>
>>>> 0 -> ~100% used (~0% none)
>>>> 1 -> ~50% used (~50% none)
>>>> 2 -> ~25% used (~75% none)
>>>> 3 -> ~12.5% used (~87.5% none)
>>>> 4 -> ~11.25% used (~88,75% none)
>>>> ...
>>>> 10 -> ~0% used (~100% none)
>>>
>>> Oh and shouldn't this be inverted?
>>>
>>> 0 eagerness = we eat up all none PTE entries? Isn't that pretty eager? :P
>>> 10 eagerness = we aren't eager to eat up none PTE entries at all?
>>>
>>> Or am I being dumb here?
>>
>> Good question.
>>
>> For swappiness it's: 0 -> no swap (conservative)
>>
>> So intuitively I assumed: 0 -> no pte_none (conservative)
>>
>> You're the native speaker, so you tell me :)
> 
> To me this is about 'eagerness to consume empty PTE entries' so 10 is more
> eager, 0 is not eager at all, i.e. inversion of what you suggest :)

Just so we are on the same page: it is about "eagerness to collapse", right?

Wouldn't a 0 mean "I am not eager, I will not waste any memory, I am 
very careful and bail out on any pte_none" vs. 10 meaning "I am very 
eager, I will collapse no matter what I find in the page table, waste as 
much memory as I want"?

-- 
Cheers

David / dhildenb

