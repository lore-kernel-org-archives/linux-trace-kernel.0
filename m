Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979E5C74A5B
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 18 Mar 2023 18:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjCRSmL (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 18 Mar 2023 14:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRSmK (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 14:42:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57DC2A6D2;
        Sat, 18 Mar 2023 11:42:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57E85B80A1F;
        Sat, 18 Mar 2023 18:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F993C433D2;
        Sat, 18 Mar 2023 18:42:04 +0000 (UTC)
Date:   Sat, 18 Mar 2023 14:42:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing/selftests: Ignore __pfx_ symbols in kprobe test
Message-ID: <20230318144202.486c43d1@rorschach.local.home>
In-Reply-To: <20230213204643.39f86987@rorschach.local.home>
References: <20230207135147.5ce618d6@gandalf.local.home>
        <20230213204643.39f86987@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 13 Feb 2023 20:46:43 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Shuah,
> 
> Can you pick this patch up?

ping?

-- Steve
