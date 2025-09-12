Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298BF314A9D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691845; cv=none; b=QCtD68sdqg86r+A91/fzctBx6O9nDOyvlWn7EQKeT0UohnvcY3izaNjmxIOX7V2qtTLrgRU0TH5M6PPglXxrSxROTQUTvaampVEIsrbJsKxt7o3VdLWhXc0BS81OIqfSzSk0I6DHCJWWYoUm/t/DKLsTLlRFM/1PRU0PqF9iRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691845; c=relaxed/simple;
	bh=dA76umRtYdyD2FG2MILJYXTmfaMo72Kmp3AqM8eKLpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsfN8wXvh+7+cq950g/xiSWMpKkhQCAuXqj2IYqUCGv0QWicUF43SLWRnbvRx02xLjyDqrtALPzLWS5nrCYVW9Nub1B1Mek4lr/2ZobvkJHd0I1umPlD02if6IXP6shKzKKLuTma5Gi1XtViBgmw+dZWnL9FHOS+afAIUEMJuTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uog7mF18; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uog7mF18"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757691843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4DxtwTQCPiZwtY4nVnJikc9BconF4cFntYOMVXEuMbk=;
	b=Uog7mF18qmUIcSopGtkwoj10L09cFZm17N+M+862LCcyAC4sHyk2e6NO8LzbH6cvtxm8D7
	zFdvhevq6e5i8xd0FW+X1Tmk4XnFUC5Thk9R41FB2I3QJitL1kGcbMGjonD1fxUYIYVvqb
	zwfw2lVHW/WdVjGYoYss2U/IpDj4z0E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-GYV9jXbkM-yAhGI2Dxc5Dg-1; Fri, 12 Sep 2025 11:44:01 -0400
X-MC-Unique: GYV9jXbkM-yAhGI2Dxc5Dg-1
X-Mimecast-MFC-AGG-ID: GYV9jXbkM-yAhGI2Dxc5Dg_1757691841
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3df19a545c2so1497563f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757691841; x=1758296641;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DxtwTQCPiZwtY4nVnJikc9BconF4cFntYOMVXEuMbk=;
        b=U7RkOn02sMH0i4Ej6D3/hTZpREmTM3Kect/zZMGrNSHWP2UOa0A/xRwKxbkaifA1fX
         D+wHJ/CXw2iwGmxIOK11qEZ2OtCq2kGeh1F1cVGiExpNRoe6N/k9iTVtx8cR2ZZ2AEMy
         rSfM5tVZaj9HV3TV1cfaktS+Yq1EDqXRcPjsHDMhwstYuxBbuI7Z2oQILtte8bB9hIrC
         uOAPNGQUnhNyryIyFeUd7FtI6Dzrg+1ZleOHL2IBZVaZGkVKYecW0C78NJuVSiHPxWs0
         xjyh5smSsGGbGH5HJwwkHfqdsRlnyLdCtyRKakLRAGOfpIO8pvhADYWu9z016gCMjawI
         GECQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI51MhIbjDlPkLgGY9ZCvOuRxIloknjz1JQ1kcOioP5h2ryNvslfBI5bC28Yi6JyI5T266Pju7fJeiTbLguCVg5lM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr2XavTcJR2jhzUhSpI8f2PMcxWaprcFrtWO4OserA7Vszpe5B
	sJaIUPam2t2xEQtyXZTwBYs+m+lTLeKM6j89y/Mq110zHubSa6T3umf4rfWLcpwvFF2xwa+3qEu
	zCVILLnT8Ngoe+NiSYshUU5usFUqcbloBLlMN0Ax3MnLjfUa/6V4y0orypAEQDXcg2wQCqIjUog
	==
X-Gm-Gg: ASbGncsrpCXD3B7/GJC/iW4hZ/oIO12ewfLSieYMBOghlu5O7ujmO5yd9GGH+lQ2WJ+
	9gK4/hnUQRFiSUKkM4UqM6SERzmAkCGWng7zAxfn2gj4+H+xtBAFmynxJm0o9QgbA5/Qz1Gx1Xj
	YWanHk7fVM1gHPrBXks39SO8k/QPKfR1K4b/ozllOoiqGXXL+XZyANADWei2OkRD6WWaukBrPVS
	p+fqThOMzGwa6uCCFb9AStTwkis403ZCABgvLGqzXCrJjQT+ZaDJtFyTV3XPRX/FiTaAobjPWCd
	VwtJzLlf8aMsdid8l5A3t9qP9VXnlEHEefY93Hna4yzsxaephM9g7lWaZdwOcDj4wNJBrgLVTL0
	PLTiO20eTsT8YlN5TbZ7Id38mMBSIb3cUHDpEYhgr4PKJUFI4cvbg2UH0KBU+PA8rKC0=
X-Received: by 2002:a5d:5d09:0:b0:3e7:17d4:389b with SMTP id ffacd0b85a97d-3e765a1b499mr3701041f8f.52.1757691840704;
        Fri, 12 Sep 2025 08:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHknotLSLP2K1zWqBYgZh5DKvVl0wcu4M9IAeXq4lHdbs1Rpq78uPryI29GX5fXqxYpJvssiQ==
X-Received: by 2002:a5d:5d09:0:b0:3e7:17d4:389b with SMTP id ffacd0b85a97d-3e765a1b499mr3701014f8f.52.1757691840256;
        Fri, 12 Sep 2025 08:44:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd691sm7166274f8f.32.2025.09.12.08.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 08:43:59 -0700 (PDT)
Message-ID: <aa15dcd0-15d3-45ad-b24f-737539bff861@redhat.com>
Date: Fri, 12 Sep 2025 17:43:56 +0200
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <k54teuep6r63gbgivpka32tk47zvzmy5thik2mekl5xpycvead@fth2lv4kuicg>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N_ocNEsLRh5CI7mEooWjRfnL1XCHf_A-RO8cJ1Aopis_1757691841
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Maybe in the Great Glorious Future (how many of those do we have?!) it would
>> be a good idea to take this kinds of things into account. Just because we can
>> map a THP, doesn't mean we should.
>>
>> Shower thought: it might be in these cases especially where the FreeBSD
>> reservation system comes in handy - best effort allocating a THP, but not
>> actually mapping it as such until you really _know_ it is hot - and until
>> then, memory reclaim can just break your THP down if it really needs to.
> 
> This is just silly. All downsides without benefit until maybe later. And
> for short-lived processes the "later" never comes.

Right, that's why I've also been arguing against that (we discussed it 
recently in the THP cabal).

-- 
Cheers

David / dhildenb

