Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815ABC41513
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 31 Jul 2023 15:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjGaPMK (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 31 Jul 2023 11:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjGaPLy (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:11:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42ED1FDE;
        Mon, 31 Jul 2023 08:11:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC91F61193;
        Mon, 31 Jul 2023 15:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0D8C433C7;
        Mon, 31 Jul 2023 15:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690816284;
        bh=9ock8osdzFVsRoJjxaLeGH9zNMvX+8AW10p+xkBEgrI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eyHqd9O+/ceH4Q5hxv4708mFJ8H34u8tgjpPTHZaG+uTPLIkajn8+2ALhQozzpCtb
         zQ+KGcRD0Q/tGbi4o3lAtTxvWZSTuTqLPZD7Jj2nPr6WBUdP57QqvGGp35DfN9TXGv
         t8WssGU5PLkW+XnDRg3H2CRBwx3YYL10aTETMNcfFrwi5Y0C/O8UoKMOvXXSHUPZWG
         wg92KHpOoE91dlAKeaJaTrdgkqdOXQl2Wop5ilhm8KiNGU6JKq3NEFyM2mAN13iWmU
         ckgQ0rOLlG4aV3yFCMIVYAW+CH48VHgyXMO/oKBXQqNpnfZMOPeEof6e+fFWcrF2CB
         QWFwfBJC7Vonw==
Message-ID: <798d0a75-8177-a40f-78ed-af672d9dae22@kernel.org>
Date:   Mon, 31 Jul 2023 17:11:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] rtla: Uninitialized variable in find_mount()
Content-Language: en-US, pt-BR, it-IT
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andreas Schwab <schwab@suse.de>,
        linux-trace-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <53066ac3-523a-4db9-a636-9c99ef56c7c1@moroto.mountain>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <53066ac3-523a-4db9-a636-9c99ef56c7c1@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 7/31/23 16:11, Dan Carpenter wrote:
> The "found" variable needs to be set to 0/false at the start.
> 
> Fixes: a957cbc02531 ("rtla: Add -C cgroup support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  tools/tracing/rtla/src/utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
> index 623a38908ed5..c769d7b3842c 100644
> --- a/tools/tracing/rtla/src/utils.c
> +++ b/tools/tracing/rtla/src/utils.c
> @@ -538,7 +538,7 @@ static const int find_mount(const char *fs, char *mp, int sizeof_mp)
>  {
>  	char mount_point[MAX_PATH];
>  	char type[100];
> -	int found;
> +	int found = 0;
>  	FILE *fp;

Same problem, right? https://lore.kernel.org/lkml/20230727150117.627730-1-colin.i.king@gmail.com/

-- Daniel

>  
>  	fp = fopen("/proc/mounts", "r");

