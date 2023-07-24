Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54DCC001B0
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 24 Jul 2023 16:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjGXQ5U (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGXQ5R (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:57:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67858102
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690217753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=siuJb/Gx947W7g0WBvc54XC4RizX/HWWBL9wwR+/gxc=;
        b=P+z2qxXXHo746Udox0N6N/0VqbOqgeRLx5rwu696WkdSi6xSa28ZYURqajkIl/0o+8Kezz
        kg21Xaw7a+uqMcgh/5Bl7pzUnAO/srmm4eE6O5Uy5hi3DN4Xx3BaCm5wdmlBdEz4Ymd6zE
        rkJxtsGqur+zsu3QybvdoomRs+H4OuU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-8tzHDQEVO1GKYlqEm8b35g-1; Mon, 24 Jul 2023 12:55:49 -0400
X-MC-Unique: 8tzHDQEVO1GKYlqEm8b35g-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fdde274729so3672500e87.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690217748; x=1690822548;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+i0Z9WjluIMP5uW/WBHzltLXbYemxnhhH7IUl23Qdow=;
        b=S/TJdo00kiKpxGMCeTV+AhStXqZn+pTHQKUt62BkU5AxCGe5fObvKipQ/NLYHFFn/A
         r4WvrmCoSn1fHdcNnD2UI5urAwOFe4+uqF0Ye9ZeLGoAnctkD7QB2yStxcvhUYfY9bxd
         iXCKGzOAtWFxn9derbhLBlyF+XeMBDpFGYdVHblMLbOzQ9yCED6ThhNQ6yRllS4uoaAs
         APPAUuVqkoQWXm86gqNB2ZPGNBRqfm8A8Gpys7ouze3wCL6ryrnGJtMJUM2wteJFolNM
         T9JNhvNUhR3LYVBM7GrLzZ+EQhq61PdCt/okhCrj+mvepyJ5bGHrY13iNtPMh1ZEnZOM
         YW6Q==
X-Gm-Message-State: ABy/qLa7Fv46CDL4xz5cKR9S88ytC6vEG4ciqtroDQyOCHkmgG/je5aa
        U5yXJsGnCZtO4mhbPlj/7EZN2IGcNqPuUCRVAPKiMhlZV9e/Q+DnVHJ49GbmwWam0+9PsHvLom1
        C7QNwS9tGviWAnNiKlrS2qaZ1fPKXWEdS
X-Received: by 2002:ac2:5dee:0:b0:4fb:99c6:8533 with SMTP id z14-20020ac25dee000000b004fb99c68533mr5480452lfq.33.1690217747934;
        Mon, 24 Jul 2023 09:55:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlESyHT5vseo1Fe9EOmjjndUHiTWba8Rkai6N/Uo2tJlbGYCmmO/8/5WknEFctQ/nYDYCoWt/g==
X-Received: by 2002:ac2:5dee:0:b0:4fb:99c6:8533 with SMTP id z14-20020ac25dee000000b004fb99c68533mr5480427lfq.33.1690217747520;
        Mon, 24 Jul 2023 09:55:47 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id o25-20020a1c7519000000b003fbaade0735sm13965691wmc.19.2023.07.24.09.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 09:55:47 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Dan Carpenter <error27@gmail.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 15/20] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <ZL6QI4mV-NKlh4Ox@localhost.localdomain>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-16-vschneid@redhat.com>
 <ZL6QI4mV-NKlh4Ox@localhost.localdomain>
Date:   Mon, 24 Jul 2023 17:55:44 +0100
Message-ID: <xhsmh351dtfjj.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 24/07/23 16:52, Frederic Weisbecker wrote:
> Le Thu, Jul 20, 2023 at 05:30:51PM +0100, Valentin Schneider a =C3=A9crit=
 :
>> +enum ctx_state {
>> +=09/* Following are values */
>> +=09CONTEXT_DISABLED=09=3D -1,=09/* returned by ct_state() if unknown */
>> +=09CONTEXT_KERNEL=09=09=3D 0,
>> +=09CONTEXT_IDLE=09=09=3D 1,
>> +=09CONTEXT_USER=09=09=3D 2,
>> +=09CONTEXT_GUEST=09=09=3D 3,
>> +=09CONTEXT_MAX             =3D 4,
>> +};
>> +
>> +/*
>> + * We cram three different things within the same atomic variable:
>> + *
>> + *                CONTEXT_STATE_END                        RCU_DYNTICKS=
_END
>> + *                         |       CONTEXT_WORK_END                |
>> + *                         |               |                       |
>> + *                         v               v                       v
>> + *         [ context_state ][ context work ][ RCU dynticks counter ]
>> + *         ^                ^               ^
>> + *         |                |               |
>> + *         |        CONTEXT_WORK_START      |
>> + * CONTEXT_STATE_START              RCU_DYNTICKS_START
>
> Should the layout be displayed in reverse? Well at least I always picture
> bitmaps in reverse, that's probably due to the direction of the shift arr=
ows.
> Not sure what is the usual way to picture it though...
>

Surprisingly, I managed to confuse myself with that comment :-)  I think I
am subconsciously more used to the reverse as well. I've flipped that and
put "MSB" / "LSB" at either end.

>> + */
>> +
>> +#define CT_STATE_SIZE (sizeof(((struct context_tracking *)0)->state) * =
BITS_PER_BYTE)
>> +
>> +#define CONTEXT_STATE_START 0
>> +#define CONTEXT_STATE_END   (bits_per(CONTEXT_MAX - 1) - 1)
>
> Since you have non overlapping *_START symbols, perhaps the *_END
> are superfluous?
>

