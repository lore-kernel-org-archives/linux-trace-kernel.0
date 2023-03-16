Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53533C6FD19
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 16 Mar 2023 15:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjCPPmF (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 16 Mar 2023 11:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjCPPlq (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:41:46 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95593BDD2E
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:41:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u5so2168224plq.7
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678981260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWtxiI6u3PLhzROb0W9QCRbZR4W+y7+CKl0MvD1ECyo=;
        b=R8KsDUcAMUsseamt0Cr5S1eKcoh15UqdwSMkn4d7vwtdALOwqU8QZwjAvRozwdLhn7
         r3cgfRZlSvqQQtTOojoPN3BvROAr2RN2N6iqHgE0MGaYDUeEo04lWChsnKhdE6TsXnR5
         sSE4EOaIGqV+RLyCU40lTPOdlwCsqd8pMiH18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678981260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWtxiI6u3PLhzROb0W9QCRbZR4W+y7+CKl0MvD1ECyo=;
        b=GAGIodUp4hg88t0SdJ1ztAN1s1lVaRpGlB8vgmlg2Ja8smpXTxqv5BVHxiULgMfllJ
         N9/TFm3QtmKLxiquk1F0a/jH+a1GXeFOGwtOKywPH3SrXVxOF66xX0pKePdP3bYdbd9K
         AwrOhMe7Jsa4KbL2CyHm1BMZu5llMOIwRrwuS5uuHVpsBMUH84Z1Ro9C1Ay39hiRqduu
         UOcBhZHLsNt8JsyragUgIYwtgtCwsXwXzLrOxJyBaZKHDWtnwhg7teoarsEzO+TRIzjD
         WZ4qBOwrxF0U3ip84eY/xU/0/YdTF6rF9qMTg37sEAV8BnTy711nWx2GaoZ/Zo6vn5ii
         Dwdw==
X-Gm-Message-State: AO0yUKWn7vxghgmDlFDVUCoN3iiwLzMpj9CeQmILBs1M0xMC+Sg81xMB
        dlyLDn+AXdsIYU87M2F1HMVaMMQ0nFdIR5ZK45/YNA==
X-Google-Smtp-Source: AK7set9qa9SraVDU2uIf/xPTxeISitKn+URkcvoZFmOq+KmcsDmQNGj9ek7q83Ak97zDy41okMWoMpxW7ecgklX9jN4=
X-Received: by 2002:a17:90a:df96:b0:23f:1caa:233a with SMTP id
 p22-20020a17090adf9600b0023f1caa233amr1196529pjv.1.1678981259713; Thu, 16 Mar
 2023 08:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230207182135.2671106-1-revest@chromium.org> <20230207182135.2671106-5-revest@chromium.org>
 <20230315194334.58eb56ab@gandalf.local.home>
In-Reply-To: <20230315194334.58eb56ab@gandalf.local.home>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 16 Mar 2023 16:40:48 +0100
Message-ID: <CABRcYmLLbRGZXWwEpyLW1YFz87tTPA8pCL7oLd4K6Hp9Etr5LA@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] ftrace: Store direct called addresses in their ops
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 12:43=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue,  7 Feb 2023 19:21:29 +0100
> Florent Revest <revest@chromium.org> wrote:
>
> > @@ -5445,6 +5445,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, un=
signed long addr)
> >       /* Enable the tmp_ops to have the same functions as the direct op=
s */
> >       ftrace_ops_init(&tmp_ops);
> >       tmp_ops.func_hash =3D ops->func_hash;
> > +     tmp_ops.direct_call =3D addr;
> >
> >       err =3D register_ftrace_function_nolock(&tmp_ops);
> >       if (err)
> > @@ -5466,6 +5467,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, un=
signed long addr)
> >                       entry->direct =3D addr;
> >               }
> >       }
> > +     WRITE_ONCE(ops->direct_call, addr);
>
> I'm curious about the use of WRITE_ONCE(). It should not go outside the
> mutex barrier.

This WRITE_ONCE was originally suggested by Mark here:
https://lore.kernel.org/all/Y9vW99htjOphDXqY@FVFF77S0Q05N.cambridge.arm.com=
/#t

My understanding is that it's not so much about avoiding re-ordering
but rather about avoiding store tearing since a ftrace_caller
trampoline could concurrently read ops->direct_call. Does that make
sense ?

> -- Steve
>
> >
> >       mutex_unlock(&ftrace_lock);
> >
