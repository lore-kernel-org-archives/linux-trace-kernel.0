Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B0B197A9A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368651; cv=none; b=P8iv9TRSfoV9h6F2W6xc9dzIBnTmN7QtZqLvonQy3FnGIgniJeSgXLuQOgpAEvnn3ulhFMb4/0pARK+QQfwUdKX/Pa0DO5BT2ST4NA4cw40hZjnKtjgIpZUU90VL4guNKrq37QHwg2CM7hFA5s5mp85P2r9oXRlSQepRaAUfKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368651; c=relaxed/simple;
	bh=13eghfT8yLaHx96wZhWKC7DsHhPBihpYadIGFzJ2Nwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVQR9GE8lCXk1AiZ/ASuEi4JCSw4ar4bJ1GcA2UTqSzs9bd/ylzjS2MDMbQlpbNLCroyPTf+hwXD7vhr8KwUo08yABANE0pDpWq1eFSmSHcAPqxYCalVKTw/ymgPBJc58g/6DsT2U8e270wfuyHRTnwt8tJ3+f8jr1WaY5536ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ToYbrV/T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToYbrV/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730368647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B7rUylMoiJ32y2mf0MmXQsKypLnMwGBu8KDma38hXgg=;
	b=ToYbrV/TfFc63j2jeJ9F8RQYd9kaB4vkJuiyzdPE5Su5YgNLovW5pY1VI1ZUHkag6BD6M0
	kiN6Zf/jqqTF/hVv//EbAKEAzYq1onG3A2AWpgmdGhVnJzW8ZE3cpIFpf/mLhRWOqJWBhk
	4nOYtVRXb9e+8+3Pk+cIZJ5+lO19NuE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-tT0Ot74WPeuu4qQBHdsl2Q-1; Thu, 31 Oct 2024 05:57:26 -0400
X-MC-Unique: tT0Ot74WPeuu4qQBHdsl2Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d95264eb4so405717f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730368645; x=1730973445;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B7rUylMoiJ32y2mf0MmXQsKypLnMwGBu8KDma38hXgg=;
        b=vLl/qEOfGlIqlpIP2LaGc7KbRC2uawEfWn3Z0Rmpoky4Ejjl7biBaiXuQOx5Yjcj8J
         ti+6iArU+Rn+BLUVeqKBsI4YPSm1Hys16n7CFkTShAyH9BaVq0wC6m7yOTjD1SsilZdJ
         CTM9AsHVcyFDTe6LkiLpccD0koxw0sraerhMYismiqvTMDBbVcVxFN7Bzprx6ZzwOhtG
         QMRLDxV5uY2b064vBqhwL5i3qC6SKH9NVPdvDrs075SX7uLetZQTOv2hOOlTMvuahbsH
         jxIBc/fYGx9U+9u1uQEUL4no1WT4PfTDUZdZCGk5iryYF0zC4yD4FEojXx2HN/dHuy+1
         aZcA==
X-Forwarded-Encrypted: i=1; AJvYcCXM2T7I63vbFhrLdTsusJzoEXe3bMSoHfrr9jHZrwiDFdoy5EltoMOwI5CJWfvGoMznwkDolXYKzETZmmTSW4vAX5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnkJozxiMfmIFJqrdb3jJbCHFvg1rYcXl3SZ2w+JJD893uDIyR
	iXzConOPRefsrBCq7Y/QEXZIbi/4X/o71XaWUlS47mr62y29FfJ1ltPeZuLMa2TNcXHQUIimNG0
	8cyFuIMdaw1C49qtWtE9qCiuWcWS9xpqfveFUQ5gAUOzbSeY0LHEsYJSyQD9vSatmCH/yVA==
X-Received: by 2002:a5d:6d8b:0:b0:374:c31e:9721 with SMTP id ffacd0b85a97d-381be906fb1mr1923997f8f.42.1730368644902;
        Thu, 31 Oct 2024 02:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB5YibDMb1v+9lfgYV8B9TgwSctIaUJV5dcpKC4opd7SH8qkWAYMYCwwnkwClMNCW9rRk/3g==
X-Received: by 2002:a5d:6d8b:0:b0:374:c31e:9721 with SMTP id ffacd0b85a97d-381be906fb1mr1923969f8f.42.1730368644438;
        Thu, 31 Oct 2024 02:57:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:ed00:7ddf:1ea9:4f7a:91fe? (p200300cbc70aed007ddf1ea94f7a91fe.dip0.t-ipconnect.de. [2003:cb:c70a:ed00:7ddf:1ea9:4f7a:91fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116a781sm1611441f8f.96.2024.10.31.02.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 02:57:24 -0700 (PDT)
Message-ID: <a774e13e-0616-4d96-bb51-bac0fcb2cb9b@redhat.com>
Date: Thu, 31 Oct 2024 10:57:21 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/6] arch: introduce set_direct_map_valid_noflush()
To: Patrick Roy <roypat@amazon.co.uk>, tabba@google.com,
 quic_eberman@quicinc.com, seanjc@google.com, pbonzini@redhat.com,
 jthoughton@google.com, ackerleytng@google.com, vannapurve@google.com,
 rppt@kernel.org
Cc: graf@amazon.com, jgowans@amazon.com, derekmn@amazon.com,
 kalyazin@amazon.com, xmarcalx@amazon.com, linux-mm@kvack.org,
 corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, luto@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241030134912.515725-1-roypat@amazon.co.uk>
 <20241030134912.515725-2-roypat@amazon.co.uk>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241030134912.515725-2-roypat@amazon.co.uk>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.10.24 14:49, Patrick Roy wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> From: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Add an API that will allow updates of the direct/linear map for a set of
> physically contiguous pages.
> 
> It will be used in the following patches.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>


[...]

>   #ifdef CONFIG_DEBUG_PAGEALLOC
>   void __kernel_map_pages(struct page *page, int numpages, int enable)
>   {
> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> index e7aec20fb44f1..3030d9245f5ac 100644
> --- a/include/linux/set_memory.h
> +++ b/include/linux/set_memory.h
> @@ -34,6 +34,12 @@ static inline int set_direct_map_default_noflush(struct page *page)
>   	return 0;
>   }
>   
> +static inline int set_direct_map_valid_noflush(struct page *page,
> +					       unsigned nr, bool valid)

I recall that "unsigned" is frowned upon; "unsigned int".

> +{
> +	return 0;
> +}

Can we add some kernel doc for this?

In particular

(a) What does it mean when we return 0? That it worked? Then, this
     dummy function looks wrong. Or this it return the
     number of processed entries? Then we'd have a possible "int" vs.
     "unsigned int" inconsistency.

(b) What are the semantics when we fail halfway through the operation
     when processing nr > 1? Is it "all or nothing"?


-- 
Cheers,

David / dhildenb

