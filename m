Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FCAC64ED6
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 28 Feb 2023 19:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjB1Tfy (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 28 Feb 2023 14:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjB1Tfw (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:35:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDF534C34;
        Tue, 28 Feb 2023 11:35:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30B4B61169;
        Tue, 28 Feb 2023 19:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160FBC433D2;
        Tue, 28 Feb 2023 19:35:48 +0000 (UTC)
Date:   Tue, 28 Feb 2023 14:35:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/3] Improve trace/ring_buffer.c
Message-ID: <20230228143547.52f30201@gandalf.local.home>
In-Reply-To: <20230228175929.7534-1-ubizjak@gmail.com>
References: <20230228175929.7534-1-ubizjak@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 28 Feb 2023 18:59:26 +0100
Uros Bizjak <ubizjak@gmail.com> wrote:

> This series improves ring_buffer.c by changing the type of some
> static functions to void or bool and

Well, it's not really an improvement unless it has a functional change. But
I'm OK with taking these.

> uses try_cmpxchg instead of
> cmpxchg (*ptr, old, new) == old where appropriate.

Now, the try_cmpxchg() could be an improvement on x86.

-- Steve

> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Uros Bizjak (3):
>   ring_buffer: Change some static functions to void
>   ring_buffer: Change some static functions to bool
>   ring_buffer: Use try_cmpxchg instead of cmpxchg
> 
>  kernel/trace/ring_buffer.c | 89 ++++++++++++++++----------------------
>  1 file changed, 37 insertions(+), 52 deletions(-)
> 

