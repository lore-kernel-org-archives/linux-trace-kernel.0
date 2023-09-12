Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A562CA0ECD
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 12 Sep 2023 03:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbjILDgp (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 11 Sep 2023 23:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbjILDgd (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:36:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D5D5580
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:36:28 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rl71c44vNzVkYP;
        Tue, 12 Sep 2023 10:33:40 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 12 Sep 2023 10:36:25 +0800
Message-ID: <16a70d48-ab54-6c14-e454-25c12a28858c@huawei.com>
Date:   Tue, 12 Sep 2023 10:36:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] eventfs: Fix the NULL pointer dereference bug in
 eventfs_remove_rec()
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     <linux-trace-kernel@vger.kernel.org>,
        Ajay Kaher <akaher@vmware.com>
References: <20230911052818.1020547-1-ruanjinjie@huawei.com>
 <20230911205125.da905de7b6616ecef3811d7f@kernel.org>
 <20230911173955.60fe81ad@gandalf.local.home>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230911173955.60fe81ad@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org



On 2023/9/12 5:39, Steven Rostedt wrote:
> On Mon, 11 Sep 2023 20:51:25 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
>> Instead,
>>
>> 	ef = eventfs_add_subsystem_dir(name, parent);
>> 	if (IS_ERR(ef)) {
>> 		...
>> 	} else
>> 		dir->ef = ef;
> 
> 
> Note, as the error has a goto out_free, it just needs to be:
> 
> 	if (IS_ERR(ef)) {
> 		...
> 		goto out_free;
> 	}
> 
> 	dir->ef = ef;

Thank you! I'll fix it sooner.


> 
> And for event_create_dir()
> 
> 	ef = eventfs_add_dir(name, ef_subsystem);
> 	if (IS_ERR(ef)) {
> 		...
> 		return -1;
> 	}
> 
> 	file->ef = ef;
> 
> -- Steve
> 
