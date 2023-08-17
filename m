Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6261C2FC18
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 17 Aug 2023 08:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349179AbjHQI6c (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 17 Aug 2023 04:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349215AbjHQI6O (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:58:14 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEBF210E
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:58:13 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26b5e737191so2393638a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262692; x=1692867492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehijAG3+DimElseOvhT2ydoS3VjVdNFUrFCVSW8Tlxc=;
        b=hSxOPHq4BKOHG2rjMx+eCEaltK6EuVzY7bFcWGYSKFEM4Ma2nvNcu1knimN7RQYL5j
         V6ZILhSBJ4uRpu1Yex71+JSerksuhVkWPYksqQmCYT+6Ayogq/Lkm02Xf3/T44eLdmfg
         AYrAhWo3fORH8bOal2jmfPFbxW92+q9w3Gvtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262692; x=1692867492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehijAG3+DimElseOvhT2ydoS3VjVdNFUrFCVSW8Tlxc=;
        b=HGfjQAtpIuFvI5+H5Mjfc9L5Wu/oWyitLXFqBPEYU7JIGlcoqOROSTj0U1GRFmdnL/
         9mcgFowywBsoC2u2zPuMU8SyR8wrA6JsjAQj0J0upZYaQb7inDxWJLSv4UlRwPLD0gyz
         TK/T+ZI6rb/lyKyO6HTjN7c4ykFnJUhy1c5r9Gno3xY3krQrEiE/EAXAIgj9mC5ffF5C
         grlM8YEHMppdaMbKAT5p/75QXUbimsQ9+MjKis07kYY8C7huWOpau7maYmz32DGSzvoq
         bwDe2BdxH4PXw57hbGu4pgZQafKXh7rQtrrS0Vvw/Zqg3Cn7gmeXlkxzBy6cJ8svtNXD
         cSUg==
X-Gm-Message-State: AOJu0Yz3Uv2GhOuCTHtEnRSw0njYb/5yW8P/H2ydVF9qTB2W9G8xOBPX
        kQJZ/Jd6lr0OLwxAYK3iChv4LaPI9+Pf8l1VbaAv4g==
X-Google-Smtp-Source: AGHT+IH7wJlK1Wn93MuV/91kwcNihtgsOunIPXO95uzJnJCqLl1ks9/sg/b2XhIGI7m4uJxhwSFPfPgEM1o0qlVcsn8=
X-Received: by 2002:a17:90b:3b49:b0:268:1be1:745a with SMTP id
 ot9-20020a17090b3b4900b002681be1745amr3423253pjb.29.1692262692654; Thu, 17
 Aug 2023 01:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181869006.505132.4695602314698748304.stgit@devnote2>
In-Reply-To: <169181869006.505132.4695602314698748304.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 17 Aug 2023 10:58:01 +0200
Message-ID: <CABRcYmLzPRZERpF2PUru7_LJOASrGp9Q=ftdxFfJYCVd0QFDJg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] Documentations: probes: Update fprobe document to
 use ftrace_regs
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

On Sat, Aug 12, 2023 at 7:38=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Update fprobe document so that the entry/exit handler uses ftrace_regs
> instead of pt_regs.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>
