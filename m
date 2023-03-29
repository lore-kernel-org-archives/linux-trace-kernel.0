Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF77C6FD18
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 29 Mar 2023 12:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjC2MvS (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 29 Mar 2023 08:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjC2MvQ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:51:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE511707;
        Wed, 29 Mar 2023 05:51:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D8EF61CDE;
        Wed, 29 Mar 2023 12:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFC5C433D2;
        Wed, 29 Mar 2023 12:51:13 +0000 (UTC)
Date:   Wed, 29 Mar 2023 08:51:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230329085106.046a8991@rorschach.local.home>
In-Reply-To: <20230329070353.1e1b443b@gandalf.local.home>
References: <20230322102244.3239740-1-vdonnefort@google.com>
        <20230322102244.3239740-2-vdonnefort@google.com>
        <20230328224411.0d69e272@gandalf.local.home>
        <ZCQCsD9+nNwBYIyH@google.com>
        <20230329070353.1e1b443b@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 29 Mar 2023 07:03:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> struct ring_buffer_meta_page_header {
> #if __BITS_PER_LONG == 64
> 	__u64	entries;
> 	__u64	overrun;
> #else
> 	__u32	entries;
> 	__u32	overrun;
> #endif
> 	__u32	pages_touched;
> 	__u32	meta_page_size;
> 	__u32	reader_page;	/* page ID for the reader page */
> 	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
> };

Oh, I guess we should also expose the amount read on the reader page,
that gets updated on the ioctl. That is, if the first time we read the
reader page and the page is not full and unmap the pages, and then new
events were added to the reader page, we should not re-read the events
that were read previously.

That is, expose cpu_buffer->reader_page->read

-- Steve
