Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93489EE49A5
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 21 Aug 2023 18:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbjHUSIF (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 21 Aug 2023 14:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjHUSIE (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:08:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0282E8
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:08:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bbc87ded50so22282515ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692641280; x=1693246080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C9KCTyEQmTzJ2AoVVtRj2q5ensCCizslMtl245k7Oc8=;
        b=FGcqArs7DVaZTc+xNN2N3gLmdWMq4dzsQb9+vbF9C0ph+t2g1dyAJRdhXCdIeTpeJK
         KK2WpBM1RtYPK+YYUYQJTv9iDOK3YKFROWs72Eb8EeBDkYOb2Q728jJij3+dVfDu0WFP
         Uh5C/4U01yJA+09Dr98qdsXJx6KQlTLBQ7ZlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641280; x=1693246080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9KCTyEQmTzJ2AoVVtRj2q5ensCCizslMtl245k7Oc8=;
        b=eHG+JGflBaRJphN+z9Sf1xr1wSq0KAAQA2QKAuvZn0CtMPC7KGMtFOEmvzkGuXQQzU
         Bm8HyrrsrihDLUidw/wReoASguI+p92aIoAdNMeg3f1q8OBaNLGFuN4P8nmd1nXj21ct
         xnbvaL81o1aR4kye1asWzKZOMgLrnRTYMuDAae5251LmPly4zWXDav81PeW0A8c68898
         zAoyV7xX5OarblYggMOngHS8hhs7eNuvGso3709qdPexuDnYGW8Hiyr+OYTyEAIK0UPf
         7AHk4Bm0a/NCP+YijNygiKnMQwoPQrR26tGhnimyLgFMviC/v8riXf5C3Tj/S+8AwZ2+
         tClw==
X-Gm-Message-State: AOJu0YwtNEt+gLPkJzxcK6jAcEOBYKTUYB/ki3u1md0pDnSugg5SIoh3
        y0lHGk8xbnzFAx3JbGWxBmr/rM409fB8Nn5mUaI=
X-Google-Smtp-Source: AGHT+IHVVBCrzwc3bXE9J1IBDI694b58opdLYIe2kSbRwqtBExci3L9ntVkfSI6zbRYvHAcufxVwbw==
X-Received: by 2002:a17:902:da89:b0:1bd:c956:2798 with SMTP id j9-20020a170902da8900b001bdc9562798mr6199513plx.46.1692641280381;
        Mon, 21 Aug 2023 11:08:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b001b8a897cd26sm7337781plg.195.2023.08.21.11.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:07:59 -0700 (PDT)
Date:   Mon, 21 Aug 2023 11:07:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Song Liu <song@kernel.org>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-ID: <202308211106.D2D2887@keescook>
References: <4853240.31r3eYUQgx@pwmachine>
 <20230818142033.1d7685e9@gandalf.local.home>
 <20230819101519.568d658fbb6461cc60d348e5@kernel.org>
 <CAPhsuW7d4cMi_FAtvyTn4HJWzRdocJaEVq-uYVcW43=JDE_EnA@mail.gmail.com>
 <20230820183218.bf0b04be3c0ccac5e7b2a587@kernel.org>
 <CAPhsuW73yT+D9HhLhi8pafYZsgT=qsqk5foAwGRTvStnWCZwNA@mail.gmail.com>
 <20230820221612.33dfc3b3072f8bd8517f95b5@kernel.org>
 <CAPhsuW7+dRddDe9XLuM2ANnGZOa2J4MnSDkWZ_xZCGVxj02bXQ@mail.gmail.com>
 <20230821190152.c467e40a5ee3d57715600159@kernel.org>
 <20230821104550.57d60a75@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821104550.57d60a75@gandalf.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:45:50AM -0400, Steven Rostedt wrote:
> On Mon, 21 Aug 2023 19:01:52 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > kprobe BPF program has access to pt_regs, so it can read ip of the
> > > attached function. Can we do the same with regular kprobe (no bpf)?  
> > 
> > Yes, it can. So I think it is OK to expand CAP_PERFMON to access kallsyms.
> > But this means CAP_PERMON itself is not safe in some case.
> 
> What are the privileges that CAP_PERFMON gives. I can see why Kees told me
> to avoid capabilities when looking at what has access to tracefs. Because
> it becomes very difficult to know what the privileges you are giving when
> you give out a capability. I just stick to normal ACL (file permissions)
> and everything is much easier and simpler to know what has access to what.

At the very least, having a fd-based "handle" for access work. But yeah,
capabilities get ugly quickly.

Anyway... what does CAP_PERFMON have access to right now? If it is
allowed to read arbitrary kernel memory, then resolving symbols is fine.
If it doesn't, then no, it shouldn't: it becomes a oracle for probing
symbol locations.

-- 
Kees Cook
