Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8710FC6FD1C
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 22 Mar 2023 09:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjCVJ3n (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 22 Mar 2023 05:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjCVJ3h (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:29:37 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE42659E4C
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:29:19 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id s3-20020a056602240300b007589413aea0so1197973ioa.5
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679477359;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwR4H6MGsoLQxINvSfgEoqaiGeIJXbBfzWUEo9uno3E=;
        b=14tyJvwzyJAA+eeAa/S+DwJxHP1JuzstwgySs+HOayZ1WjVZtkqsztZ/2nCrw4cuMG
         EoktE2cmBdWDx6Oe0m9NvlME8JwewsEPfwO0o4vI6Hiu+LgCy19YUTk3LdZXhXGoIzpb
         BMWDHwaAKoxqHPcDvSnaY85n4pbKVgaUTIJvShVivNAzmZk4jFqsXsqyqjuVw/7ExGva
         Fu5owVmJW0reSSz6WgV145Ii/LMFzJ6vm60F3wfn6xUWm0mVnQKvPl60WhY023LEYXQG
         tZ4YA9dfj1BZZ/lKPeb+IzmMQ+6DKWCcilBvTiu0O3XrmNsPe15Q8R0QBj3TABEnuPNq
         ugUw==
X-Gm-Message-State: AO0yUKXYOwXuJs2dEsgAI8LNeCooMCpYG9PfZosTudk0enhlHhxsQOi0
        2SxX3YZkGPHGSNDod6LkmXIXyDuL2WAPAmZO55kY1EDW8FWd
X-Google-Smtp-Source: AK7set9wiXXV8HcfSnBA3WXXQuxKz+LajL6b0bCizutG2gEq/GuJ4PDA4gkD8fLcC7wmG0GimCb5oA7lyiAD8rOGbOyncXzfWO0+
MIME-Version: 1.0
X-Received: by 2002:a02:9567:0:b0:3c2:b9ba:72f9 with SMTP id
 y94-20020a029567000000b003c2b9ba72f9mr2581039jah.5.1679477359313; Wed, 22 Mar
 2023 02:29:19 -0700 (PDT)
Date:   Wed, 22 Mar 2023 02:29:19 -0700
In-Reply-To: <0000000000006294c805e106db34@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000690cbc05f779cba8@google.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in bpf_trace_printk
From:   syzbot <syzbot+c49e17557ddb5725583d@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, boqun.feng@gmail.com,
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

syzbot suspects this issue was fixed by commit:

commit 05b24ff9b2cfabfcfd951daaa915a036ab53c9e1
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Fri Sep 16 07:19:14 2022 +0000

    bpf: Prevent bpf program recursion for raw tracepoint probes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a653d6c80000
start commit:   a335366bad13 Merge tag 'gpio-fixes-for-v6.0-rc6' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e66520f224211a2
dashboard link: https://syzkaller.appspot.com/bug?extid=c49e17557ddb5725583d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e27480880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12737fbf080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Prevent bpf program recursion for raw tracepoint probes

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
