Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8599DC76196
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 23 Mar 2023 07:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjCWHu3 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 23 Mar 2023 03:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCWHu0 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:50:26 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C681B33E
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:50:24 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i13so10896257lfe.9
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679557822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IlLAgQAMrY+Qapa3HyIEMrrk5zkFmAKmKhKxYGqlRfA=;
        b=X2pZvw8F39X1gqKZVD2n/DZSu2hANXRU4xGF6wdBeoJrF60vbYwLuvWcCYMSoO2/cG
         WvIgjsqj11antMece7AYvd1g6iaS1ccg/JUzkslCbjCmGTVF4r6gOBb+PcH5ERzCwtgz
         MWTPXJ8Dh5ucwqM4NrcyqgBdQwvpqE7zdKxsAyzxmZJ6smmqAOAGJ/pPCGfonij0pYoS
         3uAB9OgAnYlWap7grV8I3amlHxJFJOF56WnlVnyGXJvAAky6axmybPjLu/tXYwyQvFuH
         51bA0q7T953hvaeB6RVCPY8ZUbbA2KiLTIwfwrbhoBzuHYcI+ELJWjqlMGe6CAuk7raF
         +ucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679557822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlLAgQAMrY+Qapa3HyIEMrrk5zkFmAKmKhKxYGqlRfA=;
        b=7dG4ae8sEaYZfGLh5VX7OprZoYR+7JhgPGX1L5CpN01OxEq6SRKHDl7kTjKDYnwEZg
         BDdiZuRXhd7bfnU7vEXPK6bnsLU4yOkp6/O79qdLP9zr7uHfcfffJHZO8SntpNL7B2Kk
         UQQtbuCSrnLmp0Yf2YcRDiFGJ/A4+o+DYwg/qCpKGwPc9+pHDYY5eGJ/ihcm8DG9FuRI
         cL83n1zwkScDVJ7l+pN7STBzH5GL833YLMexIYuVSXoLYKhhkoMZC7ED4OF5T7871TBF
         vDN01GNxvFiXUEPZD4cI7VXdf66I0BSozvFGo7/zGNyH7UyZ7UkrB3J/YUZP7w1efhjp
         ZuYw==
X-Gm-Message-State: AO0yUKUTAPu1yeifcpKQM+4v8t05Y/mvFP+OPtXIPMwBvx7ckg7EpviW
        6BkG4Uyq77fVgIOVhETHZL5FFQ9nRXelrRs9ra9Hzg==
X-Google-Smtp-Source: AK7set+AZnZ7RpTuuN1sbeWai2Zv6NPiiOXrLxauD56bQOThNui9RIOxVfAjNA3Zd4PBGiqVBF7PkHS6aCBTMvredJo=
X-Received: by 2002:ac2:5607:0:b0:4dc:807a:d147 with SMTP id
 v7-20020ac25607000000b004dc807ad147mr2820080lfd.6.1679557822371; Thu, 23 Mar
 2023 00:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006294c805e106db34@google.com> <000000000000690cbc05f779cba8@google.com>
In-Reply-To: <000000000000690cbc05f779cba8@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 23 Mar 2023 08:50:10 +0100
Message-ID: <CACT4Y+Z1Vm+ci43qnoZiF89mo_R1eQV0Cd9Y_MUNoXD1FytR2A@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in bpf_trace_printk
To:     syzbot <syzbot+c49e17557ddb5725583d@syzkaller.appspotmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, boqun.feng@gmail.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        fgheet255t@gmail.com, haoluo@google.com, hawk@kernel.org,
        hdanton@sina.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        longman@redhat.com, martin.lau@linux.dev, mingo@redhat.com,
        netdev@vger.kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        sdf@google.com, song@kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 22 Mar 2023 at 10:29, syzbot
<syzbot+c49e17557ddb5725583d@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 05b24ff9b2cfabfcfd951daaa915a036ab53c9e1
> Author: Jiri Olsa <jolsa@kernel.org>
> Date:   Fri Sep 16 07:19:14 2022 +0000
>
>     bpf: Prevent bpf program recursion for raw tracepoint probes
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a653d6c80000
> start commit:   a335366bad13 Merge tag 'gpio-fixes-for-v6.0-rc6' of git://..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9e66520f224211a2
> dashboard link: https://syzkaller.appspot.com/bug?extid=c49e17557ddb5725583d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e27480880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12737fbf080000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: bpf: Prevent bpf program recursion for raw tracepoint probes
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix: bpf: Prevent bpf program recursion for raw tracepoint probes
