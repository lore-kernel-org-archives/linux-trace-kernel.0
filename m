Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A15EB64D7
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 28 Jun 2023 11:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjF1LDV (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 28 Jun 2023 07:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjF1LDF (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:03:05 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F241FCD;
        Wed, 28 Jun 2023 04:03:04 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4021451a4a4so17251251cf.0;
        Wed, 28 Jun 2023 04:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687950183; x=1690542183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSIgXt+L+8jbFTtsKzhBTuecaRWvbcSpFDcoTapWtC8=;
        b=pfmFPl4KAvd9rLO0RT54Jcl/Ifd8PlgcMtH9hVFPH0HBCqNLqocpAz6iuDxzrmRvC3
         c43NI6cNIBjwBo8nWl4joctHJLzWRYk20uKh7DF3Yh4PQ2vSyJXMatrPbwjhIs4/cRMk
         BwSz2WO/tLc/uuGeEpfNA/I7iyI9khWPXhJjjJHxhMqdBHKYaGSh6dBc7c0ypj9DKtk7
         E+LmKWT0/ZlkdJEEdHdSoetYlVZNCCKIvI4QcDoGac1ExVBoefvmRc/k+jM69i8Y+QBy
         dgd2qCS3V9sLQii+Nm58huaZOAhHmOUtacAVQr7XaASX6R6/17nHUXq9YKPpM85vj0+R
         gcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687950183; x=1690542183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSIgXt+L+8jbFTtsKzhBTuecaRWvbcSpFDcoTapWtC8=;
        b=ZyLYNileW2siesw+dm/YIBm1oOn/GQR95cNBP5eNV21t0j760cr+VnsxlPH96o++Lh
         3HBmbj2KOHTYCKktDpIAwAIFtCJQPPU4wxSYU2/BLMbKp6lJwARAECofDsEj+cn+j3ry
         WYxO4Fv8xZa79z8xudsh4mUUMciOkiyEVKF1ugtLWvfC3MbCdBfPjPnNTAdPSqP3vl3K
         5/wngQ3IML0/OweAuZoClWw3JuC16e7gavVPYlziMxYKKlsvBOaG2BLBS6mNO3PNfKpZ
         +1RYPhfAqqnsInn9eQ0RUCXErsz3uDUTt/T3PM9O0qxjAxvALadt241HUS1C40EQmB72
         JbBg==
X-Gm-Message-State: AC+VfDzzfwuS1FEcezFhPHNtSkr7bMEcoyguC62su9eBjhHYKNnXOZsd
        hBPsjhb7jU4oInVGtvSkFYzj/JLOYppJYlN3lsk=
X-Google-Smtp-Source: ACHHUZ7UfzFTKJq9y/a0p/EgPPwFgD/boO+5mAHdZbUciSgygzNf60TvwAOuEF2bxhke76Fs2ez08EaQzyIDk38iDCA=
X-Received: by 2002:a05:622a:1454:b0:403:27e8:8842 with SMTP id
 v20-20020a05622a145400b0040327e88842mr583192qtx.10.1687950183212; Wed, 28 Jun
 2023 04:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <72b05526-4dda-430a-b4ca-2ee4f26f2185@moroto.mountain>
 <CAPpZLN4ACVRrDXofO9jNQznEuF+CK6KNbCCz=5t93kMzESbZGg@mail.gmail.com> <d1397f75-1091-42e1-8038-b6844757de79@kadam.mountain>
In-Reply-To: <d1397f75-1091-42e1-8038-b6844757de79@kadam.mountain>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Wed, 28 Jun 2023 14:02:47 +0300
Message-ID: <CAPpZLN4vNW8TJDwd+JeBD1YjdoPT6eoLj18kq5xbqsgcizCwoQ@mail.gmail.com>
Subject: Re: [RFC] tracing: Cleanup the correct ep in enable_trace_eprobe()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 8:21=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Tue, Jun 27, 2023 at 07:39:17AM +0300, Tzvetomir Stoyanov wrote:
> > On Mon, Jun 26, 2023 at 4:35=E2=80=AFPM Dan Carpenter <dan.carpenter@li=
naro.org> wrote:
> > >
> > > If enable_eprobe() function fails, then we call  disable_eprobe() on =
the
> > > "ep" that failed.  That doesn't feel right.  Shouldn't we
> > > call disable_eprobe() on the previous "ep" instead?  Or even better o=
n
> > > all the previous eps (but I don't know how to do that)...
> >
> > Hi Dan,
> > There is no need to disable the eprobes which are already successfully
> > registered to the given trace probe, as they will be disabled using
> > the normal logic. The failed epropbe is not registered there, that's
> > why it must be disabled explicitly.  Thanks for digging into that
> > code!
>
> Okay, but if the loop fails on the first iteration then it won't disable
> the first ep.  Is that an issue?
>

I looked at the code again, you are right - there is a problem.
Indeed, that clean-up logic looks totally wrong, all eporbes must be
disabled. I'll submit a patch. Thanks Dan.

> regards,
> dan carpenter
>


--=20
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
