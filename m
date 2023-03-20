Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AB3C6FD1D
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 20 Mar 2023 18:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCTSKc (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjCTSJi (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:09:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC99A33465
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E428B81054
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Mar 2023 18:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD9BC433EF;
        Mon, 20 Mar 2023 18:02:43 +0000 (UTC)
Date:   Mon, 20 Mar 2023 14:02:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gildong Hong <roaming2man@gmail.com>
Cc:     mhiramat@kernel.org, delyank@fb.com, peterz@infradead.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace/events/sched: Remove unit on printing vruntime
 value
Message-ID: <20230320140241.401812d1@gandalf.local.home>
In-Reply-To: <20230320114139.GB2077@darius>
References: <20230316115655.66639-1-roaming2man@gmail.com>
        <20230316101137.1739d1e2@gandalf.local.home>
        <20230319030520.GB6049@darius>
        <20230319140738.57170fab@rorschach.local.home>
        <20230320114139.GB2077@darius>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 20 Mar 2023 20:41:39 +0900
Gildong Hong <roaming2man@gmail.com> wrote:

> I agree with your opinion.
> People can understand "vns" if they understand "vruntime".
> Followings are the modified patch.
> I add your name on "Suggested-by"
> I or you could remove the line if you mind it.

I'm good.

Thanks,

-- Steve

> 
> Thanks,
> Gildong
> 
> ------------
> >From 8a8d1f08a2f217151f26f04795d6c1483eb1c48f Mon Sep 17 00:00:00 2001  
> From: Gildong Hong <roaming2man@gmail.com>
> Date: Thu, 16 Mar 2023 20:05:48 +0900
> Subject: [PATCH] trace/events/sched: Change unit on printing vruntime value
> 
> vruntime is not actual time so change unit on printing
> from "ns" to "vns" which denotes "virtual nanosecond"
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Gildong Hong <roaming2man@gmail.com>
