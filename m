Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C115C83F12
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 29 Aug 2023 23:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjH2XRL (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbjH2XQj (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:16:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A284411B;
        Tue, 29 Aug 2023 16:16:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3704162E70;
        Tue, 29 Aug 2023 23:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB135C433C8;
        Tue, 29 Aug 2023 23:16:31 +0000 (UTC)
Date:   Tue, 29 Aug 2023 19:16:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: add a tracepoint for damos apply
 target regions
Message-ID: <20230829191629.25c5f0e2@rorschach.local.home>
In-Reply-To: <20230827004045.49516-1-sj@kernel.org>
References: <20230827004045.49516-1-sj@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun, 27 Aug 2023 00:40:45 +0000
SeongJae Park <sj@kernel.org> wrote:

> +	TP_STRUCT__entry(
> +		__field(unsigned int, context_idx)

4 bytes

> +		__field(unsigned int, scheme_idx)

4 bytes

> +		__field(unsigned long, target_idx)

8 bytes

> +		__field(unsigned int, nr_regions)

4 bytes

> +		__field(unsigned long, start)

This is going to cause a 4 byte hole. I would move nr_regions after end
so that it stays properly aligned.

-- Steve



> +		__field(unsigned long, end)
> +		__field(unsigned int, nr_accesses)
> +		__field(unsigned int, age)
> +	),
> +
