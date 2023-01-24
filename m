Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DB2C25B4E
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 24 Jan 2023 18:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjAXSCl (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 24 Jan 2023 13:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjAXSCk (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:02:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7A6269A
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674583313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4GsIE1GSxlV0HQh0Yz88+Hk9WYYpPDJ0PT4qaQWpMU=;
        b=aaeGC+34WKZWxyf2VlNhw77HUUwtOtCLH5p0H+WkUfN303ra9nLF5yEE0eIolG4j7AcRk0
        IrWnbJMOzwYlLSgRIcmKWsUARTLL2QoV2cvsa2aKOHPnvD4U90MIVyzNif3yf6zS5PM56a
        WrKnbGEFsL3pkIdwDnOmg+z5BVU/6wM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-269-8rIWy46qNpi5ff1-BNeQqA-1; Tue, 24 Jan 2023 13:01:52 -0500
X-MC-Unique: 8rIWy46qNpi5ff1-BNeQqA-1
Received: by mail-wr1-f70.google.com with SMTP id j30-20020adfb31e000000b002be008be32cso2816827wrd.13
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4GsIE1GSxlV0HQh0Yz88+Hk9WYYpPDJ0PT4qaQWpMU=;
        b=tLEmFOCu617Cu05jYPQkMC41fWjsNTgfKl6M1ED2a/0HlPklM6x8jC0BoQm3GO4gJW
         imv36REzoI6PPVA1gQvtsVzP0Adi1G32MkJGOV+8KAcLURjAc2H24MNh/xtoOwYI4Xmg
         lANtuRBz2Wf5tLPYdFvs3oIIg4kAEcpbv5lNDZu0SjiK9KFP2epuDDdBexUUG4TFhjzh
         ZNWnVy/92dGjfAEdIgeirceRMt+B+vxW6adupJrvYo60DtlMWeoGn1Wof3otw8xnYkrz
         qm48+085JKXEEejWlDGwVpqOi9EQWN23p37C/AHJWYf3u8QYG+mCA1klxX7KZGSt5uQ8
         NqiA==
X-Gm-Message-State: AO0yUKW5POsFnySYGFdjkgQ+eY3VJ/C29UgtXpOux2Y4X5q8uE7psAOD
        KbbxTmPAuC+YLfjJ8fxyvj6bTdV+agYufBXYuaABsGavB/gK8pTp68rCwVItpSlFIziku8rimZ4
        oREMGaKJUnBZUNcbr8h5E3b5DP0e1TRF7
X-Received: by 2002:a5d:4685:0:b0:2bf:ae16:98f4 with SMTP id u5-20020a5d4685000000b002bfae1698f4mr3118741wrq.30.1674583310908;
        Tue, 24 Jan 2023 10:01:50 -0800 (PST)
X-Google-Smtp-Source: AK7set+f/wEQyb7wiJGifDkW4tcgmJixb8037hpkHxzpE8CVSRS/wpQrWTf9+ZFjZ9BMojqBqe5nlA==
X-Received: by 2002:a5d:4685:0:b0:2bf:ae16:98f4 with SMTP id u5-20020a5d4685000000b002bfae1698f4mr3118719wrq.30.1674583310617;
        Tue, 24 Jan 2023 10:01:50 -0800 (PST)
Received: from [192.168.3.108] (p5b0c62c4.dip0.t-ipconnect.de. [91.12.98.196])
        by smtp.gmail.com with ESMTPSA id q6-20020adff946000000b002bdd155ca4dsm2410577wrr.48.2023.01.24.10.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 10:01:49 -0800 (PST)
Message-ID: <a391e98c-88af-886c-0426-c41c9980afa1@redhat.com>
Date:   Tue, 24 Jan 2023 19:01:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Stefan Roesch <shr@devkernel.io>
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, CGEL <cgel.zte@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>
References: <20230123173748.1734238-1-shr@devkernel.io>
 <5844ee9f-1992-a62a-2141-3b694a1e1915@redhat.com>
 <qvqwbkmnj014.fsf@dev0134.prn3.facebook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RESEND RFC PATCH v1 00/20] mm: process/cgroup ksm support
In-Reply-To: <qvqwbkmnj014.fsf@dev0134.prn3.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

[...]

>> I'm going to point out the security aspect, and that e.g., Windows used to
>> enable it system-wide before getting taught by security experts otherwise.
>> Details on KSM and security aspects can be found in that thread.
>>
> If I'm not mistaken the security aspect exists today. When KSM is
> enabled with madvise this is the same.

Yes, and we mostly only use it for virtual machines -- and to be 
precise, guest memory only -- where it has to be enabled explicitly on a 
well documented basis ...

Impossible for an admin to force it on other parts of the hypervisor 
process that might be more security sensitive. Or on other arbitrary 
applications, for now.

> 
>> Long story short: one has to be very careful with that and only enable it for
>> very carefully selected worklads. Letting a workload opt-in on a VMA level is
>> most probably safer than an admin blindly turning this on for random processes
>> ... >>
[...]

>>
>> [1] https://lore.kernel.org/all/20220517092701.1662641-1-xu.xin16@zte.com.cn/
>> [2] https://lore.kernel.org/all/20220609055658.703472-1-xu.xin16@zte.com.cn/
>>
> My understanding is that there were problems with the patch and how it
> exposed KSM. The other objection was the enable-all configuration
> option.

I don't remember all the discussions, but one concern was how to handle 
processes that deliberately want to disable it on some parts of memory.

Anyhow, I cc'ed the relevant parties already.

-- 
Thanks,

David / dhildenb

