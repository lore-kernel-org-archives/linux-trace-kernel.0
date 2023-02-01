Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53547C636CC
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  1 Feb 2023 00:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjBAAFa (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 31 Jan 2023 19:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjBAAF3 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 19:05:29 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD42D1284F
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:05:27 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id d10so11252697pgm.13
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w8A9vBT/khKMaGZggBlfcaoxdg/zaX7WQ2GHlPfZ9xs=;
        b=BiSpvB811IcBJct74KPKQULQwFcRN0Wg6Ar62bSSgLA3zig9AYd/fuex8mOqSUPSJ5
         Ziod9DDVVIQgSwvdnd6FioMZH2mxYqPmSkXelMU6CCiIp8HRvw1tog/oKIgQnrhpMIZw
         aBUu8itI0Sq+J8QKloY6eNIDrpdFjkXefbQ0uuFK7QW12BgBk0n0oNX68PmfFUDStSe2
         wIVNM2FYkwp4klqPWgCgMtXJIEZDyxZndFyilZ10JPT0SS1S1orCP13X222wVTHKrPWO
         g2Iw0peEIoMgZSWbrfkkaAAZAYt3YkysTEQ2FC9IOpLb5BQUJyaAcOyjLu9wpjM53cyk
         nBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8A9vBT/khKMaGZggBlfcaoxdg/zaX7WQ2GHlPfZ9xs=;
        b=eVzZzEBP5kdfSrO3VUT/HFocQMC92WvNpUivtVgSh1v0RHUveNJeWcC+QpjuLylm3z
         m+7cT4toIVeHNHIkocznPTG3moDwqvwhNNdp2moLuf5YDilbJOQQANpoe3DObu9HTdJl
         jn3wv3BwWcmVlprrq8iDIwfdzQEJQXsB8ys4xV4bLmmoYUTzBbp6unGp+NOfSmz2dKF7
         o08atKYt2W5XOKcFcwVbvfUhamIrA8BXV2G9YobU0azpCTAoGRpoc1gG5BwuDc1Xjd5t
         /sys0xyRy8I1QWQtqGIZQCMQu4iS463L6KHYJD57VDqilWuMjqLtKzQeYb8HdLUeZXoT
         SreQ==
X-Gm-Message-State: AO0yUKW16Ep0Xx665342ufdDeIqmMGEIfQyS20hLrZLPq2iDgb7wMirh
        s3Q6D3trJpqGMNo1dEEJq8qEMSqTpYN8CazNE4/I7w==
X-Google-Smtp-Source: AK7set9l/4wp/xKINl4PM5P7x4+dC0lcSiZC7hllzJdRw5eYtA9+kDO5qRjUUrC9bYnufKTMSSBDyeVqchrW61Oiww8=
X-Received: by 2002:a05:6a00:a18:b0:58b:506d:d6ae with SMTP id
 p24-20020a056a000a1800b0058b506dd6aemr77372pfh.24.1675209926940; Tue, 31 Jan
 2023 16:05:26 -0800 (PST)
MIME-Version: 1.0
References: <20230130181915.1113313-1-zwisler@google.com> <20230130181915.1113313-4-zwisler@google.com>
 <CAADnVQJ7KxEK92qOz0Ya4MrACHpxngSpG4W38xuGEgZmXEG-vQ@mail.gmail.com>
 <20230130145932.37cf6b73@gandalf.local.home> <CAADnVQ+F3Z70mu3-QyyNFyJ2qCkDXnMJCW-o+fcnZo=LWj5d9g@mail.gmail.com>
 <20230130183419.0626dc21@gandalf.local.home> <20230131005315.phdnhkeeconxxm3e@macbook-pro-6.dhcp.thefacebook.com>
 <20230131145048.6fac87d3@gandalf.local.home> <CAADnVQKpkuBdQWWGDBh13NCrx2WMPs4fVUyVujF4L-6XnjXFpg@mail.gmail.com>
In-Reply-To: <CAADnVQKpkuBdQWWGDBh13NCrx2WMPs4fVUyVujF4L-6XnjXFpg@mail.gmail.com>
From:   Ross Zwisler <zwisler@google.com>
Date:   Tue, 31 Jan 2023 17:05:15 -0700
Message-ID: <CAGRrVHzNcWx4Rws6GVi2UPRG1ZyzowBJQSqaS83WhsNVymU0Ww@mail.gmail.com>
Subject: Re: [PATCH 3/9] selftests/bpf: use canonical ftrace path
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 4:26 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> Fair enough. Please resubmit these two patches towards bpf-next
> with [PATCH bpf-next] subj, so that BPF CI can chew on it.

Will do, thanks.
