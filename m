Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A65C636D3
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  8 Feb 2023 22:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjBHWDK (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 8 Feb 2023 17:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjBHWDJ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 17:03:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A238F18157;
        Wed,  8 Feb 2023 14:03:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A3F2617EE;
        Wed,  8 Feb 2023 22:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4C5C433EF;
        Wed,  8 Feb 2023 22:03:06 +0000 (UTC)
Date:   Wed, 8 Feb 2023 17:03:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] tracing/selftests: Ignore __pfx_ symbols in kprobe test
Message-ID: <20230208170304.388c1786@gandalf.local.home>
In-Reply-To: <Y+PkVD1+myADYns+@hirez.programming.kicks-ass.net>
References: <20230207135147.5ce618d6@gandalf.local.home>
        <20230207135402.38f73bb6@gandalf.local.home>
        <Y+PkVD1+myADYns+@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 8 Feb 2023 19:05:08 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > This is assuming that kprobes can not be added on top of these. But another
> > solution could be to have kprobes just pick the function the __pfx_ is for.
> > Would that be a better solution?  
> 
> Simply refusing them is simplest. I don't see a compelling reason to
> make this complicated.

OK, so you are good with the patch as is then?

-- Steve
