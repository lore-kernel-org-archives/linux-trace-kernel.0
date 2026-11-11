Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387124;
	b=hkTmlGu35cAxt6795B9Ng1pAjVfVJGvOnie1U+mXinL6wa7XKbM4kzgNPs44FdbH8ANc
	 uRGOAcgOvVo6jw7SQJ8mT/iS1KghAy1oKwG4x0EJv3mvZ6vo2DAwGWDCiPoJHSLM5aZtC
	 jw7qNjy8Pru3fao4ifofEAEP4wCZUq+jeP7jvmWlIBE5CgRpFpMxsE3dJpchJnWgZ4/X9
	 yxUrF4gbxdFdw4nTu9ZD4hpty2Ak+H/aZcBBUg47dIgTezrUdmTJTWvn7RxZ7VMblME8H
	 rnLp6KwRKeBLhkQZ0zZEkxWs5MOPrBLLvbk2HHMfIMppqj3RkJ9smnP+RPHLvtB2IZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387124;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8wykzOLysom3LTHkeGjf5Ujqz1G4Lprntggj7dNVM8M=;
	b=tWcHqEhIlKGdPRI0hlId2AflfIWiXdQ0f9fU0+7hjErL8bFmY46gtvqfHTbPKtELJR1I
	 X0DvXPU7TvzNLPa8Gu10373Hpj6kQzaCSh6HSlG8uYnFJsZQzHN2gZf/JQ42bKUrJVf8I
	 MqZfciGIzj/8KiOOHE1HN2917DDD/KlEtqaUV2EyyB4kho9lEgAqMgxLTllAQlQg/vAD4
	 zZsKsL9PDlJv+nok/K1qDiuTkR2/oIYE5tOCICokh+zeXrV26IFC3Z1AFyHvb/N8KzpGH
	 YaPiIZI4/TXfg6NZ+7DJCWNztoIhU8QbwlYq79rGtlT+Yzj9pzIbIuoMM+vnYtMtBFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiNSqQc3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019C606A321;
	Wed, 11 Nov 2026 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiNSqQc3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FED1F00A05;
	Wed, 11 Nov 2026 08:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794387123;
	bh=8wykzOLysom3LTHkeGjf5Ujqz1G4Lprntggj7dNVM8M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZiNSqQc3q0uXnP+UR3P36A+j16smTNGEgv+gYmabH1FD6aLSBgfHattI13N0UN60s
	 Ouu0/c8Vee0m7hekIjk1kQmN6z6N9DX/73eOJZN9NPHOuy+jWUUWlHN8toTGHwQ4jt
	 pDMTIBJp9eEwgYlTUGZfNOI7mfZ3K5YE93E3wCWh1n97n8etmCPEp5yErjqtOGl71a
	 xl/lQ31UYkzK5geBYG5GNJvqc1BijH9xe+0wBI9EuqpBHlvbp/UdswQgKddfmcAWz6
	 HJANkx9bos4slWEhPO9GfQdzYBSQK1GOdR8Qk2M4DWwr6xxf596kw4zFoAlMy5bLp4
	 PQR0ydYpB/PWQ==
Message-ID: <86bc9747-ad4b-4471-b507-dafe3b3cdb91@kernel.org>
Date: Wed, 11 Nov 2026 09:51:59 +0100
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/compaction: Mark concurrent compact_considered
 accesses
Content-Language: en-US
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, ziy@nvidia.com, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+212c2d1f47994035cf7f@syzkaller.appspotmail.com
References: <20261111084205.80997-1-zhujun2@cmss.chinamobile.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261111084205.80997-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/26 09:42, Zhu Jun wrote:
> Direct compaction and kcompactd update compact_considered without a
> common lock. KCSAN reports the plain increment racing with a reset.
> This counter is an approximate backoff heuristic and already permits
> concurrent increments to be lost.
> 
> Use a local snapshot for the saturating increment and mark all shared
> loads and stores, including the tracepoint snapshot. Preserve the
> existing saturation limit and deferral decisions.
> 
> Fixes: 4f92e2586b43 ("mm: compaction: defer compaction using an exponential backoff when compaction fails")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Shouldn't KCSAN be suppressed by data_race() and not READ_ONCE/WRITE_ONCE?

> ---
>  include/trace/events/compaction.h |  2 +-
>  mm/compaction.c                   | 15 ++++++++-------
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
> index d05759d18538..42303a4835f5 100644
> --- a/include/trace/events/compaction.h
> +++ b/include/trace/events/compaction.h
> @@ -255,7 +255,7 @@ DECLARE_EVENT_CLASS(mm_compaction_defer_template,
>  		__entry->nid = zone_to_nid(zone);
>  		__entry->idx = zone_idx(zone);
>  		__entry->order = order;
> -		__entry->considered = zone->compact_considered;
> +		__entry->considered = READ_ONCE(zone->compact_considered);
>  		__entry->defer_shift = zone->compact_defer_shift;
>  		__entry->order_failed = zone->compact_order_failed;
>  	),
> diff --git a/mm/compaction.c b/mm/compaction.c
> index f1b2060eb201..04b93d3545af 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -126,7 +126,7 @@ static unsigned long release_free_list(struct list_head *freepages)
>   */
>  static void defer_compaction(struct zone *zone, int order)
>  {
> -	zone->compact_considered = 0;
> +	WRITE_ONCE(zone->compact_considered, 0);
>  	zone->compact_defer_shift++;
>  
>  	if (order < zone->compact_order_failed)
> @@ -142,15 +142,16 @@ static void defer_compaction(struct zone *zone, int order)
>  static bool compaction_deferred(struct zone *zone, int order)
>  {
>  	unsigned long defer_limit = 1UL << zone->compact_defer_shift;
> +	unsigned long considered;
>  
>  	if (order < zone->compact_order_failed)
>  		return false;
>  
> -	/* Avoid possible overflow */
> -	if (++zone->compact_considered >= defer_limit) {
> -		zone->compact_considered = defer_limit;
> +	/* This is a heuristic; concurrent updates may be lost. */
> +	considered = READ_ONCE(zone->compact_considered) + 1;
> +	WRITE_ONCE(zone->compact_considered, min(considered, defer_limit));
> +	if (considered >= defer_limit)
>  		return false;
> -	}
>  
>  	trace_mm_compaction_deferred(zone, order);
>  
> @@ -166,7 +167,7 @@ void compaction_defer_reset(struct zone *zone, int order,
>  		bool alloc_success)
>  {
>  	if (alloc_success) {
> -		zone->compact_considered = 0;
> +		WRITE_ONCE(zone->compact_considered, 0);
>  		zone->compact_defer_shift = 0;
>  	}
>  	if (order >= zone->compact_order_failed)
> @@ -182,7 +183,7 @@ static bool compaction_restarting(struct zone *zone, int order)
>  		return false;
>  
>  	return zone->compact_defer_shift == COMPACT_MAX_DEFER_SHIFT &&
> -		zone->compact_considered >= 1UL << zone->compact_defer_shift;
> +		READ_ONCE(zone->compact_considered) >= 1UL << zone->compact_defer_shift;
>  }
>  
>  /* Returns true if the pageblock should be scanned for pages to isolate. */

