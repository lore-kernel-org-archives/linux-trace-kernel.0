Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B37C6FD19
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 16 Mar 2023 15:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjCPPMZ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 16 Mar 2023 11:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjCPPMO (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:12:14 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8FCCB05F
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:11:58 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-541a05e4124so38150567b3.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678979517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVmUWXZCS9PKKU1y+efPewzjI1jriQW9gK3C7QPHQmI=;
        b=yo5VHWyyVCg1xHF1UmIReBMU4rFVu8JCPw81j89XpJjNdpx5OhJjPVZG8CxzSHGIer
         GfzkT+46D8v3ghU1HkuyKR5kGho+VcIpndPr3IAiejahgvr28wUamSPDSUuM2GZu5eZz
         bb5Vnv2QV0L+4S3lBXnSrHgBwaBJhejg/ExN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678979517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVmUWXZCS9PKKU1y+efPewzjI1jriQW9gK3C7QPHQmI=;
        b=ATcQbgbvoMSilV3QHhrU/EFrwaf/VVTxU8BQ29dDiwmT57kSFHFPmvYEZXMa4MdsH/
         W5dxgaAbZhwGfyUUPLvGH4cNHPnqM2kEUG9L2M3Uq9WujqlvKHPImebJEjczxaHp8F9O
         PEiuCX8kzyR48WKeDj9fmtcEmdEDJmUjPQ/gPON+u614OIiptyACOX5Uk+3HoPRMhIt6
         /EPKVqIgAU5+rJ3QOTpVQR77JqKT4020+jk6gjiSqsZ/7igsr8FQbl+wsoOTEjjVBP/5
         Fki9WeCkEBZcgktEJYkWNPCr5AKCwQirMB9JiqaM/e6VtdcRfFi7mMKLnu7zH2Q3Nsee
         BGEQ==
X-Gm-Message-State: AO0yUKVDFllRI1jCD2anixCjBoiNic2EvZazDzxWWrurUZ7+VI+F46Rp
        uX2/H6Tj1MxxksDYKQoySvAE2dBNO075hB+L+UPgj4LO1TpraKa0
X-Google-Smtp-Source: AK7set+BIYWQPa6/+ckcgOXHWt3f+OeuHPskA70Kjgm5ensrebYAAfbuajhP5TZ0Z4HaEx5ZPgh8eX2WvHY9HwHba3M=
X-Received: by 2002:a81:ae5f:0:b0:532:e887:2c23 with SMTP id
 g31-20020a81ae5f000000b00532e8872c23mr2572412ywk.9.1678979517584; Thu, 16 Mar
 2023 08:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230315181902.4177819-1-joel@joelfernandes.org>
 <20230315181902.4177819-3-joel@joelfernandes.org> <4620911e-6fd5-542e-15d8-7849cc60780b@kernel.org>
In-Reply-To: <4620911e-6fd5-542e-15d8-7849cc60780b@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 16 Mar 2023 11:11:46 -0400
Message-ID: <CAEXW_YSwsMs00vhf5usBVZ9YD8z2U6tjtwK+CNGNYK7oGJ9kGA@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] tracing: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 3:38=E2=80=AFAM Daniel Bristot de Oliveira
<bristot@kernel.org> wrote:
>
> On 3/15/23 19:18, Joel Fernandes (Google) wrote:
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> >
> > The kvfree_rcu() macro's single-argument form is deprecated.  Therefore
> > switch to the new kvfree_rcu_mightsleep() variant. The goal is to
> > avoid accidental use of the single-argument forms, which can introduce
> > functionality bugs in atomic contexts and latency bugs in non-atomic
> > contexts.
> >
> > Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/trace/trace_osnoise.c | 2 +-
> >  kernel/trace/trace_probe.c   | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.=
c
> > index 04f0fdae19a1..f68ca1e6460f 100644
> > --- a/kernel/trace/trace_osnoise.c
> > +++ b/kernel/trace/trace_osnoise.c
> > @@ -159,7 +159,7 @@ static void osnoise_unregister_instance(struct trac=
e_array *tr)
> >       if (!found)
> >               return;
> >
> > -     kvfree_rcu(inst);
> > +     kvfree_rcu_mightsleep(inst);
> >  }
> >
> >  /*
>
> Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!

 - Joel
