Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EDBC001DE
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 31 Jul 2023 15:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjGaPvb (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 31 Jul 2023 11:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjGaPva (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:51:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C901725
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:51:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E9D661197
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Jul 2023 15:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244B1C433C7;
        Mon, 31 Jul 2023 15:51:25 +0000 (UTC)
Date:   Mon, 31 Jul 2023 11:51:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhu Wang <wangzhu9@huawei.com>
Cc:     <mhiramat@kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] ring-buffer: remove kernel-doc warnings
Message-ID: <20230731115123.45397cde@gandalf.local.home>
In-Reply-To: <20230731113103.215441-1-wangzhu9@huawei.com>
References: <20230731113103.215441-1-wangzhu9@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 31 Jul 2023 19:31:03 +0800
Zhu Wang <wangzhu9@huawei.com> wrote:

> Remove kernel-doc warnings:
> 
> kernel/trace/ring_buffer.c:955: warning: Function parameter or member
> 'cpu' not described in 'ring_buffer_wake_waiters'
> kernel/trace/ring_buffer.c:3386: warning: Excess function parameter
> 'event' description in 'ring_buffer_unlock_commit'
> kernel/trace/ring_buffer.c:5362: warning: Excess function parameter 'cpu'
> description in 'ring_buffer_reset_online_cpus'
> 
> Signed-off-by: Zhu Wang <wangzhu9@huawei.com>

Gaosheng beat you to it:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=151e34d1c6eb2

-- Steve
