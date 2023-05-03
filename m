Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82173C77B78
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  3 May 2023 16:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjECQqn (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 3 May 2023 12:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjECQqX (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:46:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4243955A9;
        Wed,  3 May 2023 09:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D21F96223F;
        Wed,  3 May 2023 16:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BECC433D2;
        Wed,  3 May 2023 16:46:20 +0000 (UTC)
Date:   Wed, 3 May 2023 12:46:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix permissions for the buffer_percent file
Message-ID: <20230503124618.3baf9a98@gandalf.local.home>
In-Reply-To: <20230503140114.3280002-1-omosnace@redhat.com>
References: <20230503140114.3280002-1-omosnace@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed,  3 May 2023 16:01:14 +0200
Ondrej Mosnacek <omosnace@redhat.com> wrote:

> This file defines both read and write operations, yet it is being
> created as read-only. This means that it can't be written to without the
> CAP_DAC_OVERRIDE capability. Fix the permissions to allow root to write
> to it without the need to override DAC perms.
> 
> Fixes: 03329f993978 ("tracing: Add tracefs file buffer_percentage")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Applied. Thanks Ondrej!

-- Steve
