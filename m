Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87546C76196
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  6 Apr 2023 13:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbjDFNt7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 6 Apr 2023 09:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbjDFNty (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:49:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038D293C5;
        Thu,  6 Apr 2023 06:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9300960E06;
        Thu,  6 Apr 2023 13:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9518EC4339B;
        Thu,  6 Apr 2023 13:49:50 +0000 (UTC)
Date:   Thu, 6 Apr 2023 09:49:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Leonardo =?UTF-8?B?QnLDoXM=?= <leobras@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with
 smp_call_function*()
Message-ID: <20230406094947.6b92084c@gandalf.local.home>
In-Reply-To: <cf8d18d80222c561da1865514734d92e0e2fb3d5.camel@redhat.com>
References: <20230406075718.68672-1-leobras@redhat.com>
        <20230406081501.pS4ZnWaK@linutronix.de>
        <cf8d18d80222c561da1865514734d92e0e2fb3d5.camel@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 06 Apr 2023 05:42:13 -0300
Leonardo Brás <leobras@redhat.com> wrote:

> Hello Sebastian, thanks for the heads up!
> 
> IIUC Valentin is adding/improving tracepoints that are collected in the
> requesting CPU, at the moment of scheduling the IPI, which are also useful.
> 
> But on my scenario, would be nice to actually have the information on the time
> window in which the requested function is running in the requested CPU. 
> 

Well once you know the functions that are being called (running your test
case with the IPI trace events), then you can get the timings of those same
functions by:

 # cd /sys/kernel/tracing
 # echo '<space-delimited-list-of-functions>' > set_ftrace_filter
 # echo function_graph > current_tracer

Then the function graph will give you those timings.

-- Steve
