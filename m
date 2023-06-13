Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC57EB64D7
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 13 Jun 2023 19:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjFMT0c convert rfc822-to-8bit (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjFMT0b (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:26:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE441BFB;
        Tue, 13 Jun 2023 12:26:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8628663A24;
        Tue, 13 Jun 2023 19:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B798C433F0;
        Tue, 13 Jun 2023 19:26:09 +0000 (UTC)
Date:   Tue, 13 Jun 2023 15:26:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, ast@kernel.org,
        dcook@linux.microsoft.com
Subject: Re: [PATCH v2 3/5] tracing/user_events: Add auto cleanup and a flag
 to persist events
Message-ID: <20230613152606.3ace5547@gandalf.local.home>
In-Reply-To: <20230605233900.2838-4-beaub@linux.microsoft.com>
References: <20230605233900.2838-1-beaub@linux.microsoft.com>
        <20230605233900.2838-4-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon,  5 Jun 2023 16:38:58 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

Continuing on what Alexei was saying ...

> +	/*
> +	 * Unfortunately we have to attempt the actual destroy in a work
> +	 * queue. This is because not all cases handle a trace_event_call
> +	 * being removed within the class->reg() operation for unregister.
> +	 */
> +	INIT_WORK(&user->put_work, delayed_destroy_user_event);

We initialize the work here.

> +
> +	/*
> +	 * Since the event is still in the hashtable, we have to re-inc
> +	 * the ref count to 1. This count will be decremented and checked
> +	 * in the work queue to ensure it's still the last ref. This is
> +	 * needed because a user-process could register the same event in
> +	 * between the time of event_mutex release and the work queue
> +	 * running the delayed destroy. If we removed the item now from
> +	 * the hashtable, this would result in a timing window where a
> +	 * user process would fail a register because the trace_event_call
> +	 * register would fail in the tracing layers.
> +	 */
> +	refcount_set(&user->refcnt, 1);
> +
> +	if (!schedule_work(&user->put_work)) {

From what I understand, schedule_work() can only fail if the work is
already queued. That should never happen if we just initialized it.

That means we need a WARN_ON_ONCE() here. Because it's a major bug if that
does return false.

-- Steve


> +		/*
> +		 * If we fail we must wait for an admin to attempt delete or
> +		 * another register/close of the event, whichever is first.
> +		 */
> +		pr_warn("user_events: Unable to queue delayed destroy\n");
> +	}
