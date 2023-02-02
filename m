Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC854C05027
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  2 Feb 2023 17:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjBBRcb (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 2 Feb 2023 12:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjBBRcZ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:32:25 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C849F74A57
        for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Feb 2023 09:32:15 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id ha3-20020a17090af3c300b00230222051a6so2521188pjb.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Feb 2023 09:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HuyVsSMV1aQwyV3j6toXzGhoibHAp15bMSPIrl5X/iQ=;
        b=ogaLpO6+zk+gU/nMTEHsHZ0Dj7a1J/5FfpnNFOxFzqy2KmIp7DIQzK8Gju+lzl+mqJ
         tyXoS6NouFltkqIyV+lAryzhRxQ0Uh6tU7+obaR9nuBITSj5y3MPEdCecLGc7/D2VlpE
         C3Z4ZD+qfSbbanI8pPaFbDTMrSTXoiJGWoXTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HuyVsSMV1aQwyV3j6toXzGhoibHAp15bMSPIrl5X/iQ=;
        b=NWclNz15vXOWhaHmZsnkM7rqJzhsuRg9Br6DMyW4FK3y/TVkXHpQlzRD4rHlVWwkp/
         fEVzuhKu210hfUw8jwr1kbjbKAVY/N5+L8FgKbEjoRf1xLfoXw73Nvg1dqgdSGxWpuHY
         xJ05mpK+8DQYzuLVpClqHvfTwZyWYnz/bExkTgR4ZMPul5fnUUqnhRZK9rTl/dkg6WFj
         SKYOZPn2B5g2e7/UjIhdmgR6ALqJPP2IHnjBKKD4TU6h6pg6/C/rVvKcoi72RyrA1wM9
         zlkG2qUe40vWVS1nXcInQZlWxhIY5C8IXmTUI2r0PT6SSl5MInd9irSNyfJt8oqHq6C8
         qu1A==
X-Gm-Message-State: AO0yUKXWmskC09NsugYx4KQBYS4BKm6O7cnduWkZ9se7VHvo0XgxrAcX
        3sVvmH6Ap3R1tHVIRT6QvKVH6rNx/qfxIG4kzzpm1Q==
X-Google-Smtp-Source: AK7set/ouNligxe7/BceEKZ3iqgAgATXe+6gHnQD9Jx1q+jiw39aWDBDBvb0I7nDvH3TWpIMEhRlwmW+FZLADcRqReg=
X-Received: by 2002:a17:90a:6986:b0:22c:71ed:629d with SMTP id
 s6-20020a17090a698600b0022c71ed629dmr716540pjj.10.1675359135127; Thu, 02 Feb
 2023 09:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20230201163420.1579014-1-revest@chromium.org> <85af713d-00fe-b113-1331-1a44480c016f@huawei.com>
 <eacfbd23-da92-3572-7f57-3de425117c8a@iogearbox.net>
In-Reply-To: <eacfbd23-da92-3572-7f57-3de425117c8a@iogearbox.net>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 2 Feb 2023 18:32:04 +0100
Message-ID: <CABRcYmK8AP7_aL_NqJfNYgGzzpDp2x33qdzOkDxbUECxj2F-RQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add ftrace direct call for arm64
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Xu Kuohai <xukuohai@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, Manu Bretelle <chantra@meta.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 11:50 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 2/2/23 9:36 AM, Xu Kuohai wrote:
> > On 2/2/2023 12:34 AM, Florent Revest wrote:
> >> This series adds ftrace direct call support to arm64.
> >> This makes BPF tracing programs (fentry/fexit/fmod_ret/lsm) work on arm64.
> >>
> >> It is meant to apply on top of the arm64 tree which contains Mark Rutland's
> >> series on CALL_OPS [1] under the for-next/ftrace tag.
> >> > The first three patches consolidate the two existing ftrace APIs for registering
> >> direct calls. They are split to make the reviewers lives easier but if it'd be a
> >> preferred style, I'd be happy to squash them in the next revision.
> >> Currently, there is both a _ftrace_direct and _ftrace_direct_multi API. Apart
> >> from samples and selftests, there are no users of the _ftrace_direct API left
> >> in-tree so this deletes it and renames the _ftrace_direct_multi API to
> >> _ftrace_direct for simplicity.
> >>
> >> The main benefit of this refactoring is that, with the API that's left, an
> >> ftrace_ops backing a direct call will only ever point to one direct call. We can
> >> therefore store the direct called trampoline address in the ops (patch 4) and
> >> look it up from the ftrace trampoline on arm64 (patch 7) in the case when the
> >> destination would be out of reach of a BL instruction at the ftrace callsite.
> >> (in this case, ftrace_caller acts as a lightweight intermediary trampoline)
> >>
> >> This series has been tested on both arm64 and x86_64 with:
> >> 1- CONFIG_FTRACE_SELFTEST (cf: patch 6)
> >> 2- samples/ftrace/*.ko (cf: patch 8)
> >> 3- tools/testing/selftests/bpf/test_progs (both -t lsm and -t fentry_fexit)
>
> Thanks a ton for working on this!
>
> > so it's time to update DENYLIST.aarch64 to unblock tests that failed due to lack of direct call.

That's a good point Xu, thanks! I'll update the deny list in my next revision.
It looks like this series fixes *a lot* of these tests, so that's exciting. :)

> +1, with regards to logistics, if possible it might be nice to eventually gets
> this into a feature branch on arm64 tree, then we could pull it too from there
> for bpf-next and hash out the BPF CI bits for arm64 in the meantime.

I believe that Manu Bretelle already wired up the BPF CI for arm64, is
there more work required ?
Regarding the logistics, whatever works sgtm... :) I suppose it's up
to Catalin or Will.
