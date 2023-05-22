Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEC9C77B73
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 22 May 2023 07:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjEVHgN (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 22 May 2023 03:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjEVHgL (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:36:11 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093C7A8
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 May 2023 00:36:08 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b9daef8681fso4879949276.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 May 2023 00:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684740967; x=1687332967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYO6QyeT/vE0/dLal+mOoUvrbx/vhy+FOFfMUworJUI=;
        b=xDDT/+bIDGyUkQVLK9/FgK0mSNOUdgqdlxiCGabcrZlU8t9IA++ddilBYK93nb/EOn
         NSmWclPrefvWOGhbCXrB+X25RWUQRnUgWujGNtHx9ScLuEJET/R+5EBhtv+PCk6CTtlU
         n7ZF9PeLvX+DcBJMpayABvk9ky54qVIzosJkZ3e4dnUiF3UGkI1zt6gpfKN9+mo+ozCu
         pw/KJu2WDIoFhBzh6tKHUFLIE+dLKzT6uYo599qbezzlNDZv0ESm7suJh/4q+Oi/AKId
         Ehfbw43Ozb13E/PbEA/IfW0xLmtjHO1eKpM4h0e5/zphDWl8knJJ50AV3LCQm+Y1B2hg
         hs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684740967; x=1687332967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYO6QyeT/vE0/dLal+mOoUvrbx/vhy+FOFfMUworJUI=;
        b=I8tEtfftM9MBVTFUIg6gb21asM5Z3jh7Z24iu7+BwKZcap4Pys6vgQbwIkhzO/1W6m
         3F+OAONmEEbifg8LqzZ6+jBbGzq8kiJ6QGFpXsUMqktoPkUbIsSBC/bfkMF/mw3fLrTX
         7++Ttb30f4+t8bdIpzWsNwefWz6/rFo8IRcB+MuUR3sUoreoMUy/MweDDD9CsHfjB/+z
         M+LuGo29E2B1aLxLgJB1JIC3D0SIPB00Z+0yp4DLXc87czaHeWAT33a3rFje43/NLi7b
         +/wVg0oph+fYsGw5rKR8vCC8ckmZt+//tuRnV+okMF7e0+997xzR2tBethAQMKbLBoGY
         UZoA==
X-Gm-Message-State: AC+VfDw738EF5sRAG/SF0395N3yYmRMyZ+5jrhxrCcIBpXhjTxxwNVpy
        nHRi7Kv90obh7FRV04SVuv+k9ksS8PTQJhiyrwbDRw==
X-Google-Smtp-Source: ACHHUZ68CRANHGe6xAuOw1CpSWwlTGVc+dACk1dfiCmZPpQD6rOxHUDm2AJP7afAyAVJgTKG4e5g40VwzefbCRkUQ8o=
X-Received: by 2002:a25:a524:0:b0:ba7:4977:465d with SMTP id
 h33-20020a25a524000000b00ba74977465dmr9343957ybi.47.1684740967218; Mon, 22
 May 2023 00:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230516154605.517690-1-arnd@kernel.org> <20230516154605.517690-12-arnd@kernel.org>
In-Reply-To: <20230516154605.517690-12-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 May 2023 09:35:56 +0200
Message-ID: <CACRpkdZKQVZrU05xKG1fgbgcVaJ2Jvg8V2Hx3eHDsiGQqUtGcw@mail.gmail.com>
Subject: Re: [PATCH 11/16] ARM: move setup functions to header
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, May 16, 2023 at 5:46=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> A couple of functions are declared in arch/arm/mm/mmu.c rather than in a =
header,
> which causes W=3D1 build warnings:
>
> arch/arm/mm/init.c:97:13: error: no previous prototype for 'setup_dma_zon=
e' [-Werror=3Dmissing-prototypes]
> arch/arm/mm/mmu.c:118:13: error: no previous prototype for 'init_default_=
cache_policy' [-Werror=3Dmissing-prototypes]
> arch/arm/mm/mmu.c:1195:13: error: no previous prototype for 'adjust_lowme=
m_bounds' [-Werror=3Dmissing-prototypes]
> arch/arm/mm/mmu.c:1761:13: error: no previous prototype for 'paging_init'=
 [-Werror=3Dmissing-prototypes]
> arch/arm/mm/mmu.c:1794:13: error: no previous prototype for 'early_mm_ini=
t' [-Werror=3Dmissing-prototypes]
>
> Move the declaratsion to asm/setup.h so they can be seen by the compiler
> while building the definition.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This looks cleaner to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
