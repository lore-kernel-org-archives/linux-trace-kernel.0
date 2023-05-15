Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6936C7EE24
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 15 May 2023 18:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242260AbjEOShS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 15 May 2023 14:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244510AbjEOShJ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:37:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765A69019;
        Mon, 15 May 2023 11:37:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E71C622D6;
        Mon, 15 May 2023 18:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F04C433EF;
        Mon, 15 May 2023 18:37:02 +0000 (UTC)
Date:   Mon, 15 May 2023 14:37:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org, mark.rutland@arm.com,
        guoren@kernel.org, jszhang@kernel.org, e.shatokhin@yadro.com,
        bjorn@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH V10 4/4] samples: ftrace: Add riscv support for
 SAMPLE_FTRACE_DIRECT[_MULTI]
Message-ID: <20230515143700.26beeacf@gandalf.local.home>
In-Reply-To: <20230511093234.3123181-5-suagrfillet@gmail.com>
References: <20230511093234.3123181-1-suagrfillet@gmail.com>
        <20230511093234.3123181-5-suagrfillet@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 11 May 2023 17:32:34 +0800
Song Shuai <suagrfillet@gmail.com> wrote:

> select HAVE_SAMPLE_FTRACE_DIRECT and HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> for ARCH_RV64I in arch/riscv/Kconfig. And add riscv asm code for
> the ftrace-direct*.c files in samples/ftrace/.
> 
> Link: https://lore.kernel.org/linux-riscv/c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com/T/#ma13012560331c66b051b580b3ab4a04ba44455ec
> Tested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> Tested-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Acked-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>  arch/riscv/Kconfig                          |  2 ++
>  samples/ftrace/ftrace-direct-modify.c       | 34 ++++++++++++++++++
>  samples/ftrace/ftrace-direct-multi-modify.c | 40 +++++++++++++++++++++
>  samples/ftrace/ftrace-direct-multi.c        | 24 +++++++++++++
>  samples/ftrace/ftrace-direct-too.c          | 27 ++++++++++++++
>  samples/ftrace/ftrace-direct.c              | 23 ++++++++++++
>  6 files changed, 150 insertions(+)

I acked v8 (which you will need my ack to get these in). Unless this patch
changed since v8, you should include my ack in further versions.

Or you may be waiting longer for its acceptance.

If the patch did change, please acknowledge that in the next version (or
this one if it did change), asking me to ack it again.

-- Steve
