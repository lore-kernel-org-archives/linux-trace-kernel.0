Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975DF3F9C5
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676372; cv=none; b=DF//Z7+jsZLwExUItYxzvlEgujeD3NGu51TNhKdUMdptcsuScYYCuJ8G/ANSY6rSzQBBpX+TomnkuCN2B0Z94ru9ZR+pqS4o0Bxwzfo4AMtK8q8qFU2Xk+PQ/nfEBoW2yvORU7u3ImCXKxQHZy6+lDWj0G3dLrdCwOD0UGoQCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676372; c=relaxed/simple;
	bh=1l+TjhQp9Q1J9Sh4/4LccqAiC1Cy11CEzVtYjhTLHU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbNTI/7wALZvO28Zp3iofq+vsjPRba9DL+XtL4rvyQkEMiQoYGu4fIU6nxwllenkS9SYmVyPfLeOFgtqG7w2KoUJUuJ445WKg25YI5Kl+Z8N3rcwcPBRbsWpM0JxOG/BF9JbIU9JyE3/+KqLqvc+VK3e7A+/9Y64GXjVrPgq3D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WRjBOrUN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRjBOrUN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752676368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dPEOMS9uwY37weCLvcDPRO7UbyKU9Tf2sqinEDH0Om4=;
	b=WRjBOrUNuAB9D9anykEInoL2rLKtpKSOKvqrLQFU4UzUIdqwVwC8lyMzraQfCh+4GRTCZX
	J+iRvtwOCBe0sR+ejlg/vbz/J89gtgDP4EJyoyKqcqzTCw5VHR7R0ZOgvjIvZgdVdYk+Uj
	xQxvC1OT3ybnYyGh74wVP4l1GEzg3LY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-IY2K6zXMO-OLHW4OSphJsw-1; Wed, 16 Jul 2025 10:32:47 -0400
X-MC-Unique: IY2K6zXMO-OLHW4OSphJsw-1
X-Mimecast-MFC-AGG-ID: IY2K6zXMO-OLHW4OSphJsw_1752676366
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-454dee17a91so52346495e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676366; x=1753281166;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dPEOMS9uwY37weCLvcDPRO7UbyKU9Tf2sqinEDH0Om4=;
        b=GCi1109EWaPNqJbtaQsgKvOZ5l8BWZd0sycPcur/bBhFEgQ5du7VwTTds/EHSY4Hhy
         OL/EZtxDoioD9rAOFbcncsw1CRjkE4ScKWkJ8WY3CkSh2y/JGqc8H5aeArxSefMglOBf
         YVNeKqiZ5g5O/z0V8JtCJVtseGuv1K1KYE5R2mrSPLvday6niacYFrH5NB0wokz3vi6q
         VueLl8GfZWv9NRVjcRDmXtAummyj+DBSIBpNyHR6thBlrgl2a38sxRttRelYWPjmw8wu
         wEitGQGsbzS03kR4a+TfFSj/PzN3qTFwWsIvbXE9pfX/ElcXb1UBthHI4taDmSieCIY2
         LY4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXmWRQ0+TAvzQuyxNmaX/Nh0l/k7LQXE+823Kz2VeYqavjwvEsFAIWZ4hKxRwdycnCoW9csCLIS3RJPV8Se0SGzvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Ne2yf/9IDd3+VzCBztfbSjdvkLwJSk85XrWuRLn1zN+94U4T
	ekKWWr5nbuhmA1++OJfNSXgSRyn2c1HBxH48rBS+aN1V8meKzukeHQ1FPJPsBs5IM9wXgZMSsL/
	ruMkaMa1WdqcLDUFoQ94xBN582NtNggsdD1lLHZh4/or+glN8S5IiODXHDmlBjoUgqXdgrJvQnQ
	==
X-Gm-Gg: ASbGncsRgv5b0kVFo8mE6KcFW3V2IzEHIkclNZP0UxFFVlVo43klaOZXu8FDTraD1Sm
	Y5wW8ts8guE2W7HZA6dhZTvX2z2C/ymNJ74bwBtNhWUuiedis/JGnbyvZkgEQlcf13Oe1vLWkAx
	XE502MKFnsTqJl2RPQzk1GGnkz5xWT7scYmO/ZOD5mkjD3plkIn8oloyJtQK4pcN1iL4fyZ7dTx
	fzGOKzpJ/v406fkLOlEb8gWhkmKQbA/afgVq2SfrPMncVsRsuYwesvFJirkYD4akXCI65biAZuO
	a8+QqG3HtqM5DvTIwTgd8M736rhbS9BKUVAoEpircPXRW90yvdh2GsxckBvkqmpHI4VCDt6zcMT
	VfGR5sDe15AbBVUoqAXSUM5EiLGvXlXSL0GziORbg9e+HfQJtiPSRJOMdg1Rlf3Q6PAY=
X-Received: by 2002:a05:600c:3b97:b0:456:27a4:50ac with SMTP id 5b1f17b1804b1-4562e3a29e9mr24451105e9.23.1752676365906;
        Wed, 16 Jul 2025 07:32:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZMT5m45p1tCk9bvbDvVlLWULYFUoSYYJMJ3qlLHGbNtVt/1JcySJN5NgVdjsnSgos3dkhXA==
