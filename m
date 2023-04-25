Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CC5C77B61
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 25 Apr 2023 19:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbjDYTCC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 25 Apr 2023 15:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjDYTCB (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:02:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE9A16F3C;
        Tue, 25 Apr 2023 12:01:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E106D63107;
        Tue, 25 Apr 2023 19:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2613C4339B;
        Tue, 25 Apr 2023 19:01:56 +0000 (UTC)
Date:   Tue, 25 Apr 2023 15:01:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     sunying@nj.iscas.ac.cn
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace/recordmcount: add the necessary dependencies
Message-ID: <20230425150154.255b238a@gandalf.local.home>
In-Reply-To: <20230412101840.13601-1-sunying@nj.iscas.ac.cn>
References: <20230412101840.13601-1-sunying@nj.iscas.ac.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 12 Apr 2023 18:18:40 +0800
sunying@nj.iscas.ac.cn wrote:

> From: Ying Sun <sunying@nj.iscas.ac.cn>
> 
> HAVE_C_RECORDMCOUNT is used only if the condition
> "ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT" is met in the Makefile,
> adding a dependency constraint on this configuration option
>  to prevent it from being set ‘y' but not taking effect.

Why do we care?

The HAVE_* configs are only there to allow architectures to say if they
support it or not. They usually have no effect themselves\ and require
other configs to be enabled something. This is "Works as designed".

-- Steve


> 
> Suggested-by: Yanjie Ren <renyanjie01@gmail.com>
> Signed-off-by: Ying Sun <sunying@nj.iscas.ac.cn>
> ---
>  kernel/trace/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 8cf97fa4a4b3..69bb70b6bdd7 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -94,6 +94,7 @@ config HAVE_OBJTOOL_NOP_MCOUNT
>  
>  config HAVE_C_RECORDMCOUNT
>  	bool
> +	depends on FTRACE_MCOUNT_USE_RECORDMCOUNT
>  	help
>  	  C version of recordmcount available?
>  

