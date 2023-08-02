Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A146C001E0
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  2 Aug 2023 11:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjHBLpb (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 2 Aug 2023 07:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjHBLpb (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:45:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DA2213D;
        Wed,  2 Aug 2023 04:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A0BB61939;
        Wed,  2 Aug 2023 11:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D124DC433C8;
        Wed,  2 Aug 2023 11:45:27 +0000 (UTC)
Date:   Wed, 2 Aug 2023 07:45:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v5 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20230802074526.2fa479ab@gandalf.local.home>
In-Reply-To: <20230801132603.0b18c0eb@gandalf.local.home>
References: <20230728164754.460767-1-vdonnefort@google.com>
        <20230728164754.460767-2-vdonnefort@google.com>
        <20230801132603.0b18c0eb@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 1 Aug 2023 13:26:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > +
> > +	if (READ_ONCE(cpu_buffer->mapped)) {
> > +		/* Ensure the meta_page is ready */
> > +		smp_rmb();
> > +		WRITE_ONCE(cpu_buffer->meta_page->pages_touched,
> > +			   local_read(&cpu_buffer->pages_touched));
> > +	}  
> 
> I was thinking instead of doing this in the semi fast path, put this logic
> into the rb_wakeup_waiters() code. That is, if a task is mapped, we call
> the irq_work() to do this for us. It could even do more, like handle
> blocked mapped waiters.

I was thinking how to implement this, and I worry that it may cause an irq
storm. Let's keep this (and the other locations) as is, where we do the
updates in place. Then we can look at seeing if it is possible to do it in
a delayed fashion another time.

-- Steve
