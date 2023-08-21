Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F57EE4996
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 21 Aug 2023 14:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjHUOtm (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 21 Aug 2023 10:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbjHUOtm (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:49:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC8311C;
        Mon, 21 Aug 2023 07:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB38463B00;
        Mon, 21 Aug 2023 14:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4772C433C7;
        Mon, 21 Aug 2023 14:48:48 +0000 (UTC)
Date:   Mon, 21 Aug 2023 10:49:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-docs@vger.kernel.org
Subject: Re: [PATCH] tracefs: Fix kernel-doc warnings
Message-ID: <20230821104901.1e15079e@gandalf.local.home>
In-Reply-To: <ZONu6+WAjUXNKn7l@casper.infradead.org>
References: <20230818201414.2729745-1-willy@infradead.org>
        <20230821100146.5379a9c2@gandalf.local.home>
        <ZONu6+WAjUXNKn7l@casper.infradead.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 21 Aug 2023 15:04:27 +0100
Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Aug 21, 2023 at 10:01:46AM -0400, Steven Rostedt wrote:
> > This is one of the cases I disagree with kerneldoc. I mean, this isn't a
> > public structure (it's only in this file) so I don't expect it to be
> > parsed. These three fields act as one. Having them in the kerneldoc format
> > above makes them look as three distinct fields. Perhaps the solution is to
> > get rid of the starting /** so that it's no longer in kerneldoc format.  
> 
> Yes, take it out of kernel-doc's purview by removing that second *.
> I don't think you need me to send a v2 patch to do that ;-)

Yep, I'll do it.

Thanks!

-- Steve
