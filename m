Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57239C77B7E
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 25 May 2023 16:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240089AbjEYQuV (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 25 May 2023 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbjEYQuS (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CFF195;
        Thu, 25 May 2023 09:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54D4260B39;
        Thu, 25 May 2023 16:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1129C433EF;
        Thu, 25 May 2023 16:50:14 +0000 (UTC)
Date:   Thu, 25 May 2023 17:50:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tracing: avoid missing-prototype warnings
Message-ID: <ZG+RxIIpF50ORGRS@arm.com>
References: <20230517125215.930689-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517125215.930689-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:51:48PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> These are all tracing W=1 warnings in arm64 allmodconfig about missing
> prototypes:
> 
> kernel/trace/trace_kprobe_selftest.c:7:5: error: no previous prototype for 'kprobe_trace_selftest_target' [-Werror=missing-pro
> totypes]
> kernel/trace/ftrace.c:329:5: error: no previous prototype for '__register_ftrace_function' [-Werror=missing-prototypes]
> kernel/trace/ftrace.c:372:5: error: no previous prototype for '__unregister_ftrace_function' [-Werror=missing-prototypes]
> kernel/trace/ftrace.c:4130:15: error: no previous prototype for 'arch_ftrace_match_adjust' [-Werror=missing-prototypes]
> kernel/trace/fgraph.c:243:15: error: no previous prototype for 'ftrace_return_to_handler' [-Werror=missing-prototypes]
> kernel/trace/fgraph.c:358:6: error: no previous prototype for 'ftrace_graph_sleep_time_control' [-Werror=missing-prototypes]
> arch/arm64/kernel/ftrace.c:460:6: error: no previous prototype for 'prepare_ftrace_return' [-Werror=missing-prototypes]
> arch/arm64/kernel/ptrace.c:2172:5: error: no previous prototype for 'syscall_trace_enter' [-Werror=missing-prototypes]
> arch/arm64/kernel/ptrace.c:2195:6: error: no previous prototype for 'syscall_trace_exit' [-Werror=missing-prototypes]
> 
> Move the declarations to an appropriate header where they can be seen
> by the caller and callee, and make sure the headers are included where
> needed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
