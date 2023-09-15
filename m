Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1B0EE3F2F
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 15 Sep 2023 14:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbjIOOiP (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 15 Sep 2023 10:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbjIOOiP (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:38:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A331AC;
        Fri, 15 Sep 2023 07:38:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605D0C433C7;
        Fri, 15 Sep 2023 14:38:09 +0000 (UTC)
Date:   Fri, 15 Sep 2023 10:38:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        artem.bityutskiy@linux.intel.com,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] tracing/synthetic: Print out u64 values properly
Message-ID: <20230915103833.22bf4fc8@gandalf.local.home>
In-Reply-To: <20230915231613.6cb9372d9304c313dab462ea@kernel.org>
References: <20230911141704.3585965-1-tero.kristo@linux.intel.com>
        <20230915150101.ef50c4774ab85aa2ff7431ec@kernel.org>
        <11672c6d-e021-eeda-5907-3fefb307ce9d@linux.intel.com>
        <20230915231613.6cb9372d9304c313dab462ea@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 15 Sep 2023 23:16:13 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Anyways, that requires a new patch to be created on top as this has hit 
> > the mainline as a fix already.  
> 
> Oops, I missed that.

Yeah, I took that because it matched the original case, which was it being u64.

-- Steve
