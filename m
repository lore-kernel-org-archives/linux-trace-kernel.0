Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22201EE4993
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 21 Aug 2023 15:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbjHUPUC (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 21 Aug 2023 11:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjHUPUC (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:20:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3FFE2;
        Mon, 21 Aug 2023 08:20:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40FE663B00;
        Mon, 21 Aug 2023 15:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7119C433C8;
        Mon, 21 Aug 2023 15:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692631199;
        bh=hCGF6qt8Noi0KSVKaDcPq7ou5X9OQBuu9WQgc6AjGpQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SFSINwz8jEtrZiz3uWIy231NCb4N3CKMeE/MlcwnZu+ZuodGAEkdmtthh/E+u6j88
         EG+Dw0do/g7+O4AvGecgdxkrnJ9hTKkwaxe9kPhunCooRQEZfp8hEa4e0aSA0RK7aH
         bw9hOAL3wG+loSOSrjTixEhD+6Ibt+K6+iR7s2LFmwWK9FoXwF7CMAYawGx/jT0gy3
         F7G8PKuLI+vfi1BnU5gDUDeFghHmopouJUqlpXXvwdoRNrXMyaHSigBLF+gk67WYCy
         gF2bhKNn4vCwU632gH5lSR9p5+f/qBOpQvqdKZ09dbClMMWgvd0VQCZeqzdFPKTpZx
         kzwzowsElcnig==
Date:   Tue, 22 Aug 2023 00:19:55 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Song Liu <song@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-Id: <20230822001955.d326dbfe7a5755c9684b26cb@kernel.org>
In-Reply-To: <20230821102943.758dca19@gandalf.local.home>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
        <20230818213705.b4f5e18b392c4837068cba6f@kernel.org>
        <20230818114141.2a3a75ee@gandalf.local.home>
        <4853240.31r3eYUQgx@pwmachine>
        <20230818142033.1d7685e9@gandalf.local.home>
        <20230819101519.568d658fbb6461cc60d348e5@kernel.org>
        <CAPhsuW7d4cMi_FAtvyTn4HJWzRdocJaEVq-uYVcW43=JDE_EnA@mail.gmail.com>
        <20230820183218.bf0b04be3c0ccac5e7b2a587@kernel.org>
        <CAPhsuW73yT+D9HhLhi8pafYZsgT=qsqk5foAwGRTvStnWCZwNA@mail.gmail.com>
        <20230821102943.758dca19@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 21 Aug 2023 10:29:43 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 20 Aug 2023 03:02:18 -0700
> Song Liu <song@kernel.org> wrote:
> 
> > > For the "unique symbol" + offset, you don't need the kallsyms, but need to
> > > access the System.map or vmlinux image. In this case, we don't need to expand
> > > the CAP_PERFMON capabilities.  
> > 
> > I agree this is not needed in this case. But I wonder whether it makes sense
> > to give CAP_PERFMON access to /proc/kallsyms. Will this change make
> > CAP_PERFMON less secure?
> 
> I guess the question is, does CAP_PERFMON allow seeing where the kernel
> mapped itself via some other means? If not, then no, I would nack this as
> being a security hole.

As Song said, CAP_PERFMON allows user to put a kprobe anywhere user specified,
and it can run BPF program on it. This means it can access raw address
information via registers. if so, CAP_PERFMON allows seeing the kernel map or
equivalent information at this point.

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
