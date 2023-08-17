Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E039C41513
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 17 Aug 2023 08:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349163AbjHQI56 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 17 Aug 2023 04:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349197AbjHQI5r (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:57:47 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3135B26A8
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:46 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a800814122so3154001b6e.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262665; x=1692867465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZ7NMqvFIR2et+D8JZPMfPw5WnBck106F6tUJxbT9Gg=;
        b=b0GhhDLSM9faSxoD0WP+TXbItwqeY4LweTgfy9B593XszXNEq91tklMLWcxdjEXQrJ
         6VMQUM+rWR/ODEx3HE1E3XuNdEIONzAUxF7ibYt1tsebrIKpHhaXHhpXBg67/rQjFrv2
         xLI4IRptekVy+SWo0CuEz3yJxIsjTjMsIgqK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262665; x=1692867465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZ7NMqvFIR2et+D8JZPMfPw5WnBck106F6tUJxbT9Gg=;
        b=L9XbuNYgO+EJxsI/yRq4DSkEF/dXXkSbWhA+wNrRGMQ0LbBPevgZwhFhKNBGp1K4Cq
         LXMUBDUXb0NPzkIC8Ovvy7JP4QSCqzxsTMHEKyZeiztMLLyBwqddni/led/sNskmThrf
         hR6BMh83BXdrYQ/jLYPvEkA0wksEnKDlq2UVyWJBUVQqiyn8M6Eu6pgt9G7v7PxSSgEc
         EcT24QUTP0lYrr32J1xERxEGVkEIYnBrDPSxXgSz6494mZsYPI4iDcPyb3/zcCupm1gB
         aA2SD4cV/vGFFKPdvgnjJeB0fzLCBucVqFDbK6u9GkNXR0Ze3iqqyfy13RMP8KgHx4sg
         wCXg==
X-Gm-Message-State: AOJu0Yzh7g3o1YvqoZoax+Djl7oMrYb6fDZWjl86KUw0j9i5ryFhg1fC
        mbUysVjNOufYZTHaKiOz1iYsn7lmsbvI4ABE8cOa6jbD63f4n3Dg
X-Google-Smtp-Source: AGHT+IF/lZED8EmuEUmIk6G5RS65+A7NYREGfAS6ecOd1YzcZ0v6Mx9lu+wCelzhQCnQ1D518ZnjHFgRY/sYb2/L/FQ=
X-Received: by 2002:a05:6808:14ca:b0:3a8:3155:bc2e with SMTP id
 f10-20020a05680814ca00b003a83155bc2emr355357oiw.0.1692262665550; Thu, 17 Aug
 2023 01:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181863118.505132.13233554057378608176.stgit@devnote2>
In-Reply-To: <169181863118.505132.13233554057378608176.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 17 Aug 2023 10:57:34 +0200
Message-ID: <CABRcYm+i1PqVNUC_Hf2wsUdw8Gz-kap9YQ1zFwKKXjb7hp11bg@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 7:37=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> In order to be able to use ftrace_regs even from features unrelated to
> function tracer (e.g. kretprobe), expose ftrace_regs structures and
> APIs even if the CONFIG_FUNCTION_TRACER=3Dn.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>
