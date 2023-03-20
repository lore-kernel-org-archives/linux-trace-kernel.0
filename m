Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6A9C6FD1D
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 20 Mar 2023 17:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjCTRvU (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 20 Mar 2023 13:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCTRur (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:50:47 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B49629E38
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:45:20 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id d8so7098315pgm.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679334320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YT+7ATO+Dwh8LeAWhyYXzT48upUEJEWzs6S99xdX5+0=;
        b=V/bj/WKjHGwdQSSh+F7jQoNgBojGetJR1GMUxoBP+Y76AgvJhigK/oCYSXs3capHc7
         h7gPU5AdLWrykbsadD83ICz95567xUVKDmf7A+4m7eJCLygXud3N5bnlj5AzMzZrw22h
         9IgksBXEFc2diAmuGwYtVpWZLGjtYSSFTzxa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679334320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YT+7ATO+Dwh8LeAWhyYXzT48upUEJEWzs6S99xdX5+0=;
        b=5qmCsF13WrazF5A5sNykeSW8F2YiC4enmfgvmK0T8rBhiwtQtsWt9LeAFMXEui6YTI
         rWktsoiNCjtJRc0sYebYUsHLFBcWHiL6dIYRIOGyxQUA2CEVwq2U+BBgK+NRnicwtI7W
         vhvQI/PAEg2QnR6VFCmbjh6+KscWXF6gY8l63c5iBQOINee9kuCXPMUudN/dqQRAP6NL
         sOJmGIZbCOZTaIbQQS4tO8azPXRtOJA1wbGuxi6F4N2nRGwOsSBOhq9BO788yr7Tp0Vk
         E3UwHEZKcvB63j/JmVAsFRTqhxeDaHa5dOpCjzBHhQ+Wr4LrqjaSwVhSjQhdLMS3Q1Gf
         FlDw==
X-Gm-Message-State: AO0yUKWyWkz0W+nZA/oQ5BIHXffFdy/5O9yzMuE30m7VFFzgL+NiVddY
        tNQPeVYpoTE/eiXgNkuvpfhn4dtbEnwV0cNdVhBD+Q==
X-Google-Smtp-Source: AK7set+L6XVFaFoFys+NP3fmLtvLTx4h7+cjpO0Y1WfROQdIhvqsN5L3fnwCMIuMcaKPUeu8Q9wVx4W6w8qIOIkU+7M=
X-Received: by 2002:a05:6a00:d59:b0:625:96ce:f774 with SMTP id
 n25-20020a056a000d5900b0062596cef774mr6904230pfv.0.1679334319854; Mon, 20 Mar
 2023 10:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230316173811.1223508-1-revest@chromium.org> <20230316173811.1223508-6-revest@chromium.org>
 <ZBcqUoUTZSNyIjLx@krava> <20230319135443.1d29db2d@rorschach.local.home> <ZBdagJQFA/Z7Phj5@krava>
In-Reply-To: <ZBdagJQFA/Z7Phj5@krava>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 20 Mar 2023 18:45:08 +0100
Message-ID: <CABRcYmL_JCAGSoX98dZUhGkmek+5iL4kd+F_POJ65GfnZLADcg@mail.gmail.com>
Subject: Re: [PATCH 5/7] ftrace: Store direct called addresses in their ops
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 7:55=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sun, Mar 19, 2023 at 01:54:43PM -0400, Steven Rostedt wrote:
> > On Sun, 19 Mar 2023 16:29:22 +0100
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > > > +++ b/kernel/trace/ftrace.c
> > > > @@ -2582,9 +2582,8 @@ ftrace_add_rec_direct(unsigned long ip, unsig=
ned long addr,
> > > >  static void call_direct_funcs(unsigned long ip, unsigned long pip,
> > > >                         struct ftrace_ops *ops, struct ftrace_regs =
*fregs)
> > > >  {
> > > > - unsigned long addr;
> > > > + unsigned long addr =3D ops->direct_call;
> > >
> > > nice, should it be read with READ_ONCE ?
> >
> > Is there a "read tearing" too?
>
> don't know, saw the comment in __modify_ftrace_direct and got curious
> why it's not in here.. feel free to ignore, I'll look it up
>
> jirka

Mhh, that's a good question. Based on my current understanding, it
seems that it should have a READ_ONCE, indeed. However, I'd like Mark
to confirm/deny this. :)

If this should be a READ_ONCE, I can send a v2 series with this fixed.
