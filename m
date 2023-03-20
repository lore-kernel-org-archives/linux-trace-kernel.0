Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1F2C6FD1D
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 20 Mar 2023 13:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjCTNfk (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 20 Mar 2023 09:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCTNff (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E55BBBA
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679319286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UL6ZvX+vjCKaJ8maGzwsaH5uxn7gh6HZeTFGTMUfwTI=;
        b=Pzbl4aAG3TaolLhhc3l6QdSDcNsXkTiJjtSisTLSXTKheeiAb+a1kVJ6TsX+mq3bIoci7d
        fuLOHHgtakKjz00neQnDG0k+lEsVZ+vB6gMknf4Dlel+rWxcqYGk+CMkoLrCYNFvVcFTq5
        onlKQdPXdNLpQ1h+dj2FvVEgLwnhW+8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-BPyHfOaOOdiN0LauSH63AA-1; Mon, 20 Mar 2023 09:34:45 -0400
X-MC-Unique: BPyHfOaOOdiN0LauSH63AA-1
Received: by mail-wr1-f70.google.com with SMTP id j17-20020adfb311000000b002d660153278so320553wrd.20
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679319284;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UL6ZvX+vjCKaJ8maGzwsaH5uxn7gh6HZeTFGTMUfwTI=;
        b=hV7kbSBuDo+5V7paJJh1PpdR4rgOkj42BMrvuWZ4RTV347L3/3jkbeJw1JiG0eGUKo
         Wmlc4NF81Y6Qv4EhMx0zEuKruEIVSqAiCFfOlirKelmPOW3Jg93GIOQQIrk3pOzJOklO
         9E8tRrcNIKpc4cTLmT7964tNdOgNLYeRCCV8teUcV8/nWoafeFyFNcj2Z+DK762cr11H
         iPEWLc7NFTPEcXp404HzeDtFFvQJn/xjXy5k8ty8H4SbuNxpWEPmKsiUM1i4Y0EfKfCc
         g14zR77FILbmi3BFELrp6E0rGOTJrLSthZWkCdSNaFNyKbOW+Pg1jDvWlXbe3vioWsh7
         K6xg==
X-Gm-Message-State: AO0yUKXqTXZwR1y9fQvm/Pl+NU/qQvKgShcDu5luN5+soFkdhwvIfgYM
        aRm2MuiFTl5Hz4no1YehZLRRjxtTdCl3ACqqcXFiaD+HAoDq54IupTM5T+9FyHb5nM+6LkyA5Hl
        QYHi6cr7kbTRxMfQAfzeFKFkhXb9p68Qz
X-Received: by 2002:adf:dec9:0:b0:2d4:e032:6322 with SMTP id i9-20020adfdec9000000b002d4e0326322mr5820653wrn.31.1679319284010;
        Mon, 20 Mar 2023 06:34:44 -0700 (PDT)
X-Google-Smtp-Source: AK7set/Q81rpIrERD7ha3OcykcIz8yRM2cmG+OragzAJxFqbYZ6HxK/bVifpz+SZw9IO/LLzXVy7zQ==
X-Received: by 2002:adf:dec9:0:b0:2d4:e032:6322 with SMTP id i9-20020adfdec9000000b002d4e0326322mr5820642wrn.31.1679319283724;
        Mon, 20 Mar 2023 06:34:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id b4-20020a056000054400b002d672637520sm3454972wrf.96.2023.03.20.06.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 06:34:42 -0700 (PDT)
Message-ID: <70d9bf96-2623-d617-c03d-3c7f6c5cbf8b@redhat.com>
Date:   Mon, 20 Mar 2023 14:34:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: mmap: remove newline at the end of the trace
To:     Minwoo Im <minwoo.im.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <ZAu6qDsNPmk82UjV@minwoo-desktop>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZAu6qDsNPmk82UjV@minwoo-desktop>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 11.03.23 00:18, Minwoo Im wrote:
> We already have newline in TP_printk so remove the redundant newline
> character at the end of the mmap trace.
> 
> <...>-345     [006] .....    95.589290: exit_mmap: mt_mod ...
> 
> <...>-345     [006] .....    95.589413: vm_unmapped_area: addr=...
> 
> <...>-345     [006] .....    95.589571: vm_unmapped_area: addr=...
> 
> <...>-345     [006] .....    95.589606: vm_unmapped_area: addr=...
> 
> to
> 
> <...>-336     [006] .....    44.762506: exit_mmap: mt_mod ...
> <...>-336     [006] .....    44.762654: vm_unmapped_area: addr=...
> <...>-336     [006] .....    44.762794: vm_unmapped_area: addr=...
> <...>-336     [006] .....    44.762835: vm_unmapped_area: addr=...
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> ---
>   include/trace/events/mmap.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

