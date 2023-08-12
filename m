Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AC4C001DB
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 12 Aug 2023 21:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjHLVIq (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 12 Aug 2023 17:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjHLVIq (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 17:08:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF3D1738;
        Sat, 12 Aug 2023 14:08:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C31E661CF4;
        Sat, 12 Aug 2023 21:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686F6C433C7;
        Sat, 12 Aug 2023 21:08:47 +0000 (UTC)
Date:   Sat, 12 Aug 2023 17:08:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        <laijs@cn.fujitsu.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix race when concurrently splice_read
 trace_pipe
Message-ID: <20230812170839.2e4f2f22@rorschach.local.home>
In-Reply-To: <0b83d0e5-5fe6-0cfb-4695-23c2cb86526d@huawei.com>
References: <20230810123905.1531061-1-zhengyejian1@huawei.com>
 <20230811204257.99df8ba60d591f5bace38615@kernel.org>
 <f7af687f-2376-fede-fa22-f776811c48f1@huawei.com>
 <20230811152413.76d5b72e@gandalf.local.home>
 <0b83d0e5-5fe6-0cfb-4695-23c2cb86526d@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat, 12 Aug 2023 10:22:43 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> > And if it wasn't consumed? We just lost it?  
> 
> If 'iter->ent' was not consumed, trace_find_next_entry_inc() will find
> it again, will it?

No it will not, because it did the "inc". That means the next time it
is called, it will find the next item to read, thinking it already
"consumed" the last one.

-- Steve
