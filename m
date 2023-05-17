Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EA1C77B7A
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 17 May 2023 19:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjEQThV (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 17 May 2023 15:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEQThU (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:37:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89DDAD37
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 12:36:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-966287b0f72so211878066b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 12:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684352215; x=1686944215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DJujWcgKFUPe2mSgSbivOepwby+XZ0SdDGpw6KOt6U=;
        b=YUKLCUp0opnZL59BabfkIgSjrlevcUUcuu4BP9q8MHCvd9MpC89jZy2WbGQh8jrnk9
         vKHSCQkGbpRGnNAZrbomB2eC0vbf9tNYPzMd0IHq1CWiClp6Oz9WYeJuiX8F1ir5pqoh
         k4E3DN96nXMWj9kmEMdks3O4LnfzRZA1Rj4AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684352215; x=1686944215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DJujWcgKFUPe2mSgSbivOepwby+XZ0SdDGpw6KOt6U=;
        b=W7t+rHjnXPSVJx9wyZO5Yc7xJGfkmvAi5U84L55cn3W5YZaNt6RLE1jjeXA+d/TLJA
         RxPOe1y/Ec2b58PddV7i5CLkfWeEo6LwXcLp+FVdEl05Om8z2tNspBrdMi2CH/DXA+bi
         tp6hcss5WNhJpK16Qmv+aKGgau5kA59UjZ9d4C95mywV2boSiik+Dk1F+YIGRzqcvqoA
         mK0LXc/fRmCiBxmktKZKxpKSxapBTiKKhriaAcuzpPobKkQImF9UKlfb3dZMhK2yWmhw
         e1dV+cPXqSxIOyt9iUhq+j7w+jXMaEtCAUNUfZe/P0OANQpZlQ1sGR2kFl16JxW+iAfi
         HBxg==
X-Gm-Message-State: AC+VfDyOEbTubMW5yDld4hxKFtHy44FI9ZyoA/u5fhm1khsUstZZe/fJ
        IqXJtv8/NqjNo7i4uNWScF52kwx+CHcawOE8K8baDU0q
X-Google-Smtp-Source: ACHHUZ5UILqGI19yyh5rGsdnII0gJiESl76mZhHRleXhUMp7KinJqHjbxHkZ/Cd+NGT5qBZaaDh6Ig==
X-Received: by 2002:a17:907:5c3:b0:885:a62c:5a5c with SMTP id wg3-20020a17090705c300b00885a62c5a5cmr33472844ejb.46.1684352214838;
        Wed, 17 May 2023 12:36:54 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906688400b00965f98eefc1sm12739177ejr.116.2023.05.17.12.36.53
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:36:53 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-966287b0f72so211872166b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 12:36:53 -0700 (PDT)
X-Received: by 2002:a17:907:628c:b0:94f:2a13:4e01 with SMTP id
 nd12-20020a170907628c00b0094f2a134e01mr38924382ejc.74.1684352212926; Wed, 17
 May 2023 12:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230509163050.127d5123@rorschach.local.home> <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain> <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home> <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain> <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain> <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
In-Reply-To: <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 12:36:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
Message-ID: <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
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

On Wed, May 17, 2023 at 12:26=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Also note that this does NOT fix the incorrect RCU walks.

.. this is the patch that I think should go on top of it to fix the
misleading "safe" and the incorrect RCU walk.

NOTE! This adds that

        lockdep_assert_held(&event_mutex);

to user_event_enabler_update() too. It's already there in
user_event_enabler_write(), but I'm not actually convinced this has
gotten enough coverage checking, so I also did it in that caller.

Some callers obviously hold that mutex. Others are much less obvious,
eg that user_event_reg() -> update_enable_bit_for() chain. I *assume*
all the 'class->reg()' callers get the event mutex, but I did not in
any way check that it is true.

So that lockdep annotation should be actually *tested* with lockdep
enabled and somebody doing all these operations.

Final note: I do not know this code *AT*ALL*. I'm literally just going
by "this is the only correct coding pattern to use", not by some
deeper understanding of what the code actually wants to do.

                   Linus
