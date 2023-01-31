Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB748C636CC
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 31 Jan 2023 18:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjAaS1F (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 31 Jan 2023 13:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjAaS1E (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:27:04 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29D33EFCA
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:27:03 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id e15so19255611ybn.10
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HkHNPqnVxAIY/tqIt7qZnRTR4WfHWVZtazfgEEVLA1k=;
        b=tQEMNZ1+yeDZEj71B07fcjB50jM1i6aOuywWS/FEjrOnp3EcR69hAad3lu7vZn711m
         rWFCK+MRQGo98+OX7Z5YJLQhXxWxcbseEzjAKbTV3mnOpdwwmNbpFwvbdi+eNLV/KuMk
         sNXJc8FHml2fwt05JkbGF5OXq5QschNyjjqDrAvpuG6zFZbmRhPSLQnUptA+sed4s+4u
         /ShnkTt4PmvgX5jmo1mCcs2pWa08grni3e3ApLv3uhCKCxfacTcGLbncAhJRnWaiVYSm
         tdI+8rQTbvf6cG+WE0yUEx2Rdr8MDao7T3rRNVqVLCHHtQydcDhp9f9RmGWkoukyc4Oq
         rcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkHNPqnVxAIY/tqIt7qZnRTR4WfHWVZtazfgEEVLA1k=;
        b=mk022hwQyOcQ4/LeUKEi/4MT+/DpyBIFgMROzLbppsUDvFJN0r60vA+/xqjfPvrDqt
         OIjFBJfnlabjl6OM7m2AlZyOW1DyOvdihHDTW1ZtCMQ1Bcof5kdbXfnvlhgc2UOEyGks
         32drhfSxxzLCGJf82xska7mtzHWEN60+pdLhQHsg6mzj0yiwObUjstePMqZorsaO7xRb
         yWtclYqBYYee5RyZxG0MdYEhD65wR3IrNRB3WwjBmSRiZCxYX5qZ4/bYdxXZQiUKHvmS
         25aC0XqxF5lVLDxn84nN8fa2GzWgC3qVGl+7xIvHvtIOMezl2VkrAw25gkuBBus5Na1c
         RETQ==
X-Gm-Message-State: AO0yUKUDf2rcprtDiN8MdFChCQrw710zjN7N4oXG1Po+OzdJoJSFLVY/
        M88xEH056RpXezLrMV4DJdiKaldVHw9w0bQwy/2rVw==
X-Google-Smtp-Source: AK7set9Wi/SxOYBU/ud8H+po+UJzdx1g7/5fVkPjA4w3dbgGjnozI/UIgrAp4ux9zJMjoCX+yuiExNDq7TyEEr9b0cI=
X-Received: by 2002:a25:bfc4:0:b0:80b:877c:7a56 with SMTP id
 q4-20020a25bfc4000000b0080b877c7a56mr2044611ybm.368.1675189622981; Tue, 31
 Jan 2023 10:27:02 -0800 (PST)
MIME-Version: 1.0
References: <202301301057.e55dad5b-oliver.sang@intel.com> <Y9dETROtv9Bld9TI@casper.infradead.org>
 <20230131052352.5qnqegzwmt7akk7t@google.com> <Y9iq8fRT4sDgIwQN@casper.infradead.org>
 <20230131055743.tsilxx5vfl6gx4dj@google.com>
In-Reply-To: <20230131055743.tsilxx5vfl6gx4dj@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 31 Jan 2023 10:26:52 -0800
Message-ID: <CALvZod7TuaJ7pCc2nJKehwGkcuvsvjdL+4hs6qC3bZsOmGzXzg@mail.gmail.com>
Subject: Re: [linus:master] [mm] f1a7941243: unixbench.score -19.2% regression
To:     Matthew Wilcox <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

+per-cpu memory maintainers for FYI.

Thread started at
https://lore.kernel.org/linux-mm/202301301057.e55dad5b-oliver.sang@intel.com/

On Mon, Jan 30, 2023 at 9:57 PM Shakeel Butt <shakeelb@google.com> wrote:
>
[...]
> >
> > We could cut down the number of calls to pcpu_alloc() by a factor of 4
> > by having a pcpu_alloc_bulk() that would allocate all four RSS counters
> > at once.
> >
> > Just throwing out ideas ...
>
> Thanks, I will take a stab at pcpu_alloc_bulk() and will share the
> result tomorrow.
>

OK, not a one day effort.

Andrew, which option do you prefer?

1. Keep the patches as the test workload (fork ping pong) is not a
representative of real world workload and work on improving
pcpu_alloc() for 6.4+.

2. Revert the patches for now, improve pcpu_alloc() and re-introduce
the patches once we confirm that fork-ping-pong is not regressed
anymore.

thanks,
Shakeel
