Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CCEC41513
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 31 Jul 2023 11:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjGaLTp (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 31 Jul 2023 07:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjGaLTn (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AC8171A
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690802318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Feb3SbI628V0M+Xl6cXNHTwh1emqN1pCsroF1cMMhXw=;
        b=DkoSD4M4j0SVdH6bDKkPMS+u5i9MD6sz33fSdRvQpOqvOHdBV8g67wAGV4vgZI4xuMpaJC
        s3MoizijuMWMdxrAAv44NVx6/MBZqQX2hpNkiGqLw6aFGdg3KHmVrf0rhPkqBHYzr3TzLf
        uk2UUhd45t6JM0ZNxdyj40MED3JuSr4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-Mt-nzKkYNISK4WyBw2Pg4w-1; Mon, 31 Jul 2023 07:18:35 -0400
X-MC-Unique: Mt-nzKkYNISK4WyBw2Pg4w-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-406afc93066so39029801cf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690802315; x=1691407115;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Feb3SbI628V0M+Xl6cXNHTwh1emqN1pCsroF1cMMhXw=;
        b=TTRcGa8CNHGQN/OD/ZV/CsQz7Q44/OZrIF+g4bbxg+EmzEETocDAr/GS8iKrmpZolq
         aIsD2u3xZ1Hy0XXu1VAiQ7N1Zss/zJBlE21k9t6s26V4jROvhft/N5i7i1okuqD6pNFh
         htTwQ0GKA/nn76TnzfXklWApBtSYt1h62qH0I67cOt1jw+bDhVhzhUiEjosinw7JGBbo
         SIf97+nAo27dVL+PHE2+d3Lbk0EGe5At2pvuWCcofjekpeQyJ/xJa7hUiXaXq1taASOH
         LfgSK6TZlPWlQtJ5PC7nnD5KFSOSFqxc7XLaUN6d0sa9hy/SFmj6zYfB5r24b3zJf5nh
         t+pQ==
X-Gm-Message-State: ABy/qLaN/wykSsVebfV6Qo97I8hH9pd0qNfJYPQ8+gJoY+tWxwBqYGFQ
        shyDtgaL/q54O82XUa512CHfDsbupVOI3B4eZ3u8bjPx9w94gF5AoNZp+1h3wv2AnH0td9crAz+
        CYx501UrBOptaEDtGtTGJouW/rKFtEN6r
X-Received: by 2002:a05:622a:1806:b0:403:b23f:9e16 with SMTP id t6-20020a05622a180600b00403b23f9e16mr13377211qtc.2.1690802314883;
        Mon, 31 Jul 2023 04:18:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEehrZuAEoVbTnlaVgIfddlc4rg89Sd70WHq1FBXragdFZy0TviERBFx02bWZYfpI2p+8TwzA==
X-Received: by 2002:a05:622a:1806:b0:403:b23f:9e16 with SMTP id t6-20020a05622a180600b00403b23f9e16mr13377176qtc.2.1690802314653;
        Mon, 31 Jul 2023 04:18:34 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id e21-20020ac85995000000b003fde3d63d22sm3385798qte.69.2023.07.31.04.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:18:33 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Subject: Re: [RFC PATCH v2 12/20] objtool: Warn about non __ro_after_init
 static key usage in .noinstr
In-Reply-To: <20230728160247.multb2csnpa22fgx@treble>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-13-vschneid@redhat.com>
 <20230728160247.multb2csnpa22fgx@treble>
Date:   Mon, 31 Jul 2023 12:18:10 +0100
Message-ID: <xhsmh7cqgs51p.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 28/07/23 11:02, Josh Poimboeuf wrote:
> On Thu, Jul 20, 2023 at 05:30:48PM +0100, Valentin Schneider wrote:
>> Later commits will depend on having no runtime-mutable text in early entry
>> code. (ab)use the .noinstr section as a marker of early entry code and warn
>> about static keys used in it that can be flipped at runtime.
>
> Similar to my comment on patch 13, this could also use a short
> justification for adding the feature, i.e. why runtime-mutable text
> isn't going to be allowed in .noinstr.
>
> Also, please add a short description of the warning (and why it exists)
> to tools/objtool/Documentation/objtool.txt.
>

I had missed this, thanks for the pointer.

> --
> Josh

