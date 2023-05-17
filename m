Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDB1C7EE22
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 17 May 2023 20:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjEQUJX (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 17 May 2023 16:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEQUJW (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:09:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640797292
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 13:09:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-510d8ead2f1so1264421a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 13:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684354157; x=1686946157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUJuL+2WvYBnwuI2AxMqbxeUZxgtHjH0G/Zm8si7raQ=;
        b=FswP8g2FI3659/s/93gVCGsv3xZZtGIZfyfW2LeNfXS8vk7ZVBjKBV5EubqxsPWC4B
         DTiSzYAVTqlLfpqatXRUYC2ud7ZZO/vsf5e6eQGX32M+kzCJw+W5bHv1BObk06wK2Nh+
         YyCLeqhvFzPSmMK/EQYkoCJ95VGK9AkRl/KJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684354157; x=1686946157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUJuL+2WvYBnwuI2AxMqbxeUZxgtHjH0G/Zm8si7raQ=;
        b=kcFss9COdcpitHAz70wbcnVDCH3Zxn6OUYWg7oIMR0+UZHK1wAdUBdXkMxKuce2FC8
         un21+c9MtqVkDcfQO634XDAifbuaLPAheGjaz8XgKZYPPLydV/OsPtATLc2hIKtr16ih
         GSyy88CePX8oRz8dS+pJ3Fp7Pt08ZUx6TdTaHPNUwp6T4SI43KEGty1G1gquQYmngWmq
         tpeyaaoASXj/WTlDKk9jXW2BkNdTNRtfJaY2p5s8mg3j4TzeeVVh9DlkR1D//uPH8Bbr
         u4RjiP0ELUmMw54W1diakQrNAW7VGkPBC44jijRk1gBtkFktpWh7hAEUgkDagqqKtgCF
         BGSA==
X-Gm-Message-State: AC+VfDyoHlQQQOd3FNaBrMXMoU/XFC6E7NufLqZjisKKTyzriawUCvEd
        O9a+8WiOl/yAu9vcwENM7nhjyl/QpJeD7oyBslhvRkav
X-Google-Smtp-Source: ACHHUZ5mTy7CGyPnOC9Rr0SkTZGOa1MXGOQWxk1hb4VrlH5gkQhELKSe8m5Fi/+k0/Co3EzAD5Gqgg==
X-Received: by 2002:a17:906:db07:b0:94f:6058:4983 with SMTP id xj7-20020a170906db0700b0094f60584983mr33520028ejb.76.1684354157664;
        Wed, 17 May 2023 13:09:17 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id ew18-20020a170907951200b009660e775691sm12652260ejc.151.2023.05.17.13.09.16
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 13:09:16 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-96a2b6de3cbso189806366b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 13:09:16 -0700 (PDT)
X-Received: by 2002:a17:907:7291:b0:96a:717:d452 with SMTP id
 dt17-20020a170907729100b0096a0717d452mr29868922ejc.19.1684354155799; Wed, 17
 May 2023 13:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230509163050.127d5123@rorschach.local.home> <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain> <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home> <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain> <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain> <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
 <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
In-Reply-To: <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 13:08:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicngggxVpbnrYHjRTwGE0WYscPRM+L2HO2BF8ia1EXgQ@mail.gmail.com>
Message-ID: <CAHk-=wicngggxVpbnrYHjRTwGE0WYscPRM+L2HO2BF8ia1EXgQ@mail.gmail.com>
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

On Wed, May 17, 2023 at 12:36=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> .. this is the patch that I think should go on top of it to fix the
> misleading "safe" and the incorrect RCU walk.
>
> NOTE! This adds that
>
>         lockdep_assert_held(&event_mutex);
>
> to user_event_enabler_update() too.

One more note: I think it would be really good to use different names
for the "links".

We have "mm->link", that is the list of mm's on the 'user_event_mms'
list, protected by the 'user_event_mms_lock' and RCU-walked.

And then we have 'enabler->link', which is the list of enables on the
'user_mm->enablers' list, protected by event_mutex, and _also_
occasionally RCU-walked.

And then we have 'validator->link', which isn't RCU-walked, and seems
to also be protected by the event_mutex (?).

This is all very confusing when looking at it as an outsider.
Particularly when you sometimes just see

        list_del_rcu(&mm->link);

and you have to figure "which 'link' are we talking about again?".

Also, I have to say, I found "mm->next" *really* confusing at first.

It turns out that "mm->next" is this list that is dynamically built up
by user_event_mm_get_all(), and is only a one-shot list that is valid
only as long as 'event_mutex' is held. But the only lock the code
*talks* about is the RCU lock, which does *not* protect that list, and
only exists as a way to walk that user_event_mms list without taking
any locks.

So user_event_enabler_update() actually relies on that 'event_mutex'
lock in another way than the obvious one that is about the
mm->enablers list that it *also* walks.

Again, that all seems to work, but it's *really* confusing how
"mm->next" always exists as a field, but is only usable and valid
while you hold that event_mutex and have called
user_event_mm_get_all() to gather the list.

I think both user_event_enabler_update() and user_event_mm_get_all()
should have a mention of how they require event_mutex and how that
->next list works.

Anyway, I still *think* the two patches I sent out are right, but I'm
just mentioning this confusion I had to deal with when trying to
decode what the rules were. Maybe all the above is obvious to
everybody else, but it took me a while to decipher (and maybe I
misread something).

             Linus
