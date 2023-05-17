Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D321EC77B7A
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 17 May 2023 18:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjEQSPj (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 17 May 2023 14:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEQSPi (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:15:38 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10AA83D8
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 11:15:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-510b7b6ef59so2004105a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684347333; x=1686939333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glKf7NIJxMjvHArJbyFniLngVqkquHliX4T2ECqtZCU=;
        b=cYfzgsSW1eAL0mcxFzcFEGVKiKhkmtJW2V5Bn8D9TKCTdWnP8YMHoqvHHyUmLhNLZQ
         qjqngIFqiAXhlgkoJqdb5JkZr6fW7vDx8Jt32RAYmGXcCUaLzFcRx66QXuHZMv1B/NGS
         z0NFZBSQMtvdSXWji9N4a3iDY8hTZ6unme+Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684347333; x=1686939333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glKf7NIJxMjvHArJbyFniLngVqkquHliX4T2ECqtZCU=;
        b=joXk3tAALfynjTlKZ4He1m8WqlepIETutTWvq5/1q8gP1BYEi4tX25rTHIMHb/jJQk
         a8ZCFpR4vwbiQqg3Nt1suaUVBKtQh/HpLQYcufKvFtijGpdLZE6AMElccOd+Wgac5djp
         c9SkiCiXRSla+3i217LkdTonX8AhLEpulrNB21hd1pZ2Tt6vvqRJAuopLhjDwcA5bYxJ
         YkRu+AIBqTvF7ww6fv3lX+chdhlnVGt9s5LjRsGLXwNPVVupCbU/KERfnWgiYN+2C3G0
         v2htSBdrHZ72F/SjOllLPIdAQiF+yTBdR50SQecj10e/mdwPJ7Zn5TX+Hc+xh34sOyIF
         qo2Q==
X-Gm-Message-State: AC+VfDwPe/78IG0lmXifOetYGG7/LjfE6FUJwYsxkugWyWkNf8ic7T+z
        qmueqy2Ma8WfIpDSqdiNnpx+LspNzKuoTPPLqnV33UgU
X-Google-Smtp-Source: ACHHUZ7FemdISE7xWc98Ybn/MZxFKUxz3B4jGRWh+ar+bP7Wp76R5rPoWnnshakgGVqL0jGO+BnHnA==
X-Received: by 2002:a17:907:3d90:b0:968:236:eb17 with SMTP id he16-20020a1709073d9000b009680236eb17mr32018966ejc.24.1684347332925;
        Wed, 17 May 2023 11:15:32 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id tf8-20020a1709078d8800b0096a2b6de3a4sm10425622ejc.122.2023.05.17.11.15.32
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 11:15:32 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so2020141a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 11:15:32 -0700 (PDT)
X-Received: by 2002:a17:906:dacb:b0:966:53b1:b32a with SMTP id
 xi11-20020a170906dacb00b0096653b1b32amr31032871ejb.53.1684347331694; Wed, 17
 May 2023 11:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home> <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local> <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local> <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home> <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain>
In-Reply-To: <20230517172243.GA152@W11-BEAU-MD.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 11:15:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
Message-ID: <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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

On Wed, May 17, 2023 at 10:22=E2=80=AFAM Beau Belgrave
<beaub@linux.microsoft.com> wrote:
>
> On Tue, May 16, 2023 at 08:03:09PM -0700, Linus Torvalds wrote:
> > So what is it that could even race and change the list that is the
> > cause of that rcu-ness?
>
> Processes that fork() with previous user_events need to be duplicated.

BS.

Really. Stop making stuff up.

The above statement is clearly not true - just LOOK AT THE CODE.

Here's the loop in question:

                list_for_each_entry_rcu(enabler, &mm->enablers, link) {
                        if (enabler->event =3D=3D user) {
                                attempt =3D 0;
                                user_event_enabler_write(mm, enabler,
true, &attempt);
                        }
                }

and AT THE VERY TOP OF user_event_enabler_write() we have this:

        lockdep_assert_held(&event_mutex);

so either nobody has ever tested this code with lockdep enabled, or we
hold that lock.

And if nobody has ever tested the code, then it's broken anyway. That
code N#EEDS the mutex lock. It needs to stop thinking it's RCU-safe,
when it clearly isn't.

So I ask again: why is that code using RCU list traversal, when it
already holds the lock that makes the RCU'ness COMPLETELY POINTLESS.

And again, that pointless RCU locking around this all seems to be the
*only* reason for all these issues with pin_user_pages_remote().

So I claim that this code is garbage.  Somebody didn't think about locking.

Now, it's true that during fork, we have *another* RCU loop, but that
one is harmless: that's not the one that does all this page pinning.

Now, that one *does* do

        list_add_rcu(&enabler->link, &mm->enablers);

without actually holding any locks, but in this case 'mm' is a newly
allocated private thing of a task that hasn't even been exposed to the
world yet, so nobody should be able to even see it. So that code lacks
the proper locking for the new list, but it does so because there is
nothing that can race with the new list (and the old list is
read-only, so RCU traversal of the old list works).

So that "list_add_rcu()" there could probably be just a "list_add()",
with a comment saying "this is new, nobody can see it".

And if something *can* race it it and can see the new list, then it
had damn well needs that mutex lock anyway, because that "something"
could be actually modifying it. But that's separate from the page
pinning situation.

So again, I claim that the RCU'ness of the pin_user_pages part is
broken and should simply not exist.

> > Other code in that file happily just does
> >
> >         mutex_lock(&event_mutex);
> >
> >         list_for_each_entry_safe(enabler, next, &mm->enablers, link)
> >
> > with no RCU anywhere. Why does user_event_enabler_update() not do that?
>
> This is due to the fork() case above without taking the event_mutex.

See above. Your thinking is confused, and the code is broken.

If somebody can see the new list while it is created during fork(),
then you need the event_mutex to protect the creation of it.

And if nobody can see it, then you don't need any RCU protection against it=
.

Those are the two choices. You can't have it both ways.

> > Oh, and even those other loops are a bit strange. Why do they use the
> > "_safe" variant, even when they just traverse the list without
> > changing it? Look at user_event_enabler_exists(), for example.
>
> The other places in the code that do this either will remove the event
> depending on the situation during the for_each, or they only hold the
> register lock and don't hold the event_mutex.

So?

That "safe" variant doesn't imply any locking. It does *not* protect
against events being removed. It *purely* protects against the loop
itself removing entries.

So this code:

        list_for_each_entry_safe(enabler, next, &mm->enablers, link) {
                if (enabler->addr =3D=3D uaddr &&
                    (enabler->values & ENABLE_VAL_BIT_MASK) =3D=3D bit)
                        return true;
        }

is simply nonsensical. There is no reason for the "safe". It does not
make anything safer.

The above loop is only safe under the mutex (it would need to be the
"rcu" variant to be safe to traverse without locking), and since it
isn't modifying the list, there's no reason for the safe.

End result: the "safe" part is simply wrong.

If the intention is "rcu" because of lack of locking, then the code needs t=
o
 (a) get the rcu read lock
 (b) use the _rcu variant of the list traversal

And if the intention is that it's done under the proper 'event_mutex'
lock, then the "safe" part should simply be dropped.

               Linus
