Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D259CD5BB3
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 19 Sep 2023 12:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjISM7X (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 19 Sep 2023 08:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjISM7W (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:59:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CEAFB
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:59:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40471c054f9so16732735e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695128354; x=1695733154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s30L8Cd9UzT5Qqd3APHlIpNbIqrTMch8rb7FXz6oEhI=;
        b=GGCuQYbR0sqSN8gMIK1rrmrslsY0AEsdWKMwU2iStsyAHo54B6zKKn4IIdugmar6Ry
         uAJLPoMU7ZwRrfQEKLrFFjDak6ttB2KZMuGRtwodtvpOpD92iKIKBTAKrV1mSe4V2Bq9
         evMnkSUlWc8NAQ2KRXYjpUuK75J3avedggEEoro/UuA1OeflWqfY1A+oUWU95PQdPggp
         V17eYSRP1BPvqYwyxk3UaB48eK/IDviY6xg4vGOm8n6W+E+m8dmMAAAXlnBLDCqXgVaO
         ppx9y+agImslJeTv5ihR7VYmNgYWeEYbAHqJHzti6AlnkIORXRE6PIXTWbbh7zxY3MVN
         +ZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695128354; x=1695733154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s30L8Cd9UzT5Qqd3APHlIpNbIqrTMch8rb7FXz6oEhI=;
        b=qpiHmdwhHMMgJ/kGlkdyIYHycq9IyXTzV/9kFY3L9arsabRCGry+NQvwvrW/NM/KyZ
         ewk70GAixURVeKR4vpw8POJBhWDNQXFrZR1TTBk+gEXw2/WNgQiEOKVMTySeXNC8LUMM
         aquZdYDKOBpVDUttnhd2IRgCJao27HMxE33wcnJxW6++4r8Rx4+c7gGNZch1BJYGKHrB
         kZrounX+Bx6IovEuqbu628giSDKm0Dh/W0WZErgHtl8My1+3aFc366owLBm+fMpqDFvn
         Wexohm25/WhABHtbqs5cIQbzRycTfqBxwxrbd+9DvoTnRoKOqksuAprm1J3DXO59gVqV
         ebNA==
X-Gm-Message-State: AOJu0Ywm9Lb0tQeWP+tjlp+ytlPIuya8UhkkCJscnzD7zhOzJnGnDO/5
        QdzsQjOWDCFhVk4F8VFfg1zSDA==
X-Google-Smtp-Source: AGHT+IGVQy19vIMTiJYvnoh5+6oLkQCMGnegXStutS/GrrVLDcaqm6TLJny/0NcWOwJmQ2RfX47BZw==
X-Received: by 2002:a05:600c:1d04:b0:401:c07f:72bd with SMTP id l4-20020a05600c1d0400b00401c07f72bdmr11470022wms.4.1695128354198;
        Tue, 19 Sep 2023 05:59:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:e1a5:a258:2b02:f431? ([2a01:e0a:999:a3a0:e1a5:a258:2b02:f431])
        by smtp.gmail.com with ESMTPSA id l20-20020a1c7914000000b003fe29dc0ff2sm15353954wme.21.2023.09.19.05.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:59:13 -0700 (PDT)
Message-ID: <a736f219-9a38-4f95-a874-93e1561906d5@rivosinc.com>
Date:   Tue, 19 Sep 2023 14:59:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/user_events: align uaddr on unsigned long
 alignment
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Beau Belgrave <beaub@linux.microsoft.com>
References: <20230914131102.179100-1-cleger@rivosinc.com>
 <20230914131700.0ba3ee80@gandalf.local.home>
 <20230914132956.569dad45@gandalf.local.home>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20230914132956.569dad45@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
> 
> -- Steve


Actually, after looking more in depth at that, it seems like there are
actually 2 problems that can happen.

First one is atomic access misalignment due to enable_size == 4 and
uaddr not being aligned on a (long) boundary on 64 bits architecture.
This can generate misaligned exceptions on various architectures. This
can be fixed in a more general way according to Masami snippet.

Second one that I can see is on 64 bits, big endian architectures with
enable_size == 4. In that case, the bit provided by the userspace won't
be correctly set since this code kind of assume that the atomic are done
on 32bits value. Since the kernel assume long sized atomic operation, on
big endian 64 bits architecture, the updated bit will actually be in the
next 32 bits word.

Can someone confirm my understanding ?

Clément
