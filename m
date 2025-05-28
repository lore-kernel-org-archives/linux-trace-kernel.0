Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F472CA8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423177; cv=none; b=IJyB8YwXttVLSObvF1cS4py47/7DzfYui8KpttKgYgOP5PLmJDqvS3c+kvZSvdOQ0zDixoixvlWm3tCKQ4Fi3GQuVnq6Umlka1aMv8ga3tT16F1kyKrQ4bosiv99DsyrF6aTc9BseAAOEQBFz4rvyMsmQhFJx4yFtr7FxuP1h98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423177; c=relaxed/simple;
	bh=uMd7vvtHClvbK/XR9D4ur3jM2f+3IfWm3Bv1Ja3tbbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4tG8AqetdhEUliavle0f5pxw1kj02Gfox9vPfkuKcCz/Qhq9+29u4xXrPHefatHbQvVNCCpGT7uFcntZm8hjEYVVSo9D42oasK5aAtc1cLha9ZxIHiLEw9mkM4erKXm4ixD8KCUebxYsySjkr0TO/DPSLMI6x4bZs0DYiWL6iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTe9S5/V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTe9S5/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748423174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yPtp4BVlfZsRur8/3HKaTK/1oayZ+9mURRHo233+dpk=;
	b=TTe9S5/Vy/yhNk69KThzptuou9GPQ6PHsBRpok7vFVMa7jOWaKfii7yACY5UdEag5yK73l
	xBw8IBKx9Yh6BVNt0t2vSu+wiUDJ5GGwdZeqbQrM1SlTNg7lQX5H8iOQiKx+lbXNfN9DBo
	FMC18TgB8pA9S/Nl/wslvZms5Vd4JUw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-tbIM62gXNlq-pP07_l6qyg-1; Wed, 28 May 2025 05:06:13 -0400
X-MC-Unique: tbIM62gXNlq-pP07_l6qyg-1
X-Mimecast-MFC-AGG-ID: tbIM62gXNlq-pP07_l6qyg_1748423172
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a367b3bb78so2470980f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 02:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748423172; x=1749027972;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yPtp4BVlfZsRur8/3HKaTK/1oayZ+9mURRHo233+dpk=;
        b=LAnsUKfUnzyoICiWRvmi41l3jPw3IWS5CdcDyT02rb4l5YvGSOQw0s2c/ZFEWgFYVO
         VwtHHina65dws9OhsqiUYB1X5BBhhHxZII9cGebrGqCsApzJK07Amk6LsCuGmeR/Iq02
         aGi/J1KUy8D6OKSM9dYVsFdm7bED7O4+usgfd8jm9p9J6z2/3YlySk49FJ5vqGZCw0p/
         sy95QLE6FV5BDqDMG6j1WrCCc1zM7+j2DhAABwV2sbDq9sZsdbUM3WKGxALhICT0RDtA
         ehMLtqmWW7AD/2SvxVwFuCN5lHzQMqSlep9AgL3sdOY4uyvtGxdUfajz0qg/jpRvsxhh
         z+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWsNvIrUMpQIMZbQL4x/weMWQOxcYebSwejAt2+PXBjkpSOj/icSUJ+2hSLflDM2mBgLK9nbCGXTI+Yyss00utApas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6TjICNbNFfDi8KIYyefbD7cnnr7ZqUXLCxJiy7gbJRIVuoCzB
	GRLVIA4e9srP3k9m/F9h+0oRe2CTXA1Nc0F/cpGVyH7+/ZSczGS3VGyV4S/Cpp1w9j9maBUw9I1
	h6xUfL6BgDuyk4KF6quoDpPoki3vQD816CSpYwUfr0zUBjrEK5xGxMeiRwLgEw+bvqy6RlKr+mg
	==
