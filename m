Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A245C7EE25
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 12 Jun 2023 10:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbjFLKAT (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 12 Jun 2023 06:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbjFLJ57 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:57:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09480270F
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686562921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D3WIPm4z3+5JGaYbfhg2L2EMz9XADf68AcDZRHShQv4=;
        b=YtNaAegPlqnYHR4MwgJwANLlIwHLT/g9qq94nbP8tCha99AGPTj5PQeFYaUOFboLWsImY9
        tt/YPuVhmtK8AskHWMEWYueiprKs/P/lslcXLl6P6OVGnh4XM4ZyuEaUGmEBs2OT6HbooG
        dyCc5C8XUJ1YoNj/nUC5SzXYmeM3jt8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-Pgz91t7SOtaqeIM6zbg_NQ-1; Mon, 12 Jun 2023 05:41:59 -0400
X-MC-Unique: Pgz91t7SOtaqeIM6zbg_NQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f7e835ce65so17503915e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562918; x=1689154918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3WIPm4z3+5JGaYbfhg2L2EMz9XADf68AcDZRHShQv4=;
        b=NIrGFH5oJPcFl2jcKtZ+cJU9FzDk8qA8w2Tj2NMHUt/Nq62gKrd+kapcR58KRd6E8Z
         8qGaAaKx5pvX7FlUMQuYNT4EH9wHEB9n+fZO5oV3YH4AHvO51btylVF+rNw/HsXssMaI
         kS8ycrktkhvm0GZvAEjnKkbCit5nBSPINruXiEk43BHSNbO/XvWevzONCW7ILISW5819
         qyNy1y5nT4EqNeHZNMWpo/wGbLUyxiHya1w10qVCXC17OlSSjiB2C5NBUilx9HvmPJka
         vVce9Skuwz6QiXHRe5zoUtKELTtxgVgLLOHP2QDjpxYzAYDbNSchfurmeN684Yx+4fDw
         1JjQ==
X-Gm-Message-State: AC+VfDwK2qM5o4I6L7nTLYm8ivl+tSYz/PBMAZ3MzTa6AfJhWCfMToTU
        EG+ZDTkYJ8ZmhJPk6+EcKsKw22jRzKJTQAYomMDLpbIzEL2tRfKTpMsjQGb6oiQwN/8jq48LtHy
        YWpj6QusmEsUlImlSdZt3Eh4MT0M2MuUN
X-Received: by 2002:a05:600c:2254:b0:3f7:e535:ff3b with SMTP id a20-20020a05600c225400b003f7e535ff3bmr5477922wmm.3.1686562918184;
        Mon, 12 Jun 2023 02:41:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Sm436YTX68TNCme7HngotSe4eDUtAGeZuBK92RHWCc1ajo1ryGkbEfHpBQKOiPAD0EO+q1A==
X-Received: by 2002:a05:600c:2254:b0:3f7:e535:ff3b with SMTP id a20-20020a05600c225400b003f7e535ff3bmr5477906wmm.3.1686562917812;
        Mon, 12 Jun 2023 02:41:57 -0700 (PDT)
Received: from localhost.localdomain ([151.29.46.22])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003f5ffba9ae1sm10886705wma.24.2023.06.12.02.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:41:57 -0700 (PDT)
Date:   Mon, 12 Jun 2023 11:41:55 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, William White <chwhite@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH V3 00/11] rtla improvements
Message-ID: <ZIboY08U6SMS1tiO@localhost.localdomain>
References: <cover.1686066600.git.bristot@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1686066600.git.bristot@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi,

On 06/06/23 18:12, Daniel Bristot de Oliveira wrote:
> This is a series of improvements for rtla, mainly as a result of our
> daily usage of the tool debugging problems at red hat.
> 
> The cgroup support and house keeping options are from our usage
> of the tool debugging containers.
> 
> The auto-analysis overhead reduction is needed when we go to
> large boxes - but it is really hand in practice, as it gives an idea
> of the problem without having to look at the trace.
> 
> Running hwnoise 100 % of CPU time might cause some systems
> to slow down too much. Reduce its utilization to 75% by default to
> avoid problems for people using it for the first time.
> 
> Finally, it adds support for running timerlat user-space threads,
> and to collect the additional field via rtla timerlat top/hist.
> 
> Changes from V2:
>   - Add timerlat hist -u option
>   - Link: https://lore.kernel.org/lkml/cover.1684863094.git.bristot@kernel.org/
> Changes from V1:
>   - Add the user-space thread support to rtla timerlat top
>   - Link: https://lore.kernel.org/lkml/cover.1683827510.git.bristot@kernel.org/
> 
> Daniel Bristot de Oliveira (11):
>   rtla: Add -C cgroup support
>   rtla: Add --house-keeping option
>   rtla: Change monitored_cpus from char * to cpu_set_t
>   rtla: Automatically move rtla to a house-keeping cpu
>   rtla/timerlat: Give timerlat auto analysis its own instance
>   rtla/timerlat_hist: Add auto-analysis support
>   rtla: Start the tracers after creating all instances
>   rtla/hwnoise: Reduce runtime to 75%
>   rtla: Add timerlat user-space support for timerlat top
>   rtla: Add timerlat user-space support for
>   Documentation: Add tools/rtla timerlat -u option documentation
> 
>  Documentation/tools/rtla/common_options.rst   |   8 +
>  .../tools/rtla/common_timerlat_aa.rst         |   7 -
>  .../tools/rtla/common_timerlat_options.rst    |   7 +
>  .../tools/rtla/rtla-timerlat-hist.rst         |   7 +-
>  .../tools/rtla/rtla-timerlat-top.rst          |   7 +
>  tools/tracing/rtla/src/osnoise.c              |  65 ++++
>  tools/tracing/rtla/src/osnoise.h              |   5 +
>  tools/tracing/rtla/src/osnoise_hist.c         |  90 ++++-
>  tools/tracing/rtla/src/osnoise_top.c          |  83 ++++-
>  tools/tracing/rtla/src/timerlat_aa.c          |  35 +-
>  tools/tracing/rtla/src/timerlat_aa.h          |   5 +-
>  tools/tracing/rtla/src/timerlat_hist.c        | 262 ++++++++++++--
>  tools/tracing/rtla/src/timerlat_top.c         | 229 +++++++++++--
>  tools/tracing/rtla/src/timerlat_u.c           | 224 ++++++++++++
>  tools/tracing/rtla/src/timerlat_u.h           |  18 +
>  tools/tracing/rtla/src/utils.c                | 324 +++++++++++++++++-
>  tools/tracing/rtla/src/utils.h                |   7 +
>  17 files changed, 1277 insertions(+), 106 deletions(-)
>  create mode 100644 tools/tracing/rtla/src/timerlat_u.c
>  create mode 100644 tools/tracing/rtla/src/timerlat_u.h
> 
> -- 

I've been heavily relying on these for debugging various issues with
latency sensitive workloads and they work like a charm.

Tested-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

