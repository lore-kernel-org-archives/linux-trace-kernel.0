Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719B5C77B73
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 20 Apr 2023 16:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjDTQNf (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 20 Apr 2023 12:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjDTQNe (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:13:34 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C720FA3;
        Thu, 20 Apr 2023 09:13:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 31A20732;
        Thu, 20 Apr 2023 16:13:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 31A20732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1682007212; bh=ZYW+cTC3rQfV7FwGsuC36Jdv5I+7NAsg0phQ6uvJLR8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VU7oWgA1UFqxKMKRmP61kWkHKQRzYJWgrDV9VYn8+3cdvDHkhVJ+HjKPBFPtO8w8K
         AmEXm3Wd0ewZoBiN0fTAe+0pUAZhBs50XhU5fxoNNEUaQ8KT0lujiXYQi7855nL2lv
         uR/IwEHSSNLFaUFpVsGBVeiY3UO4ItmLW5DrN6NZWMDT8JyiJK4kkwETr9sdm6+aBw
         iH2TtuE/7bUjv6L6PoGqAUhPxALmy6dFKwSiMDV84YzOJ3A4mt6fPCJzDOsJjSDOIK
         LHuES5efJmvFYgl5pZscOx2Py9mTUHIymGPsXKztCkmZXkMR8loQjCozSIa4dnv6aV
         viu6Uk/QDqOLw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lin Yu Chen <starpt.official@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Lin Yu Chen <starpt.official@gmail.com>
Subject: Re: [PATCH] docs: trace: Fix typo in ftrace.rst
In-Reply-To: <20230412183739.89894-1-starpt.official@gmail.com>
References: <20230412183739.89894-1-starpt.official@gmail.com>
Date:   Thu, 20 Apr 2023 10:13:31 -0600
Message-ID: <87354uttuc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Lin Yu Chen <starpt.official@gmail.com> writes:

> There is a typo in the sentence "A kernel developer must be
> conscience ...". The word conscience should be conscious.
> This patch fixes it.
>
> Signed-off-by: Lin Yu Chen <starpt.official@gmail.com>
> ---
>  Documentation/trace/ftrace.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index b927fb2b94dc..e8bca5fea7cc 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -3510,7 +3510,7 @@ directories, the rmdir will fail with EBUSY.
>  Stack trace
>  -----------
>  Since the kernel has a fixed sized stack, it is important not to
> -waste it in functions. A kernel developer must be conscience of
> +waste it in functions. A kernel developer must be conscious of
>  what they allocate on the stack. If they add too much, the system
>  can be in danger of a stack overflow, and corruption will occur,

Applied, thanks.

jon
