Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA2BC77B7A
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 17 May 2023 23:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjEQXPF (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 17 May 2023 19:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEQXPF (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:15:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76BB268F
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 16:15:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so2094335a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 16:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684365302; x=1686957302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk6cd8LcbzAJxt5N/GDDi+PvU6BaObHMv6cAraPkag0=;
        b=L3qjB3VaqsqlOiGB5yeTiiPsIIfhodMmHKQY2F8CmzC2L7OHTbVab0xh8JeM0wAPRf
         MVnA11JyPXHzfj84mH2U6ojLkg5Bs+WuZdXTkNXfkEFxQ3AqIyqzUyF4jEc8wFX0MnLP
         qf/BBm0TbuUJvdeQBAKk9cgSNfVYQQ9hV9DHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684365302; x=1686957302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk6cd8LcbzAJxt5N/GDDi+PvU6BaObHMv6cAraPkag0=;
        b=lbvKWMqsTuXpOUd5DXkU3II++cmD6+XlMTRN+4kxN3usb1F9NFM7DKljs3SdykTsQc
         I8S6a8f0qeOewFvXov9X4AsECIwTerqBY4VtVIFFOtD82OuBeM+nISIXWbYN2s4RvlU0
         A2oI2UF19htQT4OKXSa9vLIw2pm/gmM5ZwDAj/68C+3z9Qrz7/SEq/jB1VP2/mwewMMf
         YoAK8dWAVFrYBC2NvFqzgOcCfS8m3f5Q8V75Uwlrp+I+Y7LNkHZC2NZ2BlFfOcuTaIrK
         aBuoDxD2VS/KF0tEh4SMmglkR5M9CgxJdC1qyLkxPLE10yQkSbXd829qssA4+v9xoXB+
         nIow==
X-Gm-Message-State: AC+VfDy0vWGwayWLioP3TrOhFL0FawglpudN8l5oCY8/gLj/oAfKm149
        yK7mbFKoBSgeymxhPpADHCU1q4teZYlz0ZGQBFsq6viF
X-Google-Smtp-Source: ACHHUZ4wiswY0MnRoc4x/s5Xnt1Uk86K5twICscDcvr4Q4kTF9KQFhoNIPXVQzWCvUuSAxZpasZqUg==
X-Received: by 2002:a17:906:6a24:b0:96a:2b5a:f013 with SMTP id qw36-20020a1709066a2400b0096a2b5af013mr25963885ejc.62.1684365301876;
        Wed, 17 May 2023 16:15:01 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id g18-20020a1709067c5200b0094e7d196aa4sm150150ejp.160.2023.05.17.16.15.00
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 16:15:01 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-510d1972d5aso1840488a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 16:15:00 -0700 (PDT)
X-Received: by 2002:a17:907:c26:b0:966:238a:c93 with SMTP id
 ga38-20020a1709070c2600b00966238a0c93mr38602562ejc.68.1684365300509; Wed, 17
 May 2023 16:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home> <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain> <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain> <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
 <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
 <CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com> <20230517230054.GA195@W11-BEAU-MD.localdomain>
In-Reply-To: <20230517230054.GA195@W11-BEAU-MD.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 16:14:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQ7qZZ1ud6nhY634eFS9g6NiOz5y2aEammoFkk+5KVcw@mail.gmail.com>
Message-ID: <CAHk-=wgQ7qZZ1ud6nhY634eFS9g6NiOz5y2aEammoFkk+5KVcw@mail.gmail.com>
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

On Wed, May 17, 2023 at 4:01=E2=80=AFPM Beau Belgrave <beaub@linux.microsof=
t.com> wrote:
>
> Do you mind giving me your Signed-off-by for these?

Assuming you have some test-cases that you've run them through, then yes:

 Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

for both. But since I can't really test them myself, I'd really like
that. I did these patches just by looking at the source code, and
while I think that's an excellent way to do development, I do think
that testing is _also_ required.

And that second patch was obviously not even build-tested, so really
just a "something like this".

> I plan to do a series where I take these patches and then also fix up a
> few comments and the link namings as you suggested.

Sounds good.

> First patch is clean, second patch I made the following changes and
> after that passed all the self-tests without bug splats with
> CONFIG_PROVE_LOCKING/RCU and ATOMIC_SLEEP:

Your suggested version with just "list_add()" and a comment about why
it doesn't need RCU safety looks good. And the build fix obviously
requited ;)

                  Linus
