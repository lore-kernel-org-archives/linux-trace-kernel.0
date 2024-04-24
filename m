Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBFA158D9C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951616; cv=none; b=YerG1TnbESFAssulHiRt2lxkHdIxgYViiLgNa4tHGmwpIHEc5I4ZJsjK5DtgA1E4U3tXhUqGhCdUayBFa7DbmTY83sjyfpGstb89sM4mTbiYRuG9xNAN7QHlThwEuZbKBgaYBMqIyYe2BuC2QQ3S1nhqH5iiOaKCUer5jiHYtvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951616; c=relaxed/simple;
	bh=kxAE2HnK94Uoex6jrFCYsczG+PKC6z/6jWCCSXTIVRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKBMgb9qZ9FgMsyIbySMPffL0ursX77ea7x+Hv4NtJ6A8n7oMjkRqB+R2L8vrQUcafgVZlIfJ+C1gy4RPwK822RldcA5VDgve814rePstW6T6tK/tAhSxMJVVkZknLwLMC8aPy1MAjgI01C+lnd3JiddTnH3O7yiWNBZ4g98Qm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fu32h64z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fu32h64z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713951612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=v7ZQm+KUdgib6tZRCwHfwUKJzpflYwxr8pEgfV1EGsA=;
	b=fu32h64zw50I69hhIVPI1Eb/9bB3pLFhTQfsMvDuypyOsbmWQIfVnWBvPcwtcxxoUyEi5G
	BEri7xbAaP5BmrBTMEpRd05vFND7rnUzDyWLFDYriaMPCMCCvheQwOHbi6vh4R2s+umOQB
	V//4/AgXWB8PInYVW4UOFNCPo7nroPM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-TjqruDGnPq-JDVSl94NHfg-1; Wed, 24 Apr 2024 05:40:11 -0400
X-MC-Unique: TjqruDGnPq-JDVSl94NHfg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34a49f5a6baso4401750f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713951610; x=1714556410;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v7ZQm+KUdgib6tZRCwHfwUKJzpflYwxr8pEgfV1EGsA=;
        b=Q32im0WKT629e3oC9dqKJOBHgiQ5fcS7YI/fGdCmNLcbBy+yT2xIaIX9/7W+nV9z/N
         LMj3/d1U152bOrlBuF+pz9eVIkggcHhFafyqbqQJ0aMp5nsZvAHtm8Pe04c7XZAlo17J
         b4oypwOYSoxW7HWnMP+hMzZIOLn1Zjoetdhz2nu57RAbm76HMrCthJRjxEYekBEDv9IV
         8x50a5TcsTmglJKcnTaqaKGnuQlnRzZLT5NIcGcYpS1bbqgsDMxyHq3xfR+pBr7S60wZ
         5KjA9Y7OiteDGPFib3EYAI/TVVqUShCaPQSeoTEbeFN/ft65FtAadGPcwBAUehhfnBHK
         akOg==
X-Forwarded-Encrypted: i=1; AJvYcCU/g1Z5ZTO5D5zStBiIT4dP5yAlePeB01XuifHz21n1Vts+pCPvwRWljoTRVWNqTcd0cVlBQcEherL2vSvPy90fkD4u+V3QZz/PI/DZe4p00XCW
X-Gm-Message-State: AOJu0YxUumBr1CSeo7iZ6QEqsmJzgQ8K5aSEMMjwBOaYbqBo9WT0ukBg
	0ugn8O/WG7tVicvSayzSwIroHJ+ToRFJCji1nfR64JcKCJOyJ7aJfZHDvBAo2r+kwwDSclIBXJP
	o6i8+c1AJV67yBzGYlfulNjJz7ttd5P68Xm/jLlaRMQVs7s4dVV6yxduuSgHhRsbgRmqqOg==
