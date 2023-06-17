Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25E2EB64D7
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 17 Jun 2023 03:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjFQDUy (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 16 Jun 2023 23:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjFQDUw (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 23:20:52 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F281526B3;
        Fri, 16 Jun 2023 20:20:49 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6300465243eso5151406d6.2;
        Fri, 16 Jun 2023 20:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686972049; x=1689564049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exFKbqpx9w0c+JI/EkpUTLKO4hw4wzGds+hcKEHiS5c=;
        b=Uvd/rbhe0BKIhk7OTkFb8/XKRYRZD6Y30ghBPL0/Pju8JdYZAAceAurJCrQ2ZPK64F
         GWQuTjetJLAZLM0XxSqWtcKCbi29Dn+Hkjx8ue5KA7AnDhFVJEO2Fg6V31QBqZgtw1yq
         UpyJuuFCLuIid+91weSqHVy30Wr8hetQ38wvLglwz2LJpy5nMG5qSop9Pmx1q/le9Fi1
         A5/VCw0PmV0a3vruV4SmrswaIYBSL6+W24dtTHIWNz8g7/kFygmOD525Bw1wADhN5B3C
         InDoIs4nldeyf9GmiKlCMgO/CTrpnUBtosDcjbG47HGJodZQAbHsWPEd8au34fyXiNsV
         J1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686972049; x=1689564049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exFKbqpx9w0c+JI/EkpUTLKO4hw4wzGds+hcKEHiS5c=;
        b=RzW7gnfnxRpB1vSikvfmPUvq2C0g+1/5EAxbzvQ+OdSxDzmURuW9EFZlmrmKh503T/
         O1Bpdx+h+Ci6PNIlD0tCpBW+QXXbIfKlqYdQXETvzN4Sx7m58VT/bE6Cu2wfUVsubNWL
         EKAdvmx80ojxyEHhy9wXPy09LP5mSvAQvYz6PgsUu9tTsj8+lpFBZfxRMM9O7M70ALhl
         x+Ks2KO9zQcRewjofqcjsAQChlKknyB3y01xbcGba9qQYbhPTUsNDaPMeXVSzRMnfIHH
         m13uJoDuriSOq2BekVq7iuDmWRxws2g0Gj5XALLOdF9Rs3shjEMkrb74ho2Vl8zzwMQY
         4FQA==
X-Gm-Message-State: AC+VfDza2M8DuAqYG2SJm22oJ1VeRJ24O0iKSHp2Q+w1MQdnxLrBnKUW
        kEyRRWCRyKuC7VDg9Ij+hLw83FEE8iD+1Wm3BRU=
X-Google-Smtp-Source: ACHHUZ4fzwKW+AQwJmPR/+K06U+zlymUW1gFHkQHGS26sz3n4zTS9PybIDUu00nfdFvXiz6tW+JKB54c4QDo6bXQRyY=
X-Received: by 2002:a05:6214:2028:b0:625:aa49:19ef with SMTP id
 8-20020a056214202800b00625aa4919efmr4953132qvf.60.1686972049082; Fri, 16 Jun
 2023 20:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <20230612151608.99661-11-laoar.shao@gmail.com>
 <CAEf4BzYTxEeaXLLajU-ka=OxPVh4LZERq210_A75mDZH+7t-yg@mail.gmail.com>
In-Reply-To: <CAEf4BzYTxEeaXLLajU-ka=OxPVh4LZERq210_A75mDZH+7t-yg@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 17 Jun 2023 11:20:13 +0800
Message-ID: <CALOAHbBNzu4YeDSwFQvUcZ4ATj-FgbWG--6BgeQryzMRq=mCRQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 10/10] bpftool: Show probed function in
 perf_event link info
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, quentin@isovalent.com, rostedt@goodmis.org,
        mhiramat@kernel.org, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 4:41=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jun 12, 2023 at 8:16=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Enhance bpftool to display comprehensive information about exposed
> > perf_event links, covering uprobe, kprobe, tracepoint, and generic perf
> > event. The resulting output will include the following details:
> >
> > $ tools/bpf/bpftool/bpftool link show
> > 3: perf_event  prog 14
> >         event_type software  event_config cpu-clock
> >         bpf_cookie 0
> >         pids perf_event(1379330)
> > 4: perf_event  prog 14
> >         event_type hw-cache  event_config LLC-load-misses
> >         bpf_cookie 0
> >         pids perf_event(1379330)
> > 5: perf_event  prog 14
> >         event_type hardware  event_config cpu-cycles
>
> how about
>
> "event hardware:cpu-cycles" for events

Agree. That is better.

>
> >         bpf_cookie 0
> >         pids perf_event(1379330)
> > 6: perf_event  prog 20
> >         retprobe 0  file_name /home/yafang/bpf/uprobe/a.out  offset 0x1=
338
>
> for uprobes: "uprobe /home/yafang/bpf/uprobe/a.out+0x1338"
> for retprobes: "uretprobe /home/yafang/bpf/uprobe/a.out+0x1338"

Agree.

>
> >         bpf_cookie 0
> >         pids uprobe(1379706)
> > 7: perf_event  prog 21
> >         retprobe 1  file_name /home/yafang/bpf/uprobe/a.out  offset 0x1=
338
> >         bpf_cookie 0
> >         pids uprobe(1379706)
> > 8: perf_event  prog 27
> >         tp_name sched_switch
>
> "tracepoint  sched_switch" ?

Agree.

>
> >         bpf_cookie 0
> >         pids tracepoint(1381734)
> > 10: perf_event  prog 43
> >         retprobe 0  func_name kernel_clone  addr ffffffffad0a9660
>
> similar to uprobes:
>
> "kprobe kernel_clone  0xffffffffad0a9660"
> "kretprobe kernel_clone  0xffffffffad0a9660"
>
>
> That is, make this more human readable instead of mechanically
> translated from kernel info? retprobe 1/0 is quite cumbersome,
> "uprobe" vs "uretprobe" makes more sense?

Agree. Will do it.

>
> JSON is where it could be completely mechanically translated, IMO.

Agree.

--=20
Regards
Yafang
