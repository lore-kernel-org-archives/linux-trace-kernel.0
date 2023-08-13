Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C18EC001E0
	for <linux-trace-kernel@archiver.kernel.org>; Sun, 13 Aug 2023 01:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjHMBNX (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 12 Aug 2023 21:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHMBNW (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 21:13:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA17710C;
        Sat, 12 Aug 2023 18:13:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4893861387;
        Sun, 13 Aug 2023 01:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DBFC433C8;
        Sun, 13 Aug 2023 01:13:19 +0000 (UTC)
Date:   Sat, 12 Aug 2023 21:13:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <mhiramat@kernel.org>, <laijs@cn.fujitsu.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracing: Fix race when concurrently splice_read
 trace_pipe
Message-ID: <20230812211317.6d015e1d@rorschach.local.home>
In-Reply-To: <b5dbdbeb-be3a-3434-0909-0697d8cb15bf@huawei.com>
References: <20230810123905.1531061-1-zhengyejian1@huawei.com>
        <20230811152525.2511f8f0@gandalf.local.home>
        <b5dbdbeb-be3a-3434-0909-0697d8cb15bf@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat, 12 Aug 2023 15:38:12 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> Reproduction testcase is show as below, it can always reproduce the
> issue in v5.10, and after this patch, the testcase passed.
> 
> In v5.10, when run `cat trace_pipe > /tmp/myfile &`, it call
> sendfile() to transmit data from trace_pipe into /tmp/myfile. And in
> kernel, .splice_read() of trace_pipe is called then the issue is
> reproduced.
> 
> However in the newest v6.5, this reproduction case didn't run into the
> .splice_read() of trace_pipe, because after commit 97ef77c52b78 ("fs:
> check FMODE_LSEEK to control internal pipe splicing"), non-seekable
> trace_pipe cannot be sendfile-ed.

So the test case cannot be run because the "sendfile" on the
trace_pipe now fails?

I'm not sure if this is considered a user space regression or not, but
I figured I'd let the interested parties know.

I don't know what tools out there records trace_pipe via sendfile, but
there might be some.

-- Steve
