Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1748FC636D4
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  7 Feb 2023 09:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjBGJdT (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 7 Feb 2023 04:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjBGJdS (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:33:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27E541EFD0;
        Tue,  7 Feb 2023 01:33:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4915D11FB;
        Tue,  7 Feb 2023 01:33:58 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA2CA3F71E;
        Tue,  7 Feb 2023 01:33:14 -0800 (PST)
Date:   Tue, 7 Feb 2023 09:33:11 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        revest@chromium.org, rostedt@goodmis.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ftrace: Add sample with custom ops
Message-ID: <Y+Ia1xLggfDTBUcH@FVFF77S0Q05N>
References: <20230103124912.2948963-1-mark.rutland@arm.com>
 <20230103124912.2948963-4-mark.rutland@arm.com>
 <20230206222516.GA873421@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206222516.GA873421@roeck-us.net>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 02:25:16PM -0800, Guenter Roeck wrote:
> On Tue, Jan 03, 2023 at 12:49:12PM +0000, Mark Rutland wrote:
> > +	pr_info("Attempted %u calls to %ps in %lluns (%lluns / call)\n",
> > +		nr_function_calls, tracee_relevant,
> > +		period, period / nr_function_calls);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Building csky:allmodconfig ... failed
> --------------
> Error log:
> ERROR: modpost: "__udivdi3" [samples/ftrace/ftrace-ops.ko] undefined!

Arnd sent a fix for this a week ago:

  https://lore.kernel.org/lkml/20230130130246.247537-1-arnd@kernel.org/

I believe Steve has been travelling and hasn't had the chance to pick that up
yet.

Thanks,
Mark.
