Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF10C54EBC
	for <linux-trace-kernel@archiver.kernel.org>; Sun,  8 Jan 2023 21:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjAHV0p (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sun, 8 Jan 2023 16:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjAHV0o (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:26:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B846158;
        Sun,  8 Jan 2023 13:26:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 816E5B80C68;
        Sun,  8 Jan 2023 21:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4D2C433EF;
        Sun,  8 Jan 2023 21:26:40 +0000 (UTC)
Date:   Sun, 8 Jan 2023 16:26:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Quanfa Fu <quanfafu@gmail.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/eprobe: Replace kzalloc with kmalloc
Message-ID: <20230108162639.6583df9f@rorschach.local.home>
In-Reply-To: <20230108010124.96e4ceb68b8dfb8e291f501d@kernel.org>
References: <20230107034557.1156022-1-quanfafu@gmail.com>
        <20230108010124.96e4ceb68b8dfb8e291f501d@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun, 8 Jan 2023 01:01:24 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Ah, good catch. I didn't notice that snprintf() doesn't return
> error code. (I confirmed that the linux internal snprintf() also
> doesn't return the error code)
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

I replied to to the first instance of this patch ;-)

  https://lore.kernel.org/all/20230108162222.146d136f@rorschach.local.home/

-- Steve
