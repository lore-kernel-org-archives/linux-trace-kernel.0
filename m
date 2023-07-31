Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A42C00528
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 31 Jul 2023 11:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjGaLSD (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 31 Jul 2023 07:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjGaLR6 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:17:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711B0E52
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690802230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M/35EV6KuQFV76XfAiI3kNPUCvGz0oTI5DQh4eGuYFg=;
        b=iTfrUa/AKf4x1sPOKRAroR1zkzSsZkhRalGiSQMYejLoVSYCUTbMHLAqtl1O9j0w/jK39g
        xUhEifHJ3JOp8rNUa37qgHQnx0/Z07Y+fCHy3gyDjQNzEMwAvmTSK91sHF60cbMr+4XKj5
        7aCe4sq0MMFM/96dBMZ8WPlnVda/+Q8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-e3WlP5yHOta3iy5nu7-34g-1; Mon, 31 Jul 2023 07:17:09 -0400
X-MC-Unique: e3WlP5yHOta3iy5nu7-34g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63cf36d8190so59345716d6.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690802229; x=1691407029;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/35EV6KuQFV76XfAiI3kNPUCvGz0oTI5DQh4eGuYFg=;
        b=kYUn0ayfPwDGTdRVB2WUTH2v8AAxmisHdQCG69mRSFfMjhyB1y/5mSxcwnSb4hMYNt
         eq1j9ZFiI/jd8bN6ih/JQTgxAszkJ+TG1kWBx1vqS6WlzZ0b4ZPHsGb8hjkKmym8gJcs
         YKbOYet0yfTufRYvTpXj1hLUXNyya3ZSxX//dz64hJH4Mz6GoHTrgok8vbbkT/sNQIOY
         9HJKU5+UHeD4l5noP2Z6XBo9oJZcJRKUrymCmrZL/wkt9ZxGs/F8nzdjIIEn5st2xYfJ
         p8bAI7fxMfNjGkuL1B1sufEVRoeXiDtJ8WBjVFAL/MDM63VIAE4Zawa3Fl5EYNJeBfDp
         Anmw==
X-Gm-Message-State: ABy/qLYdkyn//3jEOSQiKJx7c0vduSthgWMrsMkK7Bfn1cr0+kvlK+4g
        xkvrIWrMF40kL5xp7encVrvmthxZt8vovUGCdf199mLzr45yA7Ro93INR6HdhsbakLH+O+VPE1V
        KnmT1CsJ5KAS499KZ+SDRh1rofS8b/889
X-Received: by 2002:a05:622a:1a27:b0:403:cb17:c108 with SMTP id f39-20020a05622a1a2700b00403cb17c108mr12984356qtb.24.1690802229061;
        Mon, 31 Jul 2023 04:17:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGfjSM0EY4ReLF74gjgUvSgh5M/dv10+80eXvDCpwVYLgcCJZkRhEPkohi/ydjwax6EynCsig==
X-Received: by 2002:a05:622a:1a27:b0:403:cb17:c108 with SMTP id f39-20020a05622a1a2700b00403cb17c108mr12984294qtb.24.1690802228754;
        Mon, 31 Jul 2023 04:17:08 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id o18-20020ac85552000000b00403bf34266csm3426262qtr.30.2023.07.31.04.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:17:08 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
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
Subject: Re: [RFC PATCH v2 11/20] objtool: Flesh out warning related to
 pv_ops[] calls
In-Reply-To: <20230728153334.myvh5sxppvjzd3oz@treble>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-12-vschneid@redhat.com>
 <20230728153334.myvh5sxppvjzd3oz@treble>
Date:   Mon, 31 Jul 2023 12:16:59 +0100
Message-ID: <xhsmh8raws53o.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 28/07/23 10:33, Josh Poimboeuf wrote:
> On Thu, Jul 20, 2023 at 05:30:47PM +0100, Valentin Schneider wrote:
>> I had to look into objtool itself to understand what this warning was
>> about; make it more explicit.
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  tools/objtool/check.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
>> index 8936a05f0e5ac..d308330f2910e 100644
>> --- a/tools/objtool/check.c
>> +++ b/tools/objtool/check.c
>> @@ -3360,7 +3360,7 @@ static bool pv_call_dest(struct objtool_file *file, struct instruction *insn)
>>
>>      list_for_each_entry(target, &file->pv_ops[idx].targets, pv_target) {
>>              if (!target->sec->noinstr) {
>> -			WARN("pv_ops[%d]: %s", idx, target->name);
>> +			WARN("pv_ops[%d]: indirect call to %s() leaves .noinstr.text section", idx, target->name);
>>                      file->pv_ops[idx].clean = false;
>
> This is an improvement, though I think it still results in two warnings,
> with the second not-so-useful warning happening in validate_call().
>
> Ideally it would only show a single warning, I guess that would need a
> little bit of restructuring the code.

You're quite right - fabricating an artificial warning with a call to __flush_tlb_local():

  vmlinux.o: warning: objtool: pv_ops[1]: indirect call to native_flush_tlb_local() leaves .noinstr.text section
  vmlinux.o: warning: objtool: __flush_tlb_all_noinstr+0x4: call to {dynamic}() leaves .noinstr.text section

Interestingly the second one doesn't seem to have triggered the "pv_ops"
bit of call_dest_name. Seems like any call to insn_reloc(NULL, x) will
return NULL.

Trickling down the file yields:

  vmlinux.o: warning: objtool: pv_ops[1]: indirect call to native_flush_tlb_local() leaves .noinstr.text section
  vmlinux.o: warning: objtool: __flush_tlb_all_noinstr+0x4: call to pv_ops[0]() leaves .noinstr.text section

In my case (!PARAVIRT_XXL) pv_ops should look like:
  [0]: .cpu.io_delay
  [1]: .mmu.flush_tlb_user()

so pv_ops[1] looks right. Seems like pv_call_dest() gets it right because
it uses arch_dest_reloc_offset().

If I use the above to fix up validate_call(), would we still need
pv_call_dest() & co?

>
> --
> Josh

