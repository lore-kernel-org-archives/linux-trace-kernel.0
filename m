Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02C6C83F14
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 29 Aug 2023 09:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjH2JVP (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 29 Aug 2023 05:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbjH2JVD (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:21:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7515E18D
        for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:20:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fea0640d7aso39166575e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1693300858; x=1693905658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hiOjkxFy5FowkcWV2fKnpQB+5IVohs2oETRtiJnNlHU=;
        b=dulb1EQvHf6ELfIkbjdAQFI7Lk1zIHVDoWjs4ewleCbGalHUB6bnqvUWGAFwcV8p61
         DdZIiPbaPqsG/BimAHYywC7zg7VF6V0lveGPksxxq1L5cV/GlWRcxnS73oiKT2W2t4Qo
         TgJKc3rJfHIMB1vlVBgc5YBxwKBC7RVtC0FxR5Xmcs+f9Qv+CZJkCXycCLNXwjjU4b1H
         eKe4zSzkqu22XzGqezPpptspVrXAjL6fp56v4K0AlPiWLfbbKfCFMr7UgQoZklj3P8XK
         sMI640zJuXcYD9xknMw2lEXIjdyPzmCjGT6ALvY4zImO0phYA/VuYP15wFU3DZk07YzH
         inTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693300858; x=1693905658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiOjkxFy5FowkcWV2fKnpQB+5IVohs2oETRtiJnNlHU=;
        b=FQOOBZW3JieZBm0fJLqLSlubhRqRwdkM6+uTswEYV/74XuGknIQmsNZXguX1XLB2tF
         6aF5Jbfypo1tg9RETbvtMxV2dfEP+fRvZYyeZZcDXC/S8A33NZbnivg41MU7SqN4tPCV
         Pk+wMIbdYXoeYyiXti7SNPmBktdI8Ft/28J+l2+Nc8GBhsBAArEk0OrmDGgT2LMBb7ak
         nCYF3ghK5RWuXBhscDzTGhdTX7IP/pXW98gck2JpamwvF67yKwmzNhmu6BEl1tGC1V2I
         BiX55lcI76dkEF5vr1X0kkRFfX4x9b6IjYye6LTI2cOuNBRNu5HvZTC3TQcWExZ46nsc
         zWGA==
X-Gm-Message-State: AOJu0Ywy+fHhxGfWsSW5RtmJpnTGVraMwBXxSShWtiuRWQ1ZNyYKd5Sb
        oAymUBzm/AMa5a9/IkYznyhBCSnwLB6W8jf5veN7ww==
X-Google-Smtp-Source: AGHT+IEVPg6LujE2IyfZ6L24VRQ8JySGzoBh9Pi9CJ/uMz0d5kT+P+FyBoH/EZ2hAcBCQFz0+qKJwQ==
X-Received: by 2002:a1c:f304:0:b0:3fb:e4ce:cc65 with SMTP id q4-20020a1cf304000000b003fbe4cecc65mr20427498wmq.25.1693300857861;
        Tue, 29 Aug 2023 02:20:57 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:716a:ac4c:a6ab:1706? ([2a02:8011:e80c:0:716a:ac4c:a6ab:1706])
        by smtp.gmail.com with ESMTPSA id a9-20020a05600c224900b003fef5402d2dsm16682253wmm.8.2023.08.29.02.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 02:20:57 -0700 (PDT)
Message-ID: <a35d9a2d-54a0-49ec-9ed1-8fcf1369d3cc@isovalent.com>
Date:   Tue, 29 Aug 2023 10:20:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 bpf-next 09/10] bpftool: Add perf event names
Content-Language: en-GB
To:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Jiri Olsa <olsajiri@gmail.com>
References: <20230709025630.3735-1-laoar.shao@gmail.com>
 <20230709025630.3735-10-laoar.shao@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230709025630.3735-10-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 09/07/2023 03:56, Yafang Shao wrote:
> Add new functions and macros to get perf event names. These names except
> the perf_type_name are all copied from
> tool/perf/util/{parse-events,evsel}.c, so that in the future we will
> have a good chance to use the same code.
> 
> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/bpf/bpftool/link.c | 67 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index a4f5a436777f..8e4d9176a6e8 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c

[...]

> +#define perf_event_name(array, id) ({			\
> +	const char *event_str = NULL;			\
> +							\
> +	if ((id) >= 0 && (id) < ARRAY_SIZE(array))	\

Hi Yafang,

I'm observing build warnings when building bpftool after you series:

    link.c: In function ‘perf_config_hw_cache_str’:
    link.c:86:18: warning: comparison of unsigned expression in ‘>= 0’ is always true [-Wtype-limits]
       86 |         if ((id) >= 0 && (id) < ARRAY_SIZE(array))      \
          |                  ^~
    link.c:320:20: note: in expansion of macro ‘perf_event_name’
      320 |         hw_cache = perf_event_name(evsel__hw_cache, config & 0xff);
          |                    ^~~~~~~~~~~~~~~
    [... more of the same for the other calls to perf_event_name ...]

(using GCC 11.4.0)

Could you please send a follow-up to suppress them? We're always passing
unsigned, so it should be safe to drop the check on (id) >= 0.

Thanks,
Quentin
