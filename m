Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB36C7EE26
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 23 May 2023 14:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjEWOen (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 23 May 2023 10:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjEWOem (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:34:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2DE119;
        Tue, 23 May 2023 07:34:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3431763330;
        Tue, 23 May 2023 14:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43B9C433EF;
        Tue, 23 May 2023 14:34:39 +0000 (UTC)
Date:   Tue, 23 May 2023 10:34:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        Qing Zhang <zhangqing@loongson.cn>
Subject: Re: [PATCH v2 4/5] LoongArch: ftrace: Add direct call trampoline
 samples support
Message-ID: <20230523103438.7be15275@rorschach.local.home>
In-Reply-To: <1682561552-32324-5-git-send-email-tangyouling@loongson.cn>
References: <1682561552-32324-1-git-send-email-tangyouling@loongson.cn>
        <1682561552-32324-5-git-send-email-tangyouling@loongson.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 27 Apr 2023 10:12:31 +0800
Youling Tang <tangyouling@loongson.cn> wrote:

> The ftrace samples need per-architecture trampoline implementations
> to save and restore argument registers around the calls to
> my_direct_func* and to restore polluted registers (eg: ra).
> 
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  arch/loongarch/Kconfig                      |  2 +
>  samples/ftrace/ftrace-direct-modify.c       | 34 +++++++++++++++++
>  samples/ftrace/ftrace-direct-multi-modify.c | 41 +++++++++++++++++++++
>  samples/ftrace/ftrace-direct-multi.c        | 25 +++++++++++++
>  samples/ftrace/ftrace-direct-too.c          | 27 ++++++++++++++
>  samples/ftrace/ftrace-direct.c              | 23 ++++++++++++
>  6 files changed, 152 insertions(+)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
