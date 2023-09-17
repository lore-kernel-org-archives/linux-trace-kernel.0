Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07075CD13CF
	for <linux-trace-kernel@archiver.kernel.org>; Sun, 17 Sep 2023 14:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjIQOLj (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sun, 17 Sep 2023 10:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjIQOLJ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 10:11:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BAAED
        for <linux-trace-kernel@vger.kernel.org>; Sun, 17 Sep 2023 07:11:02 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31f7c87353eso701142f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 17 Sep 2023 07:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694959861; x=1695564661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iIK8KrcUKgh5UQCSYe1MCVGWo9nmkIhTMbVaXMG9OPM=;
        b=xcIY+bcjY3hDXY439dnrIpl5RZIhE04SUYxjuCQFDcKlo85Kcn88Vmo2474/pojIa5
         2vkVsAsVR9uWVSn7Ras+P/8/WoO5ijyMG+h0WAp0v8RSJFU9MkKuNCh/lXIsOwoHTgM1
         oncDnSLO9DG7/Jf7kEHZfueywQJj9u9i1h4mfzXdm43i3nO63TXpKhpPlKYZ3vgkpv5v
         4rsjuCOG/Pj/ravZsdaT/j36z2KADpCJfLJruDZqo1+04Hg1XdrYWniEec4KZZyadpef
         onaX5HwtwgdD4LjJRQLZOzFt6t4iBY2hUWkh7A2QJVQjwimykPLS81rGfkuQrZb0SiFg
         nCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694959861; x=1695564661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIK8KrcUKgh5UQCSYe1MCVGWo9nmkIhTMbVaXMG9OPM=;
        b=rIuJeyafUxzexKJgkvSTI+XPCUzOSPeovWaKnV1+GcV1CWvvhUTaKVl/O7Gpotlbdu
         7LFLYmIHtxLXPGiE17MVQtPTaZZOLh/IAzm67lZg+jAGvspYGbTJkFkDs5ZZx5fdYHpD
         5r6X2tvDeWpIm672c0yQShUPXAn6bFBE0pUg1DGBkY/FHqvq88hNwm502CMGmunOwiec
         vdyDgq2I0XNfdCy2IMDBQ4onHVc3xMpSW+D33vvZ9PFKCw2cMjyOD/qIiYgLUzJxYm8I
         eCBcR2FhD6TJiiYLjp71iaqFyjpG5XXutCn/Xz8jADDknba0wRscVpYYWg24ts2DqWP5
         9MJw==
X-Gm-Message-State: AOJu0YwXwbJeBMLQaEPojQ+TBSZ67K3alg75CkKn6nhnLrk04MUOW+Mw
        bj5wsS/TGcN+/ZXepPo9xv0j7g==
X-Google-Smtp-Source: AGHT+IF05yt+SS1h19dUi36BjWkETqgsFnNrdJeOH5lnXlR6pxR9iMLfNebUDG8HUbKAh14gGlGzpw==
X-Received: by 2002:adf:f742:0:b0:31a:e29f:5eab with SMTP id z2-20020adff742000000b0031ae29f5eabmr5187153wrp.7.1694959861090;
        Sun, 17 Sep 2023 07:11:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:9f43:3ca4:162c:d540? ([2a01:e0a:999:a3a0:9f43:3ca4:162c:d540])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d4d91000000b0031c855d52efsm9740257wru.87.2023.09.17.07.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 07:11:00 -0700 (PDT)
Message-ID: <6098915f-c5ac-40dc-80af-026891e92d4d@rivosinc.com>
Date:   Sun, 17 Sep 2023 16:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/user_events: align uaddr on unsigned long
 alignment
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Beau Belgrave <beaub@linux.microsoft.com>
References: <20230914131102.179100-1-cleger@rivosinc.com>
 <20230915115449.3d7103b841cd593d1a09a129@kernel.org>
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20230915115449.3d7103b841cd593d1a09a129@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org



On 15/09/2023 04:54, Masami Hiramatsu (Google) wrote:
> On Thu, 14 Sep 2023 15:11:02 +0200
> Clément Léger <cleger@rivosinc.com> wrote:
> 
>> enabler->uaddr can be aligned on 32 or 64 bits. If aligned on 32 bits,
>> this will result in a misaligned access on 64 bits architectures since
>> set_bit()/clear_bit() are expecting an unsigned long (aligned) pointer.
>> On architecture that do not support misaligned access, this will crash
>> the kernel. Align uaddr on unsigned long size to avoid such behavior.
>> This bug was found while running kselftests on RISC-V.
>>
>> Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  kernel/trace/trace_events_user.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
>> index 6f046650e527..580c0fe4b23e 100644
>> --- a/kernel/trace/trace_events_user.c
>> +++ b/kernel/trace/trace_events_user.c
>> @@ -479,7 +479,7 @@ static int user_event_enabler_write(struct user_event_mm *mm,
>>  				    bool fixup_fault, int *attempt)
>>  {
>>  	unsigned long uaddr = enabler->addr;
>> -	unsigned long *ptr;
>> +	unsigned long *ptr, bit_offset;
>>  	struct page *page;
>>  	void *kaddr;
>>  	int ret;
>> @@ -511,13 +511,19 @@ static int user_event_enabler_write(struct user_event_mm *mm,
>>  	}
>>  
>>  	kaddr = kmap_local_page(page);
>> +
>> +	bit_offset = uaddr & (sizeof(unsigned long) - 1);
>> +	if (bit_offset) {
>> +		bit_offset *= 8;
>> +		uaddr &= ~(sizeof(unsigned long) - 1);
>> +	}
>>  	ptr = kaddr + (uaddr & ~PAGE_MASK);
>>  
>>  	/* Update bit atomically, user tracers must be atomic as well */
>>  	if (enabler->event && enabler->event->status)
>> -		set_bit(ENABLE_BIT(enabler), ptr);
>> +		set_bit(ENABLE_BIT(enabler) + bit_offset, ptr);
>>  	else
>> -		clear_bit(ENABLE_BIT(enabler), ptr);
>> +		clear_bit(ENABLE_BIT(enabler) + bit_offset, ptr);
> 
> What we need are generic set_bit_aligned() and clear_bit_aligned(), which align the ptr
> by unsigned long. (I think it should be done in set_bit/clear_bit, for architecture
> which requires aligned access...)
> 
> #define LONG_ALIGN_DIFF(p)	(p) & (sizeof(long) -1)
> #define LONG_ALINGNED(p)		(p) & ~(sizeof(long) - 1)
> 
> static inline void set_bit_aligned(int bit, unsigned long *ptr)
> {
> 	int offs = LONG_ALIGN_DIFF(ptr) * 8;
> 
> #ifdef __BIGENDIAN
> 	if (bit >= offs) {
> 		set_bit(bit - offs, LONG_ALIGNED(ptr));
> 	} else {
> 		set_bit(bit + BITS_PER_LONG - offs, LONG_ALIGNED(ptr) + 1);
> 	}
> #else
> 	if (bit < BITS_PER_LONG - offs) {
> 		set_bit(bit + offs, LONG_ALIGNED(ptr));
> 	} else {
> 		set_bit(bit - BITS_PER_LONG + offs, LONG_ALIGNED(ptr) + 1);
> 	}
> #endif
> }

Hi Masami,

Indeed, that is a more elegant version, thanks for the snippet.

Clément

> 
> And use it.
> 
> Thank you,
> 
>>  
>>  	kunmap_local(kaddr);
>>  	unpin_user_pages_dirty_lock(&page, 1, true);
>> -- 
>> 2.40.1
>>
> 
> 
