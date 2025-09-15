Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464627602E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933532; cv=none; b=URLn2vsP7lxbPIE9IHhyoC7t1guZRbd1NgZpmm0JTW0e2lxpaD8HTbI9H5zPZdGEoz0BlgITJX+Y7EfB9QG4clMJGWXgExXb5Y5TuN8+OEsqGnFELR/NXuNraTL1v+YLKpgIBWogIgZmOiOFHDNG+ezLlGirjeJIoU/rAUoZiC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933532; c=relaxed/simple;
	bh=9da40AdvZdeBpw0p+kGjXsHMpuVPRTbtzi5VS/Lehnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+NBMshvIDVqP2UZ4t2di1jKQCq1fS1wb48As1ikQ5Pt0IWKi73nfGYdjD7AvWjcXfK2csiYxRWnSaPARLoX5Ay3QOGQrVCqS349XJ0y07EHvuaK5/gBHiTQyINapTuNpjAOvgKdJ61KZhLivXRreJqu+o4y7qCV7RWAjECFpHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlUpPkTI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlUpPkTI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757933530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TONx73D+/O/+grOG688JC7bheYa2eKKJEwalopCuMqM=;
	b=FlUpPkTIoWF7lyhqntglPHi3A8p8mgXmgz0Urml3tXQVx3co0FPcDThucj28qqqypN+ACt
	ojd0Ty3uXufcZB3y1v1TE96dQPNXFnL/gOGmGOetAlVxA7uHqimkcWJivliTejuXTWmrP1
	/5qjjG0H+vnXQIgQkpxRT6eNMZc8zm0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-gSbaEP0eO1ifJGeqButPdQ-1; Mon, 15 Sep 2025 06:52:08 -0400
X-MC-Unique: gSbaEP0eO1ifJGeqButPdQ-1
X-Mimecast-MFC-AGG-ID: gSbaEP0eO1ifJGeqButPdQ_1757933528
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3df3e935ec8so2241331f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933528; x=1758538328;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TONx73D+/O/+grOG688JC7bheYa2eKKJEwalopCuMqM=;
        b=Wuo95H5dDN0Az1L8WmWwFTnAGfBPtJZbS9RFeipnE/qpnnXB3rbsPv741GtnlsD75Q
         Ah41E3sJWJYB5bTz1y6io6ViOAxWfAmMuKunLROaeDOdH9IIw8z0qdiDOE6ddZG/SzAl
         QozrUUu5WHU/d1vwtcM7Vhuz9Td32jOHJcn5M3wqgjRIm3Qe4tTZYCneFJkwdIvX5YIM
         crthg4uz9k1AaTfcdWAFyqwy+2iJW44c4dmF6vJkpX1f+6HhCzjv+J+aCCS7CZD/JB+F
         I+D/flr1qe0jTMyUnxHGvI/8Kv03Kg8LSXslxjUrtRkzYWailalzGos6diuuLK/UuR6i
         fdZg==
X-Forwarded-Encrypted: i=1; AJvYcCU+GecySpacBXSsSyS1YOXYYozD9B6UxpANmYArrzgVpXgmBL0bjl1XLLtXaA2HLJ/4U67fCnLIAcoLu0o5QmNPbU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO1ORIR27juVLoW4LJC1BraxkjzF9o4lB6CtQkMrHtm16W3dI1
	8L5sr53lkSG0LXJtLz4kLRjOZq8G0rOMG6p0mWXHSt43OIlpIdXOO9cIAcYhzlq6JFmDAiBKlcI
	wQ5kFXCbuwmArx9RXADs2L2efKGyveQEfktDlswawQQbiMj5VECtvHGmVuwYLMJXhGyrR1kY9yw
	==
X-Gm-Gg: ASbGncveP5r6fb8VS6/18eZcaKwZgMR5y4BL1v0n/AG0WRPi2cz5LbN75DOORvtAuON
	THIWkgWvLxmy42F+7HmUJ/nOkLt2K5JUCvOIQBINrrswM7a6xfcWW1JPBQ20FKvH7yiZ1pZmjkz
	CLyg+AAPSEZ9RENFRwPMgRkutJ9MCiMG/tKaTczy1dlBDv0TOcjvHM9G4UfGgFIlLNzsmrhNywZ
	av4Lu1DT6Fn4+8Wf39v3y0TVL6NjxHjfJ902Igpq82yw47urZmzGI8jhOc6Or8+D54//g0SLJgu
	iM9Ifn6fndRTbqVFLaodxcvkoergstHgK6IhWg8NOo+7Mv/aJqpHAKrYQQdoFNzh3RcvlQRAQ5H
	KEj3TkUaNLTxX4Ut2/OQvYwk/N8g01ZKfwH5TtXg5D+GqNt05how/a66NecofNw+DaOE=
X-Received: by 2002:a05:6000:250f:b0:3e7:4719:a024 with SMTP id ffacd0b85a97d-3e7657c4d2amr8864758f8f.18.1757933527541;
        Mon, 15 Sep 2025 03:52:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKEYyRZhPxbJ806hEEJtd+E4ByVirEH/UnddaSRMoVIfYw9s7hf4KJQcASmhrnW92egs5mLA==
X-Received: by 2002:a05:6000:250f:b0:3e7:4719:a024 with SMTP id ffacd0b85a97d-3e7657c4d2amr8864705f8f.18.1757933526990;
        Mon, 15 Sep 2025 03:52:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm11735126f8f.42.2025.09.15.03.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 03:52:06 -0700 (PDT)
Message-ID: <ae9d88e2-bab9-49fc-a459-d7b9a8fe9351@redhat.com>
Date: Mon, 15 Sep 2025 12:52:03 +0200
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <155c821d-402c-4627-a723-6f8c88a2f65c@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pLBgOmZWy2_Iipkk1RvqF0hXeteH5UYj1yu9GhMiawQ_1757933528
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 12:43, Lorenzo Stoakes wrote:
> On Mon, Sep 15, 2025 at 12:22:07PM +0200, David Hildenbrand wrote:
>>
>> 0 -> ~100% used (~0% none)
>> 1 -> ~50% used (~50% none)
>> 2 -> ~25% used (~75% none)
>> 3 -> ~12.5% used (~87.5% none)
>> 4 -> ~11.25% used (~88,75% none)
>> ...
>> 10 -> ~0% used (~100% none)
> 
> Oh and shouldn't this be inverted?
> 
> 0 eagerness = we eat up all none PTE entries? Isn't that pretty eager? :P
> 10 eagerness = we aren't eager to eat up none PTE entries at all?
> 
> Or am I being dumb here?

Good question.

For swappiness it's: 0 -> no swap (conservative)

So intuitively I assumed: 0 -> no pte_none (conservative)

You're the native speaker, so you tell me :)

-- 
Cheers

David / dhildenb

