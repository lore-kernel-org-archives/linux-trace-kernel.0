Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4139EE498E
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 18 Aug 2023 18:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379400AbjHRSU5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 18 Aug 2023 14:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241209AbjHRSU2 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03D312A;
        Fri, 18 Aug 2023 11:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F6E56380D;
        Fri, 18 Aug 2023 18:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FA2C433C8;
        Fri, 18 Aug 2023 18:20:26 +0000 (UTC)
Date:   Fri, 18 Aug 2023 14:20:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-ID: <20230818142033.1d7685e9@gandalf.local.home>
In-Reply-To: <4853240.31r3eYUQgx@pwmachine>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
        <20230818213705.b4f5e18b392c4837068cba6f@kernel.org>
        <20230818114141.2a3a75ee@gandalf.local.home>
        <4853240.31r3eYUQgx@pwmachine>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 18 Aug 2023 20:13:43 +0200
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> Hi.
> 
> Le vendredi 18 août 2023, 17:41:41 CEST Steven Rostedt a écrit :
> > On Fri, 18 Aug 2023 21:37:05 +0900
> > 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:  
> > > That's why perf probe uses the offset from '_text'. Normal KASLR will just
> > > moves all symbols. (Finer one will move all symbols randomely)
> > > This should not need to access /proc/kallsyms but vmlinux or SystemMap.  
> > 
> > We could just pass in: "_text+offset" too.  
> 
> So, the idea would be to change the existing create_local_trace_kprobe() and 
> above functions to indicate the user's offset is to be used against _text and 
> not address?

No, not to modify that function, but if you know the offset from _text (via
the vmlinux), you can easily calculate it for that function.

I mentioned having a way to pass in the vmlinux debug info address and
subtract the kaslr_offset from it. But that's actually unnecessary. If you
have the address of the function you want, and the address of _text, both
from the debug info of vmlinux, you can simply pass in "_text+offset", and
then use kallsyms to give you _text, and add the offset to give you the
address for create_local_trace_kprobe().

-- Steve
