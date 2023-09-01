Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F32FCA0FE3
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  1 Sep 2023 01:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjIABeY (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 31 Aug 2023 21:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjIABeX (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:34:23 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C21BE6E;
        Thu, 31 Aug 2023 18:34:19 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RcLBD1P2Xz1L9Gb;
        Fri,  1 Sep 2023 09:32:36 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 09:34:16 +0800
Message-ID: <27b90c36-7552-6e6c-4109-3220c90ce83e@huawei.com>
Date:   Fri, 1 Sep 2023 09:34:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tracing: zero the pipe cpumask on alloc to avoid spurious
 -EBUSY
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Brian Foster <bfoster@redhat.com>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230831125500.986862-1-bfoster@redhat.com>
 <26f8fb43-6ea8-edc2-381d-3600fce261af@huawei.com>
 <20230831163331.6c90c963@rorschach.local.home>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20230831163331.6c90c963@rorschach.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 2023/9/1 04:33, Steven Rostedt wrote:
> On Thu, 31 Aug 2023 21:51:18 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
>>> Hi,
>>>
>>> I ran into this problem just recently on one of my test VMs immediately
>>> after updating to a v6.5 base. A revert of the aforementioned commit
>>> addressed the problem. I'm not terribly familiar with the tracing code,
>>> but on further inspection I noticed the cpumask doesn't appear to be
>>> initialized anywhere. I suppose this could alternatively do a
>>> cpumask_clear() or whatever after allocation, but either way this
>>> addresses the problem for me.
>>
>> Yes, pipe_cpumask must be initialized.
> 
> Can I add a Reviewed-by tag from you?

Of course :)
Reviewed-by: Zheng Yejian <zhengyejian1@huawei.com>

--

Thanks,
Zheng Yejian

> 
>>
>>>
>>> Please CC on replies as I'm not subscribed to the list. Thanks.
> 
> That's the default with Linux kernel lists.
> 
> -- Steve
> 

