Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D21C77B7A
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 18 May 2023 00:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjERAXj (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 17 May 2023 20:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjERAXi (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:23:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9B294
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 17:23:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9661a1ff1e9so212678666b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 17:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684369415; x=1686961415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT8xYYCjH6ggOvHhW6+9I5mhGuzNhDu/1pBE5VbcuBw=;
        b=INQ4ISvc/du1t93TevcwNUnl1FdGbLPaut0dYlmHtAFewyWsiD2G8ntDEYWxo6+wbl
         LBjopCMy6cL9RCR4oBDwt5vOu9JpFTsFjhDDUOUbhvHjjI9fCHkwVCJ1m/vLpyBblPnN
         LCqRCJ8rIy1fAhcSPvQ4GnHuyEVc0Nxpteazc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684369415; x=1686961415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT8xYYCjH6ggOvHhW6+9I5mhGuzNhDu/1pBE5VbcuBw=;
        b=JsQEMQxBXfHjefXNjW72KJ9wEgxV++oJwaIJ82b8M2j42WaX+pOvSkRiS4jiyFsCWS
         Cf2PXzB3ieX1tOn+gZTAVvuUFoLhaqqEs8T7DfAFqktEjJRnRMEJTbpSlC2ooIJiDOet
         6Rq0FUvoUNFXKFnUU5/dEldYkTLlceL1QVwSUfjZG0JFF+0I9neUn41ZUthSsnRwzeOq
         X7LY6RYQch6/XSV6BSvtyghwflfFLEMJbglSrQTgnMaP/BvbHMzqmN9jcQtN6jKyjRYv
         TZfVzYLK4M7RWXRbPkD8kVU2sL1jCgN7tEJ1q75CZowngLWRKXvi7NrrgjHsniy1w4mK
         4IOQ==
X-Gm-Message-State: AC+VfDy7EYKdT0m6TpN7R+pLfH7qGdP+FuEtraXuf+Wr1flX/C8mPDAk
        hrtWBol0VGjlUwr4tr5vUjiMRxNLds/YEUJ3d+vKNMVQ
X-Google-Smtp-Source: ACHHUZ6nDNL72deHcq8b9GzwPVuMEYNwkWKnfxaMoQdvDuJcKVb4WWaxMYFda7UPtOOqxnBNfs849w==
X-Received: by 2002:a17:907:7b9e:b0:96f:2315:29fe with SMTP id ne30-20020a1709077b9e00b0096f231529femr1222378ejc.0.1684369415458;
        Wed, 17 May 2023 17:23:35 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id la17-20020a170906ad9100b00965ab02b42csm217001ejb.102.2023.05.17.17.23.34
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 17:23:34 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-965c3f9af2aso214564666b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 17:23:34 -0700 (PDT)
X-Received: by 2002:a17:907:7dab:b0:967:a127:7e79 with SMTP id
 oz43-20020a1709077dab00b00967a1277e79mr31504240ejc.28.1684369414251; Wed, 17
 May 2023 17:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain> <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain> <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
 <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
 <CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com>
 <20230517230054.GA195@W11-BEAU-MD.localdomain> <CAHk-=wgQ7qZZ1ud6nhY634eFS9g6NiOz5y2aEammoFkk+5KVcw@mail.gmail.com>
 <20230517192528.043adc7a@gandalf.local.home> <20230518001422.GA254@W11-BEAU-MD.localdomain>
In-Reply-To: <20230518001422.GA254@W11-BEAU-MD.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 17:23:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjU0vq8aL_VmUDqwh9_fo8nXYt65PBjihNetTMq4s8OsA@mail.gmail.com>
Message-ID: <CAHk-=wjU0vq8aL_VmUDqwh9_fo8nXYt65PBjihNetTMq4s8OsA@mail.gmail.com>
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

On Wed, May 17, 2023 at 5:14=E2=80=AFPM Beau Belgrave <beaub@linux.microsof=
t.com> wrote:
>
> Do you run with CONFIG_DEBUG_ATOMIC_SLEEP? It will not splat with just
> CONFIG_PROVE_LOCKING and CONFIG_PROVE_RCU, which bit me here. I'm now
> running all three now that I know better.

I wonder if we should just make PROVE_LOCKING select DEBUG_ATOMIC_SLEEP..

PROVE_LOCKING is the expensive and complicated one. In contrast,
DEBUG_ATOMIC_SLEEP is the "we've had this simplistic check for some
very basic requirements for a long time".

So DEBUG_ATOMIC_SLEEP is really just a minimal debugging thing, it
feels a bit silly to have all the expensive "prove locking with
lockdep and all our lock debugging", and then not test the trivial
basics.

           Linus
