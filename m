Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0296837A3AF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750257; cv=none; b=ACIBzknyRKslzeqI0itDojqHqiCzJYuY+oBgdtXDKjXI/6Xbps6QN4S+ni1IfyCu+y+8gxHTSlZSqKbY5Y6TvVqm313z+zIsGnZJviZu15JCP5B9N0O88cs3p99o7bnKe/QnsJXFW4H5MBijdo4qEAbVzoucMAYPKZlUDXNLMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750257; c=relaxed/simple;
	bh=wZanl49DyIDL5WarzYUGp2pgrzEoeP7JtN5YoXYI9Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TioCS7pxf5TwG9FItIMc4bIhuiTBQ/2FpxDULlyyCElGv7gf3Y8rt3oXtEzR1I+ine8E2NsUlKSlLHQHBLfaTzcPnRpH4xQhcl4N++jd0lSu1bdBlqAg0gIUgYAkellwazHGHMZzen1spEmQ7XmeNQ2p/cKAQgXpyRVKBkhyadA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQZe7Wo1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQZe7Wo1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761750254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WdVdVrXFh4tr+yuwwr+7pS48uqrz07GxlHo9XTXKnac=;
	b=XQZe7Wo1uxY4sXIyw/GhpAL3cIbe5ZJiMo+x+BTSNubxPnPJJBdoXtzv8SdBmaNzf/ivEh
	XpcICWW1Miiu0uei+yaNjvqVfPxEjBEjR7RyKLjYWx1oTrI6ANd6sNGpdB6kcL1aINj1ip
	if1nNqCb96S1bDsL7zdTwgZkpu65glM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-D1qPn-S-PNKMsfG4U5uuZg-1; Wed, 29 Oct 2025 11:04:11 -0400
X-MC-Unique: D1qPn-S-PNKMsfG4U5uuZg-1
X-Mimecast-MFC-AGG-ID: D1qPn-S-PNKMsfG4U5uuZg_1761750251
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f384f10762so4565955f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761750250; x=1762355050;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WdVdVrXFh4tr+yuwwr+7pS48uqrz07GxlHo9XTXKnac=;
        b=ZrrDYFjqNGXAJL9tkVmB1l/46LKvuMgPEM7Fg3fMoloLpOCwJIhWBOA2t/mKlzEJPC
         wWEUunZlTxpElRi36Z21VX2yrNLSAp2YCqttoqJumU6d1bCXVhpLxnF+Gxt7wTRIpN84
         P52ALYMxWQvzVGkZc9F6A1TyrGHKaEruXKqA8rmnlvXorWgPCSg7H7fij461+6XjJOfe
         nhc1++WTXlWtl2rXJo1xC+5uhZNzEeItozvC2WxSwigebIUQJ26bqqyHU/THpJg1S6+w
         +BMcphmTkYOqtb2iTeEU0hwd47T6iT9lUBonkJPr152Ml88GStFi1n1NPtlD7R6rVQl1
         ty7w==
X-Forwarded-Encrypted: i=1; AJvYcCW2IsEu1kqdK89XQpHb3FJNCO5ks4Nn62OyqXBJ8N2ZFeYW7bEAxUqRAiWqT3dAgYYNtb4PU+rPIgFzU+FGjDYfTfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztVzpySdDrWlTYldAjZwT16VHE3JBvdjNOfo6U5wYhUYfkmr21
	fa/bZsPUeRJ+EAK/XN3SQOaNpbRJZ4nkxXaQwlY+y8XZ/DsWXSAuBsV8e179wm0jACfo1VM4EjU
	ZoamqlFTEuLl1R2yqh/dcKpyiv2E2cl8cnCWECy5JGZgoBSWqM1jvPDYVL3cxGAV0maQIwuYjlQ
	==
X-Gm-Gg: ASbGncvzJKu1+wOjXKrVe+1inoU1Tj7qGj+8UNH3gAR+79jPQQA1qXsOA4vfQRQhZsi
	DQnj80PzBxWbkXPZQR/wLX6gMLMRcz/HQ2lQfjlZGfftctFXm1H89YULn7jw8vBlqIIHON7yecx
	KhAkHwsJm0KnKbW1M+9GmNqrHlWV3sqY24RzoZ7KdQXo0O5OllN2MONJUJMQCTYnkQeXzExwlUF
	4dXrQqgLX6g2oHIVrq4r8Q3lpTGNsIoc4l0UyRz/UqC24D0Zi8xRlZVAKokeMGTWqcBD0h2CkCQ
	B/hE57HLml2YLYPuloZuPflT+wevgGOMKxoTzgA8k7kHsRD6bZhpahToohOb9yp52F6/wR8d+0C
	LK5p070TqRLI6gv4ymW+BDQ==
