Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F825C4332F
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  2 Nov 2022 23:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKBX7q (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 2 Nov 2022 19:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiKBX7o (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:59:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8797F2AF5;
        Wed,  2 Nov 2022 16:59:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DD62B8257C;
        Wed,  2 Nov 2022 23:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5B7C433C1;
        Wed,  2 Nov 2022 23:59:40 +0000 (UTC)
Date:   Wed, 2 Nov 2022 19:59:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Li Huafei <lihuafei1@huawei.com>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: Fix use-after-free for dynamic ftrace_ops
Message-ID: <20221102195938.477dad9f@rorschach.local.home>
In-Reply-To: <20221101230716.22c7b52728990f6b192795c0@kernel.org>
References: <20221101064146.69551-1-lihuafei1@huawei.com>
        <20221101230716.22c7b52728990f6b192795c0@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 1 Nov 2022 23:07:16 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> But I'm not sure what commit this is fixed. Maybe commit a4c35ed24112
> ("ftrace: Fix synchronization location disabling and freeing ftrace_ops").
> Steve, can you add Fixed: ?

I would associate it to:

Fixes: edb096e00724f ("ftrace: Fix memleak when unregistering dynamic ops when tracing disabled")

-- Steve
