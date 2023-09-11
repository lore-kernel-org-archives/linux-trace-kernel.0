Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316F1CA0ED4
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 11 Sep 2023 22:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359293AbjIKWQK (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 11 Sep 2023 18:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242467AbjIKPiC (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:38:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B939CE9;
        Mon, 11 Sep 2023 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sKUn8EnTz+SDHaW4B8cfnoOvswzmYO6s32I2l0TozS4=; b=Io1ANYkGCU0jFv/Kv1JcgdlKEj
        p84gfsN9vtCJu9PsGBfsZGyd2Ubu3o5AldbQ+y3PCa01qk4bRR31agZzilAK99oybX62wevKGxrv2
        fm3UWaQwCZu9tk8JspLHNpqfRBZjPQV/Gw6iNdzcY09YHJIr98GlJs58KvhucYzKwCeKwOo/C3ptI
        H55O9/v8YiSpDQGfpwEJjwsCxvBmunDjFsp8c4WKDPtck48kYoWA9c9NccNCCYd2k1INNPyk0jcYd
        k46J004G1ZIOTOf8Geytq01wGj9LDSID3QO0SQwZ2O3JW8K2Dwlcj6/qv+JDTBlU/DKa5539SH86N
        sMxfwQ5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qfiyk-001ixQ-0F; Mon, 11 Sep 2023 15:37:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A215C3005B2; Mon, 11 Sep 2023 17:37:33 +0200 (CEST)
Date:   Mon, 11 Sep 2023 17:37:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     corbet@lwn.net, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Change the name of preempt mode from full to
 low_latency
Message-ID: <20230911153733.GA3880@noisy.programming.kicks-ass.net>
References: <20230911110046.3877123-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911110046.3877123-1-yajun.deng@linux.dev>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 07:00:46PM +0800, Yajun Deng wrote:
> There is a similar name fully in Kconfig.preempt, but it corresponds to
> PREEMPT_RT. In order to distinguish them, change the name of preempt mode
> from full to low_latency.
> 
> Also, define a global array and variable that used to save preempt mode
> name and size.

Yeah, let's not rename this for giggles. Regular preemption is a fully
preemptible kernel model. No need to invent new names for it.
