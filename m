Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12881C54EBD
	for <linux-trace-kernel@archiver.kernel.org>; Mon,  9 Jan 2023 13:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbjAINOU (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 9 Jan 2023 08:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbjAINNq (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:13:46 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CD663F2
        for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:13:18 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ay40so6229641wmb.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Jan 2023 05:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaDFDl2+tN5Hl1ZB51fHbi1FKciauyhT9UPo+kncU3I=;
        b=gySwzbXAEvFLlHHx2GUBE1PzOsbvzm54w/4Hoe3q+0MuYeNv/IouoUwbFIcR1OlLQU
         8HHFfwUuG5Ejs8cXpK1Rvhg2DFXq9lvaomJmlBCnW3LXOM78ITVmfg+aHNpy13jbymSo
         7p2/7kd/0yCcDsw2eZ2Gip3LF4r3qYJHCB+iGzH8mc7B0j1JDNIdswwqnetIixd4ss9p
         R0FNGPqDOx1eSPe3qMt/2UNDxo8PJiTHa6Ylk5JZ8qEc7N2EmZeq9sKRn4woqfLsEFBg
         vj8g1MxAKqH9JtEh1PSwoG73zEf+4k3szGPQSQ+fkF90yFtgYD9omG93WrcAp9e/kRBK
         +zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaDFDl2+tN5Hl1ZB51fHbi1FKciauyhT9UPo+kncU3I=;
        b=1w77jEzvdamwLTeHJgacc5N65nRZtizENpsly4WD+NhzxQUFICqJDLH77UTAGFFD4u
         ts6N0nES7qzTE0GfwuQDp5Q/Fi610UTTz+cGaFCG15MDwhQq6kdHyl53YDuK4c5pP/vR
         g5UQPhZF61gXebBuOeX/de5zS3AAk9/AffE0KelFY4iyEbp8dJOMHrgNY66QdIincCAc
         I3JLCyJXkT88ucQr0n3yvC2BrVOjzwZfsBeHO74uWFcjpJOTlEvbgy0DhrHjdaOCZKO2
         bc8uuevKG37cjtvSz1/huEyH0tcQtq61ui/DSwJBVr/B67rJ2K3f0R3pgDZCKDvjji67
         HSaw==
X-Gm-Message-State: AFqh2koKuFIUAelS1jfFX9G+YUHSeMOjgFflEf1PW35OySuOjWUZF6R+
        zIwruz/ODDurotTcwXnPRGj6ri5fkPDD+Os3lPVlmw==
X-Google-Smtp-Source: AMrXdXszznt1RWlKaQKelt5nu0PuVTLm2drhi7RWKiIHCPFAA8P0uPu4W+bkdKD8nSJe0q214pg/4m4iIx6XHR48m5s=
X-Received: by 2002:a7b:c5d6:0:b0:3cf:70a0:f689 with SMTP id
 n22-20020a7bc5d6000000b003cf70a0f689mr3221956wmk.161.1673269997007; Mon, 09
 Jan 2023 05:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20230108025545.338-1-cuiyunhui@bytedance.com> <CANn89i+W__5-jDUdM=_97jzQy9Wq+n9KBEuOGjUi=Fxe_ntqbg@mail.gmail.com>
In-Reply-To: <CANn89i+W__5-jDUdM=_97jzQy9Wq+n9KBEuOGjUi=Fxe_ntqbg@mail.gmail.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Mon, 9 Jan 2023 21:13:06 +0800
Message-ID: <CAEEQ3wnoKqN+uTmMmUDJ9pp+YVaLmKnv42RApzPbNOGg6CRmnA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4] sock: add tracepoint for send recv length
To:     Eric Dumazet <edumazet@google.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com,
        xiyou.wangcong@gmail.com, duanxiongchun@bytedance.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 5:56 PM Eric Dumazet <edumazet@google.com> wrote:

>
> Note: At least for CONFIG_RETPOLINE=3Dy and gcc 12.2, compiler adds many
> additional instructions (and additional memory reads),
> even when the trace point is not enabled.
>
> Contrary to some belief, adding a tracepoint is not always 'free'.
> tail calls for example are replaced with normal calls.
>


>         .popsection
>
> # 0 "" 2
> #NO_APP
> .L106:
> # net/socket.c:1008: }
>         movl    %ebx, %eax      # <retval>,
>         popq    %rbx    #
>         popq    %rbp    #
>         popq    %r12    #
>         ret
> .L111:
> # ./include/trace/events/sock.h:308: DEFINE_EVENT(sock_msg_length,
> sock_recv_length,
>

Hi Eric,  Thanks for your reply,  In fact, it is because the
definition of the tracepoint function is inline,
Not just these two tracepoints=EF=BC=8Cright?

#define __DECLARE_TRACE(name, proto, args, cond, data_proto)            \
      ...
      static inline void trace_##name(proto)

Regarding the above issue, I plan to optimize it like this:

static noinline void call_trace_sock_send_length(struct sock *sk, __u16 fam=
ily,
                                            __u16 protocol, int ret, int fl=
ags)
{
        trace_sock_send_length(sk, family, protocol, ret, 0);
}

static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *ms=
g)
{
        int ret =3D INDIRECT_CALL_INET(sock->ops->sendmsg, inet6_sendmsg,
                                     inet_sendmsg, sock, msg,
                                     msg_data_left(msg));
        BUG_ON(ret =3D=3D -EIOCBQUEUED);

        if (trace_sock_send_length_enabled()) {
                call_trace_sock_send_length(sock->sk, sock->sk->sk_family,
                                            sock->sk->sk_protocol, ret, 0);
        }
        return ret;
}

What do you think?

Thanks,
Yunhui
