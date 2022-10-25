Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCBCC38A2D
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 25 Oct 2022 01:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJYB3t (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 24 Oct 2022 21:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiJYB3L (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:29:11 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA1A6378
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:06:29 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id f22so6705527qto.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pMkA+r6Lkdb6N0+izztoT+4iCmOzMvt12DLQ8k8DOjg=;
        b=ScwRDh+MFfI1jr0SDTqzUKqoKymOBLq+rBtnleXEd7FnoayNaCgt8/bry8tWtF4quS
         vlUMiL9MvVQpsdZubFViwegHaiBuEb9Fzz9lSl3hPssMAW5+oHXehHGibXMovtdbIjWb
         MLz4Qmuw2X0Yq/rYSIou7svOPMeIH/lEBJ5CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMkA+r6Lkdb6N0+izztoT+4iCmOzMvt12DLQ8k8DOjg=;
        b=kKNc6u6rp0oD5YzLp1fiK+CsiIKY+K6PLrQmLwfMPtAoN262E3skT2GB4Guzu4LeUg
         sfzqa5KiaB6u7ZTVcyu9P3al1lvi1vkrA5Lz/kX2HdoZKCk89JwCIk11KYVqy/Q3ddV3
         AvAWKCfycfsx6XWMDTJTdm0QWGKHwLkJmKZSvZw2DQ/8nALMntGBfLM1R19priZUbBSV
         D0x3ip9DE9lHgWp+Rf45wf0uPR0QsZXqdPgILQKKEiilqfxV8rli2Zw1Z9BT6+1YzolN
         0EhQMT9E8Q/hVnsVWQRYhnb1zuOVteKk+ZBEkXFYAFvtkiuRzAbVm/V15Bz+D6IbaedF
         marQ==
X-Gm-Message-State: ACrzQf2Txgp7cf9FVRE55OOkHvWSrDInvVH57/LzXI4FGs4dsBsJ+2pg
        JUmTz7b/h9LnHAaVczmg/kAxlE91d3+kfQ==
X-Google-Smtp-Source: AMsMyM4Eu94UryFOYeNTCoGSsw28akkcuIzP0ShjwcY+3OevO7LMIwI2eG6qrEJcA4HYQ5cU1E168Q==
X-Received: by 2002:a05:622a:13:b0:39d:934:d4a2 with SMTP id x19-20020a05622a001300b0039d0934d4a2mr23560234qtw.398.1666659988337;
        Mon, 24 Oct 2022 18:06:28 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id e10-20020a05622a110a00b0039cb9ef50b5sm848728qty.26.2022.10.24.18.06.26
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 18:06:26 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-367b8adf788so100780627b3.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:06:26 -0700 (PDT)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr13959508ywr.58.1666659985851; Mon, 24
 Oct 2022 18:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221024190311.65b89ecb@gandalf.local.home> <CAHk-=wji4q7rGUWDLonnEnxq0ykNCcYGpMrNnZg89rAwOgyRKg@mail.gmail.com>
 <20221024202133.38e0913e@gandalf.local.home> <CAHk-=wj_jxetFqMB8VWcJdtOt+CU0r_isyGV4AhEYFxA7YsU7Q@mail.gmail.com>
 <20221024210535.61174928@gandalf.local.home>
In-Reply-To: <20221024210535.61174928@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 18:06:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdLGWaqw5udT-aZYM2+UjfjsFj=Pb48OGBv2anG=RLmQ@mail.gmail.com>
Message-ID: <CAHk-=wjdLGWaqw5udT-aZYM2+UjfjsFj=Pb48OGBv2anG=RLmQ@mail.gmail.com>
Subject: Re: [RFC PATCH] text_poke/ftrace/x86: Allow text_poke() to be called
 in early boot
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 6:05 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Something to look into. But I'm guessing that's best for the next merge
> window, and not for the -rc releases?

Yes., I just applied your v1 patch.

               Linus
