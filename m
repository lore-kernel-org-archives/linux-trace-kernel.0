Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27C5C4332F
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 20 Oct 2022 22:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJTWXs (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJTWXs (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:23:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAA321CD7F;
        Thu, 20 Oct 2022 15:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4FE9BCE25B7;
        Thu, 20 Oct 2022 22:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB709C433D6;
        Thu, 20 Oct 2022 22:23:42 +0000 (UTC)
Date:   Thu, 20 Oct 2022 18:23:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Add trace_trigger kernel command line option
Message-ID: <20221020182347.3c09f718@gandalf.local.home>
In-Reply-To: <20221020222108.GZ5600@paulmck-ThinkPad-P17-Gen-1>
References: <20221019200137.70343645@gandalf.local.home>
        <20221019200745.0152fc51@gandalf.local.home>
        <20221020155900.GM5600@paulmck-ThinkPad-P17-Gen-1>
        <20221020123357.0f90e823@gandalf.local.home>
        <20221020130528.5f7436c3@gandalf.local.home>
        <20221020175512.GT5600@paulmck-ThinkPad-P17-Gen-1>
        <20221020145340.5feef48f@gandalf.local.home>
        <20221020222108.GZ5600@paulmck-ThinkPad-P17-Gen-1>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 20 Oct 2022 15:21:08 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> My plan is to push it in after a bit of testing.  The Fixes tag should
> make the right -stable stuff happen.

Great, thanks!

I'll resend my patch without the synchronize_rcu() avoidance.

-- Steve
