Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CD1C4332F
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 19 Dec 2022 22:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiLSWfN (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 19 Dec 2022 17:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLSWfM (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:35:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE9B6254;
        Mon, 19 Dec 2022 14:35:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA37D61183;
        Mon, 19 Dec 2022 22:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5A3C433EF;
        Mon, 19 Dec 2022 22:35:09 +0000 (UTC)
Date:   Mon, 19 Dec 2022 17:35:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Ross Zwisler <zwisler@google.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing/selftests: Add test for event filtering on
 function name
Message-ID: <20221219173507.410915a3@gandalf.local.home>
In-Reply-To: <5e3e9408-8ddd-3649-ef98-4bd611c528cc@linuxfoundation.org>
References: <20221219183106.518341498@goodmis.org>
        <20221219183214.075559302@goodmis.org>
        <Y6DQTvOrHRZ8gjDz@google.com>
        <5e3e9408-8ddd-3649-ef98-4bd611c528cc@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 19 Dec 2022 15:11:39 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 12/19/22 13:57, Ross Zwisler wrote:
> > On Mon, Dec 19, 2022 at 01:31:08PM -0500, Steven Rostedt wrote:  
> >> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >>
> >> With the new filter logic of passing in the name of a function to match an
> >> instruction pointer (or the address of the function), add a test to make
> >> sure that it is functional.
> >>
> >> This is also the first test to test plain filtering. The filtering has
> >> been tested via the trigger logic, which uses the same code, but there was
> >> nothing to test just the event filter, so this test is the first to add
> >> such a case.
> >>
> >> Cc: Shuah Khan <shuah@kernel.org>
> >> Cc: Shuah Khan <skhan@linuxfoundation.org>
> >> Cc: linux-kselftest@vger.kernel.org
> >> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> > 
> > Reviewed-by: Ross Zwisler <zwisler@google.com>  
> 
> Thank you both. I will apply this after rc1 comes out.

It's dependent on the first patch.

-- Steve

