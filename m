Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E407C77B7D
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 17 May 2023 16:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjEQQkH (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 17 May 2023 12:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjEQQkE (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:40:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F593A9C
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 09:40:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9659443fb56so146171166b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684341600; x=1686933600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUiZh9vX79/8GlRHS85iCL0x+Okzafu2CQZl4ySfqrA=;
        b=hJSArDsACQfgIfZm5gUboXLfaag3Cc98UHAkpAcbwjSjIyOWcTjMzYULTRwkLUsTBc
         Q6moqtReX3RXB65vJn4njVt1VF18bbqLOFraNA9bXXXFXhtZu7AqZ8icPXS/yqMHtGN0
         4E+pzVP7uoj7+5A2t9EcRD7+lOjwJP7YYHZoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684341600; x=1686933600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUiZh9vX79/8GlRHS85iCL0x+Okzafu2CQZl4ySfqrA=;
        b=X33leza3NitO9315VnrBLWBQh1RH0E6YGkFoKsIG4xfy0ROGuiiTJUJrOdXPeiiX+z
         Sdb+w6VZOl2f/dU8AUdSvfMIohEGP1ykWTMQyZtQNuXmlskYa/yHldW+ZAV7RQGsgFHq
         mwFaN/b++v1UrZzlMhpTQpy5zZ4aDWH8Hglv0o2NG/cA9LekZRmjGr/I6xixGAS+wJzn
         qUkF0EQOehQr2jnAsIYz8RR9o+J8gsye+ej9BuzSN1/KyHwxoOfQMg6p6H2SzdAHziRT
         Q9hXn3FcT0uZsOYXNKP9DTBEET8WUzxP6lCBGs+m3SE8egTOchn4h2BfJZMVGSgCl8XW
         OuEg==
X-Gm-Message-State: AC+VfDyI8sXgKblB+Nwx/cC8jkWLbR0Vztp56KFsDSYomXbFu8WG7/UH
        qUXFEyXqE3ExJAw432jei+3sOkPhF6mWLuYdyy2IC4yp
X-Google-Smtp-Source: ACHHUZ5iO0CBnn5jOtb/NZAOMp3JOo4oSRHDGLuGLenW9rp5n1y66pSCCEMAP16QUta8Mwo6EDt3/Q==
X-Received: by 2002:a17:907:9706:b0:965:eb5d:3b26 with SMTP id jg6-20020a170907970600b00965eb5d3b26mr43565833ejc.52.1684341600086;
        Wed, 17 May 2023 09:40:00 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id s16-20020a170906285000b0096b15e4ffcesm5132817ejc.85.2023.05.17.09.39.59
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 09:39:59 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9661a1ff1e9so146010966b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 09:39:59 -0700 (PDT)
X-Received: by 2002:a17:907:868f:b0:969:f9e8:a77c with SMTP id
 qa15-20020a170907868f00b00969f9e8a77cmr31038132ejc.64.1684341598769; Wed, 17
 May 2023 09:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230517124721.929540-1-arnd@kernel.org>
In-Reply-To: <20230517124721.929540-1-arnd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 09:39:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+129KAcegJqvo2PKPUK3yw5qQwF0LcHofdT0bPbs8iQ@mail.gmail.com>
Message-ID: <CAHk-=wh+129KAcegJqvo2PKPUK3yw5qQwF0LcHofdT0bPbs8iQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: make ftrace_likely_update() declaration visible
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, May 17, 2023 at 5:47=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This function is only used when CONFIG_TRACE_BRANCH_PROFILING is
> set, and the declaration is hidden behind this Kconfig symbol,
> which causes a warning if disabled:

That explanation is not very clear.

The problem is that the tracing code itself is built with
DISABLE_BRANCH_PROFILING, in order to not recurse. And that hides the
declaration when the definition is compiled, leading to the problem.

CONFIG_TRACE_BRANCH_PROFILING isn't the problem in itself - *that*
part of the test is consistent (not used, not declared, and not
compiled if it is off).

The problem is that DISABLE_BRANCH_PROFILING case, where it is used
elsewhere, but not declared when it is itself compiled.

I applied the patch, but I tried to reword the explanation to be more
clear. I may have failed.

          Linus
