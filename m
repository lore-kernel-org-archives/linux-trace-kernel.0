Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05A0C71159
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 18 Aug 2023 15:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241171AbjHRPlr (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 18 Aug 2023 11:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378270AbjHRPlg (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:41:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854182D4F;
        Fri, 18 Aug 2023 08:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AA9662761;
        Fri, 18 Aug 2023 15:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8685C433C8;
        Fri, 18 Aug 2023 15:41:33 +0000 (UTC)
Date:   Fri, 18 Aug 2023 11:41:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-ID: <20230818114141.2a3a75ee@gandalf.local.home>
In-Reply-To: <20230818213705.b4f5e18b392c4837068cba6f@kernel.org>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
        <20230816163517.112518-2-flaniel@linux.microsoft.com>
        <20230816144213.0f24cc62@gandalf.local.home>
        <4852847.31r3eYUQgx@pwmachine>
        <20230817111303.47b50197@gandalf.local.home>
        <20230818213705.b4f5e18b392c4837068cba6f@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 18 Aug 2023 21:37:05 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> That's why perf probe uses the offset from '_text'. Normal KASLR will just
> moves all symbols. (Finer one will move all symbols randomely)
> This should not need to access /proc/kallsyms but vmlinux or SystemMap.

We could just pass in: "_text+offset" too.

-- Steve
