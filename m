Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCACC636D4
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 16 Feb 2023 02:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBPCwH (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 15 Feb 2023 21:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBPCwG (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:52:06 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1666C45F41;
        Wed, 15 Feb 2023 18:52:05 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PHKD34FxwznV32;
        Thu, 16 Feb 2023 10:49:39 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Feb 2023 10:52:01 +0800
Subject: Re: [PATCH 1/3] kprobes: Fixed probe nodes not correctly removed when
 forcibly unoptimized
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <ast@kernel.org>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20230215115430.236046-1-yangjihong1@huawei.com>
 <20230215115430.236046-2-yangjihong1@huawei.com>
 <20230215235517.800c5089318b5353e7304b67@kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <94ffd94f-23b6-8d11-43c5-cd5ff16cac65@huawei.com>
Date:   Thu, 16 Feb 2023 10:52:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20230215235517.800c5089318b5353e7304b67@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hello Masami,

On 2023/2/15 22:55, Masami Hiramatsu (Google) wrote:
> Hi Yang,
> 
> Thanks for reporting, but maybe this is a part of following fix.
> 
> https://lore.kernel.org/all/167448024501.3253718.13037333683110512967.stgit@devnote3/
> 
> Can you confirm that fixes the same issue?
Yes, I've tested and confirmed that the patch you mentioned above fixes 
the same issue.

Will remove it in next version.

Thanks
Yang.
