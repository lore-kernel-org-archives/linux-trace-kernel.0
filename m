Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E11F94D;
	Mon,  3 Feb 2025 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738571674; cv=none; b=ZaUpRyk9AUhbNisxbUokcpni9QQ5PxMeHHrZOOohgKjfW89flTS/Ul5FWBEpbbjxkCTrSJtoXqdceRtf8daTwrth3aveyA8Mv4r0pwYu1vBkaCKvAbMr/ZeOJoavKaN+QxRRJn2hFpFQPKsr00n/geoUpz2U3+OwBnM35m1kG0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738571674; c=relaxed/simple;
	bh=4qY4vcY6DHqq+9qMn5ftmyfcHIiFFwJOM2wbeKPrN2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qkfy8HzPyoIpImCeFIeWtbqxQz/KdqpZ0kDSw9ceAExn14G0pCU6A67Mlkkq7XmWvdgir5jY8I/X34TFPIVn1Y8k3bQFAjrgg7wM0E2mojtV+E96SYJAQ0wleNkbAUXjckn0C8UuONNReVbJ6VAB+DpnubsLwrNfBlRW3Qm5Z4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1RX2tKoU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x2FTq42a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1RX2tKoU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x2FTq42a; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1RX2tKoU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x2FTq42a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1RX2tKoU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x2FTq42a"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 049531F390;
	Mon,  3 Feb 2025 08:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738571670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W5Eh3Za0HCZS0DVH2DFqtExGY67apd/ir99lJ0RvFTU=;
	b=1RX2tKoU964xdWU8mW7pIJ16kmJg0/npqUOXea4CERNOogIaf3XSyA1qrD0Kz4aFZlrBMt
	3IO/kJi5Uu93xMVnpBoUsfnrBVsrl5COE9fjFBvgNuLsiedHlJNLHwwaONJTKrrg9pxzUb
	vA6rB4FNU61Nqi4Jr9O5jMchSpYKmZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738571670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W5Eh3Za0HCZS0DVH2DFqtExGY67apd/ir99lJ0RvFTU=;
	b=x2FTq42aHJ4xNBvorVZn/3KnMhdresn1PqkLxPnTek5ViACIbyY78kkJXBFwkzqXKe7Pt8
	12X8vAxa4ODV3GAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1RX2tKoU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=x2FTq42a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738571670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W5Eh3Za0HCZS0DVH2DFqtExGY67apd/ir99lJ0RvFTU=;
	b=1RX2tKoU964xdWU8mW7pIJ16kmJg0/npqUOXea4CERNOogIaf3XSyA1qrD0Kz4aFZlrBMt
	3IO/kJi5Uu93xMVnpBoUsfnrBVsrl5COE9fjFBvgNuLsiedHlJNLHwwaONJTKrrg9pxzUb
	vA6rB4FNU61Nqi4Jr9O5jMchSpYKmZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738571670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W5Eh3Za0HCZS0DVH2DFqtExGY67apd/ir99lJ0RvFTU=;
	b=x2FTq42aHJ4xNBvorVZn/3KnMhdresn1PqkLxPnTek5ViACIbyY78kkJXBFwkzqXKe7Pt8
	12X8vAxa4ODV3GAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCFBF13795;
	Mon,  3 Feb 2025 08:34:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nYKPMZV/oGeTTgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 03 Feb 2025 08:34:29 +0000
Message-ID: <46e70b3c-6d96-4507-ba17-a52e8362873d@suse.cz>
Date: Mon, 3 Feb 2025 09:34:29 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kmem/tracing: Add kmem name to kmem_cache_alloc
 tracepoint
Content-Language: en-US
To: Wander Lairson Costa <wander@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Richard Chang
 <richardycc@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 "open list:TRACING" <linux-kernel@vger.kernel.org>,
 "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
 David Rientjes <rientjes@google.com>, Christoph Lameter <cl@gentwo.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20250130181639.58280-1-wander@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250130181639.58280-1-wander@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 049531F390
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[redhat.com,goodmis.org,kernel.org,efficios.com,linux-foundation.org,amd.com,google.com,cmpxchg.org,vger.kernel.org,gentwo.org,gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 1/30/25 19:16, Wander Lairson Costa wrote:
> The kmem_cache_free tracepoint includes a "name" field, which allows
> for easy identification and filtering of specific kmem's. However, the
> kmem_cache_alloc tracepoint lacks this field, making it difficult to
> pair corresponding alloc and free events for analysis.

Hm yeah looks like the free one was added in commit 3544de8ee6e48 and their
use case didn't need alloc too, but it makes sense.

> Add the "name" field to kmem_cache_alloc to enable consistent tracking
> and correlation of kmem alloc and free events.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

I will take this in the slab tree, unless Steven objects.

Thanks,
Vlastimil

> ---
>  include/trace/events/kmem.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index b37eb0a7060f..8ffb022f024c 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -22,6 +22,7 @@ TRACE_EVENT(kmem_cache_alloc,
>  	TP_STRUCT__entry(
>  		__field(	unsigned long,	call_site	)
>  		__field(	const void *,	ptr		)
> +		__string(	name,		s->name		)
>  		__field(	size_t,		bytes_req	)
>  		__field(	size_t,		bytes_alloc	)
>  		__field(	unsigned long,	gfp_flags	)
> @@ -32,6 +33,7 @@ TRACE_EVENT(kmem_cache_alloc,
>  	TP_fast_assign(
>  		__entry->call_site	= call_site;
>  		__entry->ptr		= ptr;
> +		__assign_str(name);
>  		__entry->bytes_req	= s->object_size;
>  		__entry->bytes_alloc	= s->size;
>  		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
> @@ -41,9 +43,10 @@ TRACE_EVENT(kmem_cache_alloc,
>  					  (s->flags & SLAB_ACCOUNT)) : false;
>  	),
>  
> -	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d accounted=%s",
> +	TP_printk("call_site=%pS ptr=%p name=%s bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d accounted=%s",
>  		(void *)__entry->call_site,
>  		__entry->ptr,
> +		__get_str(name),
>  		__entry->bytes_req,
>  		__entry->bytes_alloc,
>  		show_gfp_flags(__entry->gfp_flags),

