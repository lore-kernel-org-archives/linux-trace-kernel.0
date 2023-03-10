Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CACC6FD1E
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 10 Mar 2023 13:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjCJNw2 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjCJNw1 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:52:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12CA113F7A;
        Fri, 10 Mar 2023 05:52:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96B36B822BC;
        Fri, 10 Mar 2023 13:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018D4C4339B;
        Fri, 10 Mar 2023 13:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678456333;
        bh=vPueOgA86SINT/M86BYvufildQx9rrypq7cnRNvSf2w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Pugy02PBxUk65vWJ0aPKO1xAUUZC+cn5vMZNA5RMzEJ+aVYCXOexkwu903/7kd5SL
         sVmdS0Hr0az9SrbKCVQn2GxiWQmt+VIm8WSQ92X+IqyHe+jxBmiKuIDdgy1xG8t8I9
         cusu2r2gGXsyTnVU99nhthml1f6HYYP8+LqYDIGpZ3HQJ7E2mCgttr8G1lvTv3JGX2
         sRgAwn2pCQWsS5vP8LKgChtKF5ZL0/9acvTGfdjw2//c39qq8qdNgeQd54naocpEbd
         VWCxjZjvACWX/r7W/g1QsxwoXmBSL7bn6AY/hW1Yg7UGsrBJ4BjIkyIkELpwrwGXDw
         5kgvKFP9QpdwQ==
Message-ID: <f42fc503-2843-2879-1810-a238f0afe3b3@kernel.org>
Date:   Fri, 10 Mar 2023 14:52:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv2 1/2] trace/hwlat: Do not wipe the contents of per-cpu
 thread data
To:     Tero Kristo <tero.kristo@linux.intel.com>, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230310100451.3948583-1-tero.kristo@linux.intel.com>
 <20230310100451.3948583-2-tero.kristo@linux.intel.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230310100451.3948583-2-tero.kristo@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 3/10/23 11:04, Tero Kristo wrote:
> Do not wipe the contents of the per-cpu kthread data when starting the
> tracer, as this will completely forget about already running instances
> and can later start new additional per-cpu threads.
> 
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
-- Daniel
