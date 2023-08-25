Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B64DC3DA6F
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 25 Aug 2023 16:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244146AbjHYQNK (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 25 Aug 2023 12:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343699AbjHYQMn (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:12:43 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAC81BDB
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:12:41 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-56a8794b5adso624990a12.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692979961; x=1693584761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3K9GAzZPmrf69JfCVKUGLeyRxUQaU+/aTKM9BOzOE0=;
        b=cYNfp9vLbjf8tVTE47Bc7cP/0E/Xwx0j7tnAYEARoRhzTwEYc0ufZryAlt1ur8TmII
         MLZkGn1N1dyP1dYJnuTjfLonzEgoEb0Yu+hTIQKnPlffIeyqIJhvG28i7kXPC5u0Ajcb
         FLgj2CoL7k6bdFRKEGMADSGtdhTVmTo4OahsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692979961; x=1693584761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3K9GAzZPmrf69JfCVKUGLeyRxUQaU+/aTKM9BOzOE0=;
        b=eoQZEyIC8wgMDqAPIfkcMUNTnJz5Guk6n8jAIIedyx3Mtj+Q2nTgRtRh2ZDdEI1uPF
         HLOEMndOWo02dpw/DvEcZcoVagJC6AYL+8MZuVYDQG+gn1m7sYtj48vX2ywm6scB81Em
         xBl8pQ03vyXFIB0ciys7fUzhCPLOXLcxf5ilk+TwyigF9dVkgCCUvtw98pLI+Z83AMCI
         L0ek2Jsj5yU2sm1kxAq0RcNKTbh5enunuAEohlmQ24h/yBWEsfX/r54PHnrARHq/JIij
         qKFhV7RA+mJlXuy3zeU7vILzcs3pO5g99BCC/wtC211EB8AGFJ2vmdqOQrGqCbCbHKIP
         cCIQ==
X-Gm-Message-State: AOJu0YwkAp1iAbSqSLRz1b80EX0utwpokSF4ZaDWS/yQXkckgAFwLAL+
        eA/ZDe23GehZkZ0xAwhMjgEYjsk3QL6sjWyZZr/8fQ==
X-Google-Smtp-Source: AGHT+IGVZOa2Il9SMW0TIYGfWLMiPG8S6YwqeylIfeo4abOQtStvAldvxSg6EWjVVD7VGXHSdNLWhT8f1dSEqXg4gbI=
X-Received: by 2002:a17:90b:1486:b0:268:1dd3:695e with SMTP id
 js6-20020a17090b148600b002681dd3695emr15524004pjb.49.1692979960981; Fri, 25
 Aug 2023 09:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2> <169280382895.282662.14910495061790007288.stgit@devnote2>
In-Reply-To: <169280382895.282662.14910495061790007288.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 25 Aug 2023 18:12:14 +0200
Message-ID: <CABRcYmJcii6UzJR+jksg9SMYAYZRNqEhKoHp=V2xiPYh76Q2vg@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] Documentation: tracing: Add a note about argument
 and retval access
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

On Wed, Aug 23, 2023 at 5:17=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
> diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fp=
robetrace.rst
> index 8e9bebcf0a2e..e35e6b18df40 100644
> --- a/Documentation/trace/fprobetrace.rst
> +++ b/Documentation/trace/fprobetrace.rst
> @@ -59,8 +59,12 @@ Synopsis of fprobe-events
>                    and bitfield are supported.
>
>    (\*1) This is available only when BTF is enabled.
> -  (\*2) only for the probe on function entry (offs =3D=3D 0).
> -  (\*3) only for return probe.
> +  (\*2) only for the probe on function entry (offs =3D=3D 0). Note, this=
 argument access
> +        is best effort, because depending on the argument type, it may b=
e passed on
> +        the stack. But this only support the arguments via registers.

supports*

Otherwise:
Acked-by: Florent Revest <revest@chromium.org>
