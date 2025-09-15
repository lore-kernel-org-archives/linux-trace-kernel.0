Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FFC2FD1B3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932761; cv=none; b=giN3kAxC76lsLvkUVbbdfSRK9Qu2xo6yicWbVmdAtcWzexG7FoxY9FNAmrB4muOcu+tRg3U+MdGuY2T9wsDvyH9mpk32oVlLRh/LuCBcK1p0HMuDagOk9eCEzCLnJXUz6T+UXregYxF10aLiZ3t+5EXtKzUBDCjQtFrYScXhbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932761; c=relaxed/simple;
	bh=kYJTX9z2l84KNkpQlgdagSpKO+UWKr2Sp1d0r1o2F00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYLra8SQF6ojUX3R+yAKsaZ9KDFsmlv2sHrEZbW/J/qMMK7nuFWF8rqWOy5lTzJPVf7DJGrrgvrpTz6XudIG702HYhq9ox6hRXDfjZV7l8V1Dhy5FEdxIcQmNR/Ek9t1xIChN3sxplkFVhdx8x+3+9NniokNxR6R6VXTV901xL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUGjTceR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUGjTceR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757932758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YcQKsjEThwnEnHXQ3t079o7XGdfAO6dZHvspowVwj68=;
	b=JUGjTceR76RzRroOEY49FjGzQoLA0pOK1Jn2g2MzJ03uNLvifPPizg4pdNhwsDqujSbFyT
	sfvLxlnDFOeJZyGlWVNTimZZ+bbsf+zcQpngn+79tJN80cLJgJ/MJUQyWI7y726zI7XCp+
	kSftWtEoKE21m+YpyIyRGRQDjtJconA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-u87tqcySNCuWOcM_v7Uw8A-1; Mon, 15 Sep 2025 06:39:17 -0400
X-MC-Unique: u87tqcySNCuWOcM_v7Uw8A-1
X-Mimecast-MFC-AGG-ID: u87tqcySNCuWOcM_v7Uw8A_1757932756
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e403b84456so2581816f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757932756; x=1758537556;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcQKsjEThwnEnHXQ3t079o7XGdfAO6dZHvspowVwj68=;
        b=v3D96pBa98+Ar/7ZgjgDjHVHd8c5HlcMCjZ7EVcHl8PKDs4nNNZNMfNLjznp58adqx
         iEhMDCwgZJgxaIf9w2K6Ogkm2cD3jUIxFlXLLYqOm+WlGi1Iep5cloDRg/9orDG7NsYK
         gDRW1Sv/JgsrGmetOHOHOqjo87I71E6yXT4WAaSQbJDOuzyTvcaL9om0DCp/g1srZEd6
         Nxl/N1dg/49VdCYyI1/YigjWxUmiYO+jI9ADzf30MUiPouR+Jz2949XdT7NC0utyGgXO
         HTfFulfgmWXvMI48JSPpRk95Jagbyy6Gt6zZfnAGJA0T+Uw3uOY2SxqwGJiKbYGPCwaS
         Mbtg==
X-Forwarded-Encrypted: i=1; AJvYcCWVATy4aW+TuFWGsUYd5rCpxSg814zJbrhMhMglNC5LE9Y0L4XtkMlLoYoZ87o44BPUtbrdJXcNMDSc7NnhKodc/1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6uWYvgVm/c1ixQx6ggJncDVCw+FJritNz1PLInN7SWl9cCKiD
	2jbSFkpzoOekesv9rro0QIFPgFx8N8ECbWy0uAyL/P+6sIKgvnXIwyUOBuljppoYrVsC0oBx8Yj
	IrQXyrJPqLNdXev/hG3VxbJtEy/LntWo+ZPO5VeFkGpiH1LZUr7KmygwjJbWQErB4mAaBNqM4xg
	==
X-Gm-Gg: ASbGnctQiTD5z3zrCAxS7hfVmtjcmrfl0Nf9F1befVOcUXCaTWYMjeQCtQmzaZMoiKz
	srh5jYfik8smllprtAdupuy44hfXh+Gly3LvCqE8DkJ5xWaeVY+dLnajWWSZ+upjbsk7+2pn6kV
	34EH1FRcLYyyaK/tFr9hSSnh21tzzCE08z3ebPdNnSp9uQllp/W1+zwh6nVZr4z6dMD3ckB25Fn
	k995b2Jg/uyl0sG09FqSLp3CJaltsX8yEgDitI5TOEJRi12KYW+hYpbK2zd4pq7hzwPqCWxoaaL
	RUTgYHcNUhPP8s4yMiGZDEdYsUn8yeKJki1grjX5/QkKpdMxbVK8pCZsA14bvOAExJtkoH/V4+S
	OiaLNCgGOR+nC7g51o8bICvOsDzLAo5uK7MRXh7mN92kdUNjafl53RYKhjHc5ZPmwEFw=
X-Received: by 2002:a05:6000:2389:b0:3e6:f91e:fa72 with SMTP id ffacd0b85a97d-3e765790815mr8205049f8f.7.1757932756266;
        Mon, 15 Sep 2025 03:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYn9DxFab5es8wXOk35PrHI/xxBg5+scPyxJTOcfRQ0LiTKonMv8mifNWgJxSRISyurXBqFQ==
