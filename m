Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFA0EB64DB
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 14 Jun 2023 15:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbjFNPMR (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 14 Jun 2023 11:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245752AbjFNPMQ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:12:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17581FE3;
        Wed, 14 Jun 2023 08:12:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 670B864036;
        Wed, 14 Jun 2023 15:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65B8C433C8;
        Wed, 14 Jun 2023 15:12:13 +0000 (UTC)
Date:   Wed, 14 Jun 2023 11:12:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jackie Liu <liu.yun@linux.dev>
Subject: Re: [PATCHv2] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <20230614111212.4e33bfbc@gandalf.local.home>
In-Reply-To: <ZInLO4/xly/f+Zk3@krava>
References: <20230611130029.1202298-1-jolsa@kernel.org>
        <53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
        <20230611225407.3e9b8ad2@gandalf.local.home>
        <20230611225754.01350a50@gandalf.local.home>
        <d5ffd64c-65b7-e28c-b8ee-0d2ff9dcd78b@meta.com>
        <20230612110222.50c254f3@gandalf.local.home>
        <ZId/UL/iujOdgel+@krava>
        <ZInLO4/xly/f+Zk3@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 14 Jun 2023 16:14:19 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> FYI I did some perf meassurements and the speedup is not substantial :-\
> 
> looks like the symbols resolving to addresses we do in kernel for kprobe_multi
> link is more faster/cheaper than I thought 

The symbol lookup is supposed to be fast, but it's not "free", whereas this
is "free". I didn't expect a big speedup.

-- Steve


> 
> but still there is 'some' speedup and we will get rid of the extra
> /proc/kallsyms parsing, so I think it's still worth it to have the
> new file

