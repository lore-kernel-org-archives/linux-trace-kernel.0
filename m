Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E81BEE14D4
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  6 Sep 2023 18:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243942AbjIFSuD (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 6 Sep 2023 14:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243911AbjIFSt4 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:49:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2909172E;
        Wed,  6 Sep 2023 11:49:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776F5C433C7;
        Wed,  6 Sep 2023 18:49:47 +0000 (UTC)
Date:   Wed, 6 Sep 2023 14:50:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     zhengyejian1@huawei.com, akaher@vmware.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        shuah@kernel.org, skhan@linuxfoundation.org, yeweihua4@huawei.com
Subject: Re: "[PATCH] selftests/ftrace: Correctly enable event in
 instance-event.tc"
Message-ID: <20230906145000.29291a1b@gandalf.local.home>
In-Reply-To: <20230906142652.191866-1-naresh.kamboju@linaro.org>
References: <b62e6539-7b25-c8ab-6b6c-47e723023297@huawei.com>
        <20230906142652.191866-1-naresh.kamboju@linaro.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed,  6 Sep 2023 19:56:52 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> [my two cents]
> 
> I do see similar kernel panic while running ftrace testing on today's
> Linux next-20230906 tag. This crash is from qemu-arm64.
> 
> Here I am providing steps to reproduced link and scripts by using tuxrun tool.
>   - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2V0OqxEZUXIPNqWhQnnsuFOGYxR/reproducer
>   
> Script details,
> =============
> # To install tuxrun to your home directory at ~/.local/bin:
> # pip3 install -U --user tuxrun==0.49.0
> #
> # Or install a deb/rpm depending on the running distribution
> # See https://tuxmake.org/install-deb/ or
> # https://tuxmake.org/install-rpm/
> #
> # See https://tuxrun.org/ for complete documentation.
> #
> #

BTW, when you ran these, did you apply:

  https://patchwork.kernel.org/project/linux-trace-kernel/patch/20230905183332.628d7cc0@gandalf.local.home/

?

-- Steve
