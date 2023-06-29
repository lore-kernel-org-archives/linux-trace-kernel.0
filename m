Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA25AEB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 29 Jun 2023 13:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjF2Nqj (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 29 Jun 2023 09:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjF2Nqh (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:46:37 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F8030F0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:46:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fa7512e599so7230175e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688046395; x=1690638395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZsl8N+iQhKsIOsKT4bOEhED89h7DOOL2ijQX1JXlvM=;
        b=VEiixseM0P5V7v02CJFneYpijvx9SKlFreI31SM1UDp0Ceg9n5lxkz3TBCvceeqbOl
         CGWVQyXcB3aYDjyseZVs+R+kuUGR1OplM520KZUAl2VvQBGbswOvYpXSKU2LEMQf55QV
         phQABZ/H3UWcVWc43zbY7Pig4EK46BHYCU/GyHI7yz7WZdvd5vquzY4QmCHtSBQ9IgM2
         qbx3JH+1pmWH61BOXJH0QRqbkjozLnEArQzUo6X53kUes9ODHTtmy9+KF18btvMONgpR
         gaMsuLsQYuJFFXBQrn7eRvpX4DTlhplkZFnZf+0tbcHYA2/i70V2OzSdUIF6HhVnfqeq
         0Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688046395; x=1690638395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZsl8N+iQhKsIOsKT4bOEhED89h7DOOL2ijQX1JXlvM=;
        b=l8YcUooBoUl36FAZdPnxRv4m65mE1Gpo5vf5Y9DnlhnWRN94/awAzd3AHHYJ3G3/Kw
         ASXwEmYLGxHXWeFVhDSpev1XhVB7F2Siz9Nyb/xPU//45ibzHCkwchn6z7LdSCmKWWfE
         Zh622LMWOF1ItenBvOyI2tMIVJr7WGvAaj0qsoHrrE9th4lgB2FsnGwpRHVNPmuOVBoo
         +b4VMbxTqUy86IrYI2vX7EoepSf8o0pm67Q+JA6QaYcR/zjO3O36Moj9enTcqsOLknaX
         tSPzD2liu3V8BGIDXNz6zWxq8i1LbKv6lQqf/rAJ9yynU+fnuAMZD4NAWwKtqI1c9fof
         d0qw==
X-Gm-Message-State: AC+VfDy+k4+kT9kC+UXMyrdJ7IJGAy7bznZNTwrJuPkEpP5eY+WUBA1V
        L20kJH21HwJsiyRB1MHHN9AdIQ==
X-Google-Smtp-Source: ACHHUZ4ykR0aC8ipskXrfleWK1VpP1ySR2rPo8RtiZjGjbTNbOYq1LXPxBwFvwYApocWQDJzR2fHCQ==
X-Received: by 2002:a05:600c:29a:b0:3fb:a8ef:edfe with SMTP id 26-20020a05600c029a00b003fba8efedfemr6067924wmk.18.1688046394807;
        Thu, 29 Jun 2023 06:46:34 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:48c4:4b87:cc05:b4fb? ([2a02:8011:e80c:0:48c4:4b87:cc05:b4fb])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c238500b003f900678815sm16575276wma.39.2023.06.29.06.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 06:46:34 -0700 (PDT)
Message-ID: <4892a56a-44f8-c45e-c119-503d63ce0fd2@isovalent.com>
Date:   Thu, 29 Jun 2023 14:46:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 bpf-next 02/11] bpftool: Dump the kernel symbol's
 module name
Content-Language: en-GB
To:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230628115329.248450-1-laoar.shao@gmail.com>
 <20230628115329.248450-3-laoar.shao@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230628115329.248450-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

2023-06-28 11:53 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> If the kernel symbol is in a module, we will dump the module name as
> well. The square brackets around the module name are trimmed.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> ---
>  tools/bpf/bpftool/xlated_dumper.c | 6 +++++-
>  tools/bpf/bpftool/xlated_dumper.h | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
> index da608e10c843..567f56dfd9f1 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -46,7 +46,11 @@ void kernel_syms_load(struct dump_data *dd)
>  		}
>  		dd->sym_mapping = tmp;
>  		sym = &dd->sym_mapping[dd->sym_count];
> -		if (sscanf(buff, "%p %*c %s", &address, sym->name) != 2)
> +
> +		/* module is optional */
> +		sym->module[0] = '\0';
> +		/* trim the square brackets around the module name */
> +		if (sscanf(buff, "%p %*c %s [%[^]]s", &address, sym->name, sym->module) < 2)

Looking again at this patch, we should be good for parsing the module
name with the sscanf() because I don't expect a module name longer than
MODULE_MAX_NAME to show up, but I wonder what guarantee we have about
symbols names staying under SYM_MAX_NAME? Maybe we should specify the
max length to read, to remain on the safe side (or in case these limits
change in the future). But it doesn't have to be part of your set, I can
send a follow-up after that.

>  			continue;
>  		sym->address = (unsigned long)address;
>  		if (!strcmp(sym->name, "__bpf_call_base")) {
> diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlated_dumper.h
> index 9a946377b0e6..db3ba0671501 100644
> --- a/tools/bpf/bpftool/xlated_dumper.h
> +++ b/tools/bpf/bpftool/xlated_dumper.h
> @@ -5,12 +5,14 @@
>  #define __BPF_TOOL_XLATED_DUMPER_H
>  
>  #define SYM_MAX_NAME	256
> +#define MODULE_MAX_NAME	64
>  
>  struct bpf_prog_linfo;
>  
>  struct kernel_sym {
>  	unsigned long address;
>  	char name[SYM_MAX_NAME];
> +	char module[MODULE_MAX_NAME];
>  };
>  
>  struct dump_data {