They're only really there to tidy up the GENMASK() further down - it keeps
the range and index definitions in one hunk. I tried defining that directly
within the GENMASK() themselves but it got too ugly IMO.

>> +
>> +#define RCU_DYNTICKS_BITS  (IS_ENABLED(CONFIG_CONTEXT_TRACKING_WORK) ? =
16 : 31)
>> +#define RCU_DYNTICKS_START (CT_STATE_SIZE - RCU_DYNTICKS_BITS)
>> +#define RCU_DYNTICKS_END   (CT_STATE_SIZE - 1)
>> +#define RCU_DYNTICKS_IDX   BIT(RCU_DYNTICKS_START)
>
> Might be the right time to standardize and fix our naming:
>
> CT_STATE_START,
> CT_STATE_KERNEL,
> CT_STATE_USER,
> ...
> CT_WORK_START,
> CT_WORK_*,
> ...
> CT_RCU_DYNTICKS_START,
> CT_RCU_DYNTICKS_IDX
>

Heh, I have actually already done this for v3, though I hadn't touched the
RCU_DYNTICKS* family. I'll fold that in.

>> +bool ct_set_cpu_work(unsigned int cpu, unsigned int work)
>> +{
>> +=09struct context_tracking *ct =3D per_cpu_ptr(&context_tracking, cpu);
>> +=09unsigned int old;
>> +=09bool ret =3D false;
>> +
>> +=09preempt_disable();
>> +
>> +=09old =3D atomic_read(&ct->state);
>> +=09/*
>> +=09 * Try setting the work until either
>> +=09 * - the target CPU no longer accepts any more deferred work
>> +=09 * - the work has been set
>> +=09 *
>> +=09 * NOTE: CONTEXT_GUEST intersects with CONTEXT_USER and CONTEXT_IDLE
>> +=09 * as they are regular integers rather than bits, but that doesn't
>> +=09 * matter here: if any of the context state bit is set, the CPU isn'=
t
>> +=09 * in kernel context.
>> +=09 */
>> +=09while ((old & (CONTEXT_GUEST | CONTEXT_USER | CONTEXT_IDLE)) && !ret=
)
>
> That may still miss a recent entry to userspace due to the first plain re=
ad, ending
> with an undesired interrupt.
>
> You need at least one cmpxchg. Well, of course that stays racy by nature =
because
> between the cmpxchg() returning CONTEXT_KERNEL and the actual IPI raised =
and
> received, the remote CPU may have gone to userspace already. But still it=
 limits
> a little the window.
>

I can make that a 'do {} while ()' instead to force at least one execution
of the cmpxchg().

This is only about reducing the race window, right? If we're executing this
just as the target CPU is about to enter userspace, we're going to be in
racy territory anyway. Regardless, I'm happy to do that change.

