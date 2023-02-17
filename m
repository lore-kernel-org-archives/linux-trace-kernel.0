Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9138DC636D4
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 17 Feb 2023 11:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBQLdM (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 17 Feb 2023 06:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjBQLdL (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:33:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CD46534F
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676633544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tFo2Wp9IgQFuBh3x/erGvc1GmA/wqCVf+VmHpdKFEto=;
        b=QuXk/thUj3WHgMFMLM48tGBF/XbYYbWcs9u3Pqs7K7aLeHno9U8+83jws1Oiv12iZhw3NI
        tgCUTOy1zSpUPlTEd17HDYOHsBpkrTe9NY4UkVxO+Mg0P0CN4KPt5hEa+0ch4h57dinfiU
        DReV9A7oZzQcoqPdfiqYJeKzB7ipQ9g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-47-v35uj21zMayaoi3tjeW3Hw-1; Fri, 17 Feb 2023 06:32:22 -0500
X-MC-Unique: v35uj21zMayaoi3tjeW3Hw-1
Received: by mail-wm1-f70.google.com with SMTP id bi27-20020a05600c3d9b00b003e1e7d3db06so525391wmb.5
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:32:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFo2Wp9IgQFuBh3x/erGvc1GmA/wqCVf+VmHpdKFEto=;
        b=TVaPDhhXrhBnsQhr/68JCM0/QRoNcHjYmy9BMyubjTLRH5RP6pahoOO5clpnYqpzjf
         P5fcg1pi4ibxPhtzoSgCTIgVijGXbmKOjgLCM8dGpk10cAks+K25eop/bhMrqr5qtyd5
         Tckyn3fJVUdSgjqg+FxojYYQoihWfyL7tXJIJe9ngdN/uu3CHdV5N9qz6N7wnkF5yumt
         StKfK0veikPin+GhIMZwj66qROB76aU4bpaf5QnP/OnMJ739KtNuhFO8HJcmhvzenjQh
         YFAcNT6EU4QqIzAV/KC0Ssl9iP8G2j9pvv0QcyUTJN3Vf5agn55e5/Rej/b4NI2yCidW
         SNUw==
X-Gm-Message-State: AO0yUKUwkQxztkLVrOCdbiEFJOoMyZpLY/iW9OvQfNKpayCvAO3tfeHS
        uRHUCwp/cm3okeWvXSv/YoM5Y/z1qNwRZgisfCBHs7cpSQRKFhxNprZsWT/GB25Ibt/4cfgrmib
        r5laNgV64/Dc6ZaAwZydJtUM2KG1K5lyO
X-Received: by 2002:a05:6000:4:b0:2c5:941d:26b8 with SMTP id h4-20020a056000000400b002c5941d26b8mr3462313wrx.15.1676633541794;
        Fri, 17 Feb 2023 03:32:21 -0800 (PST)
X-Google-Smtp-Source: AK7set9z0VSv6vFYFUxc2JibA5rMdRqfesKqozBYoDdDZVR545b93kHzqNt5eh1OEGIsB0X5uIeL8A==
X-Received: by 2002:a05:6000:4:b0:2c5:941d:26b8 with SMTP id h4-20020a056000000400b002c5941d26b8mr3462290wrx.15.1676633541462;
        Fri, 17 Feb 2023 03:32:21 -0800 (PST)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id n13-20020adfe34d000000b002c546d169ddsm4038181wrj.11.2023.02.17.03.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 03:32:20 -0800 (PST)
Message-ID: <45e343f7-9b1b-fb23-30ee-4ba59b6dfa62@redhat.com>
Date:   Fri, 17 Feb 2023 12:32:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To:     Ross Zwisler <zwisler@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>, kvm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20230215223350.2658616-1-zwisler@google.com>
 <20230215223350.2658616-5-zwisler@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/6] tools/kvm_stat: use canonical ftrace path
In-Reply-To: <20230215223350.2658616-5-zwisler@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 2/15/23 23:33, Ross Zwisler wrote:
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> 
> But, from Documentation/trace/ftrace.rst:
> 
>    Before 4.1, all ftrace tracing control files were within the debugfs
>    file system, which is typically located at /sys/kernel/debug/tracing.
>    For backward compatibility, when mounting the debugfs file system,
>    the tracefs file system will be automatically mounted at:
> 
>    /sys/kernel/debug/tracing
> 
> A comment in kvm_stat still refers to this older debugfs path, so let's
> update it to avoid confusion.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
>   tools/kvm/kvm_stat/kvm_stat | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/kvm/kvm_stat/kvm_stat b/tools/kvm/kvm_stat/kvm_stat
> index 6f28180ffeea..15bf00e79e3f 100755
> --- a/tools/kvm/kvm_stat/kvm_stat
> +++ b/tools/kvm/kvm_stat/kvm_stat
> @@ -627,7 +627,7 @@ class TracepointProvider(Provider):
>           name)'.
>   
>           All available events have directories under
> -        /sys/kernel/debug/tracing/events/ which export information
> +        /sys/kernel/tracing/events/ which export information
>           about the specific event. Therefore, listing the dirs gives us
>           a list of all available events.
>   

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

