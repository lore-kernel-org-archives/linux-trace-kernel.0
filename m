Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9803DCA0ECF
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 12 Sep 2023 02:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbjILC2Z (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 11 Sep 2023 22:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237707AbjILC2J (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:28:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C379138967
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:52:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28572C116AD;
        Mon, 11 Sep 2023 21:39:39 +0000 (UTC)
Date:   Mon, 11 Sep 2023 17:39:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Jinjie Ruan <ruanjinjie@huawei.com>,
        <linux-trace-kernel@vger.kernel.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH v3] eventfs: Fix the NULL pointer dereference bug in
 eventfs_remove_rec()
Message-ID: <20230911173955.60fe81ad@gandalf.local.home>
In-Reply-To: <20230911205125.da905de7b6616ecef3811d7f@kernel.org>
References: <20230911052818.1020547-1-ruanjinjie@huawei.com>
        <20230911205125.da905de7b6616ecef3811d7f@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 11 Sep 2023 20:51:25 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Instead,
> 
> 	ef = eventfs_add_subsystem_dir(name, parent);
> 	if (IS_ERR(ef)) {
> 		...
> 	} else
> 		dir->ef = ef;


Note, as the error has a goto out_free, it just needs to be:

	if (IS_ERR(ef)) {
		...
		goto out_free;
	}

	dir->ef = ef;

And for event_create_dir()

	ef = eventfs_add_dir(name, ef_subsystem);
	if (IS_ERR(ef)) {
		...
		return -1;
	}

	file->ef = ef;

-- Steve
