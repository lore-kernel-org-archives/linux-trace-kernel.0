Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A33EE49A6
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 25 Aug 2023 16:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244041AbjHYQMi (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 25 Aug 2023 12:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244063AbjHYQMM (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:12:12 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C5D2128
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:12:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-565e54cb93aso511063a12.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692979930; x=1693584730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJKdAvSeO4VOH3RXUmPYFWaBoLletQWHD1bi3Jy/+zE=;
        b=Wv+Aikc5fWzgctUffCSl5SpZmaqfLaajo7F4H7Gbi9R5PdH0Wk34EM+4qVUjXVkrYm
         0r2jn0Znwix7CHuX5Wko9ocul/EzipKwQHlqG0OtdTkNTsZcDWRjS8WH3K554sASZWpH
         7bxBNQz2cJIvLHM5BvsIf8m6athGePEeOqE7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692979930; x=1693584730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJKdAvSeO4VOH3RXUmPYFWaBoLletQWHD1bi3Jy/+zE=;
        b=LfbXGijheKRdpO61efM26MzqztP6HlwaYxqkH1+sdUqkeuMK+hskenmEVTNOiGIsdf
         Sgn3UcV0xBB0faw1+/VSUUapoxGOsQ5xFTb5A39eeDn5Eyo4jfwrh/ss+k3pUtttT6+f
         DldVuG1tmQ3bJgkcb3tqbCI/5Dh3cWpY17ImUeK0/4FCwwK5GuSjPKKN1H/yO4yinSWz
         eJEYW/vRRf9xrghLLFqYXKjUAQCMR3jb2cHmZRde/RgCExhyZzcR77GOhB+iiS0V59Yj
         EgTEA35P1cDOVX4jUvg8yuJmHBo+DMUC48XMheu1m1Qn9mvoWidZ00usCXM+BW01iueT
         WfFg==
X-Gm-Message-State: AOJu0YyRk8pVjYf9m4CdtWlo7WOs+l4hy3G+Ytaoskw2NkYqkd9VR/QG
        O4XUzK6bzY1tpnHli4j+K7UY9vBSy6/wU6CjpzJD9w==
X-Google-Smtp-Source: AGHT+IEBHrqFG6LWnHGYuq/piq4gWrUiBxMwJVIvmD6hHxN9kT9eSyLoZ0oEcz6Qd/pumOLSwMISfSv3U10PbgFxNME=
X-Received: by 2002:a17:90a:bc92:b0:267:ee56:4c59 with SMTP id
 x18-20020a17090abc9200b00267ee564c59mr14047892pjr.35.1692979929795; Fri, 25
 Aug 2023 09:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2> <169280375109.282662.4109179404470188137.stgit@devnote2>
In-Reply-To: <169280375109.282662.4109179404470188137.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 25 Aug 2023 18:11:58 +0200
Message-ID: <CABRcYmKjv7rvhHQCbXHhUQm+W4coWJAHM+0epA58cnGHerx=yw@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] fprobe: Use fprobe_regs in fprobe entry handler
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

On Wed, Aug 23, 2023 at 5:15=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
> on arm64.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>
