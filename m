Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED020298250
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 May 2025 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747245457; cv=none; b=dR3IT+c274sHWbUxErmd5KW6rsAWI03t6WFNozQA/l4QEpGxw3nI4A9Q0V93zXcKeJ0tf1x+r5Hfqn1WFCUwcEyijDoMp5kGnQgitaKnijBc49O7gIWf0L/uDKhvfvtfNxJCiBrwWHXOY5ZvVQMCoQgvePaYqAs6deUWY7rtZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747245457; c=relaxed/simple;
	bh=X6c/QaHezuYgWRvmYLC83Uyd1iuskmuqUwpmbAVKF08=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ddzagc6eUDrNAIVb2jBXh4g1S39YyU2IhSPnFOrJMGfR1hUWhCImsScFCw4wangT4+Y1dDcf15bRjXTNANark6CWVn/5gUolBYP+vdQ2DHLW2+K6TvUj25Yn6cNuJHZ3G5sBRQCW9dGgOLBULboNKKR6DCwg1NPWZIDeGMc6WZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEDv9zhg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEDv9zhg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747245454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0bWZ4WIW6USGmd3fCtPku9lyZiPCoKVx7jpPxXIn3KU=;
	b=AEDv9zhgtwq26Bv5BDb21y56Ziv/St4gZFTVXFKO9pCwlSwXX+aT6F+dH3O/kskpVnsaAN
	jX+GTCIEfQyGnIm9a2zJ+WlFJ++fMDNV9/K9mO/36m8EMVhbp2nyFDPloRO4eVrHhGxMeC
	3/VL29DKkVVywYtXAenUKAV53/e7Zqg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-3u6jdIdgOBOrikKotviPKg-1; Wed, 14 May 2025 13:57:33 -0400
X-MC-Unique: 3u6jdIdgOBOrikKotviPKg-1
X-Mimecast-MFC-AGG-ID: 3u6jdIdgOBOrikKotviPKg_1747245452
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a1f6c5f4f2so15038f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 May 2025 10:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747245452; x=1747850252;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bWZ4WIW6USGmd3fCtPku9lyZiPCoKVx7jpPxXIn3KU=;
        b=I+/n1NlB1UZ1Z8DCIdvAsJ2T8s50mGM1ZyUfboxAnH2TJmkAV4810h1k1pvDyV0QLQ
         NWCkSrBtFVN/fOGAHzTbj6z3iKJ44uc8HoS6XvEC82K85zV5t1qqrxaymr1vL4RiatAF
         vQA2CIi7PtanVCV+1bHHSUvkfbSrzFm0LYVWdfcnoEooJc0OJAo+Nxjzv81sBiRrdqLi
         6FnMy96GXOU8YgCh5hGSe8AACWmdfsbOHvqL2sSwSMfNEwNGxkL29UDKnzawij5LD0GR
         AqX7rwqzv5xjXWAH42+mnadJtvq8RQRjf+lLV+33lKWrEVdYq+E/T2NVoB5QsCuCfO9g
         syug==
X-Forwarded-Encrypted: i=1; AJvYcCW1ScX/Q89wlfbgugx5ESM9zjiVyak9IATktTPSDXz6eCgOL++i6hYxKS0r1A6Hl5CmkLMw7qY+wTUwCyzcACO7J8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmFmkuE4dZ3YX2JWjSbRNfZkDk9vZELOmlGQvsm1VjhzRmsGwh
	yWtHNi/g5vzaBL/EqjYguZyIX6J/oewpdVcNnHvJCDJUhCi6bpdiN56QCE1qRl0u1YW5DWQTrFy
	HZe7ZzEUMZF9mMHt6ke6K/N534nSXJiHXMF3g+QeRL+l9SyFI539DAdzWXgCQFYC/xSgZyA==
