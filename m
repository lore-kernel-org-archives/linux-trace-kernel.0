Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E97C0015E
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 14 Jul 2023 01:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjGNBm0 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 13 Jul 2023 21:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjGNBmX (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:42:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8E030E5;
        Thu, 13 Jul 2023 18:41:45 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R2DcX5F6rztRL5;
        Fri, 14 Jul 2023 09:37:32 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 09:40:33 +0800
Message-ID: <2b0b9cf0-19c9-e741-3413-bdc1f43f62be@huawei.com>
Date:   Fri, 14 Jul 2023 09:40:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] traing: Fix memory leak of iter->temp when reading
 trace_pipe
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     mhiramat <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230713141435.1133021-1-zhengyejian1@huawei.com>
 <20230713103353.29cae218@gandalf.local.home>
 <20230713105029.6a160f43@gandalf.local.home>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20230713105029.6a160f43@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 2023/7/13 22:51, Steven Rostedt wrote:
> On Thu, 13 Jul 2023 14:44:04 +0000
> "Zhengyejian (Zetta)" <zhengyejian1@huawei.com> wrote:
> 
>> Hi, Steve,
>>
>> Please correct a typo in title: trainy -> tracing
> 
>   traing -> tracing ;-)

Emm, my anothor typo 'trainy'. Phone's keyboard is hard to use :)

> 
>>
>> I'm a little hurry home from work :(
>> I'll pay attention to it next time.
> 
> No problem. I made the fix.
> 
> But seriously, thanks for all the fixes you are sending my way!
> 

You're welcome! I am happy to do it and have learned a lot :)

> -- Steve
> 
> 
--
Thanks,
Zheng Yejian


