Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418F2FB966
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931968; cv=none; b=n0njRc7hK/5rQwmShHP6Fe2HS2Ent9E+aRPrWhD73MTZqxdn6puKrLggiCqnCdVKUHeQmFmdt2h4SI15wZcCP2d0ytP1HFuXJzcczTzO6ZBbqg/3dBfN/DtWVZ/Cth2W+6rYeyFQDVIcpoXcYh6/ndV3hkiS9PL/0pr8qHqM20c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931968; c=relaxed/simple;
	bh=lmCW6xrBlBUfJpyn9H3/BOvBbm3Qt4KOM0QKT0STcHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/NPIVbm/1eunKnBhjcffgdvUOqxd0reHzJjfqv2TBr2kHt2pgyjLy5hfxhZ9Hp9Nz7Me+3zlC35tuhUwsTRd5+jLO5o9Cr+r+AOgAYKqv+PMt2JRPyNn7LyuYByNLUNU90zlxX1EzjK3iEqJdiwM53j8TF/LB/LGEderbsKCD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIydoTYr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIydoTYr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757931966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LuOSdM7sr2GcJV/vZB5X+Ju1uYPsXPA3FO1S8oXCojA=;
	b=TIydoTYrkrcgRLNqPHCX2E7JGCmZxMeC4+kLGlHseAvEttr56Fk9AWYpCjcqkZ2fdvN5Sw
	pGZoa1HXhf0Rh6RBVMj4xRygXPYhgwQzLpAVzoZKYfKaBOb7eo67SF+iShk5FF3UQDmMxa
	kpIbr6Kc5qmySKfWrgU8mDKwPCfPo4M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-UXkzwGM-Phe9wmSwOorWQQ-1; Mon, 15 Sep 2025 06:26:02 -0400
X-MC-Unique: UXkzwGM-Phe9wmSwOorWQQ-1
X-Mimecast-MFC-AGG-ID: UXkzwGM-Phe9wmSwOorWQQ_1757931962
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3df3e935ec8so2221272f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757931962; x=1758536762;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LuOSdM7sr2GcJV/vZB5X+Ju1uYPsXPA3FO1S8oXCojA=;
        b=IqlpajXe8QS7GEF2mWWtXuLOTo4XwtWTNVVD44J3Y7uCd9YT8bAaB1po1P8QRe5I63
         p08lbUf7dKKAQfOdpl1HTVQeF3KEPSydM/VcvwDAjaKPJ1dxuvKxs41A8qpezwUTa+jT
         zFeMCv6ozWoGjsIY4Lm8dZcLfA+4b22EHxQ/osZqMU22KnysUc6N9AGo7Yx1eadXyFNR
         A5m+xHzrMnYuReI6h9TGJ0mUA43h8mx4iuW9FM/y2Jva5Rh3W0R3QbUU38fmvjVfzSJh
         6sq4Lkwd7SD3ESW390hxk+M1IwDGAZg4NxRTX9BwpdbHrQHlAIrmjnAL/ar/nbXNOH/g
         IVdw==
X-Forwarded-Encrypted: i=1; AJvYcCWEpKNs3OyAs57yDZcOcYTzHR3VZJ3DeXbD/GEYSsACyTptZrk5CmfjuzCxBUXNM2OQZtTDevys2UVLv3TZIK49hCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzW2RzvLQ/hMuJMw5tx1ewVWOW4MzGwBYcm2x+IYervPc4iE/s
	TNmY0VQ2bElOO3tBjek+1ban3QcG8qXKbVOQpfQ/P1x5VkBgv0qiWA4SBmlBThjSpsiis5ZdoO9
	h9bzthzWgj2FipzNFD+YDEV3RwddMpdF+trTas3S4p09hxceNaJ5ntRnAuDC6NJ/oIxustlPYnA
	==
