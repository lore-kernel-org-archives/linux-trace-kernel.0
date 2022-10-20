Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01993C433FE
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 20 Oct 2022 17:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJTRF3 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 20 Oct 2022 13:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJTRF2 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:05:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD030FA039;
        Thu, 20 Oct 2022 10:05:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18C4461CCC;
        Thu, 20 Oct 2022 17:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E4DC433C1;
        Thu, 20 Oct 2022 17:05:24 +0000 (UTC)
Date:   Thu, 20 Oct 2022 13:05:28 -0400
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
Message-ID: <20221020130528.5f7436c3@gandalf.local.home>
In-Reply-To: <20221020123357.0f90e823@gandalf.local.home>
References: <20221019200137.70343645@gandalf.local.home>
        <20221019200745.0152fc51@gandalf.local.home>
        <20221020155900.GM5600@paulmck-ThinkPad-P17-Gen-1>
        <20221020123357.0f90e823@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 20 Oct 2022 12:33:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c03fd7037add..79ac31a6a87b 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2748,9 +2748,12 @@ void trace_buffered_event_disable(void)
>  			       disable_trace_buffered_event, NULL, 1);
>  	preempt_enable();
>  
> +	if (!irqs_disabled())
> +		printk("IRQS DISABLED!! before %s:%d\n", __func__, __LINE__);
>  	/* Wait for all current users to finish */
> -	if (!early_boot_irqs_disabled)
> -		synchronize_rcu();
> +	synchronize_rcu();
> +	if (!irqs_disabled())
> +		printk("IRQS DISABLED!! after %s:%d\n", __func__, __LINE__);
>  
>  	for_each_tracing_cpu(cpu) {
>  		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));


Continuing the above printk()s I found the culprit.

synchronize_rcu() {
    rcu_poll_gp_seq_start_unlocked() {
	struct rcu_node *rnp = rcu_get_root();

	if (rcu_init_invoked()) {
		lockdep_assert_irqs_enabled();
		raw_spin_lock_irq_rcu_node(rnp);
	}
	rcu_poll_gp_seq_start(snap);
	if (rcu_init_invoked())
		raw_spin_unlock_irq_rcu_node(rnp);  <<-- Interrupts enabled here
   }



-- Steve
