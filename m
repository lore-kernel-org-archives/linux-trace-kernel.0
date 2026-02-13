Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C243A17D2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Feb 2026 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770949062; cv=none; b=EXQ6ZTPlzQj04+4+0ImKyZThf0ROmsCRdwFfXzLW4NpDplvkaz//sTrsadikJUl/oQuWbMkRl5Nn7PxcQ8MDRYDgAjbPG8d6QS/blxh7lMvBvpySOQ8cxYTDWRaIReL7Sdj4AxADLo0i599Cl9BoWe1f+CLn7QsfuP+5h3xfWHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770949062; c=relaxed/simple;
	bh=ynguVl6F9zxuFl3hACXnPNpUr0gAqyGSelF9u1/9oOE=;
	h=To:From:Subject:Cc:In-Reply-To:Content-Type:References:Date:
	 Message-Id:Mime-Version; b=H5nizl35NxAlcRH883jjbQsiNvYDVqlbav1c/81Rn0K2Mwg/ZQ/FiGsepRj/RAGu2QnWcR9dzk00IIwtmzsri+C2g6n3XFx9TT6j9M5wQpC7VNdFgzV7PE3mR5oZrKqyxm7DpsD/84UocyikR3xjF8n89a6TOeytoIwcg3iiTrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=c5mjZENs; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c5mjZENs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1770948972; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=8nmshf6y+s5gxJqdjV3suelorzDWBuHrWwzHCDo/6AU=;
 b=c5mjZENsKrfced4h0bVAMb4eHB4/nGK/UCbrSRDeKkPEvlN07h4EwSB5sgWlI5sUf5Rbcc
 JeUPLoR4QzxC+qHN1F1VaqwdTIJfD1A7LrWPTWaCec6Lkx0oXA1mPi+65djXHI/OfM84JO
 feiQxsCdekXwABoLcqb/dY1tug17UQESbluvTnMOzX5d1HWslgz0AVDPHkwlHKID7/t5ST
 CGzW7mrmtodbO2fr3nolQRqedok7SLrvGkSpBWPLhUxOcv3udwAgMz6nuBYpjiv1W3fM+U
 B7rzXvaT/aND/UsT28ninefGZr/S8lN0hZQXY71i4a7VKz3Df1KRkFLBig75Yg==
X-Lms-Return-Path: <lba+2698e896a+733acc+vger.kernel.org+wuqiang.matt@bytedance.com>
To: "Arnd Bergmann" <arnd@kernel.org>, 
	"Masami Hiramatsu" <mhiramat@kernel.org>
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: Re: [PATCH] objpool: fix minimum alignment of 'struct objpool_slot'
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Yury Norov" <yury.norov@gmail.com>, 
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20260210103530.3028454-1-arnd@kernel.org>
Content-Transfer-Encoding: 7bit
X-Original-From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Autocrypt: addr=wuqiang.matt@bytedance.com; keydata= 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 4mCJUdEkdwCS
References: <20260210103530.3028454-1-arnd@kernel.org>
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Date: Fri, 13 Feb 2026 10:15:59 +0800
Message-Id: <596a5c54-a344-40ef-a995-22befe28e680@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

On 2026/2/10 18:35, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Members of objpool_slot get passed into try_cmpxchg_release(),
> which does not work on most architectures unless they are
> naturally aligned. Marking the structure as packed makes it
> only byte-aligned, as shown by this (normally disabled) warning:
> 
> include/linux/objpool.h:156:56: warning: taking address of packed member of 'struct objpool_slot' may result in an unaligned pointer value [-Waddress-of-packed-member]
>    156 |                 if (try_cmpxchg_release(&slot->head, &head, head + 1))
>        |                                                       ~^~~~~~~~~~~~
> 
> As the struct members are all tightly packed on all architectures,
> Just remove the '__packed annotation to give it the required
> alignment of the native word size.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   include/linux/objpool.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/objpool.h b/include/linux/objpool.h
> index b713a1fe7521..f678b35b20b1 100644
> --- a/include/linux/objpool.h
> +++ b/include/linux/objpool.h
> @@ -56,7 +56,7 @@ struct objpool_slot {
>   	uint32_t            last;
>   	uint32_t            mask;
>   	void               *entries[];
> -} __packed;
> +};
>   
>   struct objpool_head;
>   

Reviewed-by: wuqiang.matt <wuqiang.matt@bytedance.com>

Regards,
Matt Wu
