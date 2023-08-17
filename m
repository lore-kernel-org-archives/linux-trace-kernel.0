Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543E2C2FC0E
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 17 Aug 2023 08:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349164AbjHQI6a (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 17 Aug 2023 04:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349202AbjHQI6G (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:58:06 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A52D2724
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:58:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bc73a2b0easo50631925ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262684; x=1692867484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfLp1c4CQASb52Y25xFQC1k0yj/rlFjQOJxQJThqQmU=;
        b=ho9t7K5YnNQvxLDVMQoh5xm1KUvC6FOjB+27q2YIWPGBsEK1xTmHG1t4a7Ee3T31Ex
         SKeSoS63VoXvRtkhpGG+BaN/dwKaZY0js6KsiZBcoiXMgPY0a8N/kAAIeNSsjokm9WlT
         yZI1f9uvxWx6FbPMxJ3Gl8EMiGLXjB2yWFuDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262684; x=1692867484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfLp1c4CQASb52Y25xFQC1k0yj/rlFjQOJxQJThqQmU=;
        b=jXl0/DS5Xotg6p2GYnNQDMOgiu05Drgaf99Pl2BO2jYiXb+ZPq0ID2tS0m9NxM/nAm
         IyAGp2EBPlKqcnGhMMhiPzsvO+zfv/1C3QsJbJKrOSiKHkMVlVu4vkiCZ63nDxQy7Lku
         9BIWK4HnnjXe2Idp20h2cXoEllGwJjxJ8MDogD1QLieYPeqphSLvtf/gli0IMWaCN6wg
         9FA7E5tKVecECAWiujs69ib1v6Ew9gkSTJ/mEvIEELixZ7s8A8+atDfD4eydRBT/Yrsa
         n9wiIN1p4u0Vq1O++erCLqG/3clzKJuUacer6wpaHZb5OdFg+M6Olr+qoaz/hy8Mz7e5
         QnSA==
X-Gm-Message-State: AOJu0YxF+ootfmEdivZs4boHlv5EfpkDUXnHr5dqe4w3Yh1alxhR5gRG
        s/mQI4JXSTvCgQ7Mpa8JH/Tc6oAizAOk6ULcHKWRYA==
X-Google-Smtp-Source: AGHT+IEuEh+F6ilNeOovqEBoQx7IdH5Xb8wY6puO8xnT2cSmh5oD8u4Z75bhE+9E37pBH0xI4F70q7QRYHtpLN1LfH8=
X-Received: by 2002:a17:90b:a12:b0:268:daa4:3a70 with SMTP id
 gg18-20020a17090b0a1200b00268daa43a70mr3495997pjb.32.1692262684544; Thu, 17
 Aug 2023 01:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181866661.505132.3229847361646568033.stgit@devnote2>
In-Reply-To: <169181866661.505132.3229847361646568033.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 17 Aug 2023 10:57:53 +0200
Message-ID: <CABRcYm+8uASJA+=AmAFVQMO+ZEOKRBca0bYpxTKb1hGV7P0iUg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] ftrace: Add ftrace_partial_regs() for converting
 ftrace_regs to pt_regs
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
> Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
> If the architecture defines its own ftrace_regs, this copies partial
> registers to pt_regs and returns it. If not, ftrace_regs is the same as
> pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>
