Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AA6C4332F
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 11 Nov 2022 02:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiKKCWu (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 10 Nov 2022 21:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKKCWt (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:22:49 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FBF5E3D8
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:22:48 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ud5so9644837ejc.4
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jFmu26M8SbZRDoS5YncX03RVCQvtd0/Eme3Pt6/0vTc=;
        b=xBRf/feYYm+kp976WAg44FNvoeTwplJR6I58eU/V1agJIFpdM7o0hwUh0crrMTP+t5
         /69cFO0/olP3VleMRFP0d1ep7Y+WcocYnUE0AynnZV3aaafUVZaE63fyWa1UflBObeqP
         9C6/vVoWTTWSNSjr9S3xDu3TbNJqORZqoV+gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFmu26M8SbZRDoS5YncX03RVCQvtd0/Eme3Pt6/0vTc=;
        b=d7DNAyhCIawT1VHQiaZG1sGy0KGET4kdWUHE2Bqq57SE2+sIDmr+e3BYDNdO8wOpnj
         LtoaDnc8RrC4XA9J9JsaM6GuqFeOTjWIgIdhFaPlMF1uoa0VoBksUHXwUDpxduealyuE
         pmh9GG7P2l9flCrjMdt5xjLXARb4MywqMeYYu3+X3FFvmrHCeEPWNeQn1U4D39lTuJ7e
         ZuWVaRdO51V3MeTGmT/zLf1TWfll+4vBihDBYV/wJKd+EO2En/EVjJydO/z36Ev75ZvD
         18/I6b1gx3CE7b2YHL7C5UNFzzwr8OR2mJS7qr2ueAzlYcgY2e9qd3MH8Hr1S8ynL5qK
         kONQ==
X-Gm-Message-State: ANoB5plRWgggLGKYtpoStw2e+Gsk1I/pXIsTfU0/5dKJ8pbUPIXuI4jH
        tPmmPlSN69a8mw+J8f+Gg9HwHTzJ/FPLa1g4belLjScKmtk=
X-Google-Smtp-Source: AA0mqf6JlN0zqCrM0zok6UN2n7q/4i8TWD4tiOeQjLz1+mGyCJ9vrn6Imgul2AnfaLFZdIhpwzmeeQo9cLQq3ZRBi+I=
X-Received: by 2002:a17:906:6592:b0:7ae:9677:d8dd with SMTP id
 x18-20020a170906659200b007ae9677d8ddmr323080ejn.71.1668133367165; Thu, 10 Nov
 2022 18:22:47 -0800 (PST)
MIME-Version: 1.0
References: <20221110175959.3240475-1-joel@joelfernandes.org> <20221111093445.e195afe799822d5a7ffbaca4@kernel.org>
In-Reply-To: <20221111093445.e195afe799822d5a7ffbaca4@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 11 Nov 2022 02:22:36 +0000
Message-ID: <CAEXW_YRtiwrWsJ8hMGMa5bKKhT163+P3OzR0T0feQROjzSJ1hQ@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: Dump instance traces into dmesg on ftrace_dump_on_oops
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rostedt@goodmis.org, Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 12:34 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Thu, 10 Nov 2022 17:59:59 +0000
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
>
> > Currently ftrace only dumps the global trace buffer on an OOPs. For
> > debugging a production usecase, I'd like to dump instance traces as
> > well, into the kernel logs. The reason is we cannot use the global trace
> > buffer as it may be used for other purposes.
> >
> > This patch adds support for dumping the trace buffer instances along
> > with the global trace buffer.
> >
> > The instance traces are dumped first, and then the global trace buffer.
> >
>
> This looks good to me.
>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

 - Joel



  - Joel
