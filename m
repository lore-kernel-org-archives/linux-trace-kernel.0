Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1E1C05027
	for <linux-trace-kernel@archiver.kernel.org>; Mon,  6 Feb 2023 16:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjBFQZl (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 6 Feb 2023 11:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjBFQZk (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:25:40 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11911F480
        for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:25:39 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 78so8546578pgb.8
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Feb 2023 08:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kFQxaP144S9AVJ5XJTXyEhWUpy1ufPfXJtGU2agH1J0=;
        b=ipHxCMjhGQl12luICsGCj+oY1Y6BRiVxfo1c4DBrKjyhbmY1Z5sGl55irNZjIBh3la
         Eu4qQV1MSbXUarEwlGjFdzb7oLKQu4hzSXyPjWwkhX0Y1MjTPj3inOBxUvXsfVgwFDJw
         tEvFLoIleDZ2ScYG8AxEMgzse7itQDeEAIl4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFQxaP144S9AVJ5XJTXyEhWUpy1ufPfXJtGU2agH1J0=;
        b=vvB4Hb/VYiygpXCjmT4A7Nyh8kDdts/klGarCR2nBXPA2hj2EyKvE4/TBomOggXn6e
         6d09Fwc+Sj4o5zSlWG3li3C9Fr9kEqVDbFZX7q/xcF6c0JKLZrT/5JyxZ0nlm0zdwdF5
         70/yMvTVEA19sHu0htOWM9L11U3OKRlBgH/iKIGZ0P2RbEcX+mqvWgY7kEW6OPnGk1go
         7WfBhMKXbmEQOvb3OHjgnVnisX/i5Gq7SkCtbfG2dTjAjtOlTXnrhcECtwHLkmthI4zM
         hEotlB4dlGpuTOde2VVp2xh/KPNqDXRVDBBAWQORxciN46RGDkQkxKExJXUwi2OF4jFl
         P40Q==
X-Gm-Message-State: AO0yUKV3JATBCNqAQl7L1/kU+eBd7OWEq/IjCvO92Murarp8oSIYhG/7
        Gelb2C4D68iZA21jdkPgzZiVvIWGM8DApFvdi04Yyw==
X-Google-Smtp-Source: AK7set+coOXre5Bf+rKkNBx/EUFNbeN32jSTpfQbb6BUdHV0Na+yutvq8fVnnBYQ3nokoBmkHBrR+Obe+cEnNzLdptM=
X-Received: by 2002:a62:3808:0:b0:5a6:5841:6570 with SMTP id
 f8-20020a623808000000b005a658416570mr270391pfa.51.1675700739133; Mon, 06 Feb
 2023 08:25:39 -0800 (PST)
MIME-Version: 1.0
References: <20230201163420.1579014-1-revest@chromium.org> <20230201163420.1579014-7-revest@chromium.org>
 <Y9wI93m2frDFGFez@FVFF77S0Q05N.cambridge.arm.com> <CABRcYmKRoDeFecvj7e+0SUaoinUa7FdtG1fmYqkRS3YPXVw4-w@mail.gmail.com>
 <Y90qS5jTog2m6YhQ@FVFF77S0Q05N>
In-Reply-To: <Y90qS5jTog2m6YhQ@FVFF77S0Q05N>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 6 Feb 2023 17:25:28 +0100
Message-ID: <CABRcYm+3U+Pb=fNt38_MsCS+vVGcN4cHhEv415yGJ4QHac6KFA@mail.gmail.com>
Subject: Re: [PATCH 6/8] ftrace: Fix dead loop caused by direct call in ftrace selftest
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, Xu Kuohai <xukuohai@huawei.com>,
        Li Huafei <lihuafei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 4:37 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Feb 03, 2023 at 01:35:00PM +0100, Florent Revest wrote:
> > On Thu, Feb 2, 2023 at 8:03 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > I think it'd be much better to do something like the below as a preparatory
> > > cleanup (tested on s390 under QEMU).
> >
> > Thanks, that looks great to me. I'll make it a part of the series in v2 then.
> > Unless it's preferred that this gets merged separately?
>
> I reckon put it in the series for v2, and if Steve or Masami want to pick it up
> beforehand, they can choose to do so from there?
>
> Since it's not currently exploding, I suspect it's not urgent.
>
> Mark.

Ack
