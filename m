Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561F30BF64
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941167; cv=none; b=U3vXuM18wyTcD0hOPS7UBYbRfKUzdqOZX2QzJ+53LO+JNGFvwnGT7ftT11k06+iWA7xDKJQn8ci09h6Gq/oPgcTaR5GE8nFh7XIwHsBQ5UVhuU/Lkn6Wr0oG+86ks891idNveE5XSKFdBVIKOWG/LjLEVuuLSegINxT/G7s8xdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941167; c=relaxed/simple;
	bh=F/zAZgU2FomGVtqnhxBwQWziN36p1+sFiuLHtl9Ytrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E00FUnczZrHaiuFbdISkpBKevYvvW/EnnxR6nRVlufaHp2gIVeIduqvvY5SITeR+7Af1Y/ohz+0WpuPb5dxMqnZDaIPYzqDNEMMl8oX28HVXN9u1bwUDok6FKnxlTr35vt/5J40t1rfJ4p1MlnQKyaGvjI2F5o+zgNTzf8gVVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZeXxYDKl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeXxYDKl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757941164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Z9AyUt4haocv7F95i9a+JlLpc0x0YT4r6qftqX3qLrs=;
	b=ZeXxYDKlH6a41ktplZuAvoo5LADV4kV1GS82PlEIlVww7yoe/6Q4IGvNNLegdZKw5xlksr
	A2wmsGcEQduRkECke8JG+3xvtnyBnM29cP5DMjKslGWwpWTVF2XBu497EyAhS9+mDEvOi0
	SojPwUZWElb3rMh0J1fG4WfIVDzivDY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-2lXYBmBjMCCdWz5DxI7AzQ-1; Mon, 15 Sep 2025 08:59:23 -0400
X-MC-Unique: 2lXYBmBjMCCdWz5DxI7AzQ-1
X-Mimecast-MFC-AGG-ID: 2lXYBmBjMCCdWz5DxI7AzQ_1757941163
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45f2f1a650dso4953965e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757941162; x=1758545962;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9AyUt4haocv7F95i9a+JlLpc0x0YT4r6qftqX3qLrs=;
        b=gKIh03aB9KKE1F1OtoTEwXfcJyVUfTE+uYcXTdFWiJpLuSh3H1+mFycHN6r6L3sgRK
         szLLKN+XcQ8K2YMMP7bRSLj4Viw/YpsE8NjNLwvwVJF+yAgHXC+wP1GLWhASRiYTCucQ
         Dsw47EzLzBSbpkAtSow+u+IuPjZHCz51j5pzKV9X6qe41L7Y+W/QxK87yrwOdEBZxI9e
         8tzuGkA80GKXwmXfgXleimptC2FUc5bYFvQROTVeQ8h4GOkvWqI3Y/mVGdT4TRSVhH36
         SCNmkg9c4/Qwf/OxRXT4Pmc5N1rfKQeU12jZt6XXnTDIsX9ZcSbsBbL7xXoV7ObkL3Zb
         755w==
X-Forwarded-Encrypted: i=1; AJvYcCWdU8EuHh1FS1rgdB9kwEq/UrQXbGMOOSUKgr1moQenBICu1X8Oi9TsK+0BS51T/X568HXw3Or21Pb6JAilBSvxM+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFxtj4zJmozFq0yGAuUjd0Q2LlJ9DKVeedUxSnMzF7Ob8r5D7E
	k2jtEHn2P6BdAbzHYi2FPclh4y5hLQeTn/sEphtVGmjQYAczhCc9W5cCV9YvuN+8qvkwS3DHHcl
	rFkHZISu2B4gAvsS0PcBdMPfuXV4r2tv5hN8jes8ztEFSab6E+sK7dvmJLBXGrho75qH0foVv8A
	==
X-Gm-Gg: ASbGncuU8C8FkMRIuobA6Zu3O5dMgPskUmKPmsj26MeqHbrdBi7lyqdgCp910TCeCxH
	7YlE6roPAfjixPir5SXJn6e+HzxnCGgytIBkqVIaGtC491oS2Uf2IaLKZ1PEu/3D/QxBw+PPhNT
	e7nNq8yh4T1xq+WzopPdMezYIv6lfJg23+CRH0xMLBtEtVQj711WEP5KRGJZ8Oc/TDj6v+VMxSP
	SbDisQojQAyOVa5hfE5uPzTckEVUO1SYhowbPIyKVXkKcZkdFq1KP1JDbzfv/leBp0ytRKPOS/f
	ba1tqptTXnm72TZRoF4T8FWT5d4ZcB3r87MxVmZjwbklKU0mdbBh+bnLPSgbVc3hyvk9QvDR53m
	PfWw98TdWfc879FJey/xtQIqpJibEV+cK2sgWUKPh2ETbKiQ4Vucq6vb1d7joC3iTAXs=
X-Received: by 2002:a05:600c:198f:b0:45d:db2a:ce37 with SMTP id 5b1f17b1804b1-45f24df556fmr95539235e9.0.1757941162503;
        Mon, 15 Sep 2025 05:59:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKriu8iaZGvf/bFu9nYRr4M1WXgTzDA+G+Qti4ilusiGCyEBdwFxvpcMyyGZ5HQLQRNLOcSg==
X-Received: by 2002:a05:600c:198f:b0:45d:db2a:ce37 with SMTP id 5b1f17b1804b1-45f24df556fmr95538715e9.0.1757941161998;
        Mon, 15 Sep 2025 05:59:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e04cf2870sm94355605e9.1.2025.09.15.05.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 05:59:21 -0700 (PDT)
Message-ID: <2af510cc-8173-49fd-87b7-a6f9c59bd104@redhat.com>
Date: Mon, 15 Sep 2025 14:59:18 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
To: Nico Pache <npache@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 <CAA1CXcD1BhXqYM7oOTLuqPHyWSztdCEk462sYXFXxJCmOpe_Rg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAA1CXcD1BhXqYM7oOTLuqPHyWSztdCEk462sYXFXxJCmOpe_Rg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BrtiytCXkpnJI3zeDIMqo9ILTyJquhiaXD8ZJ9MYBZI_1757941163
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> ...
>> 10 -> ~0% used (~100% none)
> I think this scale is too specific, I think it would be easier to map
> to the one above for the reasons stated there. There would be little
> to no benefit to having such small adjustments between 4-10

It's probably best to discuss that once I have something more concrete 
to share :)

I yet have to think about some cases I have in mind, and once I figured 
them out (and had time to do so ...) I'll post something.

-- 
Cheers

David / dhildenb

