Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FAAC636D4
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 15 Feb 2023 08:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjBOI6V (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 15 Feb 2023 03:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjBOI6U (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:58:20 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B10E32CFB
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:58:18 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id m1so19154937vst.7
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676451497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DcGGlaYPqY4tYzxSZdNCJiJzK/DPCL1PbAxHODA+Moo=;
        b=CVBzeQ0dYbsnCDfKvSNW0oP/l0G2i4gLfTFVglARKOdmKjJHkGRufworM4PaVNI2XK
         4fRJKeGL6IiUzgu8G/eux1LkuN5fruC9QqTt2qKl9ayZdbK+GzSzHOJaSuWpGXTnFeyM
         4KdiTSQenC/8N2cY6PrJzKg3gbzzUziJhaXzGU7qet/p4yR24w1IlFSNaKc6edXnocoX
         Gto0kiyMYlmPayaGMPRFF+TAsmRj6sXmmjyZVwjGfJTk9DfsNDNW9oB7vHNKwGKQ4ZRg
         55B9HiBoxHSYDXJSvL06LxC3GaSmisXlbCbFTn6L5tw2vcx0P5CapkbPxUT5e14RNtww
         xOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676451497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcGGlaYPqY4tYzxSZdNCJiJzK/DPCL1PbAxHODA+Moo=;
        b=jJbu45rILJIEMNexJlt2LHjCstzyTsxmGKp+fzEPaN4JEO2fYvltqxzbXIlmdZLn71
         l/bwxg9w09kbIFAAsMx2P8gzZmTR3h7+CXy0ji2ufisYW4ovuRF2GCCGD10u62e6oPQh
         +gWEig2ebYfSHwYzZjyndrGOLez8uSYXA6+TWfXpNVvWuGURT6jw/DT/026c02YkQqX+
         bSHvulSm4laWl0B0nilr2mlnvs5fBTwbtsEt+E84luxbUNvtT+PwsHXzS+ZsDxLZ6sk8
         IqOjMSEhx7VpQjJeHxj8Ynutl1tVfpRlMyxuf18B7BgLrZTovsv3e39m4v+ndiXrBm1z
         NN9A==
X-Gm-Message-State: AO0yUKXrvyPYtswuwYSRtMN/mviLuRYmhkqYzSr6Bn1dqXj3IUicudsb
        xlLGmjqMr+Y1kH+jc0fQMbvqIlnH7IQDaiJNh7vGbQ==
X-Google-Smtp-Source: AK7set/+8nuXNdRVrooT+d5NwgzEBPKwnKN2U6y4WQjWCLFfsrVDzHoyZVdv1D1JaQk8PJnUDZLS2EkrDasRsy1J24Q=
X-Received: by 2002:a67:70c6:0:b0:412:2e92:21a6 with SMTP id
 l189-20020a6770c6000000b004122e9221a6mr311416vsc.13.1676451497458; Wed, 15
 Feb 2023 00:58:17 -0800 (PST)
MIME-Version: 1.0
References: <ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com>
 <CAMn1gO7Ve4-d6vP4jvASQsTZ2maHsMF6gKHL3RXSuD9N3tAOfQ@mail.gmail.com>
 <CANpmjNNvGL--j-20UxqX_WjeXGiAcjfDAQpfds+Orajz0ZeBsg@mail.gmail.com> <CAMn1gO6reT+MTmogLOrOVoNqzLH+fKmQ2JRAGy-tDOTLx-fpyw@mail.gmail.com>
In-Reply-To: <CAMn1gO6reT+MTmogLOrOVoNqzLH+fKmQ2JRAGy-tDOTLx-fpyw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 15 Feb 2023 09:57:40 +0100
Message-ID: <CANpmjNN7Gf_aeX+Y6g0UBL-cmTGEF9zgE7hQ1VK8F+0Yeg5Rvg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan: switch kunit tests to console tracepoints
To:     Peter Collingbourne <pcc@google.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

+Cc tracing maintainers

On Wed, 15 Feb 2023 at 03:56, Peter Collingbourne <pcc@google.com> wrote:
>
> On Mon, Feb 13, 2023 at 10:08 PM Marco Elver <elver@google.com> wrote:
> >
> > On Tue, 14 Feb 2023 at 02:21, Peter Collingbourne <pcc@google.com> wrote:
> > >
> > > On Tue, Oct 18, 2022 at 10:17 AM <andrey.konovalov@linux.dev> wrote:
> > > >
> > > > From: Andrey Konovalov <andreyknvl@google.com>
> > > >
> > > > Switch KUnit-compatible KASAN tests from using per-task KUnit resources
> > > > to console tracepoints.
> > > >
> > > > This allows for two things:
> > > >
> > > > 1. Migrating tests that trigger a KASAN report in the context of a task
> > > >    other than current to KUnit framework.
> > > >    This is implemented in the patches that follow.
> > > >
> > > > 2. Parsing and matching the contents of KASAN reports.
> > > >    This is not yet implemented.
> > > >
> > > > Reviewed-by: Marco Elver <elver@google.com>
> > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > >
> > > > ---
> > > >
> > > > Changed v2->v3:
> > > > - Rebased onto 6.1-rc1
> > > >
> > > > Changes v1->v2:
> > > > - Remove kunit_kasan_status struct definition.
> > > > ---
> > > >  lib/Kconfig.kasan     |  2 +-
> > > >  mm/kasan/kasan.h      |  8 ----
> > > >  mm/kasan/kasan_test.c | 85 +++++++++++++++++++++++++++++++------------
> > > >  mm/kasan/report.c     | 31 ----------------
> > > >  4 files changed, 63 insertions(+), 63 deletions(-)
> > > >
> > > > diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> > > > index ca09b1cf8ee9..ba5b27962c34 100644
> > > > --- a/lib/Kconfig.kasan
> > > > +++ b/lib/Kconfig.kasan
> > > > @@ -181,7 +181,7 @@ config KASAN_VMALLOC
> > > >
> > > >  config KASAN_KUNIT_TEST
> > > >         tristate "KUnit-compatible tests of KASAN bug detection capabilities" if !KUNIT_ALL_TESTS
> > > > -       depends on KASAN && KUNIT
> > > > +       depends on KASAN && KUNIT && TRACEPOINTS
> > >
> > > My build script for a KASAN-enabled kernel does something like:
> > >
> > > make defconfig
> > > scripts/config -e CONFIG_KUNIT -e CONFIG_KASAN -e CONFIG_KASAN_HW_TAGS
> > > -e CONFIG_KASAN_KUNIT_TEST
> > > yes '' | make syncconfig
> > >
> > > and after this change, the unit tests are no longer built. Should this
> > > use "select TRACING" instead?
> >
> > I think we shouldn't select TRACING, which should only be selected by
> > tracers. You'd need CONFIG_FTRACE=y.
>
> Doesn't CONFIG_FTRACE=y mean "function tracing", i.e. function
> entry/exit tracing using compiler instrumentation? As far as I can
> tell, the KASAN tests do not make use of this feature. They only use
> the kernel tracepoint infrastructure to trace the "console" tracepoint
> defined in include/trace/events/printk.h, which is not associated with
> function entry/exit.

Yes, you are right, and it's something I've wondered how to do better
as well. Let's try to consult tracing maintainers on what the right
approach is.

> I have yet to find any evidence that TRACING ought to only be selected
> by tracers. As far as I can tell, TRACING appears to be the minimal
> config required in order for it to be possible to trace pre-defined
> (i.e. defined with TRACE_EVENT) tracepoints, which is all that KASAN
> needs. (I also tried selecting TRACEPOINTS, but this led to a number
> of link failures.) If select TRACING is only used by tracers, it could
> just mean that only tracers are making use of this functionality
> inside the kernel. From that perspective the KASAN tests can
> themselves be considered a "tracer" (albeit a very specialized one).
>
> If I locally revert the change to lib/Kconfig.kasan and add the
> TRACING select, the KASAN tests pass when using my kernel build
> script, which suggests that TRACING is all that is needed.
>
> > Since FTRACE is rather big, we probably also shouldn't implicitly
> > select it. Instead, at least when using kunit.py tool, we could add a
> > mm/kasan/.kunitconfig like:
> >
> > CONFIG_KUNIT=y
> > CONFIG_KASAN=y
> > CONFIG_KASAN_KUNIT_TEST=y
> > # Additional dependencies.
> > CONFIG_FTRACE=y
> >
> > Which mirrors the KFENCE mm/kfence/.kunitconfig. But that doesn't help
> > if you want to run it with something other than KUnit tool.
>
> In any case, I'm not sure I'm in favor of adding yet another config
> that folks need to know to enable in order to avoid silently disabling
> the unit tests. Many developers will maintain their own scripts for
> kernel development if the existing ones do not meet their needs. It's
> possible that kunit.py will work out for me now (when I looked at it
> before, it was useless for me because it only supported UML, but it
> looks like it supports QEMU now), but there's no guarantee that it
> will, so I might stick with my scripts for a while.
>
> Peter
