Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AF3C0015E
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 13 Jul 2023 14:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjGMOvV (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 13 Jul 2023 10:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjGMOvU (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:51:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D2A2707;
        Thu, 13 Jul 2023 07:51:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34CAD61087;
        Thu, 13 Jul 2023 14:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE755C433C8;
        Thu, 13 Jul 2023 14:51:17 +0000 (UTC)
Date:   Thu, 13 Jul 2023 10:51:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Zhengyejian (Zetta)" <zhengyejian1@huawei.com>
Cc:     mhiramat <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] traing: Fix memory leak of iter->temp when reading
 trace_pipe
Message-ID: <20230713105029.6a160f43@gandalf.local.home>
References: <20230713141435.1133021-1-zhengyejian1@huawei.com>
        <20230713103353.29cae218@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 13 Jul 2023 14:44:04 +0000
"Zhengyejian (Zetta)" <zhengyejian1@huawei.com> wrote:

> Hi, Steve,
> 
> Please correct a typo in title: trainy -> tracing

 traing -> tracing ;-)

> 
> I'm a little hurry home from work :(
> I'll pay attention to it next time.

No problem. I made the fix.

But seriously, thanks for all the fixes you are sending my way!

-- Steve

