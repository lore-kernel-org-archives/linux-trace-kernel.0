Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6533BC001B0
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 11 Aug 2023 19:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjHKTp3 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 11 Aug 2023 15:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKTp2 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:45:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431F2E7E;
        Fri, 11 Aug 2023 12:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D16786373F;
        Fri, 11 Aug 2023 19:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A566C433C7;
        Fri, 11 Aug 2023 19:45:26 +0000 (UTC)
Date:   Fri, 11 Aug 2023 15:45:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuang Wang <nashuiliang@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/eprobe: Iterate trace_eprobe directly
Message-ID: <20230811154523.61e67cc3@gandalf.local.home>
In-Reply-To: <20230811081239.246365-1-nashuiliang@gmail.com>
References: <20230811081239.246365-1-nashuiliang@gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 11 Aug 2023 16:12:39 +0800
Chuang Wang <nashuiliang@gmail.com> wrote:

> +
> +#define for_each_trace_eprobe_on_trace_probe(ep, _tp) \
> +	list_for_each_entry(ep, trace_probe_probe_list(_tp), tp.list)
> +

As I replied to the other patch, but after this one was sent (sorry, I was
hyperfocused on my work the last couple of days and was not reading email,
so my INBOX is a bit full). I really hate the verbosity of that name.

At a minimum, let's call it:

  for_each_trace_point_eprobe()

-- Steve
