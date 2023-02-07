Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CB6C636CC
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  7 Feb 2023 18:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBGSyI (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBGSyH (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:54:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49F7103;
        Tue,  7 Feb 2023 10:54:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 814E261137;
        Tue,  7 Feb 2023 18:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFBCC433EF;
        Tue,  7 Feb 2023 18:54:05 +0000 (UTC)
Date:   Tue, 7 Feb 2023 13:54:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing/selftests: Ignore __pfx_ symbols in kprobe test
Message-ID: <20230207135402.38f73bb6@gandalf.local.home>
In-Reply-To: <20230207135147.5ce618d6@gandalf.local.home>
References: <20230207135147.5ce618d6@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 7 Feb 2023 13:51:47 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The kprobe probepoint.tc test started failing because of the added __pfx_
> symbols that were added because of -fpatchable-function-entry=X,Y causing
> unwinders to see them as part of the previous functions. But kprobes can
> not be added on top of them. The selftest looks for tracefs_create_dir and
> picks it and the previous and following functions to add at their address.
> This caused it to include __pfx_tracefs_create_dir which is invalid to
> attach a kprobe to and caused the test to fail.
> 
> Fixes: 9f2899fe36a62 ("objtool: Add option to generate prefix symbols")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

This is assuming that kprobes can not be added on top of these. But another
solution could be to have kprobes just pick the function the __pfx_ is for.
Would that be a better solution?

-- Steve