X-Received: by 2002:a5d:6e84:0:b0:34a:912c:bb7c with SMTP id k4-20020a5d6e84000000b0034a912cbb7cmr1437577wrz.69.1713951609995;
        Wed, 24 Apr 2024 02:40:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxDdeQxiT5PNnUKKUzFHvU4KlwyItiJYdD491syZ2ofs/FBe7n5BqA/L51mPCutzUm9D5TZw==
X-Received: by 2002:a5d:6e84:0:b0:34a:912c:bb7c with SMTP id k4-20020a5d6e84000000b0034a912cbb7cmr1437558wrz.69.1713951609547;
        Wed, 24 Apr 2024 02:40:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:1f00:7a4e:8f21:98db:baef? (p200300cbc70d1f007a4e8f2198dbbaef.dip0.t-ipconnect.de. [2003:cb:c70d:1f00:7a4e:8f21:98db:baef])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d684c000000b0034aa1e534c2sm11277902wrw.96.2024.04.24.02.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 02:40:09 -0700 (PDT)
Message-ID: <c30fcda1-ed87-46f5-8297-cdedbddac009@redhat.com>
Date: Wed, 24 Apr 2024 11:40:07 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/18] mm: make folio_mapcount() return 0 for small
 typed folios
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Peter Xu
 <peterx@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Yin Fengwei <fengwei.yin@intel.com>, Yang Shi <shy828301@gmail.com>,
 Zi Yan <ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Hugh Dickins <hughd@google.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Muchun Song <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <naoya.horiguchi@nec.com>,
 Richard Chang <richardycc@google.com>
References: <20240409192301.907377-1-david@redhat.com>
 <20240409192301.907377-7-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240409192301.907377-7-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.04.24 21:22, David Hildenbrand wrote:
> We already handle it properly for large folios. Let's also return "0"
> for small typed folios, like page_mapcount() currently would.
> 
> Consequently, folio_mapcount() will never return negative values for
> typed folios, but may return negative values for underflows.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/linux/mm.h | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index daf687f0e8e5..d453232bba62 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1260,12 +1260,19 @@ static inline int folio_large_mapcount(const struct folio *folio)
>    * references the entire folio counts exactly once, even when such special
>    * page table entries are comprised of multiple ordinary page table entries.
>    *
> + * Will report 0 for pages which cannot be mapped into userspace, such as
> + * slab, page tables and similar.
> + *
>    * Return: The number of times this folio is mapped.
>    */
>   static inline int folio_mapcount(const struct folio *folio)
>   {
> -	if (likely(!folio_test_large(folio)))
> -		return atomic_read(&folio->_mapcount) + 1;
> +	int mapcount;
> +
> +	if (likely(!folio_test_large(folio))) {
> +		mapcount = atomic_read(&folio->_mapcount);
> +		return page_type_has_type(mapcount) ? 0 : mapcount + 1;
> +	}
>   	return folio_large_mapcount(folio);
>   }
>   

 From 98acfb7ff35cb65fcfca5e799bf58f8afe84a645 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 24 Apr 2024 10:56:17 +0200
Subject: [PATCH] !fixup: mm: make folio_mapcount() return 0 for small typed
  folios

Just like page_mapcount(), let's make folio_mapcount() slightly more
efficient.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  include/linux/mm.h | 7 +++++--
  1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cf700c5cdd58b..78e583b50e421 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1271,8 +1271,11 @@ static inline int folio_mapcount(const struct folio *folio)
  	int mapcount;
  
  	if (likely(!folio_test_large(folio))) {
-		mapcount = atomic_read(&folio->_mapcount);
-		return page_type_has_type(mapcount) ? 0 : mapcount + 1;
+		mapcount = atomic_read(&folio->_mapcount) + 1;
+		/* Handle page_has_type() pages */
+		if (mapcount < PAGE_MAPCOUNT_RESERVE + 1)
+			mapcount = 0;
+		return mapcount;
  	}
  	return folio_large_mapcount(folio);
  }
-- 
2.44.0


-- 
Cheers,

David / dhildenb