X-Received: by 2002:a05:6000:2389:b0:3e6:f91e:fa72 with SMTP id ffacd0b85a97d-3e765790815mr8204983f8f.7.1757932755688;
        Mon, 15 Sep 2025 03:39:15 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea4b52b7fcsm4933190f8f.33.2025.09.15.03.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 03:39:15 -0700 (PDT)
Message-ID: <444e5e05-2dc6-4201-b872-7eb8238c612c@redhat.com>
Date: Mon, 15 Sep 2025 12:39:11 +0200
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
 <2c5328ee-fb6e-45cf-a151-868cc8e7ff97@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <2c5328ee-fb6e-45cf-a151-868cc8e7ff97@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3np8Uw4ehfmnpYiXf9kn3OBR7JUWxpwI6HqjdrWxuAI_1757932756
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.09.25 12:35, Lorenzo Stoakes wrote:
> On Mon, Sep 15, 2025 at 12:22:07PM +0200, David Hildenbrand wrote:
>> On 15.09.25 11:22, Kiryl Shutsemau wrote:
>>> On Fri, Sep 12, 2025 at 05:31:51PM -0600, Nico Pache wrote:
>>>> On Fri, Sep 12, 2025 at 6:25 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 12.09.25 14:19, Kiryl Shutsemau wrote:
>>>>>> On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
>>>>>>> The following series provides khugepaged with the capability to collapse
>>>>>>> anonymous memory regions to mTHPs.
>>>>>>>
>>>>>>> To achieve this we generalize the khugepaged functions to no longer depend
>>>>>>> on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
>>>>>>> pages that are occupied (!none/zero). After the PMD scan is done, we do
>>>>>>> binary recursion on the bitmap to find the optimal mTHP sizes for the PMD
>>>>>>> range. The restriction on max_ptes_none is removed during the scan, to make
>>>>>>> sure we account for the whole PMD range. When no mTHP size is enabled, the
>>>>>>> legacy behavior of khugepaged is maintained. max_ptes_none will be scaled
>>>>>>> by the attempted collapse order to determine how full a mTHP must be to be
>>>>>>> eligible for the collapse to occur. If a mTHP collapse is attempted, but
>>>>>>> contains swapped out, or shared pages, we don't perform the collapse. It is
>>>>>>> now also possible to collapse to mTHPs without requiring the PMD THP size
>>>>>>> to be enabled.
>>>>>>>
>>>>>>> When enabling (m)THP sizes, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on
>>>>>>> 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 for
>>>>>>> mTHP collapses to prevent collapse "creep" behavior. This prevents
>>>>>>> constantly promoting mTHPs to the next available size, which would occur
>>>>>>> because a collapse introduces more non-zero pages that would satisfy the
>>>>>>> promotion condition on subsequent scans.
>>>>>>
>>>>>> Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
>>>>>> all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.
>>>>>>
>>>>>
>>>>> I am all for not adding any more ugliness on top of all the ugliness we
>>>>> added in the past.
>>>>>
>>>>> I will soon propose deprecating that parameter in favor of something
>>>>> that makes a bit more sense.
>>>>>
>>>>> In essence, we'll likely have an "eagerness" parameter that ranges from
>>>>> 0 to 10. 10 is essentially "always collapse" and 0 "never collapse if
>>>>> not all is populated".
>>>> Hi David,
>>>>
>>>> Do you have any reason for 0-10, I'm guessing these will map to
>>>> different max_ptes_none values.
>>>> I suggest 0-5, mapping to 0,32,64,128,255,511
>>>
>>> That's too x86-64 specific.
>>>
>>> And the whole idea is not to map to directly, but give kernel wiggle
>>> room to play.
>>
>> Initially we will start out simple and map it directly. But yeah, the idea
>> is to give us some more room later.
> 
> I think it's less 'wiggle room' and more us being able to _abstract_ what this
> measurement means while reserving the right to adjust this.
> 
> But maybe we are saying the same thing in different ways.
> 
>>
>> I had something logarithmic in mind which would roughly be (ignoring the the
>> weird -1 for simplicity and expressing it as "used" instead of none-or-zero)
>>
>> 0 -> ~100% used (~0% none)
> 
> So equivalent to 511 today?
> 
>> 1 -> ~50% used (~50% none)
>> 2 -> ~25% used (~75% none)
>> 3 -> ~12.5% used (~87.5% none)
>> 4 -> ~11.25% used (~88,75% none)
>> ...
>> 10 -> ~0% used (~100% none)
> 
> So equivalent to 0 today?

Yes.

> 
> And with a logarithmic weighting towards values closer to "0% used"?
> 
> This seems sensible given the only reports we've had of non-0/511 uses here are
> in that range...
> 
> But ofc this interpretation should be something we determine + treated as an
> implementation detail that we can modify later.
> 
>>
>> Mapping that to actual THP sizes (#pages in a thp) on an arch will be easy.
> 
> And at different mTHP levels too right?

Yes exactly.

-- 
Cheers

David / dhildenb

