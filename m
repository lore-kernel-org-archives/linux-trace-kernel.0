Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224D7C4332F
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  4 Jan 2023 03:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjADDfI (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 3 Jan 2023 22:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjADDfH (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 22:35:07 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B977175B2
        for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Jan 2023 19:35:06 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so22973606wmb.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Jan 2023 19:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsvk33R4DYQucuzlILv604rElypjCvBYNtIeYzz0ItU=;
        b=3oPy7+/jBszDhLigAlcyWJ6kZj7wuKNL8KKHikey1QL2RrHkm82yqN0HrLoHfyD/Np
         hvADAUjv04m5PtaKw+YETVRcGYgSUcZQdM3QEBMIYe6u/N58dvcESEvokUVObcQosnTb
         PZZC27Ng0YvD/2QcKhqwXrwm+i4vqLP7ofMRRlX2xMgGY+PdM8j/v2oFtuD13+Tnq/8g
         6lFuZCOcWtfaNQztCOmwqHRTmhvjaKPd+M+/tProuJU1f9ByAZKYmMYwPeLTzqWqfHr/
         W66+LngGprgSggAPkGil5/MvRA7CP6EtYiA+eEAfNaWTSqqQcKNEtmMAEyIA64wmpCT5
         Z+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsvk33R4DYQucuzlILv604rElypjCvBYNtIeYzz0ItU=;
        b=JiYc/dnaCkJ7OaylUdr9/qA2q04jIru2IGKQZkT1smXgzxvmWwPzql40OuHVI3X/2W
         EFv63Qho7EO5mtab7ZpSgCgTiuHd+kR5105GqG4FE60maOOovuAVZCp6OcDy55lD/x9K
         2jUIYp3rKC6vMsFzbnnNU3xrfCe4xxRo1XOKZuoipa9fig9NtY1eO24xrFUl4wmnfAMK
         bc8mnE5Cik3Z72Axnb3wMqNXO/fRAO0hvlDoKqteZlopMEAPFNCm6F8s3ZIOUYPBSoV/
         HaKpbWSSRceL39itv5Xgl0y9um8N4FySd91UkKDuZ76d9rSM3y97VtI6dViHmvYsPtCy
         aRWA==
X-Gm-Message-State: AFqh2koy0GgIE9RweMB74/IvtQNziVX5ojLfqOOQw585JeLkZdhk/Gwh
        dI8Hu2qZszpD/ar1QIsqRXPeIQ3RvqLtx+XuHvfHPg==
X-Google-Smtp-Source: AMrXdXv/rEpUOV6MhzNpIfs3SJsrAZanT6qfePBKVHNyTtojiOwaTIsZIFySFaHBQhw+w4GqtmEzKe/FnRXjQ605btg=
X-Received: by 2002:a05:600c:3503:b0:3cf:8952:2fd2 with SMTP id
 h3-20020a05600c350300b003cf89522fd2mr2897959wmq.9.1672803304583; Tue, 03 Jan
 2023 19:35:04 -0800 (PST)
MIME-Version: 1.0
References: <20221229080207.1029-1-cuiyunhui@bytedance.com> <Y7HaeTkNtfb3oIP4@pop-os.localdomain>
In-Reply-To: <Y7HaeTkNtfb3oIP4@pop-os.localdomain>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Wed, 4 Jan 2023 11:34:53 +0800
Message-ID: <CAEEQ3wmc_hPwUc9zeFJ7c0xvmyip7CGHvCHQN2U4c8wyfM1KLA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] tcp/udp: add tracepoint for send recv length
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     edumazet@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
        davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, duanxiongchun@bytedance.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Cong Wang <xiyou.wangcong@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=80 03:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Dec 29, 2022 at 04:02:07PM +0800, Yunhui Cui wrote:
> > From: Xiongchun Duan <duanxiongchun@bytedance.com>
> >
> > Add a tracepoint for capturing TCP segments with
> > a send or receive length. This makes it easy to obtain
> > the packet sending and receiving information of each process
> > in the user mode, such as the netatop tool.
>
> You can obtain the same information with kretprobe:
> https://www.gcardone.net/2020-07-31-per-process-bandwidth-monitoring-on-L=
inux-with-bpftrace/

As we know, kprobe gets the result by trapping in an exception, which
loses performance compared to tracepoint.

We did a test for performance comparison. The results are as follows.

Time per request
sock_sendmsg(k,kr):  12.382ms=EF=BC=8C tcp_send_length(tracepoint): 11.887m=
s=EF=BC=8C
without hook=EF=BC=9A11.222ms

It can be seen that the performance loss of tracepoint is only half of
that of kprobe.
