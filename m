Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A02AC77B61
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 25 Apr 2023 01:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjDYBkD (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 24 Apr 2023 21:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjDYBkC (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 21:40:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC573AF0A;
        Mon, 24 Apr 2023 18:40:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4641E6203D;
        Tue, 25 Apr 2023 01:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E2DC433EF;
        Tue, 25 Apr 2023 01:39:59 +0000 (UTC)
Date:   Mon, 24 Apr 2023 21:39:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] tracing/user_events: Ensure bit is cleared on
 unregister
Message-ID: <20230424213957.55c503c1@rorschach.local.home>
In-Reply-To: <20230411211709.15018-3-beaub@linux.microsoft.com>
References: <20230411211709.15018-1-beaub@linux.microsoft.com>
        <20230411211709.15018-3-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 11 Apr 2023 14:17:08 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> +static int user_event_mm_clear_bit(struct user_event_mm *user_mm,
> +				   unsigned long uaddr, unsigned char bit)
> +{
> +	struct user_event_enabler enabler;
> +	int result;
> +
> +	memset(&enabler, 0, sizeof(enabler));
> +	enabler.addr = uaddr;
> +	enabler.values = bit;
> +retry:
> +	/* Prevents state changes from racing with new enablers */
> +	mutex_lock(&event_mutex);
> +
> +	/* Force the bit to be cleared, since no event is attached */
> +	mmap_read_lock(user_mm->mm);
> +	result = user_event_enabler_write(user_mm, &enabler, false);
> +	mmap_read_unlock(user_mm->mm);
> +
> +	mutex_unlock(&event_mutex);
> +
> +	if (result) {
> +		/* Attempt to fault-in and retry if it worked */
> +		if (!user_event_mm_fault_in(user_mm, uaddr))
> +			goto retry;

Without looking into the functions of this call, I wonder if this can
get into an infinite loop?

-- Steve


> +	}
> +
> +	return result;
> +}
> +
