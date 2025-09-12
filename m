Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF1247281
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692305; cv=none; b=EsFhHLkmM9RHEMapkRBCPGOs3TXrhPauqdPvnlPRFnY5GbbeyAoNhRhT9RmHx7460B1W0vnuvLfg1jXMXrcYAb/GMDdSGIP84mPejg5Rvpev6LAiqm3J9M/oXUn64X3MLcoaOMJjBWoObY9cdcw+AusSrUmm2eNUkEJH5tec2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692305; c=relaxed/simple;
	bh=8rdXAHjf1qNhSLyvo4ghb/MFVMN9CJC6T58LiqUjX7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loxnkjEXhx0zahkLZ/bcgqsrRjJu+9EXLlnOUun5HjYhIVPHR9J9rBYZViJx4VxhyrdbZUeCUS0jFuk6wHXbosft40ZTJn8DBgxoTPTEwF3idlDrxksx/QiJtYkUdlHFNyvHnsxedpqhXQviHFyH6z897+X1eCXt/qvq/PDee/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcMw5SUv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcMw5SUv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757692302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=evSM+hUM6XOAVnv4pWD+Pp87EHuxINXdM8cowVunr7o=;
	b=UcMw5SUvI9wT0spNvE4O6YS4ihll63pjbUUdShE9Jrq3HQp13uH1vkpHWQ0IyudWEglS4n
	y5gSaK+I82LAVOtgSsB8ZP/clAZvuxkFrlJoNMyGGhvgsG2ngQzLExHBcAFm6tRBKvEGQe
	uVR5BQ9v1zDNoo+MYxgwOXIGZw7NBWk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-LXFSd3yHNYaEl7xXUd-QiQ-1; Fri, 12 Sep 2025 11:51:41 -0400
X-MC-Unique: LXFSd3yHNYaEl7xXUd-QiQ-1
X-Mimecast-MFC-AGG-ID: LXFSd3yHNYaEl7xXUd-QiQ_1757692300
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45df609b181so16097765e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692300; x=1758297100;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evSM+hUM6XOAVnv4pWD+Pp87EHuxINXdM8cowVunr7o=;
        b=jV+7owncZ42+ZQts+Yaq2MynqZXZy8/vMt5dE5XPOAtlbOFosFrhnrQaqZ7fY7yxK/
         5hrlgMV7skIZxpW1r30FnMz4REvYswDD7TBloPOX46OblBpF4cBqbBr2diFdFrlJZFTd
         UkJMNumfrvRTAuC1Z0kjbUTV4LVhfiufgWnnXoEnTkNfQUt38UMRBCglidf2w9at/m1g
         lwP7tsJ4LF63sWnohY1wDU5uyNs4aYPonxAbAuoF+AcF1ZWOycvhDuVrknVBMoxINDvJ
         DfU/MCUvAkB3yLZQlb4c3BX67J8GBdB1YskJ3XDpFaQj5lCqIhiTkgXjux9478Kn61au
         D29Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+cGyW3TLCkuLMU5fDCvHl3qAOnBihCSOkkKTTvf9pfrfHb0dPBPaseERalMIP+Jqqq0Fg/I7yOYpYroohBEO6bDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc98G3cXvX9hriHSVahBRt4oDvwDW3sElz7pZgTrVfMt06XfYL
	QSBhMo3gAZSexKsGKVmpvzY/anKRvwPOH7Dp7Lxq42+4yx3BaprmclZR/TKjKlb+/hnKt6v0qyd
	WmDcuP6qFNBBSMhVGVU+V5JI4Y/Jai3L5AqP2xZ63NgtlGDiI+cxVhDrxmEfOT7f7/2NQVcnygg
	==
