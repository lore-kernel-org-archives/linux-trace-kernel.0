Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968C8EEAA5E
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 14 Sep 2023 17:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbjINRm3 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 13:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbjINRm2 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:42:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE0A1FDA
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:42:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40472fef044so1848875e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694713343; x=1695318143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DLq4gTAMQUNXxLZTkpUDOrOkY4rGIcpbYoF8xB6HKFM=;
        b=Vc8ROuAzKtDKViQooBc3/JQbBm8sCF8iNhPbABsLwRct3315512ou757YC1cXa722b
         1nabBHNemIIDMWweXrljIynnU6PhxHfqW4O9/nJY14UFAVQ5ZkiW6gTKNardlRVtNM7t
         K+8W+g2Twyk+DtNvG3u7xqeHRAVvPjCZ1/I5Z8LwqcZyqOXUA0YV9RWujt8o4wHWixpE
         P63uxQ+l0Fpqyimz+S/jCCDz9H9DqGT0G98H6YWjoVRaBtNc4DyWlZrsNTHuTFfF+6gy
         LSpuOA1lCd8yWoEd7GmPaoP5WjSU9kPU2OZGzQVh7CVk1UXaXGn1grqnYZya1fFukm4C
         mQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694713343; x=1695318143;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLq4gTAMQUNXxLZTkpUDOrOkY4rGIcpbYoF8xB6HKFM=;
        b=Ev6TXm4otEHh5xBjpsbxD99zEsjiepdFkd1MBBZFPlad6gXrXfVdigh6bQMVYfea/K
         cgaV1ir9mWdUG30iSIiym/6VPIbqfiz1S6ioUEnd6pPRX4qrSjYfYTCbwomshEwEQXV6
         70wOngwZqDK8BJcpIuGpzixusbVo2pRGaqEPsj+STKzloALvtOxuwjT/nNA2JICxl1Pc
         m8aJUkJnU+3ejJK+gp99C//ktMA36Ldfnv/t+Tba/MU0oKyxrWdRrp8Chq4BBYABscTb
         IFpt0zFPneAQoULN/j7jbPnQWrCLwH/00rKelqySZ/9i6kXjhTwOLytwa6YEn2Ead8z7
         8Ohw==
X-Gm-Message-State: AOJu0Yzeeq0DuGX2p0ri1IsrozxVIPOWLowPTwDe/ODEbvMD1MVuRxdK
        KDLSyM4rO13Y6eNlUM4nTPM1YA==
X-Google-Smtp-Source: AGHT+IE6BPY12TchbzdXQm6qGz00ZV9M74r4RAvvvVEipM5FQl50j/cEJCYPGVhHTu8HXSsmHvI/Vg==
X-Received: by 2002:a05:600c:1da2:b0:401:7d3b:cc84 with SMTP id p34-20020a05600c1da200b004017d3bcc84mr5350644wms.0.1694713342992;
        Thu, 14 Sep 2023 10:42:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:9f43:3ca4:162c:d540? ([2a01:e0a:999:a3a0:9f43:3ca4:162c:d540])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c020700b003fe2de3f94fsm2526696wmi.12.2023.09.14.10.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 10:42:22 -0700 (PDT)
Message-ID: <8bf013fa-0fa8-4ebc-9776-0cd6c134972e@rivosinc.com>
Date:   Thu, 14 Sep 2023 19:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/user_events: align uaddr on unsigned long
 alignment
Content-Language: en-US
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230914131102.179100-1-cleger@rivosinc.com>
 <20230914164218.GA450-beaub@linux.microsoft.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20230914164218.GA450-beaub@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org



On 14/09/2023 18:42, Beau Belgrave wrote:
> On Thu, Sep 14, 2023 at 03:11:02PM +0200, Clément Léger wrote:
>> enabler->uaddr can be aligned on 32 or 64 bits. If aligned on 32 bits,
>> this will result in a misaligned access on 64 bits architectures since
>> set_bit()/clear_bit() are expecting an unsigned long (aligned) pointer.
>> On architecture that do not support misaligned access, this will crash
>> the kernel. Align uaddr on unsigned long size to avoid such behavior.
>> This bug was found while running kselftests on RISC-V.
>>
>> Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> Thanks for fixing! I have a few comments on this.
> 
> I unfortunately do not have RISC-V hardware to validate this on.
> 
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
> 
> I think for future readers of this code it would be more clear to use
> BITS_PER_BYTE instead of the hardcoded 8. Given we always align on a
> "natural" boundary, I believe the bit_offset will always be 32 bits.
> 
> A comment here might help clarify why we do this as well in case folks
> don't see the change description.

Hi Beau,

Yes sure, I'll add a comment and use the define as well.

> 
>> +		uaddr &= ~(sizeof(unsigned long) - 1);
> 
> Shouldn't this uaddr change be done before calling pin_user_pages_remote()
> to ensure things cannot go bad? (I don't think they can, but it looks a
> little odd).

Indeed, I don't think that will cause any problem since pin_user_pages
will return a page aligned address anyway and that aligning uaddr will
not yield any page crossing. But I'll check to be sure and move that
before the call if needed.

Clément

> 
> Thanks,
> -Beau
> 
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
>>  
>>  	kunmap_local(kaddr);
>>  	unpin_user_pages_dirty_lock(&page, 1, true);
>> -- 
>> 2.40.1