X-Gm-Gg: ASbGncs/Kuf8Ku+DJSbUClX4vJ5zAUzrpNJHLXnLqFFS8nKLPmi5VLIsB8s7JzueEQA
	B3CSFCFWV1Y75hrSyfcQUXVwsaGaqu1XHqL9or33cUz+dzBAkKczZlggplkxcyoLmf1pnmJ3jS/
	uJnJaaOJ4mIi/l2ChCtPCZnx+tPIGxrT9IGRa2m8sGvbBk+DTgrzPg6iGfAosyoBHz4KpxMmLd9
	gI+U36CzQCVAaXRmfNbGVpSFoHoKiCt8NksZyw55J5by3udMOsszIoLYGYT1vPMZc+DkFTFPNZF
	NcoUsY53wbmkN9TU4juVV2UJl0+9UeXyCvzkgTempoWqV66fjFkjwRVSldxOqlaz42+1BXNHNwN
	y3P6D4owsksHaQHSAuqhnj+sLXLgS4EP422FAOe4=
X-Received: by 2002:a05:6000:430d:b0:3a0:b5db:559a with SMTP id ffacd0b85a97d-3a349954e89mr3786757f8f.59.1747245452386;
        Wed, 14 May 2025 10:57:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp4OKdBffaHI+7gilOZzshfSllV9gdjyqy9+7eDS0fOGPhf7CpV4/kX9mFGXIv7GQk11jdug==
X-Received: by 2002:a05:6000:430d:b0:3a0:b5db:559a with SMTP id ffacd0b85a97d-3a349954e89mr3786725f8f.59.1747245451911;
        Wed, 14 May 2025 10:57:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:6200:d485:1bcd:d708:f5df? (p200300d82f156200d4851bcdd708f5df.dip0.t-ipconnect.de. [2003:d8:2f15:6200:d485:1bcd:d708:f5df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm20235782f8f.22.2025.05.14.10.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 10:57:31 -0700 (PDT)
Message-ID: <31998178-7f18-4c5c-9207-180998768cfe@redhat.com>
Date: Wed, 14 May 2025 19:57:29 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] mm: introduce pfnmap_track() and
 pfnmap_untrack() and use them for memremap
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>,
 Ingo Molnar <mingo@kernel.org>
References: <20250512123424.637989-1-david@redhat.com>
 <20250512123424.637989-4-david@redhat.com>
 <beqj5nkucukfi7nq7cptzqwksugo5dkljzjg2opzlize7ixfvc@q27zsivgbcow>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <beqj5nkucukfi7nq7cptzqwksugo5dkljzjg2opzlize7ixfvc@q27zsivgbcow>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N7k2oSH56Xeq5TXukTB3uc5DbROuvcHcY3EhqPnORcs_1747245452
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.05.25 19:40, Liam R. Howlett wrote:
> * David Hildenbrand <david@redhat.com> [250512 08:34]:
>> Let's provide variants of track_pfn_remap() and untrack_pfn() that won't
>> mess with VMAs, and replace the usage in mm/memremap.c.
>>
>> Add some documentation.
>>
>> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Acked-by: Ingo Molnar <mingo@kernel.org> # x86 bits
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Small nit with this one, but either way:
> 
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks!

[...]

> 
> The other user is pfnmap_track_ctx_alloc() in mm/memory.c which is
> called from remap_pfn_range(), which also has addr.
> 
> Couldn't we just use the address directly?
> 
> I think the same holds for untrack as well.

Hm, conceptually, I want the "pfntrack" interface to consume ... PFNs :)

Actually, I was thinking about converting the "size" parameter to 
nr_pages as well, but decided to leave that for another day.

... because I really should be working on (... checking todo list ...) 
anything else but PAT at this point.

So unless there are strong feelings, I'll leave it that way (the way the 
old interface also used it), and add it to my todo list (either make it 
an address or make size -> nr_pages).

Thanks for all the review Liam!

-- 
Cheers,

David / dhildenb

