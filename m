Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298D0C636CC
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 15 Feb 2023 19:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBOTdO (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 15 Feb 2023 14:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBOTdN (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:33:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6692237731;
        Wed, 15 Feb 2023 11:33:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 178CDB821C1;
        Wed, 15 Feb 2023 19:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32536C433D2;
        Wed, 15 Feb 2023 19:33:09 +0000 (UTC)
Date:   Wed, 15 Feb 2023 14:33:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Marco Elver <elver@google.com>
Cc:     Peter Collingbourne <pcc@google.com>, andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] kasan: switch kunit tests to console tracepoints
Message-ID: <20230215143306.2d563215@rorschach.local.home>
In-Reply-To: <CANpmjNN7Gf_aeX+Y6g0UBL-cmTGEF9zgE7hQ1VK8F+0Yeg5Rvg@mail.gmail.com>
References: <ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com>
        <CAMn1gO7Ve4-d6vP4jvASQsTZ2maHsMF6gKHL3RXSuD9N3tAOfQ@mail.gmail.com>
        <CANpmjNNvGL--j-20UxqX_WjeXGiAcjfDAQpfds+Orajz0ZeBsg@mail.gmail.com>
        <CAMn1gO6reT+MTmogLOrOVoNqzLH+fKmQ2JRAGy-tDOTLx-fpyw@mail.gmail.com>
        <CANpmjNN7Gf_aeX+Y6g0UBL-cmTGEF9zgE7hQ1VK8F+0Yeg5Rvg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 15 Feb 2023 09:57:40 +0100
Marco Elver <elver@google.com> wrote:

> Yes, you are right, and it's something I've wondered how to do better
> as well. Let's try to consult tracing maintainers on what the right
> approach is.

I have to go and revisit the config options for CONFIG_FTRACE and
CONFIG_TRACING, as they were added when this all started (back in
2008), and the naming was rather all misnomers back then.

"ftrace" is really for just the function tracing, but CONFIG_FTRACE
really should just be for the function tracing infrastructure, and
perhaps not even include trace events :-/ But at the time it was
created, it was for all the "tracers" (this was added before trace
events).

-- Steve
