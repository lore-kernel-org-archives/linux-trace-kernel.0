Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF31EC874B
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  7 Sep 2023 18:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbjIGSFm (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjIGSFl (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:05:41 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBE11FFA
        for <linux-trace-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:05:16 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34df30f4658so5066945ab.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 Sep 2023 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694109914; x=1694714714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CdG/yEmvsuQjOBoALKvigFMhVG4ZkbJlbNCVNFCW95k=;
        b=nUC9vSs+3VNBqxKldhdULGo6+iJdS6wIef30i6LrnDoiGgQmj4rLG4cBfvpBDz2isV
         3f0sZvIM8w4Rb/OYlWUHlXp8Hs09/MiXFERn7d8E/uHS2wYIU873VN+XjKFMP8+dndIa
         fkNoIVDd34MLDnlUBFq8+8YAabV7mO2a5nuM/m7LSPsBRuMzAzwURT2HZpsQvAhVBg39
         E1JgtqTrVji5AWjOukFqOpLNqOweyJUGiKWfNmc7lcz1nb3WQxhIYUG4w/DocqkklwSd
         5KP5aKc1u/Z8Y+/uL+8c6xOg64Btz/e01SixbeZsZlxtb4nP5nxiKWn4NTJRLzGT3zO7
         5wZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694109914; x=1694714714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdG/yEmvsuQjOBoALKvigFMhVG4ZkbJlbNCVNFCW95k=;
        b=K27CXZyZ3yO5PH/J9u9qe/MRLrI04gjj2RpmqsTPVHqYMKwc+5DisxtM6b4GPyEZfp
         VvVWcc8UzyPDmcsnX+4bhmfbjkFjoJBlKsDwqpTIzhNa2EcWVKVUSMgUcgCD2rf6ORCH
         XFQLTI51ctRNaErgBNIedK21AQ/b7tpHsv/HOfL20nYV9bXEHC8CGFnd3HFOxYNaXcOC
         FxLMidh+OueSlXp2PchFdeszEaNHMcl5spenzJNGhz85bQUHuEakSdw9QatSirJhJDcE
         Er1bvoTm5qPATdtMfKTlyhhAOfWRTpg9xh4rG2SgfRfxi5sq9A0F0iatenqXoNUDQpy9
         gOsQ==
X-Gm-Message-State: AOJu0Yya8GRLut//13qHqmwt17ovZrZQMuFL50yw29FwNzHuJSvKHpdG
        +W1I6Xnbu5MRut5sJzAg3ZvQOa6BRrZ/H4IzCGDZL1fIr9fl83kZMzWF3w==
X-Google-Smtp-Source: AGHT+IHvJa/7FkPw5UU4MQhoWrNN0JeNEpF4NYmZOKhJtjjWQqdbyDvw0AaJBhSfLDJ+K7NB4oYLX/Nq50B/h5Hi3tI=
X-Received: by 2002:a05:6122:9a9:b0:493:7c76:bbac with SMTP id
 g41-20020a05612209a900b004937c76bbacmr2374358vkd.2.1694093097716; Thu, 07 Sep
 2023 06:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230907024710.866917011@goodmis.org>
In-Reply-To: <20230907024710.866917011@goodmis.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 7 Sep 2023 18:54:46 +0530
Message-ID: <CA+G9fYt1dC7=pggtwX2D3jibbLweg+a2LnvYtxfF1nCnqELZSg@mail.gmail.com>
Subject: Re: [PATCH 0/6] tracing: Fix removing instances while reading/writing
 to their files
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 7 Sept 2023 at 08:17, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> It appears that the dynamic code of eventfs has caused a race window
> to open up a bit more and showed that several files were not protected
> by the trace array ref count. This means that a task could open one
> of the files in an instance, remove the instance, and still be able to
> read or write to that file. That access will then cause a "use-after-free"
> bug.
>
> Close those holes!
>
> Also, fix a left over unused variable in the eventfs dput fix.

This patch set applied on top of Linux next master branch and
tested selftests ftrace tests [1]. The test run to complete and not
found any crashes.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

>
> Steven Rostedt (Google) (6):
>       tracefs/eventfs: Use dput to free the toplevel events directory
>       tracing: Increase trace array ref count on enable and filter files
>       tracing: Have tracing_max_latency inc the trace array ref count
>       tracing: Have current_trace inc the trace array ref count
>       tracing: Have option files inc the trace array ref count
>       tracing: Have event inject files inc the trace array ref count
>
> ----
>  fs/tracefs/event_inode.c           | 17 +++++++---
>  fs/tracefs/inode.c                 |  2 +-
>  fs/tracefs/internal.h              |  5 +--
>  kernel/trace/trace.c               | 68 ++++++++++++++++++++++++++++++++++----
>  kernel/trace/trace.h               |  2 ++
>  kernel/trace/trace_events.c        |  6 ++--
>  kernel/trace/trace_events_inject.c |  3 +-
>  7 files changed, 85 insertions(+), 18 deletions(-)

[1] https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/naresh/tests/2V4IYQhAHrFXjwQvHLc2w3mKhXs

--
Linaro LKFT
https://lkft.linaro.org
