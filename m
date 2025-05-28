Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB4C274651
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423198; cv=none; b=tIh6nQR36X05Od/b2H8QMZE8VMXVIIMvx0heOC3Jos4vTNFsLGmdN5pAuRPqQH+t8PHB5T8C3LjctDQ9iDx0SnmKndcxrbIle8jgya3NF/O7WYC5elPshIPGxVGFZS2gbGuERPXYlzJnrPH8D+sCprnHJVFzj+rk+0RgN/xrBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423198; c=relaxed/simple;
	bh=4TvTmbiWXB5FhroHsvlg+K8JZ75ZnMsD85mUMetTHRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZiX1ubgRGwqaNb9waQ3DEfL9GJQWK3iwHBADOMrQXzCZTopQku6FVLijR+hotZ3BerlksT84kqG3XTTdiH7TYro/v+iqRHNyaWDEZFrCSEqvFQEWR/qvoAdsA/RJJkk2uWTwLHz2VWZ7mntSv8yl22QFUhEhohP3m/TO0Y7+tX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtpYYOC1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtpYYOC1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748423195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0jNfWBnNwI4vmCYyyWkZIC0z1gNt+R1x0CiFYOJERUE=;
	b=gtpYYOC10+bH8TOE0RfnYrz+ucxSzh8VOokCfeGSHWwId8KlnF6qtJyxpRlI6fb4Px7ciq
	35x12nDjCSktc6kvIvM7FmoBozdnXNc/VGmMQ7/cB97KwL35qQYv7dDGuxkDyEjj+cGyAx
	SN8lTLWijfVns1dGOo94JpV4ORsaolA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-qtLQaukyP8GXZfYTtBN2Zg-1; Wed, 28 May 2025 05:06:32 -0400
X-MC-Unique: qtLQaukyP8GXZfYTtBN2Zg-1
X-Mimecast-MFC-AGG-ID: qtLQaukyP8GXZfYTtBN2Zg_1748423191
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so25371275e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 02:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748423191; x=1749027991;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0jNfWBnNwI4vmCYyyWkZIC0z1gNt+R1x0CiFYOJERUE=;
        b=AvXaEXAr0PxizTdZ0QAOW+45sDRJUKgNmnHlfBTS01IEAoTB5bdkvbYDMamk3UEWuR
         7IYzokgkxbKpT/w/BAO4XNtEjsEVqtFIquQL8a6RR0jsx0p05HYkxdBQu61QjVgQrIrn
         hfGejMqCD3FBXQW9Ysm53t7swk86pnjScI+/NrdDWTkjZZmH17HbqIecp/CrwyixsWPL
         gsht727Qr2dNOkQSxMnO9TYVOZ0DacSJ9+x91QIGooLFWQ7NRJTFyHX5sWnXLO4gzgj+
         hRP5V34NF5Q/ZJ4VaQP84/qIrsZelbkSrhQJy9fLeCaJeUYVdfKbkUhj3TExchgq0dGs
         J4Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVaNHF0tpNlAT4KKZOaf6HCEqzcoA59bguL60+4MjwwOhOP3IqRHLOuwU3nhWF+TL0FPvIshVKIreidLAFvsDlELz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyJHvvUhkZ4XlvOfuo7LxXKWF4l69XCzqvGch8linO04X1JpT1
	KNq6SjH/USQfqJ4x7VCJHOOjaRM8eyL4EBcdgHEHl4k80TXmzuS2LarRPy1n4fvPuTpuINj7ec0
	LV6Btb0lutFt2CBxep789amPHLX/LQMDscA6wDz3jPB4oFlNcqPt/g4CeaR+BtCx/PxmnLRd+CA
	==
X-Gm-Gg: ASbGncvzm3Pr1THOzyYrowEo2+5r5gKzS+1+qKGXd7Ix137QxlXYXGZSaUj6eyyR/5q
	q0sS8FT4cPuinBm1i7ZwYM463opAdS1SIKqh8iU3NhMwVz2E4yl5Unbv7az4Q4EQKAitKPiY+iH
	uCNuopUAR3xAKUXqYZUaSPkuTVE8PrqmVgVsecEgT5bJyuwuxyGsFvXa4DMU2zDRFrdVyDE3GbN
	NDBEhJE/hEwV6rmzaCZ8YATE0uYpXbaboesBoFP+A3k2u5UvlZJmc7ugnqx9ppGqWnQqz/bDzt+
	Bzap3NmvkyYiwzglGmMclApoCyjCpsK7+I2H/WDQ3t8AD1Vrul89Zbk2bAzARQdx4DVy2uBPEZb
	bWVoowGujo++1JT2JKP2P+zu/+ZlE2QfjOteH4NY=
X-Received: by 2002:a05:6000:1785:b0:3a3:63d3:369a with SMTP id ffacd0b85a97d-3a4cb4602a6mr11987347f8f.25.1748423191187;
        Wed, 28 May 2025 02:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFS2yw6ICITHixIjXBzRYXeXOzAPyp23fKYDFoE4S3dOHqpW1SBJwXLDvJ8JMJEkqZ76misw==
X-Received: by 2002:a05:6000:1785:b0:3a3:63d3:369a with SMTP id ffacd0b85a97d-3a4cb4602a6mr11987314f8f.25.1748423190772;
        Wed, 28 May 2025 02:06:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36? (p200300d82f30ec008f7e58a4ebf06a36.dip0.t-ipconnect.de. [2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eac7d7a7sm889461f8f.21.2025.05.28.02.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 02:06:30 -0700 (PDT)
Message-ID: <23fc6556-6578-44ba-8443-84adecc29d24@redhat.com>
Date: Wed, 28 May 2025 11:06:29 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: Remove tlb_flush_reason::NR_TLB_FLUSH_REASONS
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
 <20250528-tlb-trace-fix-v1-2-2e94c58f450d@columbia.edu>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250528-tlb-trace-fix-v1-2-2e94c58f450d@columbia.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pt4nCJjo9EiUM_OGJiPNiqXfnpEOgRjhg8nr8rBscsw_1748423191
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.05.25 07:35, Tal Zussman wrote:
> This has been unused since it was added 11 years ago in commit
> d17d8f9dedb9 ("x86/mm: Add tracepoints for TLB flushes").
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   include/linux/mm_types.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3e934dc6057c..8b91362fcf8e 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1539,7 +1539,6 @@ enum tlb_flush_reason {
>   	TLB_LOCAL_MM_SHOOTDOWN,
>   	TLB_REMOTE_SEND_IPI,
>   	TLB_REMOTE_WRONG_CPU,
> -	NR_TLB_FLUSH_REASONS,
>   };
>   
>   /**
> 


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

