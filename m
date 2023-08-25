Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B05BEE49A5
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 25 Aug 2023 16:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbjHYQMi (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 25 Aug 2023 12:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244041AbjHYQMJ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:12:09 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938412128
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:12:05 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-565e54cb93aso510999a12.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692979925; x=1693584725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8MLhs3IfeRC8yy9z6+Fa7fpyQgi8tcq6XmRwm/8Nn8=;
        b=BB6WxysYDMEr2xwwK59SBU99pmVr1e5MTAkEqlZGzqL2kXzO4tGtCYBA/dXHM5/49Y
         oHvyi4wrljHIncqRzGD9VACZ0xiPgcVa7ker+oxni2UKE57XTU+Wui8/R6Yeq31Hf1zu
         aujLXiNJyl/OQ5rIarFbSvoPWbCyeoq19phfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692979925; x=1693584725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8MLhs3IfeRC8yy9z6+Fa7fpyQgi8tcq6XmRwm/8Nn8=;
        b=EG7+8w853NzDOR+uwdZoGpA+tdUeHrBkPWP4VNTm8XviAfRAV4sIUKydTMKwD8aS0S
         MQ2nL5pR1j8JEFwQNyHy51t+fWjCOvdO0zlr4Fzi1BRiqs/UYNOgqcbN6VufkMQKFwFx
         H8oFPIMXFAEGgk0GlRR24aAxMi8xq/9ilxdijSwdWGMZZVuBHDHO4WDbhYr3U2pQE7a+
         PxU82Na3+e8+1SN+4R8RVYRyP7uEDMO0z4ICpQCdC+F2eNO+7hvWhCh5zFN3ubUgVjPy
         4+NC7T4PrspbaB+Gaxt17xegsDYIueTFLAViyUTjhN/HeETGMYrtsCPFJErt+95BkAYg
         vx9Q==
X-Gm-Message-State: AOJu0YyKSPsAx1TNgOOfxqeCuB6lLjeegFIA+L27G87NNsWs7iw6oXXs
        s0fm1+k2ycZAbyTAWT/GbamWOHX0/KKjsLwWUSqJbg==
X-Google-Smtp-Source: AGHT+IET8rQZ5xah8Zdkmp/PwyqZ2Z7qh9Vx9+xr62A4BxIguP08Fq+SgE93rxtJ2HmVHbjTMXJjf0sNSYxDm+i2j8o=
X-Received: by 2002:a17:90a:fd14:b0:26d:ae3:f6a7 with SMTP id
 cv20-20020a17090afd1400b0026d0ae3f6a7mr15511414pjb.21.1692979925072; Fri, 25
 Aug 2023 09:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2> <169280373992.282662.14835192462715188987.stgit@devnote2>
In-Reply-To: <169280373992.282662.14835192462715188987.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 25 Aug 2023 18:11:53 +0200
Message-ID: <CABRcYmKCd4iW8Yk0Z5p2H2HNpnbuuegZRA5BC_OekuPan25wfA@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] Documentation: probes: Add a new ret_ip callback parameter
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
> Add a new ret_ip callback parameter description.
>
> Fixes: cb16330d1274 ("fprobe: Pass return address to the handlers")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>
