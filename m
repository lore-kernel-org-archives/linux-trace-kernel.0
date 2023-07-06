Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0926EB64DC
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  6 Jul 2023 11:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjGFLbm (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 6 Jul 2023 07:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjGFLbl (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7341992
        for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688643056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GGfRdlkJ3HdO+/y60WijuGvRZhKQFtZj0a8vHJ3Z9W0=;
        b=ATMJjYqDbZFHtF05sCAq+I/33cVJn96JXRnkYDLVs89PLEmmBuJ33P3O9Mi6Wc5boA4udM
        qrBJnCRfCGygWAxlx36nO0noXqPBdf4YeGbGcBLONtkiiLjwxxdH7Nwp+Gyuht7QJxdv+6
        J/5YQn5DJzRtBMAomr6fLErkUMuXZus=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-Y0g_eGlrO0CM1MdmFRKTWQ-1; Thu, 06 Jul 2023 07:30:53 -0400
X-MC-Unique: Y0g_eGlrO0CM1MdmFRKTWQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635e0889cc5so8318136d6.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Jul 2023 04:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688643053; x=1691235053;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RinQDlUt4K38HkHxLwhOYs8pH7N2WJkW7Jmb1TL6X3c=;
        b=OjKsmPdFJ5ydVbzj6b2yBrFQA1XJy4QEHRtNRupCRce/AVEY5vAVVfXXmwnK7c16ip
         z7on1XKZx0CIEwNS81ixz6Yb4Au3dDBU0fl9/gdUowcDhZXkYpiCMHa1IWv7wG0rUMQ2
         ybPAr0azbINOnj8/8amWratj75ZeGH7nVm5berEt5zdbEoUgVHbf4wrraiaF3k5o7+XO
         kbeKUDuXHmGjKWZhGC+Up+lleOb2iVqsCXyAq4J+suk07mbjxJREMFxXQnYh89fTw6pB
         wqdWKyCihra9UjhCiHFvBsuZIFrl79LJ/BpfkKCMkRtohlPf+pqwiCCTH2xPYCbYViPp
         HZDQ==
X-Gm-Message-State: ABy/qLa7LkHdwRCqKgS7Xgz1jKg+H3qTsAH5QkkM/iXvVSMhYLREnG/Z
        +8sSpx/8sphMlJ2XUmzC2pukOj3HbT8klm7Awwyb2uk/86Qdo3MT1UCJkFDSxIqjce7tSYXeGuH
        3JJQpbJhSqiBhZDWKYNTcK6YOid3ONbRn
X-Received: by 2002:a0c:f549:0:b0:62f:effe:3dca with SMTP id p9-20020a0cf549000000b0062feffe3dcamr1420092qvm.2.1688643053023;
        Thu, 06 Jul 2023 04:30:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEbUYOJppwMgQvsEvMakiRmaJatTD8CbvHxxx1dIrR+0X5zWXHf8RNpRxDwVdgtv2CCKKsXFA==
X-Received: by 2002:a0c:f549:0:b0:62f:effe:3dca with SMTP id p9-20020a0cf549000000b0062feffe3dcamr1420051qvm.2.1688643052762;
        Thu, 06 Jul 2023 04:30:52 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id a12-20020a0ce38c000000b0062de6537febsm769879qvl.58.2023.07.06.04.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 04:30:52 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
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
Subject: Re: [RFC PATCH 11/14] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <ZKXtfWZiM66dK5xC@localhost.localdomain>
References: <20230705181256.3539027-1-vschneid@redhat.com>
 <20230705181256.3539027-12-vschneid@redhat.com>
 <ZKXtfWZiM66dK5xC@localhost.localdomain>
Date:   Thu, 06 Jul 2023 12:30:46 +0100
Message-ID: <xhsmhttuhuvix.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 06/07/23 00:23, Frederic Weisbecker wrote:
> Le Wed, Jul 05, 2023 at 07:12:53PM +0100, Valentin Schneider a =C3=A9crit=
 :
>> +bool ct_set_cpu_work(unsigned int cpu, unsigned int work)
>> +{
>> +=09struct context_tracking *ct =3D per_cpu_ptr(&context_tracking, cpu);
>> +=09unsigned int old_work;
>> +=09bool ret =3D false;
>> +
>> +=09preempt_disable();
>> +
>> +=09old_work =3D atomic_read(&ct->work);
>> +=09/*
>> +=09 * Try setting the work until either
>> +=09 * - the target CPU no longer accepts any more deferred work
>> +=09 * - the work has been set
>> +=09 */
>> +=09while (!(old_work & CONTEXT_WORK_DISABLED) && !ret)
>
> Isn't there a race here where you may have missed a CPU that just entered=
 in
> user and you eventually disturb it?
>

Yes, unfortunately.

>> +=09=09ret =3D atomic_try_cmpxchg(&ct->work, &old_work, old_work | work)=
;
>> +
>> +=09preempt_enable();
>> +=09return ret;
>> +}
> [...]
>> @@ -100,14 +158,19 @@ static noinstr void ct_kernel_exit_state(int offse=
t)
>>   */
>>  static noinstr void ct_kernel_enter_state(int offset)
>>  {
>> +=09struct context_tracking *ct =3D this_cpu_ptr(&context_tracking);
>>      int seq;
>> +=09unsigned int work;
>>
>> +=09work =3D ct_work_fetch(ct);
>
> So this adds another fully ordered operation on user <-> kernel transitio=
n.
> How many such IPIs can we expect?
>

Despite having spent quite a lot of time on that question, I think I still
only have a hunch.

Poking around RHEL systems, I'd say 99% of the problematic IPIs are
instruction patching and TLB flushes.

Staring at the code, there's quite a lot of smp_calls for which it's hard
to say whether the target CPUs can actually be isolated or not (e.g. the
CPU comes from a cpumask shoved in a struct that was built using data from
another struct of uncertain origins), but then again some of them don't
need to hook into context_tracking.

Long story short: I /think/ we can consider that number to be fairly small,
but there could be more lurking in the shadows.

> If this is just about a dozen, can we stuff them in the state like in the
> following? We can potentially add more of them especially on 64 bits we c=
ould
> afford 30 different works, this is just shrinking the RCU extended quiesc=
ent
> state counter space. Worst case that can happen is that RCU misses 65535
> idle/user <-> kernel transitions and delays a grace period...
>

I'm trying to grok how this impacts RCU, IIUC most of RCU mostly cares abou=
t the
even/odd-ness of the thing, and rcu_gp_fqs() cares about the actual value
but only to check if it has changed over time (rcu_dynticks_in_eqs_since()
only does a !=3D).

I'm rephrasing here to make sure I get it - is it then that the worst case
here is 2^(dynticks_counter_size) transitions happen between saving the
dynticks snapshot and checking it again, so RCU waits some more?

