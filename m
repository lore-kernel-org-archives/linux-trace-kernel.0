Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A15C2FC1A
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 17 Aug 2023 08:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349173AbjHQI6b (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 17 Aug 2023 04:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349213AbjHQI6K (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:58:10 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E31E7C
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:58:09 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bdf4752c3cso22618345ad.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262688; x=1692867488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crlYGKquqF5t5yJzuYzOspJUZ1j4poI8LPHia0IINUw=;
        b=DksOOuTp1UVrleiR8CEK0iz/auSb6d/LPavN/30BDmNJ0cdz7LS99xeIxjET/PJ41X
         h81Ebion1q7krwAQiA51IC+KPYAqix6+FMf3GyFu87M3wpXcLnJ/nLO4LuaIACrnECZC
         CQtdKis22ego1txUw9OgYHzv9B7tY+JdrfxRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262688; x=1692867488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crlYGKquqF5t5yJzuYzOspJUZ1j4poI8LPHia0IINUw=;
        b=QQVb8nCl3VRxKBzdCyHOizLEAP+q46FFAVLue/uV8DLTNBrr+36fpQJqimHMFn7G+f
         vAsXhjXBowunBDYdGIZqH7yYPVZKJAYjijb+5P7W+LlWPCUqM+AqPPTOfVf5W5zEahbb
         e4jssrncaNFxyEJOG/4H7DC4+mtlkZigmieCG5bxjfmfitCzAMqwvR9Jhw0gZhf9E/RB
         wFTwyVGf7Lpy/CA9r6C1ebiRoK35QCk+9lOq5n8MagcXtvU0h5g/GXaUo4+u7umQd3AX
         LWrgp3Bo37KyUn8dRFbrIkFBPi+H54V5RwVPgOvdGIdSXifzE8jiUXU6AFire1O/suzC
         7A7A==
X-Gm-Message-State: AOJu0Yz7LiZNQnewtLOhoh+YHp8V8K2c2t7GrUB02P1dw+PFJToVsEA0
        XMV57Lsvto12VFe6/NvqO3Wo+4RfcbMEknTFOFWEJQ==
X-Google-Smtp-Source: AGHT+IHPdZNMxsM5+V5vX1EyN/E9ZUkGEZfEzPzHjovvpTHCp44OCZVb5aKpzX0DMTkIEr47E1RrBt56OImd/BKdS3c=
X-Received: by 2002:a17:90b:4391:b0:268:c7fc:b771 with SMTP id
 in17-20020a17090b439100b00268c7fcb771mr3404103pjb.14.1692262688334; Thu, 17
 Aug 2023 01:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181867839.505132.10717747708330472036.stgit@devnote2>
In-Reply-To: <169181867839.505132.10717747708330472036.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 17 Aug 2023 10:57:57 +0200
Message-ID: <CABRcYmLxL=F3xuNKV12oPt_aHoLM8gDLeAxMeVQsk-iuXi2mSw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] bpf: Enable kprobe_multi feature if CONFIG_FPROBE
 is enabled
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
> Enable kprobe_multi feature if CONFIG_FPROBE is enabled. The pt_regs is
> converted from ftrace_regs by ftrace_partial_regs(), thus some registers
> may always returns 0. But it should be enough for function entry (access
> arguments) and exit (access return value).
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>
