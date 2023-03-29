Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8ACC6FD18
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 29 Mar 2023 01:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjC2BBj (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 28 Mar 2023 21:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjC2BBh (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:01:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C761724;
        Tue, 28 Mar 2023 18:01:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F9A7618E6;
        Wed, 29 Mar 2023 01:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758E9C433EF;
        Wed, 29 Mar 2023 01:01:33 +0000 (UTC)
Date:   Tue, 28 Mar 2023 21:01:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     patchwork-bot+f2fs@kernel.org,
        Douglas RAILLARD <douglas.raillard@arm.com>, chao@kernel.org,
        mhiramat@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix f2fs_truncate_partial_nodes ftrace
 event
Message-ID: <20230328210131.7a057a63@gandalf.local.home>
In-Reply-To: <ZCOH9pc3hBKU3G3Z@google.com>
References: <20230306122549.236561-1-douglas.raillard@arm.com>
        <167821082479.1693.18260840022075703789.git-patchwork-notify@kernel.org>
        <20230328190306.3337b7b0@gandalf.local.home>
        <ZCOH9pc3hBKU3G3Z@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 28 Mar 2023 17:36:06 -0700
Jaegeuk Kim <jaegeuk@kernel.org> wrote:

> > I'm hoping you are not waiting for the merge window to get this in. Please
> > get it to Linus before rc5 is out, because I plan on adding my patch[1]
> > which will cause this to fail the build at rc5.
> > 
> > The above is a fix to bug that causes unwanted results. Please get it into
> > mainline ASAP.  
> 
> Thanks for heads-up. I sent a pull request having the above patch to Linus.
> 
> https://lore.kernel.org/linux-f2fs-devel/ZCOHd4jYn8zUCEZ0@google.com/T/#u

Much appreciated!

-- Steve
