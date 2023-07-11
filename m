Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95579EB64DC
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 11 Jul 2023 16:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGKQUV (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 11 Jul 2023 12:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjGKQUF (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:20:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9722704;
        Tue, 11 Jul 2023 09:19:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60F0461556;
        Tue, 11 Jul 2023 16:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FADC433C7;
        Tue, 11 Jul 2023 16:19:12 +0000 (UTC)
Date:   Tue, 11 Jul 2023 12:19:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] Revert "tracing: Add "(fault)" name injection to
 kernel probes"
Message-ID: <20230711121910.1ac49973@gandalf.local.home>
In-Reply-To: <168908495772.123124.1250788051922100079.stgit@devnote2>
References: <168908491977.123124.16583481716284477889.stgit@devnote2>
        <168908495772.123124.1250788051922100079.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 11 Jul 2023 23:15:57 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> This reverts commit 2e9906f84fc7c99388bb7123ade167250d50f1c0.
> 
> It was turned out that commit 2e9906f84fc7 ("tracing: Add "(fault)"
> name injection to kernel probes") did not work correctly and probe
> events still show just '(fault)' (instead of '"(fault)"'). Also,
> current '(fault)' is more explicit that it faulted.
> 
> This also moves FAULT_STRING macro to trace.h so that synthetic
> event can keep using it, and uses it in trace_probe.c too.
> 
> Link: https://lore.kernel.org/all/20230706230642.3793a593@rorschach.local.home/
> 
> Cc: stable@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Tom Zanussi <zanussi@kernel.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
