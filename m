Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73172C4332F
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  8 Dec 2022 22:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiLHW1c (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 8 Dec 2022 17:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLHW1a (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:27:30 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8171880A3A
        for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:27:19 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so3008023pjm.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 08 Dec 2022 14:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IQR25hXZloAZorduWX7OmeRW/OBJ2WK3euXwD9n9+OE=;
        b=jPWrXunVIw6xvwvb4APnqTacxKN8+MZTMZkPycGpLzVR9FwAdZtA7UpOUL7aRe6YXN
         nqULpExYr9dskSVj6kTkQDgo/gG+dW7WcPiYnZ0jKWPcG1Ri3o9BCskGQVC41G2LFFxM
         FjhYO449k6XP1vOsWydY5gc6Iz6eBa4fVKIaAz3ZwN5fXghuLUotRr31csVdNVWKUB4V
         WCbCSsZWweOWfFgw3js1GcWVoqpQ4wJ/uoK1NgFw21wA9vl/6gzV1lrXb74Q4OC2Z8aR
         4NwNBQYl5KhAH6UZgU4wCGsBplT6Q8fHQgwbpTKZ3nquUz2+hma/jaZlBivR7k5lrKW/
         q1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQR25hXZloAZorduWX7OmeRW/OBJ2WK3euXwD9n9+OE=;
        b=OZCU82NXaCSwYPT4YfOmU07vbJutlWfokvwlJOymehojiFPkc06cga4QTgIfxwbla5
         uCdOFnXYHOTbkmW++n8U12ngi33f/DqWhmc0I/gdlYzQ6e3W1i3boIaxuL+ANAi59iXg
         v+ZpXRwCbmnbq8wgHM/cWXjcrfw7I+uIN5RnswlhwzMxUPSRmCj2TFyB1P2ubErc+Ulj
         gzoUCOddKWCwuXtya4Kr6ietU6uGF9x5T1OdVXv5CFe3dzEWdfzqoApFvywZTcKyE2S+
         UafDMdzvHP5cdZthL69iGz00SdwXbvSlOEJd0rw6xMgfp7jtnk3LNYmWKQurkSpE7zCS
         jxcw==
X-Gm-Message-State: ANoB5pmX9c2qpKs0XaUzId8mq3imk0fKoVEYphzmFgGP8Yj94ucSUZ5U
        wZxaYVNPQ9wZDAmOKL+AR/lFGcSk1PCZ6rc5gstVkg==
X-Google-Smtp-Source: AA0mqf60mwXumrk4UCOpMfT9176Le5R3jMXkA3oyK0ZTsWhXOXgDFL3X4Sj0SNL7lP9IAszx/ccNAveyoVuDKUZD9X0=
X-Received: by 2002:a17:902:7682:b0:182:6c84:7ff4 with SMTP id
 m2-20020a170902768200b001826c847ff4mr86056876pll.25.1670538438538; Thu, 08
 Dec 2022 14:27:18 -0800 (PST)
MIME-Version: 1.0
References: <20221020210056.0d8d0a5b@gandalf.local.home>
In-Reply-To: <20221020210056.0d8d0a5b@gandalf.local.home>
From:   Ross Zwisler <zwisler@google.com>
Date:   Thu, 8 Dec 2022 15:27:07 -0700
Message-ID: <CAGRrVHw2ABuBtb+6BtES0WPNpbtu3p6vfZ-pADjtYYxm9kWZ4g@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: Add trace_trigger kernel command line option
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 7:00 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> Allow triggers to be enabled at kernel boot up. For example:
>
>   trace_trigger="sched_switch.stacktrace if prev_state == 2"
>
> The above will enable the stacktrace trigger on top of the sched_switch
> event and only trigger if its prev_state is 2 (TASK_UNINTERRUPTIBLE). Then
> at boot up, a stacktrace will trigger and be recorded in the tracing ring
> buffer every time the sched_switch happens where the previous state is
> TASK_INTERRUPTIBLE.
>
> Another useful trigger would be "traceoff" which can stop tracing on an
> event if a field of the event matches a certain value defined by the
> filter ("if" statement).
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

<>

> +#ifdef CONFIG_HIST_TRIGGERS

Can you help me understand why this is only available if
CONFIG_HIST_TRIGGERS is selected in the kernel config?  AFAICT this
code doesn't depend on the histogram code, and the run-time selection
of triggers is usable without CONFIG_HIST_TRIGGERS.

Thanks!

> +static void trace_early_triggers(struct trace_event_file *file, const char *name)
> +{
> +       int ret;
> +       int i;

<>
