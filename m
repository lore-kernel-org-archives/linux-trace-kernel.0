Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7EBC7EE2E
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 10 Jun 2023 08:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjFJI2q (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 10 Jun 2023 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjFJI2p (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 04:28:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18743A98;
        Sat, 10 Jun 2023 01:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B8D261DE0;
        Sat, 10 Jun 2023 08:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E59AC433EF;
        Sat, 10 Jun 2023 08:28:38 +0000 (UTC)
Date:   Sat, 10 Jun 2023 09:28:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Florent Revest <revest@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, kpsingh@kernel.org, xukuohai@huaweicloud.com
Subject: Re: [PATCH 0/2] Ftrace direct call samples improvements
Message-ID: <ZIQ0NBiNOEkzC33Q@arm.com>
References: <20230427140700.625241-1-revest@chromium.org>
 <20230609162046.13d19398@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609162046.13d19398@gandalf.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 04:20:46PM -0400, Steven Rostedt wrote:
> On Thu, 27 Apr 2023 16:06:58 +0200
> Florent Revest <revest@chromium.org> wrote:
> 
> > This series is a subset of [1] that didn't go through the arm64 tree.
> > 
> > - The first patch fixes a small bug when a direct call sample is loaded on x86
> > - The second patch adds arm64 support to all direct calls samples
> > 
> > They are sent together because the second one depends on the first one.
> > 
> > This series applies cleanly on Linus's master branch. It needs the first two
> > patches of [1] which, at the time of writing, don't seem to have made it to the
> > trace/linux-trace tree but I suppose they could be pulled from Linus's master
> > 
> > 1: https://lore.kernel.org/bpf/20230405180250.2046566-1-revest@chromium.org/
> > 
> > Florent Revest (2):
> >   samples: ftrace: Save required argument registers in sample
> >     trampolines
> >   arm64: ftrace: Add direct call trampoline samples support
> 
> Is this going through the arm64 tree, or should it go through mine?

Feel free to take it through your tree.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
