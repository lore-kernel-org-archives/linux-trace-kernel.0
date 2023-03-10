Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9A2C6FA99
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 10 Mar 2023 13:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCJNxb (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjCJNxV (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:53:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D489A1F93A;
        Fri, 10 Mar 2023 05:53:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 391F4617D5;
        Fri, 10 Mar 2023 13:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB50C433D2;
        Fri, 10 Mar 2023 13:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678456386;
        bh=bAL2Stu3la6pUSVNpMt5rhR+kUG6q+Mxcy+8qzYdYg0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pnHzzjX1ULl10LX6eRmwSlLHSE9mVp1W4D6p8V2r0hPMZMAGKJVAsV5EVAKxKjrpU
         T0LGwlILXepp788/dxJiiE6P1Fb6IheNxTdEjpx3GKn8HlLkl1RMPR6c7HEi3iXn4K
         mZPhzKYIc4qftUOJAnMIxfvi9iAAtjCxos4Z1wbL2YDAgoDPYKuKHY0m1bnCHZ5yj+
         xC7m/KIQfRxoDVO+W2RkTExu2RxzolP2aMEiLsnTrshE6Y0FCk4A0KY3vr+LwKCK6p
         fdo+VNWc0FGdl4aZkNtDfuQtpKsRJGnPhtZC/pK93maaZNyHdfY35LlNR1JPm7RrAN
         jfvqiUxmxr6cg==
Message-ID: <675a89a7-5db1-dda4-de4c-ffa947fa0a21@kernel.org>
Date:   Fri, 10 Mar 2023 14:53:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] tracing/osnoise: set several trace_osnoise.c variables
 storage-class-specifier to static
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230309150414.4036764-1-trix@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230309150414.4036764-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 3/9/23 16:04, Tom Rix wrote:
> smatch reports several similar warnings
> kernel/trace/trace_osnoise.c:220:1: warning:
>   symbol '__pcpu_scope_per_cpu_osnoise_var' was not declared. Should it be static?
> kernel/trace/trace_osnoise.c:243:1: warning:
>   symbol '__pcpu_scope_per_cpu_timerlat_var' was not declared. Should it be static?
> kernel/trace/trace_osnoise.c:335:14: warning:
>   symbol 'interface_lock' was not declared. Should it be static?
> kernel/trace/trace_osnoise.c:2242:5: warning:
>   symbol 'timerlat_min_period' was not declared. Should it be static?
> kernel/trace/trace_osnoise.c:2243:5: warning:
>   symbol 'timerlat_max_period' was not declared. Should it be static?
> 
> These variables are only used in trace_osnoise.c, so it should be static
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

-- Daniel