X-Received: by 2002:a05:6000:22ca:b0:428:3f70:4b2 with SMTP id ffacd0b85a97d-429aefda8c1mr2684168f8f.63.1761750250313;
        Wed, 29 Oct 2025 08:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQD1xLBQ4VY8cCjZ9K04TQoxLh1bjMhMB/K9HMpgFhxu8cSEiLIZZCFGjX/uivaIO2mRj5FQ==
X-Received: by 2002:a05:6000:22ca:b0:428:3f70:4b2 with SMTP id ffacd0b85a97d-429aefda8c1mr2684117f8f.63.1761750249760;
        Wed, 29 Oct 2025 08:04:09 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47718427409sm46680625e9.1.2025.10.29.08.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 08:04:09 -0700 (PDT)
Message-ID: <2d8ed924-6d06-42e4-a876-381fb331f926@redhat.com>
Date: Wed, 29 Oct 2025 16:04:06 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, ziy@nvidia.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local>
 <063f8369-96c7-4345-ab28-7265ed7214cb@linux.alibaba.com>
 <9a3f2d8d-abd1-488c-8550-21cd12efff3e@lucifer.local>
 <e2a89e74-1533-4a83-8d0f-3f4821750e25@redhat.com>
 <64b9a6cd-d2e4-4142-bf41-abe80bf1f61a@lucifer.local>
 <dc002ef9-53ee-4466-b963-baadfd5162b7@redhat.com>
 <a97780ab-6256-43b7-8c0a-80ecbdc3d52d@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <a97780ab-6256-43b7-8c0a-80ecbdc3d52d@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k7dDsDS2fxVriNk_gck8hM7PYexT4dbrb2ctYyriKzA_1761750251
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> No creep, because you'll always collapse.
> 
> OK so in the 511 scenario, do we simply immediately collapse to the largest
> possible _mTHP_ page size if based on adjacent none/zero page entries in the
> PTE, and _never_ collapse to PMD on this basis even if we do have sufficient
> none/zero PTE entries to do so?

Right. And if we fail to allocate a PMD, we would collapse to smaller 
sizes, and later, once a PMD is possible, collapse to a PMD.

But there is no creep, as we would have collapsed a PMD right from the 
start either way.

> 
> And only collapse to PMD size if we have sufficient adjacent PTE entries that
> are populated?
> 
> Let's really nail this down actually so we can be super clear what the issue is
> here.
> 

I hope what I wrote above made sense.

> 
>>
>> Creep only happens if you wouldn't collapse a PMD without prior mTHP
>> collapse, but suddenly would in the same scenario simply because you had
>> prior mTHP collapse.
>>
>> At least that's my understanding.
> 
> OK, that makes sense, is the logic (this may be part of the bit I haven't
> reviewed yet tbh) then that for khugepaged mTHP we have the system where we
> always require prior mTHP collapse _first_?

So I would describe creep as

"we would not collapse a PMD THP because max_ptes_none is violated, but 
because we collapsed smaller mTHP THPs before, we essentially suddenly 
have more PTEs that are not none-or-zero, making us suddenly collapse a 
PMD THP at the same place".

Assume the following: max_ptes_none = 256

This means we would only collapse if at most half (256/512) of the PTEs 
are none-or-zero.

But imagine the (simplified) PTE layout with PMD = 8 entries to simplify:

[ P Z P Z P Z Z Z ]

3 Present vs. 5 Zero -> do not collapse a PMD (8)

But sssume we collapse smaller mTHP (2 entries) first

[ P P P P P P Z Z ]

We collapsed 3x "P Z" into "P P" because the ratio allowed for it.

Suddenly we have

6 Present vs 2 Zero and we collapse a PMD (8)

[ P P P P P P P P ]

That's the "creep" problem.

> 
>>
>>>
>>>> max_ptes_none == 0 -> collapse mTHP only if all non-none/zero
>>>>
>>>> And for the intermediate values
>>>>
>>>> (1) pr_warn() when mTHPs are enabled, stating that mTHP collapse is not
>>>> supported yet with other values
>>>
>>> It feels a bit much to issue a kernel warning every time somebody twiddles that
>>> value, and it's kind of against user expectation a bit.
>>
>> pr_warn_once() is what I meant.
> 
> Right, but even then it feels a bit extreme, warnings are pretty serious
> things. Then again there's precedent for this, and it may be the least worse
> solution.
> 
> I just picture a cloud provider turning this on with mTHP then getting their
> monitoring team reporting some urgent communication about warnings in dmesg :)

I mean, one could make the states mutually, maybe?

Disallow enabling mTHP with max_ptes_none set to unsupported values and 
the other way around.

That would probably be cleanest, although the implementation might get a 
bit more involved (but it's solvable).

But the concern could be that there are configs that could suddenly 
break: someone that set max_ptes_none and enabled mTHP.


I'll note that we could also consider only supporting "max_ptes_none = 
511" (default) to start with.

The nice thing about that value is that it us fully supported with the 
underused shrinker, because max_ptes_none=511 -> never shrink.

-- 
Cheers

David / dhildenb

