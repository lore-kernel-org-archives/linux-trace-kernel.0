Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEAAC001DB
	for <linux-trace-kernel@archiver.kernel.org>; Mon,  7 Aug 2023 13:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjHGN1o (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 7 Aug 2023 09:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjHGN1e (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:27:34 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3961FEA
        for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:27:06 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40c72caec5cso444321cf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691414768; x=1692019568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV86SNTrsedHb/4GViYCEi4y0WkKBp0siTYx3zahDc8=;
        b=4S7gV7c2cdcuEpB2T5mX/CpOL0kpeYdnmSvNbTa56EyndJ1AvAzRNKOCHIXMgx0KOG
         m3pW2Po9Xpwb5mBlkkTlDX7BdfoeEdLud2EtxxftfD36WTiHHe2nEeXaITwz2BDbbA0E
         mSvp6S22gXS5JjA4PzFAz3yxbfL/xwTpchOOFlQes8Q9oNXqFc9aOWbePypmk7q1dk4A
         a4vRst4pzFXh9rN/C4cxoJLZMGwpmyH5jRV3WLEwpNBiRYis7cS9NoowQ/CtsnQCP+xr
         DEBbVtZs2zdvHzsuMXpeRoX/6pa4fjpkmdII9AdqLI15u6AO9N5fAAXHrXdcgBZmZLKS
         kpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414768; x=1692019568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aV86SNTrsedHb/4GViYCEi4y0WkKBp0siTYx3zahDc8=;
        b=ajzfDs5N4OKMm/NCFH7EZBpvtUp48rhpOhCZDqEdvGypfRcc9AUPoPHXHUQ7peqSTn
         1BWosl7pln5pGi/KRGIcsz7ZWihbqcdLDNFMqowQiSWla2ACXk0PCagmPjFrNfgCjCze
         1Cg270Wt+l8cPUNLPiF24HGqMUj9yQDMv9vOzmUx/KuWS105DW3oPdM3hBoJu7MwtgEL
         yeSx9rp7gg90a3Auinz2EDbSuvrxCJnCVYw2hd6kUwoeJ9tQVllZpF+iIBH2NvPwnK0k
         bHvvOdzMzkUDTRS1Yn8EFuH310pJNsfBXAeJuM+j7O4W2w4bDiFzKeQP3zeIZcTfFyXu
         J7Gw==
X-Gm-Message-State: AOJu0YyDQiEtmHxoJskKBMv+Iy5FjmcKzpWzvpnvTF5w1ftGYm/FHzZU
        +3Z7HMf/Vcu3bl+2Yk3o8zI7fVXlN/5aprSY3o4qtw==
X-Google-Smtp-Source: AGHT+IH7l8fz/va80d2V76Roj1BsoAMY57SE1UROxLkV3dyWOxXlttc6h2gDN6ZO1f9HDD+7BbQ8h6jdtiwhSOmFGN4=
X-Received: by 2002:a05:622a:1806:b0:403:ac17:c18a with SMTP id
 t6-20020a05622a180600b00403ac17c18amr454405qtc.14.1691414768116; Mon, 07 Aug
 2023 06:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230806075216.13378-1-me@manjusaka.me> <CANn89i+bMh-xU7PCxf_O5N+vy=83S+V=23mAAmbCuhjuP5Ob9g@mail.gmail.com>
 <8d25f9e8-9653-4e9b-b88b-c5434ce8aabf@app.fastmail.com>
In-Reply-To: <8d25f9e8-9653-4e9b-b88b-c5434ce8aabf@app.fastmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 7 Aug 2023 15:25:56 +0200
Message-ID: <CANn89iJAu5CLq1LkRLt0qJ+ytFGXWGqymMHBnMevcPS4Z2GAXQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC PATCH] tcp event: add new tcp:tcp_cwnd_restart event
To:     Manjusaka <me@manjusaka.me>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 2:49=E2=80=AFPM Manjusaka <me@manjusaka.me> wrote:
>
> > Do not include code before variable declarations.
> Sorry about that. I will update the code later.
>
> > I would rather add a trace in tcp_ca_event(), this would be more generi=
c ?
>
> https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_cong.c#L41
>
> I think maybe we already have the tcp_ca_event but named tcp_cong_state_s=
et?

I am speaking of tcp_ca_event()...

For instance, tcp_cwnd_restart() calls tcp_ca_event(sk, CA_EVENT_CWND_RESTA=
RT);

tcp_set_ca_state() can only set icsk_ca_state to one value from enum
tcp_ca_state:
TCP_CA_Open, TCP_CA_Disorder, TCP_CA_CWR, TCP_CA_Recovery, TCP_CA_Loss

enum tcp_ca_event has instead:
CA_EVENT_TX_START, CA_EVENT_CWND_RESTART, CA_EVENT_COMPLETE_CWR,
CA_EVENT_LOSS, CA_EVENT_ECN_NO_CE, CA_EVENT_ECN_IS_CE
