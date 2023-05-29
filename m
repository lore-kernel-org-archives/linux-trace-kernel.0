Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EA5C77B7A
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 29 May 2023 11:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjE2L0T (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 29 May 2023 07:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjE2L0P (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:26:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0E9BE
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 May 2023 04:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685359526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QiP7BFxT10yGcr7FtZErZq6l5Z39ttes77bUh96OvFU=;
        b=SgQf5s49zeWktQrC0Tds7v2ft6V+33BYhnaseDeUJ2J0nPcDDjBXjWMEqKxLPpWGIfpxyc
        A8MDZXmL+YoH243euRK/Sx7yNK4RSnTOUczEcsQq2X05Euujn/2HTALed0nXin3aB7/+Vz
        NeuuSzsYm/o6SuSzBwJCNlWZmjaCLzM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-Ync4HdfnN9GrkNgRGdf0aA-1; Mon, 29 May 2023 07:25:25 -0400
X-MC-Unique: Ync4HdfnN9GrkNgRGdf0aA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51496307313so1110180a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 May 2023 04:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685359524; x=1687951524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiP7BFxT10yGcr7FtZErZq6l5Z39ttes77bUh96OvFU=;
        b=P/HeZslQbGGFZdME9Xt+kptLV3ieose1Q3BkG+F2/l8F4xjUi9+LpXGCWoSV5LbVXv
         w3sGBTXRASGThXiMc81WQQIS+HIXNfBHqNm+HCelo1DuA1KwFPsTzeWDtHw3YEHcMNex
         JhhI6eNc+C0wGvbrDaOCfrYSTSWCE25FPFCFN67S636OpuI3ffnI28bHnJ2pE8BpWYa1
         l3V6VIOZaeN/5bIZejaKIvG/uHR7d5O7wD1iJ5FngfWU/d+wJmgOsSWWZK1NMF4DEcr4
         pFQIOjUoLksR1nS1XomXr5VCDzI3LhBkSpNjyXUNsbL6TzoN0XWAJtotEKVSyqXsqd7a
         i3qg==
X-Gm-Message-State: AC+VfDzyv9zh/UN8P4+9zo9RwCX2Py/+C3Q0Z8ep71cWEAauIYSxeoAj
        dZcoh/7QM5NpoZ4q0a1rHTvEk1xPMXKslci39MoaN7cj9N9iSGFLr3Dzof1EpUa4aqX7x4ENBv8
        qz+mxWKilYxvL7qfUf1gxfwPasXAitsV4
X-Received: by 2002:aa7:d3cb:0:b0:510:e80f:fa4e with SMTP id o11-20020aa7d3cb000000b00510e80ffa4emr7110188edr.1.1685359524528;
        Mon, 29 May 2023 04:25:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lK/aT5tTJA1o7fgmWGbF8O1nXzHMpx1okbozAGeSsnjjVzV4LPS1NMpynZaWFt7VVuEoigQ==
X-Received: by 2002:aa7:d3cb:0:b0:510:e80f:fa4e with SMTP id o11-20020aa7d3cb000000b00510e80ffa4emr7110168edr.1.1685359524190;
        Mon, 29 May 2023 04:25:24 -0700 (PDT)
Received: from [192.168.0.46] (host-87-12-203-248.business.telecomitalia.it. [87.12.203.248])
        by smtp.gmail.com with ESMTPSA id b13-20020a056402138d00b0050690bc07a3sm3050803edv.18.2023.05.29.04.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 04:25:23 -0700 (PDT)
Message-ID: <13f35387-6a8d-5c97-06bb-c09e74a37657@redhat.com>
Date:   Mon, 29 May 2023 13:25:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tracing/rv/rtla: Update MAINTAINERS file to point to
 proper mailing list
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20230529044002.0481452b@rorschach.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20230529044002.0481452b@rorschach.local.home>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 5/29/23 10:40, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The mailing list that goes to linux-trace-devel is for the tracing
> libraries, and the patchwork associated to the tracing libraries keys
> off of that mailing list.
> 
> For anything that lives in the Linux kernel proper (including the tools
> directory) must go through linux-trace-kernel, as the patchwork to that
> list keys off of the Linux kernel proper.
> 
> Update the MAINTAINERS file to reflect the proper mailing lists.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0ad886d3163..5bb6dccd6ea3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17808,7 +17808,7 @@ F:	tools/testing/selftests/rtc/
>  Real-time Linux Analysis (RTLA) tools
>  M:	Daniel Bristot de Oliveira <bristot@kernel.org>
>  M:	Steven Rostedt <rostedt@goodmis.org>
> -L:	linux-trace-devel@vger.kernel.org
> +L:	linux-trace-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/tools/rtla/
>  F:	tools/tracing/rtla/
> @@ -18370,7 +18370,7 @@ F:	drivers/infiniband/ulp/rtrs/
>  RUNTIME VERIFICATION (RV)
>  M:	Daniel Bristot de Oliveira <bristot@kernel.org>
>  M:	Steven Rostedt <rostedt@goodmis.org>
> -L:	linux-trace-devel@vger.kernel.org
> +L:	linux-trace-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/trace/rv/
>  F:	include/linux/rv.h

