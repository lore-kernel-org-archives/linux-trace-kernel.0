Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42094C77B7A
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 31 May 2023 23:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjEaXmX (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 31 May 2023 19:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEaXmW (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 31 May 2023 19:42:22 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82EE12C
        for <linux-trace-kernel@vger.kernel.org>; Wed, 31 May 2023 16:42:20 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f6c6320d4eso42661cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 31 May 2023 16:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685576540; x=1688168540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDpz4krIKrc5w7qSPtF5SBqUynCIQ+thylT8XbaHGrk=;
        b=WNm7FPyfhTPx3ZGuMrBHq00CD2pUQeKGlcUX8mQgn+G5dCO9p4/NX7woMudP9DApXP
         eMJLs5SBR4fdqa3yCschb/mCpUzrZdTzCQk17xPxaPcyNXmO0GRLdFy3gHbSHxXHPTIP
         /ozEJCi5UQdQkb2Q3mM6Zqe3S8JqvimfuEEiV/OCiDq8WYg8q9tsb/A8n35UOySEMRSe
         cP+xGSCeNhL+QPzuxby2Y4g4uZHxNXxQLSBGnHEXmI9NR/ErERIcrgGmxuzljhndSanB
         WP4UQiQL4UinzVp+2JgQHC1IybU3nDhwSEzellmsm7CBhp4CdyqxMsCJACyJb3WM+PYH
         0PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685576540; x=1688168540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDpz4krIKrc5w7qSPtF5SBqUynCIQ+thylT8XbaHGrk=;
        b=fspEU9DU4/emdYdGYHOH5jx+1zorky6yW5gJ5h5OZfnrUTh3h7ALesU/1DTXbNTr4F
         0hkar75UzMfeUryxUjKx87MfUd+iGFOMeNIooZa4kdI7lB5IESVz8CoN3TJI4kWEmlBF
         LGDGGrGCHiqD2tLwX1Vg5OWfq10Dw59iKadAcB6XWnVVOmArCkl9da1FfnpEJW7Pmv28
         rir/e6X1iRGw6zuRQ92LjVZf3tuHSIKSCYaImgV7hwkCN5Get3FQTcHfV2dSAbtw2dia
         zZaanrEAaaTIH1l7xCQLzxfMg9/5Z8axo4VkIkECijikt6FObggWG0CzcY+k8PODuOuG
         T8tA==
X-Gm-Message-State: AC+VfDwP3jorALs3/A2EYSS1hkO+L0PULox8n5Yx1C9Vg6zGc6qm5dXd
        QaV2Fuc3/57nRlpgCEoiUfLGzRxJGPCHIdKQAnPa1A==
X-Google-Smtp-Source: ACHHUZ5sABagGYjruKN8zRy0nDodbSiJxufLAv2SN+7MEBixn3XZ6Uymw2VwUSkM1BtzAJXGzFSFspv6fmhfCqrF5xc=
X-Received: by 2002:ac8:7f02:0:b0:3f6:97b4:1a53 with SMTP id
 f2-20020ac87f02000000b003f697b41a53mr30800qtk.29.1685576539790; Wed, 31 May
 2023 16:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230526234435.662652-1-yuzhao@google.com> <20230526234435.662652-5-yuzhao@google.com>
 <ZHJHJPBF6euzOFdw@linux.dev> <CAOUHufa74CufHziHSquO5bZwbFXz2MNssBzW+AH7=Xo5RCnQ0A@mail.gmail.com>
 <ZHZQdQAApIrw6fBu@linux.dev> <CAOUHufZOkBmZJgCU2xW2B8S3P3TWERHezy0xKWY9_TeyV9K7Rg@mail.gmail.com>
 <ZHef0VsZvZ1Vnz0u@linux.dev> <CAOUHufZrfnfcbrqSzmHkejR5MA2gmGKZ3LMRhbLHV+1427z=Tw@mail.gmail.com>
 <ZHfWzX04GlcNngdU@linux.dev>
In-Reply-To: <ZHfWzX04GlcNngdU@linux.dev>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 31 May 2023 17:41:43 -0600
Message-ID: <CAOUHufa9X4eXkvG+=xgm4AxrtvUKSZhjSRDtnskhVrVA2w2BkQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2 04/10] kvm/arm64: make stage2 page tables
 RCU safe
To:     Oliver Upton <oliver.upton@linux.dev>
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
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Larabel <michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
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

On Wed, May 31, 2023 at 5:23=E2=80=AFPM Oliver Upton <oliver.upton@linux.de=
v> wrote:
>
> On Wed, May 31, 2023 at 05:10:52PM -0600, Yu Zhao wrote:
> > On Wed, May 31, 2023 at 1:28=E2=80=AFPM Oliver Upton <oliver.upton@linu=
x.dev> wrote:
> > > On Tue, May 30, 2023 at 02:06:55PM -0600, Yu Zhao wrote:
> > > > On Tue, May 30, 2023 at 1:37=E2=80=AFPM Oliver Upton <oliver.upton@=
linux.dev> wrote:
> > > > > As it is currently implemented, yes. But, there's potential to fa=
st-path
> > > > > the implementation by checking page_count() before starting the w=
alk.
> > > >
> > > > Do you mind posting another patch? I'd be happy to ack it, as well =
as
> > > > the one you suggested above.
> > >
> > > I'd rather not take such a patch independent of the test_clear_young
> > > series if you're OK with that. Do you mind implementing something
> > > similar to the above patch w/ the proposed optimization if you need i=
t?
> >
> > No worries. I can take the above together with the following, which
> > would form a new series with its own merits, since apparently you
> > think the !AF case is important.
>
> Sorry if my suggestion was unclear.
>
> I thought we were talking about ->free_removed_table() being called from
> the stage-2 unmap path

Yes, we were, or in general, about how to make KVM PTs RCU safe for ARM.

So I'm thinking about taking 1) your patch above, 2) what I just
suggested and 3) what you suggested below to form a mini series, which
could land indepently and would make my job here easier.

> in which case we wind up unnecessarily visiting
> PTEs on a table known to be empty. You could fast-path that by only
> initiating a walk if  page_count() > 1:

Yes, this is what I meant.

> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 95dae02ccc2e..766563dc465c 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -1331,7 +1331,8 @@ void kvm_pgtable_stage2_free_removed(struct kvm_pgt=
able_mm_ops *mm_ops, void *pg
>                 .end    =3D kvm_granule_size(level),
>         };
>
> -       WARN_ON(__kvm_pgtable_walk(&data, mm_ops, ptep, level + 1));
> +       if (mm_ops->page_count(pgtable) > 1)
> +               WARN_ON(__kvm_pgtable_walk(&data, mm_ops, ptep, level + 1=
));
>
>         WARN_ON(mm_ops->page_count(pgtable) !=3D 1);
>         mm_ops->put_page(pgtable);
>
>
> A lock-free access fault walker is interesting, but in my testing it hasn=
't
> led to any significant improvements over acquiring the MMU lock for
> read. Because of that I hadn't bothered with posting the series upstream.

It's hard to measure but we have perf benchmarks on ChromeOS which should h=
elp.
