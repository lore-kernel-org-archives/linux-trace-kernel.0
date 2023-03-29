Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8018C6FD18
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 29 Mar 2023 13:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjC2NLX (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 29 Mar 2023 09:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjC2NLV (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:11:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF3C4C33;
        Wed, 29 Mar 2023 06:11:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A927561CEB;
        Wed, 29 Mar 2023 13:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24174C433EF;
        Wed, 29 Mar 2023 13:11:16 +0000 (UTC)
Date:   Wed, 29 Mar 2023 09:11:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230329091107.408d63a8@rorschach.local.home>
In-Reply-To: <ZCQ2jW5Jl/cWCG7s@google.com>
References: <20230322102244.3239740-1-vdonnefort@google.com>
        <20230322102244.3239740-2-vdonnefort@google.com>
        <20230328224411.0d69e272@gandalf.local.home>
        <ZCQCsD9+nNwBYIyH@google.com>
        <20230329070353.1e1b443b@gandalf.local.home>
        <20230329085106.046a8991@rorschach.local.home>
        <ZCQ2jW5Jl/cWCG7s@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 29 Mar 2023 14:01:01 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > Oh, I guess we should also expose the amount read on the reader page,
> > that gets updated on the ioctl. That is, if the first time we read the
> > reader page and the page is not full and unmap the pages, and then new
> > events were added to the reader page, we should not re-read the events
> > that were read previously.
> > 
> > That is, expose cpu_buffer->reader_page->read  
> 
> Couldn't it be an issue of updating cpu_buffer->reader_page->read during the
> ioctl? I guess we would write the value of the current written events on that
> page, hopping for the userspace reader to read it all.
> 
> But then if new events are written, the reader doesn't need the ioctl to read
> them, it can just check the meta->entries field or the commit field in the
> reader_page header?
> 
> So it's much likely cpu_buffer->reader_page->read will go out of sync?

Here's the issue I found during testing:

write 10 events to ring buffer (all go into the reader page)

Run application that maps the pages, and reads the 10 events, and exits.

Write 10 more events to ring buffer (all are appended to the reader page)

Run application that maps the pages and reads 20 events, and exits.

It read the 10 previous events, but should not have. It should have
only read the last 10 that were not read previously.

-- Steve
