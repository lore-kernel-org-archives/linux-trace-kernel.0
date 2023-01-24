Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132B1C54E94
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 24 Jan 2023 16:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjAXQjo (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 24 Jan 2023 11:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjAXQjj (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:39:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6CD6A43
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674578324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Rx2z0k7BUxOegxeHoQtWpkmv6MaMTCI5y68M3kfHOU=;
        b=hBw7qOFN4AU+ctsHpKjKSlQhPHJFQD5EpK459s0yUdYEH4tAAL3xSPrUVZhBM7ninBXrgP
        h+13+pBWBsfFNECz2tGNlBJPn2MyenG2VRbkH8J2kPqz53W6+XUdKqRdyYLeRkeDN2zJBb
        VMU8hi+idf0paysF8CQYIP6AjH1BBZo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-g2IJYhWjMAq9GX2SYIcPpw-1; Tue, 24 Jan 2023 11:38:42 -0500
X-MC-Unique: g2IJYhWjMAq9GX2SYIcPpw-1
Received: by mail-wm1-f70.google.com with SMTP id r15-20020a05600c35cf00b003d9a14517b2so11465316wmq.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Rx2z0k7BUxOegxeHoQtWpkmv6MaMTCI5y68M3kfHOU=;
        b=0O14pvt1MjsK4GIMSjq31jTV1pqw2zbQjVocpEugRIU02fdphRQYVYk1PEUHw3zr1g
         okahgxJpyT7DKGQygVx4NeqSjGn7/P05lvq8z19tWzwAod8/w++VzEDjuUVAGnwGk76V
         9qOwZYO1hl6qr0VvkKpVBRLu3Qw5TnW6mVizLI1x+1xhPnpA+rN24fQ123bYkC7wrMUd
         rQKQRWOndG9cHlLdYaYew03XvZPPA2CjiLPWIbf8ORwLKvJdlxflrBfWi6BPuQHZHiUN
         28S/ePoDB4EvlWHSwMZoWkKZta1FGvGZFghnwEHTCHt8NPWQLJ6cp81KZYBYKtL6JFtm
         3rZw==
X-Gm-Message-State: AFqh2kogWXAh5fclzj3Jjb4O1NtVepiz1j440E8VfSwL+3Vjk0sfOACQ
        4OoAOu4OJKs4j8QviJlCbRdj2ublns/VBPmqc8AFm7RA3IWXGytXazZD1KX41O/BHDuLtrbDfUr
        6t0MbVNguksbqyCjbwbmiYD52mW5OOWMz
X-Received: by 2002:a1c:4b19:0:b0:3da:fb5c:8754 with SMTP id y25-20020a1c4b19000000b003dafb5c8754mr25522202wma.2.1674578321649;
        Tue, 24 Jan 2023 08:38:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvVtbfb9k89pLyrSioWTGvup1rj2EisIjnE2x0FKAleLGpTUyvPeeUYg++4LJXskdcWl0OzyA==
X-Received: by 2002:a1c:4b19:0:b0:3da:fb5c:8754 with SMTP id y25-20020a1c4b19000000b003dafb5c8754mr25522189wma.2.1674578321360;
        Tue, 24 Jan 2023 08:38:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b003db0b0cc2afsm15324053wmq.30.2023.01.24.08.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:38:40 -0800 (PST)
Message-ID: <5844ee9f-1992-a62a-2141-3b694a1e1915@redhat.com>
Date:   Tue, 24 Jan 2023 17:38:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Stefan Roesch <shr@devkernel.io>, linux-mm@kvack.org
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, CGEL <cgel.zte@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>
References: <20230123173748.1734238-1-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RESEND RFC PATCH v1 00/20] mm: process/cgroup ksm support
In-Reply-To: <20230123173748.1734238-1-shr@devkernel.io>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 23.01.23 18:37, Stefan Roesch wrote:
> So far KSM can only be enabled by calling madvise for memory regions. What is
> required to enable KSM for more workloads is to enable / disable it at the
> process / cgroup level.

Did you stumble over the proposals from last year to enable this 
per-process [1] and system-wide [2]? I remember there was also regarding 
enabling it system-wide.

I'm going to point out the security aspect, and that e.g., Windows used 
to enable it system-wide before getting taught by security experts 
otherwise. Details on KSM and security aspects can be found in that thread.

Long story short: one has to be very careful with that and only enable 
it for very carefully selected worklads. Letting a workload opt-in on a 
VMA level is most probably safer than an admin blindly turning this on 
for random processes ...

Last attempts got nacked ...

[1] 
https://lore.kernel.org/all/20220517092701.1662641-1-xu.xin16@zte.com.cn/
[2] https://lore.kernel.org/all/20220609055658.703472-1-xu.xin16@zte.com.cn/

> 
> 1. New options for prctl system command
> This patch series adds two new options to the prctl system call. The first
> one allows to enable KSM at the process level and the second one to query the
> setting.
> 
> The setting will be inherited by child processes.
> 
> With the above setting, KSM can be enabled for the seed process of a cgroup
> and all processes in the cgroup will inherit the setting.
> 
> 2. Changes to KSM processing
> When KSM is enabled at the process level, the KSM code will iterate over all
> the VMA's and enable KSM for the eligible VMA's.
> 
> When forking a process that has KSM enabled, the setting will be inherited by
> the new child process.
> 
> In addition when KSM is disabled for a process, KSM will be disabled for the
> VMA's where KSM has been enabled.
> 
> 3. Add tracepoints to KSM
> Currently KSM has no tracepoints. This adds tracepoints to the key KSM functions
> to make it easier to debug KSM.
> 
> 4. Add general_profit metric
> The general_profit metric of KSM is specified in the documentation, but not
> calculated. This adds the general profit metric to /sys/kernel/debug/mm/ksm.
> 
> 5. Add more metrics to ksm_stat
> This adds the process profit and ksm type metric to /proc/<pid>/ksm_stat.
> 
> 6. Add more tests to ksm_tests
> This adds an option to specify the merge type to the ksm_tests. This allows to
> test madvise and prctl KSM. It also adds a new option to query if prctl KSM has
> been enabled. It adds a fork test to verify that the KSM process setting is
> inherited by client processes.
> 
> 
> Stefan Roesch (20):
>    mm: add new flag to enable ksm per process
>    mm: add flag to __ksm_enter
>    mm: add flag to __ksm_exit call
>    mm: invoke madvise for all vmas in scan_get_next_rmap_item
>    mm: support disabling of ksm for a process
>    mm: add new prctl option to get and set ksm for a process
>    mm: add tracepoints to ksm
>    mm: split off pages_volatile function
>    mm: expose general_profit metric
>    docs: document general_profit sysfs knob
>    mm: calculate ksm process profit metric
>    mm: add ksm_merge_type() function
>    mm: expose ksm process profit metric in ksm_stat
>    mm: expose ksm merge type in ksm_stat
>    docs: document new procfs ksm knobs
>    tools: add new prctl flags to prctl in tools dir
>    selftests/vm: add KSM prctl merge test
>    selftests/vm: add KSM get merge type test
>    selftests/vm: add KSM fork test
>    selftests/vm: add two functions for debugging merge outcome
> 
>   Documentation/ABI/testing/sysfs-kernel-mm-ksm |   8 +
>   Documentation/admin-guide/mm/ksm.rst          |   8 +-
>   MAINTAINERS                                   |   1 +
>   fs/proc/base.c                                |   5 +
>   include/linux/ksm.h                           |  19 +-
>   include/linux/sched/coredump.h                |   1 +
>   include/trace/events/ksm.h                    | 257 ++++++++++++++++++
>   include/uapi/linux/prctl.h                    |   2 +
>   kernel/sys.c                                  |  29 ++
>   mm/ksm.c                                      | 134 ++++++++-
>   tools/include/uapi/linux/prctl.h              |   2 +
>   tools/testing/selftests/vm/Makefile           |   3 +-
>   tools/testing/selftests/vm/ksm_tests.c        | 254 ++++++++++++++---
>   13 files changed, 665 insertions(+), 58 deletions(-)
>   create mode 100644 include/trace/events/ksm.h
> 
> 
> base-commit: c1649ec55708ae42091a2f1bca1ab49ecd722d55

-- 
Thanks,

David / dhildenb

