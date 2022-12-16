Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A94BC4332F
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 16 Dec 2022 21:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiLPVi6 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 16 Dec 2022 16:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLPVi5 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 16:38:57 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D426D15F2E
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Dec 2022 13:38:54 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id o8so1937235ilo.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Dec 2022 13:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s5TaqJbUnyGhuPZZS5UNZKhBWRtutQq3cE9SHhAW1+Y=;
        b=AOcpZMj9vOMtGGDfZKG7d7Yg+7nxDSrZWtnGF04EUv0esZ7U3zu7kmN9WZarij09DB
         rpDdPRGk+ppGyeFFd9hFbPmdIheD4DwIBMmD/YqiHn+iuBBF/VL09QO2ytWrPMNoczEx
         vB6/PomDUKVKfpw+y9rchIGX79t4wBW8AcpwuwNwD7TG3r08GsksNdbSD7dsWiov+way
         fWKMkOkFxSiFr2Oz65BUK3N+ySO6HIcQQUtUDt7ySwxhcMMBBJWbMqHppojXoitLM9pg
         ceYrePwsOKv7lG2vuiI9gmrzYVaXbmD2FPf/J0IKnAaP6dYxO6C9gHF+0zffERYTt36/
         ie2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5TaqJbUnyGhuPZZS5UNZKhBWRtutQq3cE9SHhAW1+Y=;
        b=wNgrDO0AqXzR2fDKXyA9RleAjqZ8OKt+C5HxGEkO2t4uLgZVgkuE3M4IXy9qjuSQ0R
         TZvWmYF6HOvwYgabXW5shqbynhP1e+sykBxiMkwhU9zGEmPqEtBGhPM1mx1oDpznqYpg
         HZeHok8YehY6dxsJMLCM0auaO1ZyLgDQgZaVIGfrf9u1+LlwDjWOr/upmpgnas4XQ3Ij
         BJkYb2h42B8exHIlUELDQ2BxvZSHcvfu15rQA8qnPO/cA71JmkOAoQo0r3ILed+9maae
         w1BV63Ye1DTEt5BoLdYzsAGQ34oXzya8XWc3+vaMAjWtrKSo5u+chBZ+hi9q6Gwl/3q+
         1YvQ==
X-Gm-Message-State: AFqh2kq4uEdXSh0XcYe/d48hyP8EWjtSqArAJQQGCimxYfQs2QU8dVUr
        tgssXfIJZ71K6KEOYu3zTn0RORvAdWH/YnRp
X-Google-Smtp-Source: AMrXdXt+NHicpunxcqTvC73xwn58fXmuR8zZdjlFz5HXD2WxIxU2j7AgXazccgwhoowSaO3IgMvXdA==
X-Received: by 2002:a05:6e02:ec7:b0:305:dee9:bcb4 with SMTP id i7-20020a056e020ec700b00305dee9bcb4mr7117271ilk.26.1671226733873;
        Fri, 16 Dec 2022 13:38:53 -0800 (PST)
Received: from google.com ([2620:15c:183:200:a41d:a9ca:1f95:c2e6])
        by smtp.gmail.com with ESMTPSA id b14-20020a92db0e000000b002fc323a2902sm974855iln.62.2022.12.16.13.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:38:53 -0800 (PST)
Date:   Fri, 16 Dec 2022 14:38:49 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Add a way to filter function addresses to
 function names
Message-ID: <Y5zlaWEVdBSJhQR/@google.com>
References: <20221214125209.09d736dd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214125209.09d736dd@gandalf.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 12:52:09PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> There's been several times where an event records a function address in
> its field and I needed to filter on that address for a specific function
> name. It required looking up the function in kallsyms, finding its size,
> and doing a compare of "field >= function_start && field < function_end".

This is amazingly useful!

> But this would change from boot to boot and is unreliable in scripts.
> Also, it is useful to have this at boot up, where the addresses will not
> be known. For example, on the boot command line:
> 
>   trace_trigger="initcall_finish.traceoff if initcall_finish.function == acpi_init"

I think this should actually be:

  trace_trigger="initcall_finish.traceoff if func.function == acpi_init"
                                             ^^^^

right?  'func' is the function pointer in the format:

  [ /sys/kernel/debug/tracing/events/initcall/initcall_finish ]
  # cat format
  name: initcall_finish
  ID: 20
  format:
          field:unsigned short common_type;	offset:0;	size:2;	signed:0;
          field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
          field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
          field:int common_pid;	offset:4;	size:4;	signed:1;

          field:initcall_t func;	offset:8;	size:8;	signed:0;
          field:int ret;	offset:16;	size:4;	signed:1;

  print fmt: "func=%pS ret=%d", REC->func, REC->ret

> To implement this, add a ".function" prefix, that will check that the
> field is of size long, and the only operations allowed (so far) are "=="
> and "!=".
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

<>

> @@ -1393,6 +1414,12 @@ static int parse_pred(const char *str, void *data,
>  		i += len;
>  	}
>  
> +	/* See if the field is a user space string */

Is this comment correct, or was it just copied from the .ustring handling
above?  We aren't doing any string sanitization (strncpy_from_kernel_nofault()
and friends) AFAICT, just doing a kernel symbol lookup.

Maybe:

  /* See if this is a kernel function name */

?

> +	if ((len = str_has_prefix(str + i, ".function"))) {
> +		function = true;
> +		i += len;
> +	}
> +
>  	while (isspace(str[i]))
>  		i++;
>  
> @@ -1423,7 +1450,57 @@ static int parse_pred(const char *str, void *data,
>  	pred->offset = field->offset;
>  	pred->op = op;
>  
> -	if (ftrace_event_is_function(call)) {
> +	if (function) {
> +		/* The field must be the same size as long */
> +		if (field->size != sizeof(long)) {
> +			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
> +			goto err_free;
> +		}
> +
> +		/* Function only works with '==' or '!=' and an unquoted string */
> +		switch (op) {
> +		case OP_NE:
> +		case OP_EQ:
> +			break;
> +		default:
> +			parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
> +			goto err_free;
> +		}
> +
> +		if (isdigit(str[i])) {
> +			ret = kstrtol(num_buf, 0, &ip);
> +			if (ret) {
> +				parse_error(pe, FILT_ERR_INVALID_VALUE, pos + i);
> +				goto err_free;
> +			}

Maybe I'm holding it by the wrong end, but can we actually use this to filter
based on an address?  Hex doesn't work (as you'd expect from looking at
kstrol()), but decimal doesn't work for me either:

  [ /sys/kernel/debug/tracing/events/kmem/kmalloc ]
  # echo "traceoff:1 if call_site.function == 0xffffffff96ca4240" > trigger

  [ /sys/kernel/debug/tracing/events/kmem/kmalloc ]
  # echo "traceoff:1 if call_site.function == 18446744071944421952" > trigger
  bash: echo: write error: Invalid argument

Should this interface insist that users use function names that we can look
up?
