Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6D8C77B75
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 22 May 2023 13:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjEVNiq (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 22 May 2023 09:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjEVNip (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:38:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36CF1CD;
        Mon, 22 May 2023 06:38:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD12511FB;
        Mon, 22 May 2023 06:39:28 -0700 (PDT)
Received: from [10.57.22.146] (unknown [10.57.22.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D78173F67D;
        Mon, 22 May 2023 06:38:40 -0700 (PDT)
Message-ID: <88fcd266-301a-f6e1-cf1c-69c20e74ef35@arm.com>
Date:   Mon, 22 May 2023 14:38:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/3] Add basic tracing for uclamp and schedutil
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, qyousef@google.com,
        qyousef@layalina.io, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
References: <20230509122246.1702397-1-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230509122246.1702397-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi Rafael,



On 5/9/23 13:22, Lukasz Luba wrote:
> Hi all,
> 
> The task scheduler feature: Uclamp, begins to take off. To better understand
> the dynamics in the task scheduler and CPU frequency requests we need some
> better tracing.
> In schedutil (cpufreq governor) we allow to enter the scheduler
> and make the frequency change. Although, there is some limit in regards to how
> often this can happen. That min period is provided by the cpufreq driver.
> Thus, some of the cpufreq requests might be filter out and the frequency won't
> be changed (hopefuly will be set a bit later). We would like to know about
> those situations, especially in context of the user-space hints made via
> Uclamp for particular tasks.
> This patch set aims to add base for our toolkits and post-processing trace
> analyzes.
> 
> Changelog:
> v2:
> - solved the issue from CI build warning, dropped schedutil.h and re-used
>    the sched.h which is available in build_utility.c where cpufreq_schedutil.c
>    is included
> - added tag for the last patch 3/3 for the CI robot helping hend
> - re-based on top of v6.4-rc1
> v1:
> - implementation can be found here [1]
> 

I was going to gently ping you, while I've realized that you
are not on CC list :( I don't know what happened, my apologies.

Shell I resend this patch set so you can have it in a proper way
in your mailbox?

Could you have a look at this, please?

This is getting more attention, since in Android we have a
daemon which can now communicate with the kernel and send
those Uclamp values on behalf of an unprivileged app.

Regards,
Lukasz
