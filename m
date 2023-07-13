Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367B7EB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 13 Jul 2023 01:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjGMBwZ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 12 Jul 2023 21:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjGMBwZ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 21:52:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB921724;
        Wed, 12 Jul 2023 18:52:23 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R1czN6WNczrRlv;
        Thu, 13 Jul 2023 09:51:44 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 09:52:20 +0800
Message-ID: <10aa72df-b5e7-6666-7f4d-4810884b7aa2@huawei.com>
Date:   Thu, 13 Jul 2023 09:52:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ring-buffer: Fix deadloop issue on reading trace_pipe
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20230708225144.3785600-1-zhengyejian1@huawei.com>
 <20230709154523.32dc89c2@rorschach.local.home>
 <63ff741f-b781-37da-3f47-15d1a8ff76a4@huawei.com>
 <20230712121448.628ad188@gandalf.local.home>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20230712121448.628ad188@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 2023/7/13 00:14, Steven Rostedt wrote:
> On Mon, 10 Jul 2023 09:37:52 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
>> teve, IIUC, following tags should be added?
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 48fdc72f23ad ("ring-buffer: Fix accounting of entries when
>> removing pages")
>> Fixes: 83f40318dab0 ("ring-buffer: Make removal of ring buffer pages
>> atomic")
> 
> I actually added:
> 
> Fixes: a5fb833172eca ("ring-buffer: Fix uninitialized read_stamp")
> 
> -- Steve
> 

Yes, a5fb833172eca directly cause the deadloop issue.

--

Thanks,
Zheng Yejian
