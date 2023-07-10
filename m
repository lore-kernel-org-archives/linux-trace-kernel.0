Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE38EB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 10 Jul 2023 22:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjGJWQL (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 10 Jul 2023 18:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjGJWQK (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 18:16:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9504019A;
        Mon, 10 Jul 2023 15:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AC5D6121C;
        Mon, 10 Jul 2023 22:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF343C433C8;
        Mon, 10 Jul 2023 22:16:03 +0000 (UTC)
Date:   Mon, 10 Jul 2023 18:16:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] tracing/probes: Fix to record 0-length data_loc
 in fetch_store_string*() if fails
Message-ID: <20230710181601.438b79a8@gandalf.local.home>
In-Reply-To: <168878453829.2721251.15110493517953858343.stgit@mhiramat.roam.corp.google.com>
References: <168878450334.2721251.3030778817503575503.stgit@mhiramat.roam.corp.google.com>
        <168878453829.2721251.15110493517953858343.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat,  8 Jul 2023 11:48:58 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> --- a/kernel/trace/trace_probe_kernel.h
> +++ b/kernel/trace/trace_probe_kernel.h
> @@ -55,8 +55,7 @@ fetch_store_string_user(unsigned long addr, void *dest, void *base)
>  	__dest = get_loc_data(dest, base);
>  
>  	ret = strncpy_from_user_nofault(__dest, uaddr, maxlen);
> -	if (ret >= 0)
> -		*(u32 *)dest = make_data_loc(ret, __dest - base);
> +	*(u32 *)dest = make_data_loc((ret >= 0) ? ret : 0, __dest - base);
>  
>  	return ret;
>  }
> @@ -87,8 +86,7 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
>  	 * probing.
>  	 */
>  	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
> -	if (ret >= 0)
> -		*(u32 *)dest = make_data_loc(ret, __dest - base);
> +	*(u32 *)dest = make_data_loc((ret >= 0) ? ret : 0, __dest - base);

The above is a complex line, and not something that I think should be cut
and pasted between two different locations.

I know you took out the set_data_loc() helper, but really it should have
stayed, and have used that to update this code in the two places it
affected, instead of making the changes in those two locations.

That is, patch 3 could have had kept.

static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base)
{
	if (ret >= 0)
		*(u32 *)dest = make_data_loc(ret, __dest - base);
}

And this patch could have been:

static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base)
{
	*(u32 *)dest = make_data_loc(ret, __dest - base);
}

That would keep the complexity down in this changes set.

-- Steve


>  
>  	return ret;
>  }
