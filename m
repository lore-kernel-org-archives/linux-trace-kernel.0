Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8820EB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 29 Jul 2023 00:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbjG2ApO (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 28 Jul 2023 20:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbjG2ApA (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:45:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD805BBB
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A4CF6221E
        for <linux-trace-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38A9C433C7;
        Sat, 29 Jul 2023 00:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690591366;
        bh=angggWPfhzmefVLWjAM85Kb/o7ZmtdBHg0B1/nJQ5TE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jH3pxDV3yTXKTZvog841YUd2DxTcdzq5mvwdGmjDR41XIoK2q0MsPxxEdxp5oazgR
         HSGGO8aYjvm8BqNrfAH0vifKtSIdGlweaXoFjoTxgGL6rVCMktJSpC4CiiUuvZ/i6X
         6A6IYaEtuiPQAzHUq+c4XVlp0D2wuF/RalLRGEO62py8Lg7i4KSzDAFP6cZA2ghX9G
         vMft9PvWZkApUr73x5PC1uxAdht1evNIyMbUc69DWzWLvMmmoEwu9p58Z64ULnSghV
         bEcrMFm03xR71s0Go7fpmjbSC+EtvbMVh2BrgaqGFMUQFg/heG2P7kvVCZncXDoSZO
         qc7hGe14FiyUQ==
Date:   Sat, 29 Jul 2023 09:42:42 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     <rostedt@goodmis.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-trace-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] ARM: ftrace: remove unused ftrace_graph_caller_old()
 declaration
Message-Id: <20230729094242.459e02f0350aa1bcb29d961b@kernel.org>
In-Reply-To: <20230728084840.2459430-1-cuigaosheng1@huawei.com>
References: <20230728084840.2459430-1-cuigaosheng1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 28 Jul 2023 16:48:40 +0800
Gaosheng Cui <cuigaosheng1@huawei.com> wrote:

> All uses of ftrace_graph_caller_old() were removed by
> commit d3c61619568c ("ARM: 8788/1: ftrace: remove old
> mcount support"), so remove the declaration, too.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> Acked-by: Linus Walleij <linus.walleij@xxxxxxxxxx>

Please write the correct email address for the Acked-by tag.

Thank you,

> ---
> v2:
> - Nothing change, resend, thanks!
> v1:
> - links: https://www.spinics.net/lists/linux-usb/msg231303.html
>  arch/arm/kernel/ftrace.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> index a0b6d1e3812f..0320cfba5b74 100644
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -261,7 +261,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  extern unsigned long ftrace_graph_call;
>  extern unsigned long ftrace_graph_call_old;
> -extern void ftrace_graph_caller_old(void);
>  extern unsigned long ftrace_graph_regs_call;
>  extern void ftrace_graph_regs_caller(void);
>  
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
