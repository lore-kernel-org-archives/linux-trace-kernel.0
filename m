Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5553C001DB
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 25 Aug 2023 16:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244307AbjHYQMj (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 25 Aug 2023 12:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244073AbjHYQMQ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:12:16 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF752128
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:12:13 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-569deb93999so611836a12.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692979933; x=1693584733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYfnmVl0jR/3Cs9h4eIxS2wjr6yR3DPQqFq/3LncF7k=;
        b=QFbnh1wmRTqXWOJeQYmwJaojukZCLyiBMiTKNopr+7CveeO2lQMV+EV+kG+Vx0v2y2
         V4eCK4kQD9wfQrs7NX/r+60aZo6ipw6kvmzDeJxz8zxjn3EAP6o3Iz4a1ez75/fFDykN
         1TrcH+aGIcyq3wcPcrT4hW1zphbyX6J3VINk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692979933; x=1693584733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYfnmVl0jR/3Cs9h4eIxS2wjr6yR3DPQqFq/3LncF7k=;
        b=WzAoegtwCJCFlwJ3fGm4BQb/VhgzXs5La/sDkU4uzUjyoXUUsImcxgXtcq6FYyiTg5
         bABgWuCRnq1Hnu3dTsHFa1A35Jd7zULDEGlmzXzc2Cd4e9HZropamrutwt24w+9cLhPa
         N8pRld0WERL1hYpBAsTPICc8t7F4MAnqor7HLxRJTyYGdtbRcUQtI7zRmJuGA0WdJTM7
         wS8OAaMkGUBEvUDrixE/xHW6H/8rEyUIKE+hMvWN+EFyTe7iTWfr2tU/f2jAUBebMjHL
         e5LILYb8zA+I4tSQGVf8YcY9/wBnqWGK93MkKOoAZMDmGUqxZ961n25gfsmn17YaQqUA
         xTTg==
X-Gm-Message-State: AOJu0YzqZy8Llfb7SH0cXDp6WKRRH9AW1tfujH2Tk8bECNqXwG9XuQK/
        4KAanKBqDeHqtO0Re+FhG2g9P5ZO+7UJNqyUphz6aQ==
X-Google-Smtp-Source: AGHT+IHa1afA+N+wXb1aYhgjkfrZlAddyzbUP7Mom1/uH0U2fOpHMMEZ4yGnZpurZozI9wPJAHv1bVnaNdlENLUL16s=
X-Received: by 2002:a17:90b:1986:b0:269:851:4f00 with SMTP id
 mv6-20020a17090b198600b0026908514f00mr14045766pjb.35.1692979933334; Fri, 25
 Aug 2023 09:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2> <169280377434.282662.7610009313268953247.stgit@devnote2>
In-Reply-To: <169280377434.282662.7610009313268953247.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 25 Aug 2023 18:12:01 +0200
Message-ID: <CABRcYmLCDTMCQMViP56eT13YEW247acDqQUmXY=pf4qTS_4aUw@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] fprobe: rethook: Use ftrace_regs in fprobe exit
 handler and rethook
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

On Wed, Aug 23, 2023 at 5:16=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Change the fprobe exit handler and rethook to use ftrace_regs data struct=
ure
> instead of pt_regs. This also introduce HAVE_PT_REGS_TO_FTRACE_REGS_CAST
> which means the ftrace_regs's memory layout is equal to the pt_regs so
> that those are able to cast. Only if it is enabled, kretprobe will use
> rethook since kretprobe requires pt_regs for backward compatibility.
>
> This means the archs which currently implement rethook for kretprobes nee=
ds to
> set that flag and it must ensure struct ftrace_regs is same as pt_regs.
> If not, it must be either disabling kretprobe or implementing kretprobe
> trampoline separately from rethook trampoline.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>
