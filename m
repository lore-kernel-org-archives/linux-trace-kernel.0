Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE665CA0EE8
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 12 Sep 2023 13:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjILNzY (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 12 Sep 2023 09:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjILNzY (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:55:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C74710CE
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:55:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C90EC433C7;
        Tue, 12 Sep 2023 13:55:19 +0000 (UTC)
Date:   Tue, 12 Sep 2023 09:55:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH v5] eventfs: Fix the NULL pointer dereference bug in
 eventfs_remove_rec()
Message-ID: <20230912095536.2e572c49@gandalf.local.home>
In-Reply-To: <20230912134752.1838524-1-ruanjinjie@huawei.com>
References: <20230912134752.1838524-1-ruanjinjie@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 12 Sep 2023 21:47:52 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> v5:
> - Move the ef below dir to keep the "upside-down x-mas tree" format.

That was quick!

I'll add it to my queue and start testing it.

Thanks Ruan!

-- Steve
