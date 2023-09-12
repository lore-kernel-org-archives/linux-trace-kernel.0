Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38882CA0ECB
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 12 Sep 2023 02:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbjILCb5 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 11 Sep 2023 22:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbjILCb2 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:31:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CF9180EE0;
        Mon, 11 Sep 2023 18:56:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDDDC433BA;
        Tue, 12 Sep 2023 01:56:31 +0000 (UTC)
Date:   Mon, 11 Sep 2023 21:56:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: add a tracepoint for damos apply
 target regions
Message-ID: <20230911215648.2cdff894@gandalf.local.home>
In-Reply-To: <20230912014308.38298-1-sj@kernel.org>
References: <20230911165144.5002a0ac@gandalf.local.home>
        <20230912014308.38298-1-sj@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 12 Sep 2023 01:43:08 +0000
SeongJae Park <sj@kernel.org> wrote:

> Nevertheless, since the variable is unsigned int, I would need to use UINT_MAX
> instead.  To make the code easier to understand, I'd prefer to add a third
> parameter, as you suggested as another option at the original reply, like
> below:

That works too.

-- Steve
