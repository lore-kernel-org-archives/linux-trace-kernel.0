Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EFEEB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 28 Jun 2023 00:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjF1AvM (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 27 Jun 2023 20:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF1AvL (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 20:51:11 -0400
Received: from out-6.mta0.migadu.com (out-6.mta0.migadu.com [IPv6:2001:41d0:1004:224b::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B3A296D
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jun 2023 17:51:09 -0700 (PDT)
Message-ID: <282ad135-63c6-4094-5410-35982ae27c3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687913467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pYrLOEInFHKQlhe8boNYza5GcYlIQbXwpAeQuauBDww=;
        b=hHgvu2wfdVwgPEyrXd03GAEd37NnT8gEi8Xmq8NIhGmyxqJtRvIgl0YaRdcQu3et7KfOnK
        mBaXhPrDQxv6FcMpLgTvphOh8Gf7OW5g6jFyEXeG34pcZNa3EBdfu4wBfnyRMBq1UKVheh
        oy7JjrQJ6VZpZIehJyieBl0Ze/mvtWQ=
Date:   Wed, 28 Jun 2023 08:50:58 +0800
MIME-Version: 1.0
Subject: Re: Please help, I want kprobe.multi support on arm64, but regs is
 replaced by args
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "rostedt@goodmis.org >> Steven Rostedt" <rostedt@goodmis.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        bpf@vger.kernel.org
References: <0118f3b5-d13a-57f0-7a7f-41f59666d387@linux.dev>
 <20230628020606.b67d161c4d4f7e41bd466cd2@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jackie Liu <liu.yun@linux.dev>
In-Reply-To: <20230628020606.b67d161c4d4f7e41bd466cd2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi, Masami.

在 2023/6/28 01:06, Masami Hiramatsu (Google) 写道:
> Hi Jackie,
> 
> That is actiall what I'm working on now :)
> 
> Here is my previous implementation (but not applicable because now we need to
> remove kretprobe trampoline with it.)
> https://lore.kernel.org/all/164735287344.1084943.9787335632585653418.stgit@devnote2/
> 
> Let me explain my idea. I would like to replace the kretprobe with fprobe
> exit handler so that we can intgrate the function return hook with fgraph tracer.
> Currently fprobe entry/exit handler uses pt_regs, but I will replace it with
> ftrace_regs. And this means rethook has to work with ftrace_regs and it can not
> support kretprobes anymore on some arch (HAVE_RETHOOK but
>   !HAVE_DYNAMIC_FTRACE_WITH_REGS).
> 
> There are many good reasons, like;
> 
> - On some arch (e.g. arm64) can not emulate full pt_regs.
> - Saving full register on function entry/exit is not efficient.
> - Enabling both fgraph tracer and rethook are redundant.
> 
> This requires some changes on kprobe users like BPF and SystemTap, so I need to
> talk with them about
> 
> - Moving onto the fprobe to trace function entry/exit.
> - Using ftrace_regs API to access function argument and return value.
> 
> Anyway, I'll add CONFIG_DYNAMIC_FTRACE_WITH_REGS dependency to them until
> in-kernel stuffs are ready. It ensures ftrace_regs can be converted to
> pt_regs.

This is a great idea, thank you for your excellent work. We really need
it on arm64.

-- 
Jackie

> 
> I also introduced fprobe events, so I will send a series of patches how to do
> that (fprobe entry side has been done, working on rethook side).
> 
> Thank you,
> 
> 
> On Sun, 25 Jun 2023 16:27:44 +0800
> Jackie Liu <liu.yun@linux.dev> wrote:
> 
>> Hi, Mark Rutland and other developers.
>>
>> I am trying to implement the rethook of the arm64 platform, referring to
>> the code of other architectures, it can already run normally on the v6.1
>> branch, but after commit 26299b3f6ba2 ("ftrace: arm64: move from REGS to
>> ARGS"), regs is no longer supported, resulting in CONFIG_FPROBE is also
>> not supported (although RETHOOK is implemented). I try to revert the
>> patch, and kprobe.multi can be run correctly. Now, what should I do?
>> Should I roll back this patch or find a way to run fprobe without regs?
>>
>> Any help is welcome.
>>
>> --
>> Jackie Liu
> 
> 