X-Received: by 2002:a05:600c:3b97:b0:456:27a4:50ac with SMTP id 5b1f17b1804b1-4562e3a29e9mr24450675e9.23.1752676365450;
        Wed, 16 Jul 2025 07:32:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d758sm17727799f8f.49.2025.07.16.07.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:32:44 -0700 (PDT)
Message-ID: <290d669f-e358-471a-95b7-c46f974742d0@redhat.com>
Date: Wed, 16 Jul 2025 16:32:43 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/14] khugepaged: skip collapsing mTHP to smaller
 orders
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-9-npache@redhat.com>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAmgsLPQFCRvGjuMACgkQTd4Q
 9wD/g1o0bxAAqYC7gTyGj5rZwvy1VesF6YoQncH0yI79lvXUYOX+Nngko4v4dTlOQvrd/vhb
 02e9FtpA1CxgwdgIPFKIuXvdSyXAp0xXuIuRPQYbgNriQFkaBlHe9mSf8O09J3SCVa/5ezKM
 OLW/OONSV/Fr2VI1wxAYj3/Rb+U6rpzqIQ3Uh/5Rjmla6pTl7Z9/o1zKlVOX1SxVGSrlXhqt
 kwdbjdj/csSzoAbUF/duDuhyEl11/xStm/lBMzVuf3ZhV5SSgLAflLBo4l6mR5RolpPv5wad
 GpYS/hm7HsmEA0PBAPNb5DvZQ7vNaX23FlgylSXyv72UVsObHsu6pT4sfoxvJ5nJxvzGi69U
 s1uryvlAfS6E+D5ULrV35taTwSpcBAh0/RqRbV0mTc57vvAoXofBDcs3Z30IReFS34QSpjvl
 Hxbe7itHGuuhEVM1qmq2U72ezOQ7MzADbwCtn+yGeISQqeFn9QMAZVAkXsc9Wp0SW/WQKb76
 FkSRalBZcc2vXM0VqhFVzTb6iNqYXqVKyuPKwhBunhTt6XnIfhpRgqveCPNIasSX05VQR6/a
 OBHZX3seTikp7A1z9iZIsdtJxB88dGkpeMj6qJ5RLzUsPUVPodEcz1B5aTEbYK6428H8MeLq
 NFPwmknOlDzQNC6RND8Ez7YEhzqvw7263MojcmmPcLelYbfOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCaCwtJQUJG8aPFAAKCRBN3hD3AP+DWlDnD/4k2TW+HyOOOePVm23F5HOhNNd7nNv3
 Vq2cLcW1DteHUdxMO0X+zqrKDHI5hgnE/E2QH9jyV8mB8l/ndElobciaJcbl1cM43vVzPIWn
 01vW62oxUNtEvzLLxGLPTrnMxWdZgxr7ACCWKUnMGE2E8eca0cT2pnIJoQRz242xqe/nYxBB
 /BAK+dsxHIfcQzl88G83oaO7vb7s/cWMYRKOg+WIgp0MJ8DO2IU5JmUtyJB+V3YzzM4cMic3
 bNn8nHjTWw/9+QQ5vg3TXHZ5XMu9mtfw2La3bHJ6AybL0DvEkdGxk6YHqJVEukciLMWDWqQQ
 RtbBhqcprgUxipNvdn9KwNpGciM+hNtM9kf9gt0fjv79l/FiSw6KbCPX9b636GzgNy0Ev2UV
 m00EtcpRXXMlEpbP4V947ufWVK2Mz7RFUfU4+ETDd1scMQDHzrXItryHLZWhopPI4Z+ps0rB
 CQHfSpl+wG4XbJJu1D8/Ww3FsO42TMFrNr2/cmqwuUZ0a0uxrpkNYrsGjkEu7a+9MheyTzcm
 vyU2knz5/stkTN2LKz5REqOe24oRnypjpAfaoxRYXs+F8wml519InWlwCra49IUSxD1hXPxO
 WBe5lqcozu9LpNDH/brVSzHCSb7vjNGvvSVESDuoiHK8gNlf0v+epy5WYd7CGAgODPvDShGN
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250714003207.113275-9-npache@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XksZKFKeAQOQLg57xc9AnJXgO9fTE1dtncv_gEIgvAk_1752676366
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 02:32, Nico Pache wrote:
> khugepaged may try to collapse a mTHP to a smaller mTHP, resulting in
> some pages being unmapped. Skip these cases until we have a way to check
> if its ok to collapse to a smaller mTHP size (like in the case of a
> partially mapped folio).
> 
> This patch is inspired by Dev Jain's work on khugepaged mTHP support [1].
> 
> [1] https://lore.kernel.org/lkml/20241216165105.56185-11-dev.jain@arm.com/
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/khugepaged.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 5d7c5be9097e..a701d9f0f158 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -612,7 +612,12 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   		folio = page_folio(page);
>   		VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
>   
> -		/* See hpage_collapse_scan_pmd(). */
> +		if (order != HPAGE_PMD_ORDER && folio_order(folio) >= order) {
> +			result = SCAN_PTE_MAPPED_HUGEPAGE;
> +			goto out;
> +		}

Probably worth adding a TODO in the code like

/*
  * TODO: In some cases of partially-mapped folios, we'd actually
  * want to collapse.
  */

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

