Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7983E1F16B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684886; cv=none; b=hpbQ+hb05OXlgefIJyn6ylAOIehlAJN2WlS9fVemwDQghX0SicpH3obJLJ22IReobVcC3bTRdGVgGMsL1NWSHhDFBJ3hq4dOWYthhVNLGOMCwkMEI7cEVrWZuxCgj6VL1SoZKkVcy8KOaWrzdWxkYHMu6cBc6WcrOziHCLUCd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684886; c=relaxed/simple;
	bh=/ln5JGNWmfcCe8/H0oSeSbnsYQEmNVX3vWvsR1wlNjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZY0/GGYAG+7onU4lN8wUC6NEXChwVMFJ/7ygkYvsIY/M+RHngQQAmWv9rKhF6wV0TYW6mR6iqMxxvHpkCGRLrwrptlQx5WfS2F7yE1ApiklJeDhyoZgfY9BiOpLMw3e9pWZvGYM/42n6i+qeA7dJtva5arWrvEPxByFjhOB87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grzuAL/T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grzuAL/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757684884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w3448OdTgFs0YiOnfQSy1wV2L7Q5FFoX8LkMxHWDXQ0=;
	b=grzuAL/T9NeXhOU/e3E8Hk6xupxbklC21TUsry2qclH7fvSEbBLNvFvzQRzAvGbdAC8HjA
	Ttgc2Y0nEmM9OPfy4c7Cmo7048TSPworwfNQwNWc8M6mmGMnsl5jPH3WXJcYMi3eH3+Jag
	Qfijkj1QbntGfxgoniI24/8y9OLkGRY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-wu7dZxVpNVGzxWhfv-BfGQ-1; Fri, 12 Sep 2025 09:48:02 -0400
X-MC-Unique: wu7dZxVpNVGzxWhfv-BfGQ-1
X-Mimecast-MFC-AGG-ID: wu7dZxVpNVGzxWhfv-BfGQ_1757684881
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e2055ce8b7so898126f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684881; x=1758289681;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3448OdTgFs0YiOnfQSy1wV2L7Q5FFoX8LkMxHWDXQ0=;
        b=xHBTNi3+MtIcIxTXwlQk/gOWV0kmowHQblosJY113rX+xbZDBg9NT34/mYwbuCghzE
         xgtiO0MvfixxPUjPyFWNYzBP7o/ehOAw8BLAD2fdC+oII1AtMZ1MBBTbRX+uA1qS4QKx
         fdC2vGJmlQpoDq2Ay55Lq2RbrjYHZ8E/44GuJIyMEAaT2hwudaZyp9NmpCIy+/NvhsxQ
         J+XHZaHbfs+5t6JYl0oE/24577nZ3ok9ggSKhfYTs7RmyU7cZ50EWOmvA1p6reDQWgzn
         fHn23UYFxyW9OoC9XRT0aw7PwBVnDHIrBh1wr1Agzw/PExXSNCmlBgPr7VP93H4Xyg4t
         G2Og==
X-Forwarded-Encrypted: i=1; AJvYcCUR1cmTs8FIWph3qrWZ5mRBypgS2sTvdJDChiRzCDGHWURAG1NO/3C4qJ1KQcYKVLrNfjA7YsjR7YYQU/5NaJJA5SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6F4NZNPk6mUQYnT86/eF0qDRI7K3X8Nz6uhjJLY4+CpMY6sCB
	2BpvSQ6bpu2f/s7mNgyn4z5//571xcDjhF/DdTg1oD/LZd11A5ANlfAiZN3xnG1V6WyhvcLeVF2
	By/wo4kchBsrPIh7dWjUhhbUMCaZKxOr5OMddtJfzaK156GDs6SROEM93/DZnh0U19MHKRhHgCQ
	==
X-Gm-Gg: ASbGncsIajmswMp4RnUSrX9QptWW1uOWqtAySypn26nJqNjlQMo8vvgexR2kp5HOe5T
	qgT/HZBeEyDA6EZTRyh187Ix6PT89deFO9sXAwSS09aEBceSPlQ+GG8jJrDPHZCC7axp1fzR81Q
	TO7k59qQF1mgnD6usPWurLUYlkRKtmUGTWu/bEOnSSaq3uOQgBbwOVv2UIM4RP4ElCdlgwVkqHG
	MMlQcKhs2lvfmDMIjWt7MY4uEtFQ6R6l012r4ZYJ/cs4ZAdU+qkzHHA69zOXew5XQVwYyjl5J3i
	V/7/D016ySWyixOXavvrrFQCICmgsLB2vyOD8txWjMmocwWLNdZXT89m/hoTnitTyqzDHsUBvC5
	/DqpY6fCfaieBX4pgAY6+X0Deao0xRimCT/HDB1x/GucLB39AW2LIOxUE6w3Tvl9vp+o=
X-Received: by 2002:a05:6000:2903:b0:3e0:152a:87b4 with SMTP id ffacd0b85a97d-3e7659db0ecmr2929899f8f.35.1757684881156;
        Fri, 12 Sep 2025 06:48:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR3i6SRCrcMcssae1nGWwzt+oNV7vkhRgpzb3bl3dJ8CMEtAZfsOX+4eMBZZIz5FBmhHDpKA==
X-Received: by 2002:a05:6000:2903:b0:3e0:152a:87b4 with SMTP id ffacd0b85a97d-3e7659db0ecmr2929876f8f.35.1757684880716;
        Fri, 12 Sep 2025 06:48:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd691sm6839560f8f.32.2025.09.12.06.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 06:48:00 -0700 (PDT)
Message-ID: <43f42d9d-f814-4b54-91a6-3073f7c7cedf@redhat.com>
Date: Fri, 12 Sep 2025 15:47:58 +0200
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _TvVpgq4Mf73CM73Wh9gL61qRoBO89DuoSHs54V4vdo_1757684881
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 14:19, Kiryl Shutsemau wrote:
> On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
>> The following series provides khugepaged with the capability to collapse
>> anonymous memory regions to mTHPs.
>>
>> To achieve this we generalize the khugepaged functions to no longer depend
>> on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
>> pages that are occupied (!none/zero). After the PMD scan is done, we do
>> binary recursion on the bitmap to find the optimal mTHP sizes for the PMD
>> range. The restriction on max_ptes_none is removed during the scan, to make
>> sure we account for the whole PMD range. When no mTHP size is enabled, the
>> legacy behavior of khugepaged is maintained. max_ptes_none will be scaled
>> by the attempted collapse order to determine how full a mTHP must be to be
>> eligible for the collapse to occur. If a mTHP collapse is attempted, but
>> contains swapped out, or shared pages, we don't perform the collapse. It is
>> now also possible to collapse to mTHPs without requiring the PMD THP size
>> to be enabled.
>>
>> When enabling (m)THP sizes, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on
>> 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 for
>> mTHP collapses to prevent collapse "creep" behavior. This prevents
>> constantly promoting mTHPs to the next available size, which would occur
>> because a collapse introduces more non-zero pages that would satisfy the
>> promotion condition on subsequent scans.
> 
> Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
> all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.

BTW, I thought further about this and I agree: if we count zero-filled 
pages towards none_or_zero one we can avoid the "creep" problem.

The scanning-for-zero part is rather nasty, though.

-- 
Cheers

David / dhildenb

