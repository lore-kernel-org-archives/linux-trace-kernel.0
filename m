Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2502054F5;
	Mon,  7 Apr 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041469; cv=none; b=MnQTbLQpqkbX188uVk2dFXtBmbAlvyCbChqJv+OdW39EplA5GeD+5/NME5AHXbqnsapF10XA56yMkx7/RjOb8p+MzA9ZboABoHbyBL1MoybWB7U/zyY/mQBiqxFOYYdyNXtA+DHzHoElo2jptJFW4XtH3m3JbhaIvsLulx2sCIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041469; c=relaxed/simple;
	bh=H+CdtIhmID2/drSfh5+XjpR6UYF4Qy4pqbDGwhcpi1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9jz0wLafK1H229neCFx0nVLEirS6d8J4ehl5W/hx+lHLucXdY4kgE0k8t4/AZmNLgc9g4yWoaUkUiDm1WDPSyDnQ4Ih1LOJN78fz36+geekQjVLX0pT29kqwTxaIVhTu3f+CHgtkMmGMB39SnKRLXgk52BgPCCrlZ0VWDzCCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ4Z06Yg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ4Z06Yg"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2295d78b433so42647755ad.2;
        Mon, 07 Apr 2025 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744041467; x=1744646267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=v5r35eAB9xHFrwGXzgL7ZcsIMlZ9GDgOCNF5pC7M0bw=;
        b=IQ4Z06YgRYFcMsry0WbkmTmUUTG3A2dyY/IA69a1CS9EiYzy7tyGVE8m5kvPRtMxxT
         LiPGmm2ZlHdEXZsLo2rsLJJWVUOo8dDNe/cUXK7cMq5uN8Fo3lAr3JwAwWsg52ml/ENF
         do1EzN0Iu4jnEaA3LWM59BPV6Aa/g49N/xf4skn6GFqulJ/DgDNYR10JazbAf3xkSeQ/
         6y4OLXmXGkkypwc3ydBj+0+JiuH+coEIRXYkJaOyJWXiSdSkZU6WKlABQITP9Iyio/E2
         G/hoVQaS8T5zrqjPBa6BXWRMY4RlrVl1NZbORq8tn7/lxKvszQoh3dh8c1hE5oKQnjSW
         cqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744041467; x=1744646267;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5r35eAB9xHFrwGXzgL7ZcsIMlZ9GDgOCNF5pC7M0bw=;
        b=NzUiZdwhvK3zCbZau5CpexIP8dkSEN4z8tmStH40O2n3OWk7FhVaQqGGmgk6Bk19zc
         Wjt5qjyb6YyzfA3UJ43CTgIlzrLsZsrKDgWwerTuLAgYVJmOm+d7yhKdLULSwRZ+Z55d
         4D9sAibEIqd76ySoeUy7Ko+agNG7G8qcNkWazSFWltiq85TXLYDU0kaVVpy5elT8Fkx0
         Ka9X1Lz9KC+zkZBGh96QZcNKYPOj/ZijCRyNkW2qKqM+wKz7DIXQbV2neErEbldLRdIv
         dSSc/MjwTmCrdSzOgo0QH9HArZDA7/M8an+yni2unabvngnrbCFIAGdfdl0GTJVkxcO7
         uyww==
X-Forwarded-Encrypted: i=1; AJvYcCV870F6yqQVUoWFcIOKjzV+3OUF+Fd5OXcgkPR7xpxf+ukTycjAlSqDUJjE+I9dZ0iE8hitY5fGM5QkWCgwceZnbek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmAr1SHfC9d7Qm79Ivk+8Wg/EvsIVNVBU3xREKa0siv/2NKNXL
	aDVQCDHXbPfioY3jPMuolri7IQA3yaZiqdyZ9Ll8cIfm7Y5jU5Gu
X-Gm-Gg: ASbGncv9BqvmzlepeNlzVfm4d3dUY45G6UwLINfAVvykMMeeiLqLyLM6xXMqDDYdpQJ
	ts59s5WBfSCnuZolOumeMgCtELL7Mca1yy0IZhuq8udgXWOQeEwwXOEu40KtryomlDZQq7Q1KaA
	pC3gpbB2GbGWVgiO/e4pLfw/TwOGGW68Mg6YJ488I/vP07T9yPFXJ9g4t2w6RMMihZ4lmjm4W7U
	5YneCtPa5NYCYZRVK/BIKrdxqNXHrkUpUtuEA3G0IjkBrmfE1l8PehkrHZYKurmJ3pPlP/06KAE
	82blW1M10b2cjNlCH1MsP+y9r/8jbzwCEqJ+keOTwqyoGvuujCNXkgG4k4/zIH7255hiPeA3VRD
	GMseNlL6/PztUhYZp+WCmQxB9S5Fu
X-Google-Smtp-Source: AGHT+IFBRwllDf9K+EOnjhqcFFxAPq/2hjZGxCvm4B7YpsWaiJHVT4hb0raWmhns3hpBw+Rx3nS3Sg==
X-Received: by 2002:a17:903:246:b0:223:faf5:c82 with SMTP id d9443c01a7336-22a8a045fe5mr152539315ad.8.1744041466969;
        Mon, 07 Apr 2025 08:57:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c27b3sm83336955ad.97.2025.04.07.08.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 08:57:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2c0b957b-3a7c-4607-9a8b-79fcbf7297c8@roeck-us.net>
Date: Mon, 7 Apr 2025 08:57:44 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] tracing: Use vmap_page_range() to map memmap ring
 buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Jann Horn <jannh@google.com>
References: <20250402144903.993276623@goodmis.org>
 <20250402144953.754618481@goodmis.org>
 <4f8ece8b-8862-4f7c-8ede-febd28f8a9fe@roeck-us.net>
 <20250407112352.264e12b0@gandalf.local.home>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250407112352.264e12b0@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/25 08:23, Steven Rostedt wrote:
> On Sun, 6 Apr 2025 10:39:27 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> non-MMU builds (xtensa:nommu_kc705_defconfig):
> 
> Bah!
> 
:-)

>>
>> kernel/trace/trace.o:(.init.literal+0x250): undefined reference to `get_vm_area'
> 
> Does this fix it?
> 

Yes, it does.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index b581e388a9d9..8ddf6b17215c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9806,6 +9806,7 @@ static int instance_mkdir(const char *name)
>   	return ret;
>   }
>   
> +#ifdef CONFIG_MMU
>   static u64 map_pages(unsigned long start, unsigned long size)
>   {
>   	unsigned long vmap_start, vmap_end;
> @@ -9828,6 +9829,12 @@ static u64 map_pages(unsigned long start, unsigned long size)
>   
>   	return (u64)vmap_start;
>   }
> +#else
> +static inline u64 map_pages(unsigned long start, unsigned long size)
> +{
> +	return 0;
> +}
> +#endif
>   
>   /**
>    * trace_array_get_by_name - Create/Lookup a trace array, given its name.
> 
> 
> -- Steve

