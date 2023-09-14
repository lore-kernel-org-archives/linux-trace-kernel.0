Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75C5EEAA5C
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 14 Sep 2023 17:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbjINRco (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 13:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbjINRcn (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:32:43 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEC31FFA
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:32:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4046f7d49a9so2579865e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694712758; x=1695317558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NIcgENX7e2e7T7UAPxVNsw3jDCyvIv8ff6aQ3AhHiGc=;
        b=MkSqlnaHepoTr+Hjf/5V7ynsEhlfVHcb5UovHDOrDG8prr0MN4Lc+MVfWHpTW2b1Ye
         ikue4EfPQNEc9K3cAa6DdJR8FyzE/wCei4qprjr1xL5rhFi0Mm/BkqwwLPOl9XudxylJ
         Tnl7KWTgx2uuq3w4VYiQxwjLAzjGf1CCgQEgRrvRKjh4zQcpsrU2y9VE2S2qXheilg91
         DU3HXrXNfUjFDwEHZVjHzQiLqIRzpE4isll3E6Toqfpq2rgX0MRSa40scaUARkobu7Z/
         DYxRU246xWKoaWcfVstT0lxaNJRuVjQPPM1ZnDStimsEjQlIqT+/AKUG06lfkDHr2yvD
         YmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694712758; x=1695317558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NIcgENX7e2e7T7UAPxVNsw3jDCyvIv8ff6aQ3AhHiGc=;
        b=MD/8HyBNj+t1E3Wkurj2/jPKkFN73BbMGpmZsIry+nH30GaY8JJEgwb3OML+lkizjR
         OkPpXcs9f9KXNMgfM9pDjQzInRkRnXydyOPJ0O84WvAEZ8csGgGk8607BTqgCE+Q8qUX
         JPWjT8NLtxqo+ID7iv09iKqGT1SUZCdzVddlS+QkEnAVOgjBvMaQGyUcEcwxLynU3ReD
         aSYn8Wl45URzWLRQsimpPTpsEu+Lyc3q+kBjjrIm/BFkkU6yFZSlOgJeFvBtgNjTP1rc
         Oo7yWD/LYqtnJHh1xdM9f8k/34EBsQJ9OtQCBubTMmgHamBOIQIarWZmqjhPHeYZTOna
         k1GA==
X-Gm-Message-State: AOJu0YwptgFBVaQI0NQqdf5FLjbLM3HCqZM57eVsxr9+q7np+E1ibE6g
        jQpFW8fMsX+6sUtUqYOOcdv8jQ==
X-Google-Smtp-Source: AGHT+IEqIVJX+CNjKGy50laq3XjUoP6KTYYjJAvaLKEMt33y1ybi3gEJ/x3twhrlaDVilnhjwjVvjQ==
X-Received: by 2002:a05:600c:3c8f:b0:401:faf5:85c3 with SMTP id bg15-20020a05600c3c8f00b00401faf585c3mr5372619wmb.0.1694712757702;
        Thu, 14 Sep 2023 10:32:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:9f43:3ca4:162c:d540? ([2a01:e0a:999:a3a0:9f43:3ca4:162c:d540])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c220700b00403038d7652sm2535191wml.39.2023.09.14.10.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 10:32:37 -0700 (PDT)
Message-ID: <1fcb00f4-f8b0-4c98-88d5-16895066d222@rivosinc.com>
Date:   Thu, 14 Sep 2023 19:32:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/user_events: align uaddr on unsigned long
 alignment
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Beau Belgrave <beaub@linux.microsoft.com>
References: <20230914131102.179100-1-cleger@rivosinc.com>
 <20230914131700.0ba3ee80@gandalf.local.home>
 <20230914132956.569dad45@gandalf.local.home>
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20230914132956.569dad45@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org



On 14/09/2023 19:29, Steven Rostedt wrote:
> On Thu, 14 Sep 2023 13:17:00 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> Now lets look at big endian layout:
>>
>>  uaddr = 0xbeef0004
>>  enabler = 1;
>>
>>  memory at 0xbeef0000:  00 00 00 00 00 00 00 02
>>                                     ^
>>                                     addr: 0xbeef0004
>>
>> 				(enabler is set )
>>
>> 	bitoffset = uaddr & (sizeof(unsigned long) - 1); bitoffset = 4
>> 	bit_offset *= 8;				 bitoffset = 32
>> 	uaddr &= ~(sizeof(unsigned long) - 1);		 uaddr = 0xbeef0000
>>
>> 	ptr = kaddr + (uaddr & ~PAGE_MASK);
>>
>> 	clear_bit(1 + 32, ptr);
>>
>>  memory at 0xbeef0000:  00 00 00 00 00 00 00 02
>>                                   ^
>> 				bit 33 of 0xbeef0000
>>
>> I don't think that's what you expected!
> 
> I believe the above can be fixed with:
> 
> 	bit_offset = uaddr & (sizeof(unsigned long) - 1);
> 	if (bit_offset) {
> #ifdef CONFIG_CPU_BIG_ENDIAN
> 		bit_offest = 0;
> #else
> 		bit_offset *= BITS_PER_BYTE;
> #endif
> 		uaddr &= ~(sizeof(unsigned long) - 1);
> 	}

Hi Steven,

Nice catch ! I don't have big endian at end but I'll check that.

Thanks,

> 
> -- Steve
