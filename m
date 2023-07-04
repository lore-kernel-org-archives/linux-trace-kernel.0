Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98254EB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  4 Jul 2023 17:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjGDRGA (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 4 Jul 2023 13:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDRF7 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:05:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98C4F3;
        Tue,  4 Jul 2023 10:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70F7B61330;
        Tue,  4 Jul 2023 17:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F92C433C7;
        Tue,  4 Jul 2023 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688490357;
        bh=URM3onoMud5zmGL1iJsWFhtC70gXcJT0bdgZ5a8t7fw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EHfyX7FfuWKKGbcnaGKbRMO/OpIkDZSx5KloAnmnmYscETqCjrTNkCKjSyahLz3VE
         sdhabaTzPmEcHMYfjzS6//D2e5mq8Dnc0eKMUD3JgMZARe7ZPzRv0ecQ9PgK/vrkts
         QXtmu8lpkUTTNlBSlvaOVpTOnXcRIV/bxK6bZIYk7OCuYySHvjM2O+jvnaU8gbQzCL
         WIp7rmEm06pkF4e1Q/zn+M8O9KOJV2QWXglrkBQ73OJBqrvq54WP1+vGKVhSuhnvlb
         ccmRBxN08g+ZJbKz7MusWFBum4Q//QjfjfXmH1drZ1GiuUond+5kzLzbqOfghkCZx3
         zAu+2g79jxONw==
Message-ID: <1f82d68f-c436-077b-e320-4f1d579c70ab@kernel.org>
Date:   Tue, 4 Jul 2023 11:05:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] net: Replace strlcpy with strscpy
To:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-hardening@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org
References: <20230703175840.3706231-1-azeemshaikh38@gmail.com>
Content-Language: en-US
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230703175840.3706231-1-azeemshaikh38@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 7/3/23 11:58 AM, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  include/trace/events/fib.h  |    2 +-
>  include/trace/events/fib6.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


