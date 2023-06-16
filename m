Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E67EB64D7
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 16 Jun 2023 17:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjFPRad (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 16 Jun 2023 13:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFPRac (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:30:32 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14D5269E;
        Fri, 16 Jun 2023 10:30:31 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51a2c60c529so1248115a12.3;
        Fri, 16 Jun 2023 10:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686936630; x=1689528630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pNmnngxiEhIiRvBXuB1ZJgxGNhge5uLTtwEosNjp94=;
        b=FGfUbbwEAPbQVuu9zcediuO2rg8ejYXvYrvBl8ry+3wnmeYBJkl59ALuvYT6ua7shz
         KbaSvWaIr/XMvmh+oCgUayYpU+lvCBskwfSco55XqO0dFy6YtnSAHDNvwsENuh/9onXm
         IlBeCREeLpRmZvIer+PdK4LcjAkLaY0sGi3jeRg6w90h/Ba75ez20xmyqdnYXc0vhj8z
         FflCx7rURdM8zt/5FLUn5/i1j4054eFRqum6eANHLVFErPJzAV1oS5/3UlSzwheT9cQt
         Gm7MPhtGkRstIz4957zDELm6fHn6QjAFuy91vDzZOnCHY9zG6ibYl6GbrcmzKa851skY
         bm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686936630; x=1689528630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pNmnngxiEhIiRvBXuB1ZJgxGNhge5uLTtwEosNjp94=;
        b=NXkLz4pr2ngpWAQvtPzelmjQISFC8ZWR9m+keggiciWbBzwqQpp1L52oDKB5m6r32X
         EMS9eblqNEb4hexleRrErjq8KKJpizFYzzASCvabz+Tt6fLl0m0oTahi9dOq2Akh7EIu
         0K6l7mYzszOfboMcHEqq7k+3Si9MJEsAFIPB2mkK4MzjxcUUhE4qi//JFBmdcG/5CitO
         TO9djFFzFct475VOpo0VRPuVwGwaywdisgEBU7ry/1kLB0s3UKG0xU0kSXDKL3YoaRBU
         ByWYRuGxgPQjuOw3GEYXPEmJLlGd6a55pB3NshTMiN7Fs6bej/0VUZdYwaclyxM6kxoG
         o1HQ==
X-Gm-Message-State: AC+VfDxM+8Kh5x1YDcqTfWW9VEeLUOyWX5P9EIufU9m8sH7wsBjtTpV8
        urFE/hPwHFVCMS7J2axJ5Xxnr0e+eERr9fsXpdM=
X-Google-Smtp-Source: ACHHUZ5ojqU+hKiLZbtlwA/RqPBGowaA6L8WZhUb7bZkXOJMGZu/2lBFh4fuEX2PDABMANw1/KBrGa9jxiHBs6+4qXc=
X-Received: by 2002:aa7:d287:0:b0:518:7bc3:4cec with SMTP id
 w7-20020aa7d287000000b005187bc34cecmr1753533edq.22.1686936630095; Fri, 16 Jun
 2023 10:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-4-laoar.shao@gmail.com>
In-Reply-To: <20230612151608.99661-4-laoar.shao@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 16 Jun 2023 10:30:18 -0700
Message-ID: <CAEf4BzaZEb_Uz21WDmQr7UC8Q50EfHDr2=dK477Z8fGEinCZ7w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpftool: Show probed function in
 kprobe_multi link info
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, quentin@isovalent.com, rostedt@goodmis.org,
        mhiramat@kernel.org, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 8:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Show the already expose kprobe_multi link info in bpftool. The result as
> follows,
>
> 52: kprobe_multi  prog 381
>         retprobe 0  func_cnt 7
>         addrs ffffffff9ec44f20  funcs schedule_timeout_interruptible
>               ffffffff9ec44f60        schedule_timeout_killable
>               ffffffff9ec44fa0        schedule_timeout_uninterruptible
>               ffffffff9ec44fe0        schedule_timeout_idle
>               ffffffffc09468d0        xfs_trans_get_efd [xfs]
>               ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
>               ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
>         pids kprobe_multi(559862)
> 53: kprobe_multi  prog 381
>         retprobe 1  func_cnt 7
>         addrs ffffffff9ec44f20  funcs schedule_timeout_interruptible
>               ffffffff9ec44f60        schedule_timeout_killable
>               ffffffff9ec44fa0        schedule_timeout_uninterruptible
>               ffffffff9ec44fe0        schedule_timeout_idle
>               ffffffffc09468d0        xfs_trans_get_efd [xfs]
>               ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
>               ffffffffc0957320        xfs_trans_get_dqtrx [xfs]

it all subjective, but this format is a bit weird where "addrs" and
"funcs" is in first row to the left. Just makes everything wider. Why
not something like

addr              func
ffffffff9ec44f20  schedule_timeout_interruptible
ffffffff9ec44f60  schedule_timeout_killable
ffffffffc0953a10  xfs_trans_get_buf_map [xfs]
ffffffffc0957320  xfs_trans_get_dqtrx [xfs]

Not it's singular (addr and func) because it's column names,
basically. Can also do "addr func [module]".

>         pids kprobe_multi(559862)
>
> $ tools/bpf/bpftool/bpftool link show -j
> [{"id":52,"type":"kprobe_multi","prog_id":381,"retprobe":0,"func_cnt":7,"=
funcs":[{"addr":18446744072078249760,"func":"schedule_timeout_interruptible=
","module":""},{"addr":18446744072078249824,"func":"schedule_timeout_killab=
le","module":""},{"addr":18446744072078249888,"func":"schedule_timeout_unin=
terruptible","module":""},{"addr":18446744072078249952,"func":"schedule_tim=
eout_idle","module":""},{"addr":18446744072645535952,"func":"xfs_trans_get_=
efd","module":"[xfs]"},{"addr":18446744072645589520,"func":"xfs_trans_get_b=
uf_map","module":"[xfs]"},{"addr":18446744072645604128,"func":"xfs_trans_ge=
t_dqtrx","module":"[xfs]"}],"pids":[{"pid":559862,"comm":"kprobe_multi"}]},=
{"id":53,"type":"kprobe_multi","prog_id":381,"retprobe":1,"func_cnt":7,"fun=
cs":[{"addr":18446744072078249760,"func":"schedule_timeout_interruptible","=
module":""},{"addr":18446744072078249824,"func":"schedule_timeout_killable"=
,"module":""},{"addr":18446744072078249888,"func":"schedule_timeout_uninter=
ruptible","module":""},{"addr":18446744072078249952,"func":"schedule_timeou=
t_idle","module":""},{"addr":18446744072645535952,"func":"xfs_trans_get_efd=
","module":"[xfs]"},{"addr":18446744072645589520,"func":"xfs_trans_get_buf_=
map","module":"[xfs]"},{"addr":18446744072645604128,"func":"xfs_trans_get_d=
qtrx","module":"[xfs]"}],"pids":[{"pid":559862,"comm":"kprobe_multi"}]}]
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/link.c | 109 +++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 108 insertions(+), 1 deletion(-)
>

[...]
