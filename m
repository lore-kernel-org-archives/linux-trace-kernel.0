Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CF4C3DA7A
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  6 Jan 2023 04:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjAFEYH (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 5 Jan 2023 23:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjAFEX7 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 23:23:59 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A660193F4
        for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Jan 2023 20:23:54 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m7so273572wrn.10
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Jan 2023 20:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMx8hqsmDH7uwUr+MaFAPSJQbUQHznQbqDI9RPeo9/w=;
        b=tY5Cei/ARcdvRIV226os/xQMBhiUFhOUbUldkBLjEH/cB3CJk3qWlxPwNoCHcRMAcb
         veRcagafhCc4Pgdsk1sxjAEvHWYZKwYBAtu739ZWTarO1zgshzNWEYxoQkWihFq+omh8
         IxhLIHUtwRUChCEZ9kzmZAY6ly3M9vVUqYtpzgBfYdAewAvqUpSL0XkGKVFEgDVlM4hJ
         DkjqzsCD0iQEy0sW283GW5xWKC7sGJMtiUE4zBwqehalS5M7o2G9RPgBc/LUmA0/TjIH
         +gRJTRqJ24IzjpLbgSzsPm174UhO1aVefLZGRh2FAUcqXAi9SxzWFkjwxEIUsErVLHOB
         4AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMx8hqsmDH7uwUr+MaFAPSJQbUQHznQbqDI9RPeo9/w=;
        b=sQT5LWK64bIjN/hJ5BUMVqdI7t3vucp+6jsPBlb2N5ANBgi4a6jSEXTyaTaQypJmZk
         3cVJ+fVZSPUmzOpKHt+o/mOS0uuuCoDybwRBs0oyS5GLPv9TBwPznHF2iB48peRo9xK7
         vjRD+CSqkIQG78bD3W/UE4/2LpxbnSu9Qe7YIvWiHfMAHgumUJLuGZ/vDAiqThfM+i7r
         QU7JhAZNBS3q5TTsR3x3BnAYcA43uVxh4xI6h9iCCePIToNiBvfoQL7l+RA9Reck1nB8
         evNniIHKj+ZgR9v1PnQ7rfQM1OTr3KhOjWj/3eYw8MFyZEYqbyv8/WGcFrJzV2d8KvV0
         zYvw==
X-Gm-Message-State: AFqh2kqoZTLJnhN06IOTyqBV7QAzyp5cYXM4yqozQ/GUKlYjFvVWM6JH
        SCKePFgAsMMsrd7tGfFijmoChNa6C++LkJ/nIziRtg==
X-Google-Smtp-Source: AMrXdXvrO8sE1PFjTeUZYd/6TK8WlhAjWv9cOx0c0sdQc5AhAJSoOx9JjHVY9LNUnE5jhSonK+bjaF/f7oYBCbpQDDI=
X-Received: by 2002:a5d:624f:0:b0:24c:208:ae87 with SMTP id
 m15-20020a5d624f000000b0024c0208ae87mr1250834wrv.523.1672979032832; Thu, 05
 Jan 2023 20:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20230105100014.1935-1-cuiyunhui@bytedance.com>
 <20230105090807.51213cea@gandalf.local.home> <CAEEQ3wmnUpuZxLbrMwPCk+pnbC27fo4bi-nN-848o6QGO6Xt+Q@mail.gmail.com>
 <20230105230737.426abfdd@gandalf.local.home>
In-Reply-To: <20230105230737.426abfdd@gandalf.local.home>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Fri, 6 Jan 2023 12:23:41 +0800
Message-ID: <CAEEQ3wmhAiguPm6K2=q26QRUurcoG+voJrDaDX8rd1KRf_SAgA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] sock: add tracepoint for send recv length
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, duanxiongchun@bytedance.com,
        kuniyu@amazon.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 12:07 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 6 Jan 2023 11:24:18 +0800
> =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@bytedance.com> wrote:
>
> > Regardless of whether the MSG_PEEK flag is set or not, it is possible
> > to return -errno,
> > but based on your suggestion, I plan to modify it like this:
> >
> > trace_sock_recvmsg_length(sock->sk, sock->sk->sk_family,
> >                           sock->sk->sk_protocol,
> >                           !(flags & MSG_PEEK) ? ret : (ret < 0 ? ret : =
0),
> >
> > what do you think?
>
> Sure.

Ok, Thank you.

>
> But note, from your original patch:
>
> > +     trace_sock_recvmsg_length(sock->sk, sock->sk->sk_family,
> > +                               sock->sk->sk_protocol,
> > +                               (ret > 0 && !(flags & MSG_PEEK)) ?
> > +                               ret : 0,
> > +                               (ret > 0 && !(flags & MSG_PEEK)) ? 0 : =
ret,
> > +                               flags);
>
> If flags MSG_PEEK is set, you return ret in error regardless, so error
> would be ret even if it was positive.
>
> So I'm guessing that this change actually fixed a bug. ;-)
>
> -- Steve

Ha-ha, seems like it=EF=BC=8CI will modify these and post v3.

Thanks,
Yunhui
