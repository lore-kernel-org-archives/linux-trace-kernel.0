Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E4ACD5BBD
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 19 Sep 2023 13:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjISN54 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 19 Sep 2023 09:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjISN5j (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:57:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB740E47;
        Tue, 19 Sep 2023 06:57:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB09DC433C7;
        Tue, 19 Sep 2023 13:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695131822;
        bh=1d5DP918hZxk10UdIwlD+ga9m6M7ZS6lCpvi4cE2yFk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Kj1AB0OOLQfr9v+8rqfBUXf6VEFtqnDrzzaLgoEbGthCXi/ehGfzmzciqkoz2EMqo
         yxtyP2OQEG1vCk9ut6xug1fcDmCboEbNVjklWI8jRhEZSkTkq39us30H9mEq2QJ3eF
         xqtioHnNvyU0Pa7ziifR4C054lp/ESrLT7XroYgVRY4Y/YGOc7RHk7dW6F1XXNpNXM
         TMDM9YHiXLzb1ccA6rMesoPhTkQt2Yg2lvHK2NOYmTY08kLasm//gc5yjoy3lkiTj/
         8e++/0sZR0BYRVppjfG458Y144ORgv0rlAs6vh2SoG7eVEb5th1W+W+Q/+wvYZU9gS
         35ZaGDzEbYzIQ==
Message-ID: <de5568cc-b710-ae56-710b-92eaa4fc09e8@kernel.org>
Date:   Tue, 19 Sep 2023 15:56:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] rtla: fix a example in rtla-timerlat-hist.rst
To:     Xie XiuQi <xiexiuqi@huaweicloud.com>, rostedt@goodmis.org,
        corbet@lwn.net, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bobo.shaobowang@huawei.com
References: <20230919133028.697144-1-xiexiuqi@huaweicloud.com>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230919133028.697144-1-xiexiuqi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 9/19/23 15:30, Xie XiuQi wrote:
> From: Xie XiuQi <xiexiuqi@huawei.com>
> 
> The following error message is reported when running the example in document.
> 
>   # timerlat hist -d 10m -c 0-4 -P d:100us:1ms -p 1ms --no-aa
>   Failed to set timerlat period
>   Could not apply config
> 
> The unit of the period is microsecond, '1ms' cannot be accepted.

right, but we could also parse the -p accordingly, no?

as well as the -r for osnoise and hwnoise... and other
us only parameters....

>   usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] ...
>          ...
> 	  -p/--period us: timerlat period in us
>          ...
> 
> Also fix another minor missleading comment.
> 
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>

