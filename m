Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76B9EB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 29 Jul 2023 01:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjG2BbB (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 28 Jul 2023 21:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjG2BbA (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:31:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8864E50
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:30:59 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RCRk729B3zVjr1;
        Sat, 29 Jul 2023 09:29:19 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 09:30:56 +0800
Subject: Re: [PATCH v2] ARM: ftrace: remove unused ftrace_graph_caller_old()
 declaration
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     <rostedt@goodmis.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-trace-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230728084840.2459430-1-cuigaosheng1@huawei.com>
 <20230729094242.459e02f0350aa1bcb29d961b@kernel.org>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <70dd3a95-8953-ed2c-7689-13d79ae93af7@huawei.com>
Date:   Sat, 29 Jul 2023 09:30:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20230729094242.459e02f0350aa1bcb29d961b@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

> Please write the correct email address for the Acked-by tag.

Thanks for taking time to review this patch, I have corrected the email
address for the Acked-by tag.

On 2023/7/29 8:42, Masami Hiramatsu (Google) wrote:
> On Fri, 28 Jul 2023 16:48:40 +0800
> Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>
>> All uses of ftrace_graph_caller_old() were removed by
>> commit d3c61619568c ("ARM: 8788/1: ftrace: remove old
>> mcount support"), so remove the declaration, too.
>>
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> Acked-by: Linus Walleij <linus.walleij@xxxxxxxxxx>
> Please write the correct email address for the Acked-by tag.
>
> Thank you,
>
>> ---
>> v2:
>> - Nothing change, resend, thanks!
>> v1:
>> - links: https://www.spinics.net/lists/linux-usb/msg231303.html
>>   arch/arm/kernel/ftrace.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
>> index a0b6d1e3812f..0320cfba5b74 100644
>> --- a/arch/arm/kernel/ftrace.c
>> +++ b/arch/arm/kernel/ftrace.c
>> @@ -261,7 +261,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
>>   #ifdef CONFIG_DYNAMIC_FTRACE
>>   extern unsigned long ftrace_graph_call;
>>   extern unsigned long ftrace_graph_call_old;
>> -extern void ftrace_graph_caller_old(void);
>>   extern unsigned long ftrace_graph_regs_call;
>>   extern void ftrace_graph_regs_caller(void);
>>   
>> -- 
>> 2.25.1
>>
>
