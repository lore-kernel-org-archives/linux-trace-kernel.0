Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4940DEB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 27 Jun 2023 04:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjF0EnU (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 27 Jun 2023 00:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjF0EmV (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:42:21 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D7E26A9;
        Mon, 26 Jun 2023 21:39:35 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3fde9739e20so36206741cf.2;
        Mon, 26 Jun 2023 21:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687840774; x=1690432774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHjpNQzC+Q2IL4RRpRsi47zUXLa6D+m3AFuxLIltpF8=;
        b=CnVTrczLMg8QFVCBFHPfMRjMxrIASRqOLsER1JxRAinp3ld7kL0lTsyegx9oceTyIj
         iY664TOITPnCHmFw6goWhzR5plg5jKQ+q9z/c1zXzwFXCUFrrP6cZCsmpuKW/sw0ZDLw
         zGj6VCzhF1zSagoJevB/51wWSv8XS/doEm6uRdG+xUVLkjEu61kF0BTljM0yT8tAMwW1
         IXmISC8Xmj/Lgo7BGtpFSSc8X0kEa6HJwXkvDw+3PBCB/np3l8uVxD8RpwY64Ftk1/wQ
         hXczvr1GgfS0K4vPMwyPiP74dXrtxUCIU9ROIL98qIcj2zpq3gl+br3YGdYFHcoLlyCH
         jP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840774; x=1690432774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHjpNQzC+Q2IL4RRpRsi47zUXLa6D+m3AFuxLIltpF8=;
        b=LYBtP4kPy1g1yyEx2MwM54VBkiluN79XlJCPE4b/C9W3YXe7Qhb+cCKvdbakprlf3d
         ttDQ3x3t4rI7KZw17RYokZsdi9BS/C+9zXq4vAyKCLUENCXSZSXLbmM7hxqnCETizu39
         Q2SAKp1cbmJa+nC8qHbfU+DSbBmS5U6Q7B6xlP+P8FPunNMMhPeN1jAB8BCzRH6/Xk6V
         WaBMdv+41QTJ7HwXGpBmr+DcgqHKncRJIg3P0zwVl+rbFrUrOtbtyD+z+xAuzZCJqQfS
         tIBTmzzio3gNy62jJOzZcwud3mIw0qZo4yJ9nbG+uyOilwVOfPHAZAxAuEqUIXaLt4zE
         nBow==
X-Gm-Message-State: AC+VfDw+S6T/4CdgyahroWGbODYLx9UOSrb2kvohm0MyKjl4+2pzazwa
        4rZPHvILzY7W7hzONSznK+4oqTvlLnWYROOauOhSXSbO
X-Google-Smtp-Source: ACHHUZ4GSlYEvU37ypfSllsBQwmEC/ZFbZttxU6BLxrKovFxHaP/9/t4wZHgV/0Su67X8dWbNZUnSbB48eH8jYBha8o=
X-Received: by 2002:ac8:7f87:0:b0:3ff:21f1:93f with SMTP id
 z7-20020ac87f87000000b003ff21f1093fmr21972608qtj.7.1687840774037; Mon, 26 Jun
 2023 21:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <72b05526-4dda-430a-b4ca-2ee4f26f2185@moroto.mountain>
In-Reply-To: <72b05526-4dda-430a-b4ca-2ee4f26f2185@moroto.mountain>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Tue, 27 Jun 2023 07:39:17 +0300
Message-ID: <CAPpZLN4ACVRrDXofO9jNQznEuF+CK6KNbCCz=5t93kMzESbZGg@mail.gmail.com>
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

On Mon, Jun 26, 2023 at 4:35=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> If enable_eprobe() function fails, then we call  disable_eprobe() on the
> "ep" that failed.  That doesn't feel right.  Shouldn't we
> call disable_eprobe() on the previous "ep" instead?  Or even better on
> all the previous eps (but I don't know how to do that)...

Hi Dan,
There is no need to disable the eprobes which are already successfully
registered to the given trace probe, as they will be disabled using
the normal logic. The failed epropbe is not registered there, that's
why it must be disabled explicitly.  Thanks for digging into that
code!

>
> This patch is not tested at all.  I'm mostly sending it as a kind of
> bug report.  If this patch is correct or the fix is simple enough for
> an absolute moron to fix it then I can probably do that.  But if it's
> something I'm too stupid to handle then could you just give me reported
> by credit?  (That is the solution I really would prefer).
>
> Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events"=
)
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  kernel/trace/trace_eprobe.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index b5181d690b4d..29de54347b8c 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -640,8 +640,8 @@ static int disable_eprobe(struct trace_eprobe *ep,
>  static int enable_trace_eprobe(struct trace_event_call *call,
>                                struct trace_event_file *file)
>  {
> +       struct trace_eprobe *ep, *prev =3D NULL;
>         struct trace_probe *pos, *tp;
> -       struct trace_eprobe *ep;
>         bool enabled;
>         int ret =3D 0;
>
> @@ -666,13 +666,13 @@ static int enable_trace_eprobe(struct trace_event_c=
all *call,
>                 ret =3D enable_eprobe(ep, file);
>                 if (ret)
>                         break;
> -               enabled =3D true;
> +               prev =3D ep;
>         }
>
>         if (ret) {
>                 /* Failed to enable one of them. Roll back all */
> -               if (enabled)
> -                       disable_eprobe(ep, file->tr);
> +               if (prev)
> +                       disable_eprobe(prev, file->tr);
>                 if (file)
>                         trace_probe_remove_file(tp, file);
>                 else
> --
> 2.39.2
>


--=20
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
