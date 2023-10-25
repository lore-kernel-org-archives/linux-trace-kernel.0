Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242A1273D3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fBonVWPW"
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C49132
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:26:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9fa869a63so36719665ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698233204; x=1698838004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDHj8oJ2Uz1cmUueWdlI4KjOLBnm0yM7e81hC7jLmlU=;
        b=fBonVWPW5HE86+KsFZdWKjAki1AOQBbiKH067hD5JuRp4tyCOFn3T+23jowrr2hzuD
         VJ2nNZPoBHc6Mj8uW+HgL3kTnAZs299GjYZHCRC7WeWdSSB/2dguSJ0dOD5ibHjR5l1h
         SViyxgI7yYFAS4Y/Oq9fexA1W0iF1KNukQVOrLdvj7pgkN1Yh2ZMQ+RH8R0qLJmwbNqR
         zqyeHFfqtzr7F+x89aFHYMoQhqxx6fFvHwDAumuAxqno0vqgTFAKHNQ8+I/Hr/lpaBHs
         Yn6jU7kdzLe1ZNrBc0tfeK9gGj0AL3u3b6oMFEBJ88gOJO69lvRtBB813RxI0MrFcJlJ
         JFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698233204; x=1698838004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDHj8oJ2Uz1cmUueWdlI4KjOLBnm0yM7e81hC7jLmlU=;
        b=ggG+kHo8GWWRJ6l7pNX0lG585CR1sQFP8kl5lVUGV/z9R/Jf85gEGROl13G5dDoWVx
         ADbvjw/LF/gHQtMiNpU7J5tWoeFxu/XBiBJEQrSz0BhJ9YCMnszDe+8I+lBg2YC70ZNA
         Rd4Ru3KwQb4jw3/KTIK8euULm8V4U7K7+0cBKCSXxU4gy5pr6pg68WS0wkZXSpOI/V2n
         Sk3EcUU8ZUudm3kGRMTJcrBip2yeuYXz9u6yFQmvS4pHY8w7aMHUfwwcMxp9kktSpeYx
         O82MbEUgPH/YxQP+HfcnTSG2SC/09h83Mc8I3qAOIiri/WmtKC0TVQjV44QYEGIWZG81
         MQjg==
X-Gm-Message-State: AOJu0YyqbPMXedOJtywDNGdYcy5+TOkzlSaRGQg+Q8N5ZFt1FLnHwxbJ
	wzmzADuIXYbWQ/YwaRqSXlLbxw==
X-Google-Smtp-Source: AGHT+IHqc2uphs07Xxief3RuxCddj2AvBcvevNUlL3pWyEdSMiy37da9YdaHmnpww9QQ9NcGW+Sd0g==
X-Received: by 2002:a17:902:d312:b0:1c9:e072:33a6 with SMTP id b18-20020a170902d31200b001c9e07233a6mr11401819plc.40.1698233203816;
        Wed, 25 Oct 2023 04:26:43 -0700 (PDT)
Received: from [192.168.6.6] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b001b8b2a6c4a4sm8992566pli.172.2023.10.25.04.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 04:26:43 -0700 (PDT)
Message-ID: <560f1066-cefa-2ed9-e4f6-992096e11fda@bytedance.com>
Date: Wed, 25 Oct 2023 19:26:37 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [External] [PATCH] locking/atomic: sh: Use generic_cmpxchg_local
 for arch_cmpxchg_local()
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <169815917362.8695.13904684741526725648.stgit@devnote2>
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
In-Reply-To: <169815917362.8695.13904684741526725648.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/10/24 22:52, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Use generic_cmpxchg_local() for arch_cmpxchg_local() implementation
> in SH architecture because it does not implement arch_cmpxchg_local().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   arch/sh/include/asm/cmpxchg.h |    2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
> index 288f6f38d98f..e920e61fb817 100644
> --- a/arch/sh/include/asm/cmpxchg.h
> +++ b/arch/sh/include/asm/cmpxchg.h
> @@ -71,4 +71,6 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
>   				    (unsigned long)_n_, sizeof(*(ptr))); \
>     })
>   
> +#include <asm-generic/cmpxchg-local.h>
> +

asm-generic/cmpxchg-local.h defines only 2 routines: __generic_cmpxchg_local
and __generic_cmpxchg64_local.

Shall add the definition of arch_cmpxchg_local into 
arch/sh/include/asm/cmpxchg.h, or group arch_cmpxchg_local and 
arch_cmpxchg64_local into
asm-generic/cmpxchg-local.h ?

>   #endif /* __ASM_SH_CMPXCHG_H */
> 

