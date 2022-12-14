Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481F5C4332F
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 14 Dec 2022 00:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiLNAD3 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 13 Dec 2022 19:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237071AbiLNAD0 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:03:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4374E6268;
        Tue, 13 Dec 2022 16:03:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E5CE6177B;
        Wed, 14 Dec 2022 00:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882E1C433EF;
        Wed, 14 Dec 2022 00:03:23 +0000 (UTC)
Date:   Tue, 13 Dec 2022 19:03:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter
 on boot up
Message-ID: <20221213190321.379c6c2c@gandalf.local.home>
In-Reply-To: <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
References: <20221213172429.7774f4ba@gandalf.local.home>
        <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 14 Dec 2022 08:49:54 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Avoid calling the synchronization function when system_state is
> > SYSTEM_BOOTING.  
> 
> Shouldn't this be done inside tracepoint_synchronize_unregister()?
> Then, it will prevent similar warnings if we expand boot time feature.

I thought about that, but because this is a special case, I was thinking
that we don't just gloss over it and have something call this when it
shouldn't be in early boot up. I was surprised when it was called, and then
had to debug it a bit to figure out why it was. When I discovered the path
it took to get there, I realized it was legitimate.

Right now, I only see this one case as an exception. If more pop up that
are correct, then we can switch it over. But right now, I still want
calling tracepoint_synchronize_unregister() to warn if it is called in
early boot up, because that could be a sign that something went wrong.

-- Steve