X-Gm-Gg: ASbGncvJjGhjYT1foN7ZF18ePeT8w1FOTRvogrgJv5riZUjqiRO0T6FuAK5NLzlS5IP
	vqJ/0JT5BnPhur9GISiarztHxDvZH69TsjlYkLcmNt2NZG1c6HwHLaUWxpi8wQSKNjOVrTb1FZv
	B8tFdpZltufNWmoroqncZa3b3E6ACbDkJJAm8ldVgtXEuFLmMjR6HpSVRsjnplpWJAES/t1SR9q
	LG/AG4JgpN3FCbJo2ENLfCA2jwWMNfM1T5tIJV7PureuaX2hwIATTSD7JoIfsVpx1Pp5AgVQw78
	XJeoKrCSy/gQrR1Q7oBYi669iXC5aWoc3KFj4tCXFxBALPB2PVEifboP9wlaW6fjNBM1quZR4bs
	6e9xPo2FlAASxPIwrZdliwUcT3Fr1F1fmCO5HZ0s=
X-Received: by 2002:a05:6000:26d0:b0:3a4:e4bd:1b27 with SMTP id ffacd0b85a97d-3a4e4bd1c83mr3907318f8f.54.1748423172263;
        Wed, 28 May 2025 02:06:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNHqCOw0QGd8W0A6TOY7dtBnKuUBRtv0uNloTLnvRnPNgfBlftkrP2fUjm4+kQAzqv5GkdyQ==
X-Received: by 2002:a05:6000:26d0:b0:3a4:e4bd:1b27 with SMTP id ffacd0b85a97d-3a4e4bd1c83mr3907286f8f.54.1748423171762;
        Wed, 28 May 2025 02:06:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36? (p200300d82f30ec008f7e58a4ebf06a36.dip0.t-ipconnect.de. [2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eacd7cc5sm905044f8f.73.2025.05.28.02.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 02:06:11 -0700 (PDT)
Message-ID: <876f65d0-e873-4c08-b404-db89e542e7a3@redhat.com>
Date: Wed, 28 May 2025 11:06:10 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/tlb/trace: Export the TLB_REMOTE_WRONG_CPU enum
To: Tal Zussman <tz2294@columbia.edu>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250528-tlb-trace-fix-v1-0-2e94c58f450d@columbia.edu>
 <20250528-tlb-trace-fix-v1-1-2e94c58f450d@columbia.edu>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250528-tlb-trace-fix-v1-1-2e94c58f450d@columbia.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gmpjFG1QKBpQYfud-9ZsEjlrCcxJOmNGyvMWDc3_mhQ_1748423172
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.05.25 07:35, Tal Zussman wrote:
> When the TLB_REMOTE_WRONG_CPU enum was introduced for the tlb_flush
> tracepoint, the enum was not exported to userspace. Add it to the
> appropriate macro definition to enable parsing by userspace tools, as
> per [0].
> 
> [0] Link: https://lore.kernel.org/all/20150403013802.220157513@goodmis.org
> 
> Fixes: 2815a56e4b72 ("x86/mm/tlb: Add tracepoint for TLB flush IPI to stale CPU")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   include/trace/events/tlb.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/tlb.h b/include/trace/events/tlb.h
> index b4d8e7dc38f8..725a75720a23 100644
> --- a/include/trace/events/tlb.h
> +++ b/include/trace/events/tlb.h
> @@ -13,7 +13,8 @@
>   	EM(  TLB_REMOTE_SHOOTDOWN,	"remote shootdown" )		\
>   	EM(  TLB_LOCAL_SHOOTDOWN,	"local shootdown" )		\
>   	EM(  TLB_LOCAL_MM_SHOOTDOWN,	"local mm shootdown" )		\
> -	EMe( TLB_REMOTE_SEND_IPI,	"remote ipi send" )
> +	EM(  TLB_REMOTE_SEND_IPI,	"remote ipi send" )		\
> +	EMe( TLB_REMOTE_WRONG_CPU,	"remote wrong CPU" )

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

