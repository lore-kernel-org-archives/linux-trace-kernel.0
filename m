Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE4AC61DA3
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 24 Feb 2023 06:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBXGpX (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBXGpW (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 01:45:22 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2E213D7E
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Feb 2023 22:45:21 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id c12so12862367wrw.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Feb 2023 22:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4p2N3znozSpEZbXtte2eMWOETBMxmUkJjVlowyV2+bc=;
        b=N39tkFtx+s7CpXrGQlLyWXyoblArhh6VID9Ru50wl2J62Q++6oqJH6CDo1T3SFLs5/
         c7bA4i771vDpqJxlNPbOz1BvJROOZ5UxxrsZAEdsOsmEpF6CVY4Ri9C4HFCqQGV89zRO
         wJcp+gaKNkegs5/U6cNrOgakrYo+SLW/XZ5Dw13rRmtOx7lxZ3Laa/PQdaSZzFmmQlN1
         dr9xOJ716vNQ4W2La6SOrcgF3G0rWGoWIEQt65AfitBU3ZI8RKHpa0sAm4M9ou4qzVkA
         gLM1J3XQJtTayQLfzA1PRNI5hkU3MMfR4iqTWhOla8GhVP7Rj8Ktl9BLhNwHUqBbW9NX
         1ewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4p2N3znozSpEZbXtte2eMWOETBMxmUkJjVlowyV2+bc=;
        b=YFnrUU78k35c+AjVjslQxmsQbGt2QSTmGOH4ktGV4Eirew0yjcsjEZz2F/8qVm3eWX
         MLUDK+S1FhCFkuPXd+4eWvxEsWadjxnN4QAyD2kGs4OeFFIxSWjSkuYjGT9LsiNGX3HO
         GxeuElani7RItza+nYwAzOZJ1wbX9Ni20vN4nVIsHh1GlE0gU/QzYOjZBVOOud1vIs2l
         oY8Hs00k8rDP2atd0qd5le29ET5ouLBhIf/WObjMpBaWjtkmh69JyuzjIHt4an9Itdm8
         A3S/HEYcjvMhgcbenp5WlL16cs1sfBBk+f5G/tjtScHbB1Kl+rXEomMvwkZFhlrHV02W
         d6vg==
X-Gm-Message-State: AO0yUKXaZ1UFtK0WrPYSzmd0XVX2RyDQsk5Cirt8735kGxB9hD0Rff2z
        AwKB2qxWdNy1SqH2ujwvScDuh/dr+g289rFBIOhdXA==
X-Google-Smtp-Source: AK7set/oLnSaCRuVllUODj6q0Pghmzon19a0040df5q10BofQNdQRjI3Ze3ELHznn1gn9/2Ovf05XHFR5R4O+US0skc=
X-Received: by 2002:a5d:544a:0:b0:2c5:3fcb:682b with SMTP id
 w10-20020a5d544a000000b002c53fcb682bmr946077wrv.2.1677221119373; Thu, 23 Feb
 2023 22:45:19 -0800 (PST)
MIME-Version: 1.0
References: <ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com>
 <CAMn1gO7Ve4-d6vP4jvASQsTZ2maHsMF6gKHL3RXSuD9N3tAOfQ@mail.gmail.com>
 <CANpmjNNvGL--j-20UxqX_WjeXGiAcjfDAQpfds+Orajz0ZeBsg@mail.gmail.com>
 <CAMn1gO6reT+MTmogLOrOVoNqzLH+fKmQ2JRAGy-tDOTLx-fpyw@mail.gmail.com>
 <CANpmjNN7Gf_aeX+Y6g0UBL-cmTGEF9zgE7hQ1VK8F+0Yeg5Rvg@mail.gmail.com> <20230215143306.2d563215@rorschach.local.home>
In-Reply-To: <20230215143306.2d563215@rorschach.local.home>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 23 Feb 2023 22:45:07 -0800
Message-ID: <CAMn1gO4_+-0x4ibpcASy4bLeZ+7rsmjx=0AYKGVDUApUbanSrQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan: switch kunit tests to console tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Marco Elver <elver@google.com>, andrey.konovalov@linux.dev,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 11:33 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 15 Feb 2023 09:57:40 +0100
> Marco Elver <elver@google.com> wrote:
>
> > Yes, you are right, and it's something I've wondered how to do better
> > as well. Let's try to consult tracing maintainers on what the right
> > approach is.
>
> I have to go and revisit the config options for CONFIG_FTRACE and
> CONFIG_TRACING, as they were added when this all started (back in
> 2008), and the naming was rather all misnomers back then.
>
> "ftrace" is really for just the function tracing, but CONFIG_FTRACE
> really should just be for the function tracing infrastructure, and
> perhaps not even include trace events :-/ But at the time it was
> created, it was for all the "tracers" (this was added before trace
> events).

It would be great to see this cleaned up. I found this aspect of how
tracing works rather confusing.

So do you think it makes sense for the KASAN tests to "select TRACING"
for now if the code depends on the trace event infrastructure?

Peter
