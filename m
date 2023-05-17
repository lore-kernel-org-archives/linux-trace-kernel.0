Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E411C77B75
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 17 May 2023 03:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjEQDEZ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 16 May 2023 23:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjEQDD6 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:03:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DCC49ED
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 May 2023 20:03:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so432544a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 May 2023 20:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684292607; x=1686884607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQC84bjg5veEkaq5Nnh/MZ6+IOv+WPa/0t9irvzCFqA=;
        b=eJVM8sjvhAsNsYLqSl3U5y8HuzaKazuAgmyIfLhtAhm2XH4lP5JAENwLSJq7gWQULb
         tZGh3K2dZgEIDmBa/bhJRFbkz2I+998mprOOkf4i2/C+jqEz3wheSwoB0+IXdGk+PHWV
         pSU9sRlB1iFg0Y6+z/vkUMZejHqdMrUNQSoe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684292607; x=1686884607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQC84bjg5veEkaq5Nnh/MZ6+IOv+WPa/0t9irvzCFqA=;
        b=Ts0KKamKXrXMTvcpAeVrsaFI8SNGS6DxQNR1yAMMBw+LAOjbkROcGXojKDCaaAACFS
         7WY7QNSFQWZI1wf+tmn+v4sfo3jMLbY38e54i4jVw1JOLEC3vkhocyFK/R8nVRwOlFn/
         XOX0jHlm/UkoyfKcEMpcgdUsRrx7p6p27OzfnB/ngdWhlt966scKoVEZZUKHWIIZtS71
         MbC1pChmUTF7DM/ko0SGZvUXNijAxPPbnUJsyA/YRaaYhPNYSS+AVzVRPAm8tD1pm5Ov
         wvIMc8P1RFiylgcYG+WpEwdejBgNGfxZPExida+bdyjw0E3LMTlDRuOMJWYqah7mq92f
         8aWA==
X-Gm-Message-State: AC+VfDzfbj+gTnwJFBI3aTa2oqXWDUiaBw+xXRcxQ4aDCV0ZkSnuDTPB
        uyv1QHAUi55KepstRViQlZhhSy1C8APrwxWY+JoHG/BS
X-Google-Smtp-Source: ACHHUZ4Ul8MrtSYdSH1qjgzzZGRljjulEcwIfpwTRNX64tF+FO+lJt7MFbUbYJb6GGuGqqadkZ7Spw==
X-Received: by 2002:a17:907:6d81:b0:96a:7fa4:7b90 with SMTP id sb1-20020a1709076d8100b0096a7fa47b90mr18116816ejc.18.1684292607564;
        Tue, 16 May 2023 20:03:27 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a10-20020a170906368a00b0096b275e19cbsm3971424ejc.115.2023.05.16.20.03.26
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 20:03:27 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-96b0235c10bso31160466b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 May 2023 20:03:26 -0700 (PDT)
X-Received: by 2002:a17:907:6d15:b0:96a:bfc:7335 with SMTP id
 sa21-20020a1709076d1500b0096a0bfc7335mr23923089ejc.53.1684292606486; Tue, 16
 May 2023 20:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home> <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local> <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local> <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com> <20230516222919.79bba667@rorschach.local.home>
In-Reply-To: <20230516222919.79bba667@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 May 2023 20:03:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
Message-ID: <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Beau Belgrave <beaub@linux.microsoft.com>,
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

On Tue, May 16, 2023 at 7:29=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> So this code path is very much in user context (called directly by a
> write system call). The issue that Alexei had was that it's also in an
> rcu_read_lock() section.
>
> I wonder if this all goes away if we switch to SRCU?

Yes, SRCU context would work.

That said, how critical is this code? Because honestly, the *sanest*
thing to do is to just hold the lock that actually protects the list,
not try to walk the list in any RCU mode.

And as far as I can tell, that's the 'event_mutex', which is already held.

RCU walking of a list is only meaningful when the walk doesn't need
the lock that guarantees the list integrity.

But *modification* of a RCU-protected list still requires locking, and
from a very cursory look, it really looks like 'event_mutex' is
already the lock that protects the list.

So the whole use of RCU during the list walking there in
user_event_enabler_update() _seems_ pointless. You hold event_mutex -
user_event_enabler_write() that is called in the loop already has a
lockdep assert to that effect.

So what is it that could even race and change the list that is the
cause of that rcu-ness?

Other code in that file happily just does

        mutex_lock(&event_mutex);

        list_for_each_entry_safe(enabler, next, &mm->enablers, link)

with no RCU anywhere. Why does user_event_enabler_update() not do that?

Oh, and even those other loops are a bit strange. Why do they use the
"_safe" variant, even when they just traverse the list without
changing it? Look at user_event_enabler_exists(), for example.

I must really be missing something. That code is confusing. Or I am
very confused.

            Linus
