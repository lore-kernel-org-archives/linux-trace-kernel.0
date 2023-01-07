Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67D0C54EBE
	for <linux-trace-kernel@archiver.kernel.org>; Sat,  7 Jan 2023 08:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjAGIuU (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 7 Jan 2023 03:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAGIuT (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 03:50:19 -0500
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Jan 2023 00:50:18 PST
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F0C361457
        for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Jan 2023 00:50:18 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id E4mmphZiSo7FNE4mmpsxLZ; Sat, 07 Jan 2023 09:42:42 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 07 Jan 2023 09:42:42 +0100
X-ME-IP: 86.243.100.34
Message-ID: <30dd32b4-cd74-77a1-d9ad-84e361680dac@wanadoo.fr>
Date:   Sat, 7 Jan 2023 09:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] tracing/eprobe: Replace kzalloc with kmalloc
To:     Quanfa Fu <quanfafu@gmail.com>, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230107034557.1156022-1-quanfafu@gmail.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230107034557.1156022-1-quanfafu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Le 07/01/2023 à 04:45, Quanfa Fu a écrit :
> Since this memory will be filled soon below, I feel that there is
> no need for a memory of all zeros here. 'snprintf' does not return
> negative num according to ISO C99, so I feel that no judgment is
> needed here.
> 
> No functional change intended.
> 
> Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
> ---
>   kernel/trace/trace_eprobe.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 352b65e2b910..cd1d271a74e7 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -917,15 +917,13 @@ static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const ch
>   	for (i = 0; i < argc; i++)
>   		len += strlen(argv[i]) + 1;
>   
> -	ep->filter_str = kzalloc(len, GFP_KERNEL);
> +	ep->filter_str = kmalloc(len, GFP_KERNEL);
>   	if (!ep->filter_str)
>   		return -ENOMEM;
>   
>   	p = ep->filter_str;
>   	for (i = 0; i < argc; i++) {
>   		ret = snprintf(p, len, "%s ", argv[i]);
> -		if (ret < 0)
> -			goto error;
>   		if (ret > len) {

Hi,

as per [1]:
  * The return value is the number of characters which would be
  * generated for the given input, excluding the trailing null,
  * as per ISO C99.  If the return is greater than *or equal* to
  * @size, the resulting string is truncated.

So, should this test be:
     if (ret >= len)
            ~~~~


Also, isn't the p[-1] = '\0' after the loop eating the last character?
    argc = 1;
    argv[0] = "a";

    Before the loop:
    ===============
    len = 1 + 1 = 2;
    ep->filter_str = 0x00 0x00
                     ^
                     |___ p

    After the loop:
    ===============
    ep->filter_str = 0x61 0x00
                          ^
                          |___ p
    len = 1;

    After p[-1]:
    ============
    ep->filter_str = 0x00 0x00
                       ~~ ^
                          |___ p

Did I miss something obvious?
I don't know the intent here, or if it is an issue at all, but it looks odd.

CJ


[1]: https://elixir.bootlin.com/linux/v6.2-rc1/source/lib/vsprintf.c#L2925
>   			ret = -E2BIG;
>   			goto error;

