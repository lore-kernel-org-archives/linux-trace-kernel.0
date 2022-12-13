Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546CCC4332F
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 13 Dec 2022 00:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiLMAcG (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 12 Dec 2022 19:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiLMAbi (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:31:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46542702;
        Mon, 12 Dec 2022 16:30:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18E266119B;
        Tue, 13 Dec 2022 00:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC665C433EF;
        Tue, 13 Dec 2022 00:30:41 +0000 (UTC)
Date:   Mon, 12 Dec 2022 19:30:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Douglas Raillard <douglas.raillard@arm.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] tracing: Remove pointer (asterisk) from cpumask_t field
Message-ID: <20221212193040.1ac6c163@gandalf.local.home>
In-Reply-To: <20221213090411.676021b8fff2c9bc95fba53f@kernel.org>
References: <20221212130352.606d7ce2@gandalf.local.home>
        <20221213090411.676021b8fff2c9bc95fba53f@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 13 Dec 2022 09:04:11 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> What about renaming it as __dynamic_array_struct(), because the root issue
> is that we can not pass the data structure to is_signed_tyep() macro?

Actually, I updated this patch where __cpumask() will be its own macro.
Will post it soon.

-- Steve
