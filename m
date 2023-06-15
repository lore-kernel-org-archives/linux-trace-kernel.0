Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B40BEB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 15 Jun 2023 12:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241398AbjFOMJt (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 15 Jun 2023 08:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239479AbjFOMJs (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:09:48 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E56194;
        Thu, 15 Jun 2023 05:09:46 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-62ff4f06b3cso2248416d6.1;
        Thu, 15 Jun 2023 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686830986; x=1689422986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IF+9/YdeA2r727kKQG2P0OM0ZLGeDe465FJeTetImgg=;
        b=mVzrPwDLNfBTJIZyZcb8nOVIK/hWtGa9FTseJiaUYIkppxkpueXDIVpuLhUlzxMRPd
         oTikZTluoAgI+IG/elQmhTdtDKFFI9Gifwlf0uMj8UZ6Dks1guVIoYAh5ivau6VAFtUJ
         dnVVW2YUEmZ38JuBT5VWR4uznt5w0PI8Zdpj4W0m91rpWYqZVfAgYcm+t9OznoeJ/YEp
         Z+sv25cjjAMyHHM+42SMYqrdR+W/cUHCQ++NNRtgBBx4kjlw3MWO16k7E6BdtcEPKmpK
         48zAPvU0G1IJFTp0qVtFyQWJRwid2wKTtlXJfJtm92gluUbWPcHwxCAvcG8y+WsFqcPK
         lM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686830986; x=1689422986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IF+9/YdeA2r727kKQG2P0OM0ZLGeDe465FJeTetImgg=;
        b=ANK/8s2N0RKlLNt0eLBOJZX9LZABJluNY+Y6JUUgfUerLyMWR4UeTA7sDidhdoK1jJ
         f9Syo/CkhzhxxfBh3ZCtLLwyolr3oWXhdiGvokF7sTB0n2cq1Of4jOMJahsdIoRBqyhr
         adGYEA15GBfag99XZj9ZuZJLao7+rV+27+vzRPi4Z54aaCnkNTbdSkOncY05bghOHNo7
         qtXeM87UkYlwE6fzEOLgr2455PatnFcyLwf1+DyWbmIJD4HDRIyGA9zojMt4Ttp8xMRV
         b/psfLFkEQ763uIhqfO1fz1f4iaGqmoaOZTgRispkw/RBw45rhb/HBbHP6J2vvJHWdy+
         EXgg==
X-Gm-Message-State: AC+VfDykcXsLwiuoJYidmaehjseeZtrHJ/ubb6B/x0tzCya9T2hvgSgQ
        Vef8l4C8E8xI0uCrPn8nHMa6GIIifJ8exO+N5wk=
X-Google-Smtp-Source: ACHHUZ5/zJ0aT/B7ry94litBAmZVFu4T7YriOhHaHbOEguwhZUVuBFhahMkxMpfLb+07bQxpJGWYbE8IsE8P/t2+OgA=
X-Received: by 2002:ad4:5b8b:0:b0:62b:5081:46bd with SMTP id
 11-20020ad45b8b000000b0062b508146bdmr22462532qvp.17.1686830985679; Thu, 15
 Jun 2023 05:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230612151608.99661-1-laoar.shao@gmail.com> <ZIriJs5qvMYBq7DZ@krava>
In-Reply-To: <ZIriJs5qvMYBq7DZ@krava>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 15 Jun 2023 20:09:09 +0800
Message-ID: <CALOAHbCdMVd0F-aGsw0D7LeAcvTSOfhwgtW+oxAQFOwbTyqEsQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/10] bpf: Support ->fill_link_info for
 kprobe_multi and perf_event links
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org,
        bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 6:04=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Jun 12, 2023 at 03:15:58PM +0000, Yafang Shao wrote:
> > This patchset enhances the usability of kprobe_multi programs by introd=
ucing
> > support for ->fill_link_info. This allows users to easily determine the
> > probed functions associated with a kprobe_multi program. While
> > `bpftool perf show` already provides information about functions probed=
 by
> > perf_event programs, supporting ->fill_link_info ensures consistent acc=
ess to
> > this information across all bpf links.
> >
> > In addition, this patch extends support to generic perf events, which a=
re
> > currently not covered by `bpftool perf show`. While userspace is expose=
d to
> > only the perf type and config, other attributes such as sample_period a=
nd
> > sample_freq are disregarded.
> >
> > To ensure accurate identification of probed functions, it is preferable=
 to
> > expose the address directly rather than relying solely on the symbol na=
me.
> > However, this implementation respects the kptr_restrict setting and avo=
ids
> > exposing the address if it is not permitted.
> >
> > v2->v3:
> > - Expose flags instead of retporbe (Andrii)
> > - Simplify the check on kmulti_link->cnt (Andrii)
> > - Use kallsyms_show_value() instead (Andrii)
> > - Show also the module name for kprobe_multi (Andrii)
> > - Add new enum bpf_perf_link_type (Andrii)
> > - Move perf event names into bpftool (Andrii, Quentin, Jiri)
> > - Keep perf event names in sync with perf tools (Jiri)
>
> hi,
> I'm getting some failing tests with this version:
>
> #11/2    bpf_cookie/multi_kprobe_link_api:FAIL
> #11/3    bpf_cookie/multi_kprobe_attach_api:FAIL
> #11      bpf_cookie:FAIL
>
> #104/1   kprobe_multi_test/skel_api:FAIL
> #104/2   kprobe_multi_test/link_api_addrs:FAIL
> #104/3   kprobe_multi_test/link_api_syms:FAIL
> #104/4   kprobe_multi_test/attach_api_pattern:FAIL
> #104/5   kprobe_multi_test/attach_api_addrs:FAIL
> #104/6   kprobe_multi_test/attach_api_syms:FAIL
> #104     kprobe_multi_test:FAIL
> #105/1   kprobe_multi_testmod_test/testmod_attach_api_syms:FAIL
> #105/2   kprobe_multi_testmod_test/testmod_attach_api_addrs:FAIL
> #105     kprobe_multi_testmod_test:FAIL

Thanks for your report.
BPF CI catched these errors as well.
That is caused by setting link->fp.flags, which has been pointed out
by you in patch #1.
I will fix it in the next version.

--
Regards

Yafang
