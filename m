Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBF5C7EE2F
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 12 Jun 2023 15:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238842AbjFLPC2 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 12 Jun 2023 11:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239171AbjFLPC0 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:02:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D51186;
        Mon, 12 Jun 2023 08:02:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7244461629;
        Mon, 12 Jun 2023 15:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C75C433EF;
        Mon, 12 Jun 2023 15:02:23 +0000 (UTC)
Date:   Mon, 12 Jun 2023 11:02:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yonghong Song <yhs@meta.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jackie Liu <liu.yun@linux.dev>
Subject: Re: [PATCHv2] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <20230612110222.50c254f3@gandalf.local.home>
In-Reply-To: <d5ffd64c-65b7-e28c-b8ee-0d2ff9dcd78b@meta.com>
References: <20230611130029.1202298-1-jolsa@kernel.org>
        <53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
        <20230611225407.3e9b8ad2@gandalf.local.home>
        <20230611225754.01350a50@gandalf.local.home>
        <d5ffd64c-65b7-e28c-b8ee-0d2ff9dcd78b@meta.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 12 Jun 2023 07:49:53 -0700
Yonghong Song <yhs@meta.com> wrote:

> I am actually interested in how available_filter_functions_addrs
> will be used. For example, bpf_program__attach_kprobe_multi_opts()
> can already take addresses from kallsyms. How to use
> available_filter_functions_addrs to facilitate kprobe_multi?
> Do we need to change kernel APIs? It would be great at least we
> got a RFC patch to answer these questions.

I agree, having that information would also be useful to me.

Jiri? Andrii?

-- Steve
