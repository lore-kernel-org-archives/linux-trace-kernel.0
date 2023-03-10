Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A0AC6FD1F
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 10 Mar 2023 15:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjCJPws (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 10 Mar 2023 10:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCJPwU (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:52:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E828125D8B;
        Fri, 10 Mar 2023 07:45:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1619B822E4;
        Fri, 10 Mar 2023 15:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03F5C4339B;
        Fri, 10 Mar 2023 15:45:00 +0000 (UTC)
Date:   Fri, 10 Mar 2023 10:44:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] tracing: Make tracepoint lockdep check actually test
 something
Message-ID: <20230310104458.4f3b1343@gandalf.local.home>
In-Reply-To: <20230310172758.38c1ec9c6272e41a579ff820@kernel.org>
References: <20230309165603.6967197d@gandalf.local.home>
        <20230310172758.38c1ec9c6272e41a579ff820@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 10 Mar 2023 17:27:58 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> This check has been introduced by commit 3a630178fd5f ("tracing: generate RCU
> warnings even when tracepoints are disabled"), and it also added a comment
> above this macro.
> 
>  * When lockdep is enabled, we make sure to always do the RCU portions of
>  * the tracepoint code, regardless of whether tracing is on. However,
>  * don't check if the condition is false, due to interaction with idle
>  * instrumentation. This lets us find RCU issues triggered with tracepoints
>  * even when this tracepoint is off. This code has no purpose other than
>  * poking RCU a bit.
> 
> I think at least the last sentence will be outdated by this fix.

Ah thanks, I forgot to update that part. What about:

  * When lockdep is enabled, we make sure to always test if RCU is
  * "watching" regardless if the tracepoint is enabled or not. Tracepoints
  * require RCU to be active, and it should always warn at the tracepoint
  * site if it is not watching, as it will need to be active when the
  * tracepoint is enabled.

?

-- Steve