X-Gm-Gg: ASbGncttLpe96EjUX5BuvOZ/e0SPL6jONNla8kyW1Oi+myjaLQY+Oa/O03fJ2PxHvgj
	Bahg4NpU+ZN7o9xixtulAO/4Ke3uau88iYrfe3Zcfwt7WlP/pe2Fc6pnAP37sveo5NDe+AuBlB9
	nU6sv2zKFId8xE1D1olNyfo/xntEX+MzFBY1GmKf2e6hvhBWXt/lv4pz1q4WdO9PxW3P6l9wlSU
	rDuAQdDT3prsJj6hln9V87L/QLssYtBQX0xLTppXzYg2ey7CIhPZrnjmf5E4BBNZiuFvrc3VxWf
	xGWsFBZwriZj2h7R1GHv56lfpXUWA8Q9IIQCdrwGLZJiAufLnu69RXzYIyyYlSSGll5RCmTN4uy
	pIeUd/9O21KvlGqge0DE00zn5un0jrjUzRPc83ORglIsjY6OVx99ZhtH9O5XcwNfI6MY=
X-Received: by 2002:a05:6000:26c5:b0:3e7:6197:9947 with SMTP id ffacd0b85a97d-3e765a2675fmr9795866f8f.53.1757931961404;
        Mon, 15 Sep 2025 03:26:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEITkGGGz76cys5swmSEelvVvlXnf7rFrqKHK6hXOsBMYdCsiJrRwiLPBM7GrXfuGS8fKwr2Q==
X-Received: by 2002:a05:6000:26c5:b0:3e7:6197:9947 with SMTP id ffacd0b85a97d-3e765a2675fmr9795840f8f.53.1757931960953;
        Mon, 15 Sep 2025 03:26:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c4490sm172678095e9.19.2025.09.15.03.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 03:25:59 -0700 (PDT)
Message-ID: <78d75263-e0ab-4dcd-ae97-5c5c9bb10193@redhat.com>
Date: Mon, 15 Sep 2025 12:25:54 +0200
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
 <43f42d9d-f814-4b54-91a6-3073f7c7cedf@redhat.com>
 <ab8c2e03-53fb-402c-a674-c2c6ab11f54e@redhat.com>
 <rapl4xr55zv2nq3jh5ulk4wvfyxa2kmbnnb4uram6q43y4cbwn@dv5m52ocyqne>
 <80c50bf4-27b1-483c-9977-2519369c2630@redhat.com>
 <7ri4u7uxsv6elyohqiq2w5oxv4yhk2tyniwglfxtiueiyofb3n@l4exlmlf5ty4>
 <59641180-a0d9-400c-aaeb-0c9e93954bf5@redhat.com>
 <c5bcecb8-13e7-4db5-849e-2120c69b2af5@lucifer.local>
 <ed784d6c-6c2a-4e0b-ad2f-e953bf310ce8@redhat.com>
 <dcfc7e27-d3c8-4fd0-8b7b-ce8f5051d597@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <dcfc7e27-d3c8-4fd0-8b7b-ce8f5051d597@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oaFAkNjMan1SC2HOZw6t2SUa2kUkgb-YCD_SP_1LDDQ_1757931962
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> I would just say "The kernel might decide to use a more conservative approach
>> when collapsing smaller THPs" etc.
>>
>>
>> Thoughts?
> 
> Well I've sort of reviewed oppositely there :) well at least that it needs to be
> a hell of a lot clearer (I find that comment really compressed and I just don't
> really understand it).

Right. I think these are just details we should hide from the user. And 
in particular, not over-document it so we can more easily change 
semantics later.

> 
> I guess I didn't think about people reading that and relying on it, so maybe we
> could alternatively make that succinct.
> 
> But I think it'd be better to say something like "mTHP collapse cannot currently
> correctly function with half or more of the PTE entries empty, so we cap at just
> below this level" in this case.

IMHO we should just say that the value might be reduced for internal 
purposes and that this behavior might change in the future would likely 
be good enough.

-- 
Cheers

David / dhildenb

