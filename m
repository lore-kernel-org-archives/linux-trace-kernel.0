Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5EFC7112B
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 18 Aug 2023 12:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352358AbjHRMhd (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 18 Aug 2023 08:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376968AbjHRMhL (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:37:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1E83A98;
        Fri, 18 Aug 2023 05:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD5376199F;
        Fri, 18 Aug 2023 12:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC5BC433C7;
        Fri, 18 Aug 2023 12:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692362229;
        bh=ZjnyShxsSZ84NGbzounZUkS+y6G0oLM7+tiT2QRq7Qc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NEf4yxeZedv+vFkN+1U+XIf7gqAVurCKtszW+5UJMps7Qqa3MaAyBuHCM0ec4MG7m
         bCjE+5cr8pNlhvGVRO5yoJeCJIcbh69EiuItRc+cdhSwncECCZWpxAiKbbVKYvxjLz
         Kxz4dV9yIuwYCwHOVt5gszZQMkGSbYu83KxX9JcEnNGsgEjV+EaaZGH4Klo5+KXikx
         ZwlRMvnxXXUanpTTqzjgsHlRojg1W+ir7rF7YAx5ATra+VTZs051kFMuMe2QamNQ6D
         iEiQ76tJ276NnUCKyzOEZr6wb8/tFiMk+1+iUwE7O8A+4e91lPgCLslpzL+EhQaPHE
         pPhMoUVEkL9/g==
Date:   Fri, 18 Aug 2023 21:37:05 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-Id: <20230818213705.b4f5e18b392c4837068cba6f@kernel.org>
In-Reply-To: <20230817111303.47b50197@gandalf.local.home>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
        <20230816163517.112518-2-flaniel@linux.microsoft.com>
        <20230816144213.0f24cc62@gandalf.local.home>
        <4852847.31r3eYUQgx@pwmachine>
        <20230817111303.47b50197@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 17 Aug 2023 11:13:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 17 Aug 2023 12:59:30 +0200
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> 
> > > Why can't you just pass in the address like sysfs does?  
> > 
> > To get the addresses from /proc/kallsyms, you need to either have CAP_SYSLOG 
> > or even CAP_SYS_ADMIN.
> > But to call perf_event_open(), you only need CAP_PERFMON.
> > This way, by giving only the name you can trace function with less privileges 
> > (i.e. without CAP_SYS_ADMIN).
> > Please correct me if I am wrong as I am not an expert in knowing the minimal 
> > set of capabilities you need to trace.
> 
> I wonder if we should add an option to put in the non-relocated address?
> One that can be acquired by debuginfo in the vmlinux. I'm assuming that the
> kernel has access to the added offset (I haven't looked). If it does, then
> we could allow users to just add something like "+@0xffffffffdeadbeef" and
> add the relocation offset to get to the mapped address of the function.

That's why perf probe uses the offset from '_text'. Normal KASLR will just
moves all symbols. (Finer one will move all symbols randomely)
This should not need to access /proc/kallsyms but vmlinux or SystemMap.

Thank you,

> 
> This would allow those without kallsym privileges to pass in kernel address
> for tracing.
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
