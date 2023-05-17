Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85031C7EE24
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 17 May 2023 01:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjEQBqv (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 16 May 2023 21:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjEQBqu (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:46:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB902112
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 May 2023 18:46:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc4bc2880so257491a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 May 2023 18:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684288007; x=1686880007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQUgUB35pEGeEzoSa+CRldRq4FG5rDCSn4467LnemCE=;
        b=XOVzAj8XiIHw+f06SLNIvJC7d04MHA3DZIJYmFMnEZSFNaCx4nEr+UKjTJn0OhUS52
         r2pbbLAF/e6U513uMvV1yNj3R1Zl0yC2EbzVpvkyp9C20N6hpev+0c+BWDbuCIBevXa/
         Z87y5VbTj1vsYdi502f+bigGqeeVXXVRyK5Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684288007; x=1686880007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQUgUB35pEGeEzoSa+CRldRq4FG5rDCSn4467LnemCE=;
        b=g0te6EoY3x5DvEg44F1OZfIEYGWKPl+gfERsIdGKmmFh6wKFoA5+Y/AOvBjpfXgnJE
         7cIFlBBgzJNkWxdOb+hScD9akF4vT4wgZBFZUYW2aZeNKgoaMxiOXIKCDrW5BBhAj6/o
         Np3VDoorfFb3KCbhxPdDJWZuLJsgaQ6gBfLry9V6T2dYfk2jBzhNELKcMH3vCckn9T+9
         /Cs+cL2A2hT1lUY5erSfQJdYdKEejkwaLqN87WJbPlCXATZkVcigeCyMavDZiGOzJoCd
         auNKiR2Jn59GJgHJKYr8IauC2qj7GNQ+eM4FcJs6H4VlaRrEx+w7zdwHVznGK2QVOfz/
         1BWA==
X-Gm-Message-State: AC+VfDz4c3SOTo+sIefhP/nRePv3hCnafPyQiMn6HdpK+HbKKVsd1rRE
        Tk6RQn3Pa3B6TEEJCM7t5CR/AayfCg456+CrjOQx+w==
X-Google-Smtp-Source: ACHHUZ4oERJeike9eMAbPoG8IoqendLwBQDy9uRBlMNJsc1N4xtpyVXatO1dsdy81Nu5aAFutulOmQ==
X-Received: by 2002:a17:906:4fcf:b0:94e:1764:b09b with SMTP id i15-20020a1709064fcf00b0094e1764b09bmr38239555ejw.45.1684288007264;
        Tue, 16 May 2023 18:46:47 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id hg10-20020a1709072cca00b009659c23e78fsm11479552ejc.215.2023.05.16.18.46.46
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 18:46:46 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-969f90d71d4so21015166b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 May 2023 18:46:46 -0700 (PDT)
X-Received: by 2002:a17:907:1c9e:b0:96a:9c6:d75a with SMTP id
 nb30-20020a1709071c9e00b0096a09c6d75amr24685640ejc.24.1684288006002; Tue, 16
 May 2023 18:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home> <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local> <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local> <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
In-Reply-To: <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 May 2023 18:46:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
Message-ID: <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>, dthaler@microsoft.com,
        brauner@kernel.org, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, May 16, 2023 at 5:56=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That code depends on all the usual MM locking, and it does not work at
> all in the same way that "pagefault_disable()" does, for example.

Note that in interrupt context, the page table locking would also
deadlock, so even though it's using spinlocks and that _could_ be
atomic, it really isn't usable in interrupt (much less NMI) context.

And even if you're in process context, but atomic due to other reasons
(ie spinlocks or RCU), while the page table locking would be ok, the
mm locking isn't.

So FOLL_NOFAULT really is about avoiding faulting in any new pages,
and it's kind of like "GFP_NOIO" in that respect: it's meant for
filesystems etc that can not afford to fault, because they may hold
locks, and a page fault could then recurse back into the filesystem
and deadlock.

It's not about atomicity or anything like that.

Similarly, FOLL_NOWAIT is absolutely not about that - it will actually
start to fault things in, it just won't then wait for the IO to
complete (so think "don't wait for IO" rather than any "avoid
locking").

Anyway, the end result is the one I already mentioned: only
"get_user_page[s]_fast_only()" is about being usable in atomic
context, and that only works on the *current* process.

That one really is designed to be kind of like "pagefault_disable()",
except instead of fetching user data, it fetches the "reference" to
the user datat (ie the pointers to the underlying pages).

In fact, the very reason that *one* GUP function works in atomic
context is pretty much the exact same reason that you can try to fault
in user pages under pagefault_disable(): it doesn't actually use any
of the generic VM data structures, and accesses the page tables
directly. Exactly like the hardware does.

So don't even ask for other GUP functionality, much less the "remote"
kind. Not going to happen. If you think you need access to remote
process memory, you had better do it in process context, or you had
better just think again.

               Linus
