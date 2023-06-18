Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2CFEB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Sun, 18 Jun 2023 20:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjFRULv (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sun, 18 Jun 2023 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRULt (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:11:49 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8039E4C
        for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Jun 2023 13:11:48 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so115361cf.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Jun 2023 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687119108; x=1689711108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpfISiVhGBFvYu3AQzytJ9eyp0qWbNPzT0F/TqGcEF0=;
        b=BI4IVSXI0OmI7HSHsHlrapOhxlYQr88irtqXtejFQDdwi0ENBjBoT+XLb8GlVX5ye2
         2RKZIVa3SgmrzIbhLz9gPTVxEaHp2aLuGzJABn2V8qcyj1r5n7W74CILO0agM4yRBdqp
         1RaptWkZvNHDOFx+VjmcCLiDP8C+KTiX8SbGmrEKzvHmrSeItS1P0Xmdw5h0oqtFiDy4
         AOhW0Kb490uZt+xyTNM54SZyWZrBQ/OOSALJEaw5URHLWQ5/4/9LTWbU9KUB5nzr8SkC
         EiNHGrA/DNhBI3N/ps22/XwwMptyPwh1WFUc37QSRtqZWWbsx8o8/qqFNZmnqhSquaII
         BNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687119108; x=1689711108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpfISiVhGBFvYu3AQzytJ9eyp0qWbNPzT0F/TqGcEF0=;
        b=mBeCOdc00sbHTUqYHO3vqw4koj8qRlD86R8Fp/ZcR2ia2uzMw37eP8YLevSr0JISsn
         QvoyLABTCPKZcvjRwRr1HW9OISSpx6kfKFLvUUmwa/FUCCW19u3kXZ+sm28Nucw5/HYk
         kP38CMxg/DcSkO1qXGf04nzNq98svfQ0NC5SKMoRkmgcswYM2NoDazH13cZsMdB3JL7J
         gW0KJDzrLjRizbcHZkk3YPpUiIxuFCACQX+zYlugZGe27KmIKDCT++yV8fKk5BZCxvU+
         NneJuu0f4iLeRHuYltTXSg6yPPvLTWUpwmNNfXLekREJ/YiB2oF/k3cHgRSRRaD/kIsS
         mrew==
X-Gm-Message-State: AC+VfDyCWW2FX8fky99/+EdhN5Q4nZp61ruHMFE7bwjbxGnAdmzDLv2z
        Wg1aUNDAT9CJXazTPJHAflOr09ri+6v64nZnKs3bXw==
X-Google-Smtp-Source: ACHHUZ7+FzP5AfTCxoLANN0O1kovXzprxLRO2NDRfP+79+jkGgGwKBzMX+UybO5p4uMqphT40cGSU06Ta5mNNZ2MZbY=
X-Received: by 2002:a05:622a:85:b0:3f8:5b2:aeed with SMTP id
 o5-20020a05622a008500b003f805b2aeedmr773688qtw.21.1687119107794; Sun, 18 Jun
 2023 13:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230526234435.662652-1-yuzhao@google.com> <20230609005935.42390-1-yuzhao@google.com>
 <873530okh0.wl-maz@kernel.org>
In-Reply-To: <873530okh0.wl-maz@kernel.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 18 Jun 2023 14:11:11 -0600
Message-ID: <CAOUHufaWbWZ-q-PUJnjXD_jDk1s34mcg4vHU8CtAtmeAT-deRA@mail.gmail.com>
Subject: Re: kvm/arm64: Spark benchmark
To:     Marc Zyngier <maz@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Anup Patel <anup@brainfault.org>,
        Ben Gardon <bgardon@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Gavin Shan <gshan@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Larabel <michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paul Mackerras <paulus@ozlabs.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Huth <thuth@redhat.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-trace-kernel@vger.kernel.org, x86@kernel.org,
        linux-mm@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 7:04=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 09 Jun 2023 01:59:35 +0100,
> Yu Zhao <yuzhao@google.com> wrote:
> >
> > TLDR
> > =3D=3D=3D=3D
> > Apache Spark spent 12% less time sorting four billion random integers t=
wenty times (in ~4 hours) after this patchset [1].
>
> Why are the 3 architectures you have considered being evaluated with 3
> different benchmarks?

I was hoping people having special interests in different archs might
try to reproduce the benchmarks that I didn't report (but did cover)
and see what happens.

> I am not suspecting you to have cherry-picked
> the best results

I'm generally very conservative when reporting *synthetic* results.
For example, the same memcached benchmark used on powerpc yielded >50%
improvement on aarch64, because the default Ubuntu Kconfig uses 64KB
base page size for powerpc but 4KB for aarch64. (Before the series,
the reclaim (swap) path takes kvm->mmu_lock for *write* on O(nr of all
pages to consider); after the series, it becomes O(actual nr of pages
to swap), which is <10% given how the benchmark was set up.)

          Ops/sec  Avg. Latency  p50 Latency  p99 Latency  p99.9 Latency
------------------------------------------------------------------------
Before  639511.40       0.09940      0.04700      0.27100       22.52700
After   974184.60       0.06471      0.04700      0.15900        3.75900

> but I'd really like to see a variety of benchmarks
> that exercise this stuff differently.

I'd be happy to try other synthetic workloads that people think that
are relatively representative. Also, I've backported the series and
started an A/B experiment involving ~1 million devices (real-world
workloads). We should have the preliminary results by the time I post
the next version.