X-Gm-Gg: ASbGncsz69IgQV8nlCMl/YYMyRxqQ2iFwIYTAv6hyTJ4Qw00HuKC4vyQ7ugteVPV4wT
	njIHBi9lzOd+ULAmKFFCE4iv4PM8BS4G/q24nMSyt5uSGYCcAD2eFWRWHnKqRTJu+DzG+K8tKXb
	JU6h1/hEth0c7lEbwN2nN1aQnBStjaTNgulQNNorvD+jnXBM2/pVLG/tBV3DY/tMLzSzsuGfocB
	BicQL0EovRPP61YipkEIwlWykYw4i1mZuEqltQYME8c5sTKdAp40iEay8xn0V7PNON4R3jECh6g
	ut9rgg3Qch2Xk5Ri3Q6b7TsEvj1a+FGyhbEfdDLyVrjvyF+waGqXAZhEQkPSvZBpEsfUk2nIcqZ
	XF+sTTs9q2h1bKmBwKJNNkg/EajTuSnMxsopoK8jTBZtbUl1bTF6Z/PB49lwNbCDda78=
X-Received: by 2002:a05:600c:2251:b0:45d:f7e4:88b4 with SMTP id 5b1f17b1804b1-45f211fee13mr31607655e9.30.1757692299865;
        Fri, 12 Sep 2025 08:51:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTJ5GavPsbuXit70YFZCDKrkElDxaBYazDmnr1RZ35Woeh3Th8WiB7RfPyeeDQGWEoFz+o1w==
X-Received: by 2002:a05:600c:2251:b0:45d:f7e4:88b4 with SMTP id 5b1f17b1804b1-45f211fee13mr31606965e9.30.1757692299300;
        Fri, 12 Sep 2025 08:51:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm647828f8f.27.2025.09.12.08.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 08:51:38 -0700 (PDT)
Message-ID: <6c8a85b6-232e-4341-8df1-501b9d73e14e@redhat.com>
Date: Fri, 12 Sep 2025 17:51:35 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
To: Kiryl Shutsemau <kas@kernel.org>, Pedro Falcato <pfalcato@suse.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nico Pache <npache@redhat.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org,
 hughd@google.com, richard.weiyang@gmail.com, lance.yang@linux.dev,
 vbabka@suse.cz, rppt@kernel.org, jannh@google.com
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <20250912133701.GA802874@cmpxchg.org>
 <da251159-b39f-467b-a4e3-676aa761c0e8@redhat.com>
 <hcpxpo3xpqcppxlxhmyxkqkqnu4syohhkt5oeyh7qse7kvuwiw@qbhiubf2ubtm>
 <k54teuep6r63gbgivpka32tk47zvzmy5thik2mekl5xpycvead@fth2lv4kuicg>
 <y6ljs2byyzxkxqqxaf37kx5lqpshv47ndejksen2ihrvhcwksc@4r6f4sdtjd3g>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <y6ljs2byyzxkxqqxaf37kx5lqpshv47ndejksen2ihrvhcwksc@4r6f4sdtjd3g>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -YtNa_1kHIw7mSslRRVT1E6qRJ0a8CYpdo4eAyJY4ok_1757692300
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 17:44, Kiryl Shutsemau wrote:
> On Fri, Sep 12, 2025 at 04:39:02PM +0100, Kiryl Shutsemau wrote:
>>> Shower thought: it might be in these cases especially where the FreeBSD
>>> reservation system comes in handy - best effort allocating a THP, but not
>>> actually mapping it as such until you really _know_ it is hot - and until
>>> then, memory reclaim can just break your THP down if it really needs to.
>>
>> This is just silly. All downsides without benefit until maybe later. And
>> for short-lived processes the "later" never comes.
> 
> The right way out is to get better info on access pattern from hardware.
> For instance, if we move access bit out of page table entry and make it
> independent of the actually mapping size that would give us much better
> view on what actually is going on.

We discussed this a couple of times in the past, the problem is that it 
does not help anybody really if all but a handful piece of hardware 
provides such a features.

Long long long term I agree, short term we cannot really build core 
infrastructure around any of that.

-- 
Cheers

David / dhildenb

