Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29623EE49A5
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 23 Aug 2023 01:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjHWBJH (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 22 Aug 2023 21:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjHWBJG (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 21:09:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326D4CF9
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:09:05 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVp2b5RqGzTmX4;
        Wed, 23 Aug 2023 09:06:47 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 09:09:02 +0800
Message-ID: <904aa931-2161-7d58-bcda-222069cf4209@huawei.com>
Date:   Wed, 23 Aug 2023 09:09:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] rv/include: set variable 'da_mon_##name' to static
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <linux-trace-kernel@vger.kernel.org>, <liwei391@huawei.com>,
        <bristot@kernel.org>
References: <20230809040937.1011766-1-liaoyu15@huawei.com>
 <20230822101153.18e89373@rorschach.local.home>
From:   Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <20230822101153.18e89373@rorschach.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.173]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 2023/8/22 22:11, Steven Rostedt wrote:
> On Wed, 9 Aug 2023 12:09:37 +0800
> Yu Liao <liaoyu15@huawei.com> wrote:
> 
>> @@ -262,7 +262,7 @@ static inline void da_monitor_destroy_##name(void)						\
>>  /*												\
>>   * per-cpu monitor variables									\
>>   */												\
>> -DEFINE_PER_CPU(struct da_monitor, da_mon_##name);						\
>> +static DEFINE_PER_CPU(struct da_monitor, da_mon_##name);						\
> 
> You need to fix the backslash when you add text.
> 
> -- Steve

Thank you for the review. I'll make the suggested changes and send you
the V2.

Best regards,
Yu
> 
>>  												\
>>  /*												\
> 

