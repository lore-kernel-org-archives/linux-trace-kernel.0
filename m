Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC712C001DC
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 31 Jul 2023 17:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjGaRWH (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 31 Jul 2023 13:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjGaRVu (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B7C1BE8
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690824062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n5ngqZBDf0cyFOLr/EV9FYkGhOEjZk258ZtGJgwKwNc=;
        b=h6A+vpnZFCGjhKUPtElFri3jfAIAScSxK3BmnlqM9CVa763NaPv/yWG4N1Z1AaEJGsaSJJ
        bZW2kn/8ihoRVdWIbVeqHKb0V7K8imbA0r957iJwPKAfGuqC9Fya1HusnNxu0ifROaOEUC
        ZzopbwlD8wHwd7MbpGmhTVazOZ50a28=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-ntvZ7FjfORe0Ia3FhLToTA-1; Mon, 31 Jul 2023 13:21:01 -0400
X-MC-Unique: ntvZ7FjfORe0Ia3FhLToTA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-57320c10635so57097347b3.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690824060; x=1691428860;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NfShcrH5vNeU09yfaTlylFugR/gu1+MgjXGX+9Q5ac=;
        b=cUVLEImCB/ikif5eo89pUs7V6Q0aLOvAogkM4sCMa+KIbuWsTif3JMgD+dB9Iwe6Ow
         BJTh4QSNslckNyet/M9Ess7ycOHSQeOesEjPPLwUdc1M21MqF1MQ/2s06Htlhd/h+ReR
         Mw894zVmB2P3qd87I34ep3isIVuUO08S7qKIssb6wD9kJ7gur6bO+0ql8tsJlLIs1+9h
         TVQ6eWZvDq1nvRwpWNQJlWxH8GUIgYvW8BlLa+Fj0bSeWdoQCWk9iGDdM8xBJezChl+o
         zlSOxSCSoloWe/VKiHxRkY6o/zDYxbFDIoKhTpNV0DwO8WFk97UMEk3wXA5W3fWA+UY5
         81RQ==
X-Gm-Message-State: ABy/qLapw4Wzcf70P8j5VlfKF35mTVTr1B/H8QuObqBtAA2TqPHV+9ny
        mkRqDXeiEDpRXBA6XdgijFx/lTwa9BC5xvHFqt6y3JYBkFsEvHHGPJxjGScdBemHWCpST7YFtl2
        qU8NNjzELS5FwlMUCek8RZAcbk545uoE5
X-Received: by 2002:a81:c24f:0:b0:583:4304:75a4 with SMTP id t15-20020a81c24f000000b00583430475a4mr10696707ywg.29.1690824060501;
        Mon, 31 Jul 2023 10:21:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFbVJszIfUaYg4Uc4+wm7XQPO4r+bpFj464rdlreCyyKuJOaZIruagzYqntofPsjWen070/Bg==
X-Received: by 2002:a81:c24f:0:b0:583:4304:75a4 with SMTP id t15-20020a81c24f000000b00583430475a4mr10696647ywg.29.1690824059920;
        Mon, 31 Jul 2023 10:20:59 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id 10-20020ac8208a000000b00401f7f23ab6sm3744764qtd.85.2023.07.31.10.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:20:59 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
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
        Frederic Weisbecker <frederic@kernel.org>,
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
Subject: Re: [RFC PATCH v2 06/20] tracing/filters: Optimise scalar vs
 cpumask filtering when the user mask is a single CPU
In-Reply-To: <b7cf996a-f443-402c-8e13-c5f25a964184@kadam.mountain>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-7-vschneid@redhat.com>
 <20230729155547.35719a1f@rorschach.local.home>
 <04f20e58-6b24-4f44-94e2-0d12324a30e4@kadam.mountain>
 <20230731115453.395d20c6@gandalf.local.home>
 <b7cf996a-f443-402c-8e13-c5f25a964184@kadam.mountain>
Date:   Mon, 31 Jul 2023 18:20:49 +0100
Message-ID: <xhsmhy1iwq9ou.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 31/07/23 19:03, Dan Carpenter wrote:
> On Mon, Jul 31, 2023 at 11:54:53AM -0400, Steven Rostedt wrote:
>> On Mon, 31 Jul 2023 15:07:52 +0300
>> Dan Carpenter <dan.carpenter@linaro.org> wrote:
>>
>> > On Sat, Jul 29, 2023 at 03:55:47PM -0400, Steven Rostedt wrote:
>> > > > @@ -1761,6 +1761,11 @@ static int parse_pred(const char *str, void=
 *data,
>> > > >                                FILTER_PRED_FN_CPUMASK;
>> > > >                } else if (field->filter_type =3D=3D FILTER_CPU) {
>> > > >                        pred->fn_num =3D FILTER_PRED_FN_CPU_CPUMASK=
;
>> > > > +=09=09} else if (single) {
>> > > > +=09=09=09pred->op =3D pred->op =3D=3D OP_BAND ? OP_EQ : pred->op;
>> > >
>> > > Nit, the above can be written as:
>> > >
>> > >                  pred->op =3D pret->op !=3D OP_BAND ? : OP_EQ;
>> > >
>> >
>> > Heh.  Those are not equivalent.  The right way to write this is:
>>
>> You mean because of my typo?
>
> No, I hadn't seen the s/pred/pret/ typo.  Your code does:
>
>       if (pred->op !=3D OP_BAND)
>               pred->op =3D true;
>       else
>               pred->op OP_EQ;
>
> Realy we should probably trigger a static checker warning any time
> someone does a compare operations as part of a "x =3D comparison ?: bar;
> Years ago, someone asked me to do that with regards to error codes like:
>
>       return ret < 0 ?: -EINVAL;
>
> but I don't remember the results.
>

FWIW this is caught by GCC:

     error: the omitted middle operand in ?: will always be =E2=80=98true=
=E2=80=99, suggest explicit middle operand [-Werror=3Dparentheses]
     pred->op =3D pred->op !=3D OP_BAND ? : OP_EQ;


> regards,
> dan carpenter

