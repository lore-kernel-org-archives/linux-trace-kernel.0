Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F486C46467
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 11 Jan 2023 06:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjAKGRp (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 11 Jan 2023 01:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjAKGRl (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:17:41 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F44AE0A0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:17:16 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso11811004wms.5
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RrLy7xqWg1RnasudUvZBWKEA1yRY0PzlYprkCqFjws=;
        b=GyeBjW22NyAmEp9Vg91TZBgMb+YTns5QP/d9s835LoybvRg1tPhifllP1C7p5zxyBb
         ri3iK8Sv/Ig9OLEC0QeGSguv1neXysmQAgH1d4FkVN+7GsyiU71OhbnygOD26+kw9il5
         vGIz9c+QwmJ5Rwu4VBhQBCGaaMn9rPRW9PCAYTOvk5duKfguUCprUHObQn3OZuSPkQ04
         mWoT5Fz9CL0RyWs5oUeSuHxFit3+MAd3fmgu1ZPig9w1C9RrNCWs2coh2K1laR+TUuwA
         ELQyaAzueWIzqzPn2QrI+rpOoOy2OOEaTUBTLF54lycLEi9jP9yAD3HnzRzKGjjwtHgq
         MkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RrLy7xqWg1RnasudUvZBWKEA1yRY0PzlYprkCqFjws=;
        b=lqlhrDwTQ5Va8BoJl3gZHBG6HH1K0Vhck7Bh3swFUExSXu/0KD080IHzJgwZdCDsMr
         weCsQMz94wztP3azjBvTUCBWyx1EdkTNAXo0XXBeehD3a2/N9mQsDd1AQh6xrE1AQjC0
         t6J5wbByuli1qF53Rh8L00sAgUpZ2niRY3FIefYuCFxJOiz1qBzEuw4j1Qshyx4XSQw3
         f9vA1n0q+oAWngTubIfKxvk66fhdBYpECkNB0GMB3vN647cE8pNBaLrsJmZmH0yb7HnG
         dWjUMCKn2IKExjltoVp/y62MPWIPVOhwEF0b58arJOgRYOqYuZNT0FToMEdxX845++iE
         uyeQ==
X-Gm-Message-State: AFqh2kowgBHgWTYSCNHyB3lkeA3j6Pf4CFpy+OpohtEZmMwIKgI0iMfU
        sN7m10FwqULmECDwNKEHD8XJN4DGNHeEru+umm5L2w==
X-Google-Smtp-Source: AMrXdXvUXG/20qDMqPMjWOCkbdTXLsSllvNMxCWx5sZ8AC8O46XC7jpKSDg4yZu1o5EclM9TlPxoJ/kkytPH8oBqtPM=
X-Received: by 2002:a05:600c:44d4:b0:3d1:fd95:a8f6 with SMTP id
 f20-20020a05600c44d400b003d1fd95a8f6mr3752705wmo.189.1673417835232; Tue, 10
 Jan 2023 22:17:15 -0800 (PST)
MIME-Version: 1.0
References: <20230110091356.1524-1-cuiyunhui@bytedance.com>
 <CANn89i+Wh2krOy4YFWvBsEx-s_JgQ0HixHAVJwGw18dVPeyiqw@mail.gmail.com>
 <20230110104419.67294691@gandalf.local.home> <CAEEQ3w=aU3siD-ubhPB3+Wv10ARfUeR=cUHmvdEp2q+y105vAw@mail.gmail.com>
 <20230110231201.5eddb889@gandalf.local.home>
In-Reply-To: <20230110231201.5eddb889@gandalf.local.home>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Wed, 11 Jan 2023 14:17:04 +0800
Message-ID: <CAEEQ3wn7XbsjfQaUR_Ka_KZz-+sb-edcQUtipspnUZQQ3+Y4ig@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5] sock: add tracepoint for send recv length
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Eric Dumazet <edumazet@google.com>, mhiramat@kernel.org,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        kuniyu@amazon.com, xiyou.wangcong@gmail.com,
        duanxiongchun@bytedance.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        dust.li@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 12:12 PM Steven Rostedt <rostedt@goodmis.org> wrote=
:
>
> On Wed, 11 Jan 2023 11:53:24 +0800
> =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@bytedance.com> wrote:
>
> > Hi Steve, Based on your suggestion, can we use the following code
> > instead of using DEFINE_EVENT_PRINT =EF=BC=9F
>
> I only suggested it because you didn't have that logic for the
> sock_send_length trace event. But if you don't care about that one, then
> sure, use it for both.
>
> -- Steve
>

Ok, Thank you, I'll post v6 later.
