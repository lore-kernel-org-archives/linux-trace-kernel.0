Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8B7C7618A
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 20 Mar 2023 16:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjCTQrz (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjCTQr0 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:47:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE87A34C1D;
        Mon, 20 Mar 2023 09:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B890616E2;
        Mon, 20 Mar 2023 16:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046DCC4339B;
        Mon, 20 Mar 2023 16:40:45 +0000 (UTC)
Date:   Mon, 20 Mar 2023 12:40:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing/selftests: Ignore __pfx_ symbols in kprobe test
Message-ID: <20230320124044.64d50f7c@gandalf.local.home>
In-Reply-To: <495eb06b-9a86-ff55-d0c9-66d836ce456a@linuxfoundation.org>
References: <20230207135147.5ce618d6@gandalf.local.home>
        <20230213204643.39f86987@rorschach.local.home>
        <20230318144202.486c43d1@rorschach.local.home>
        <8579dfaf-11bf-cefa-c3ed-eb9b2d9d1a22@linuxfoundation.org>
        <495eb06b-9a86-ff55-d0c9-66d836ce456a@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 20 Mar 2023 10:30:44 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> The patch doesn't apply to linux-kselftest fixes branch.
> Please rebase and resend with cc to linux-kselftest.
> Makes sense why it got buried in my regular Inbox.

And it doesn't apply because Masami fixed it already.

I'll just drop it. Thanks!

-- Steve
