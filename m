Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E006AC001DF
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 31 Jul 2023 11:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjGaLVp (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 31 Jul 2023 07:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjGaLVZ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9B6172B
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690802425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5vaUW0ZFNoavCkOsFWH4xJQw7j0BCOKV0sVk8cbQiFE=;
        b=CYKx1O7Sa+KAxkzJjncUFmvRSPSy8t221jyjykmWBOyVZyPBUDH3JzUsb9H3puHWlSdKXs
        W1v27oirBDFN/UTLpdUSU90zn/0+HvXEX+wXjNTEEzSVofT3j1rL5mLLAw1JJMdCjgnOAt
        tjAa/cwgHhRjsPvOFI6QvBLJnde2TsQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-H1r4dO7hPAmk1JVMamqZvg-1; Mon, 31 Jul 2023 07:20:24 -0400
X-MC-Unique: H1r4dO7hPAmk1JVMamqZvg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7659d103147so618536885a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690802424; x=1691407224;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vaUW0ZFNoavCkOsFWH4xJQw7j0BCOKV0sVk8cbQiFE=;
        b=aTbImaBeWGcDUBLNxQo/68qaRxA7ufAYR423aZWRHCwmNQJOtkfs+aFqwsQfaXfMIb
         EDpKiv+IwpLYdnhZs4RO4JZE5EZWvfRNVwYhSFkwa3n/txg65vXJMMMm1jWMUZUz72vo
         zUWGGbY/fCGB+lmIRazZ9M1bfshdD57unwLjAu/9U4ZrYrbFU/uzRyIKCYnw/VfJGDeC
         TojSfEYSQe4tNNzqcRAyuBVC0RE8WV4CDeFy/4OMT4n6LJVQAl/GAjBJvLhmM0dRoye4
         nVP/Na+aWftnQCXe1jnr1TlPYH2AsHtkMLKjuJj6WdaVh5Zr7d+vj3MkpUm1zRu/SAIW
         uUIg==
X-Gm-Message-State: ABy/qLaCs1tk7dGUa6N5aQdfGnGuxUVBdM6NgzDUYxTrtY149VoPuo7a
        r0SewAWnFDywbNsVSXLhdpbsSYnuCPp1ZrggTeew8guftgMs1F0BhsYGnvUkimUAVCHug2mSbqW
        jrax0vpKII84pnXlPN0oaRH8gGhhSYIDk
X-Received: by 2002:a05:620a:3199:b0:765:a678:977c with SMTP id bi25-20020a05620a319900b00765a678977cmr11440910qkb.67.1690802424235;
        Mon, 31 Jul 2023 04:20:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF4PsqV0GfIB6WcE+e1KZA+Ob00KHOmMkV0SPV2mk8Z9iXGAjuozcLuEeBrBpyr3ypNADcfxg==
X-Received: by 2002:a05:620a:3199:b0:765:a678:977c with SMTP id bi25-20020a05620a319900b00765a678977cmr11440851qkb.67.1690802423943;
        Mon, 31 Jul 2023 04:20:23 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id c23-20020a05620a11b700b00767303dc070sm3206663qkk.8.2023.07.31.04.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:20:23 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Subject: Re: [RFC PATCH v2 05/20] tracing/filters: Optimise cpumask vs
 cpumask filtering when user mask is a single CPU
In-Reply-To: <20230729153436.1e07bfa6@rorschach.local.home>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-6-vschneid@redhat.com>
 <20230729153436.1e07bfa6@rorschach.local.home>
Date:   Mon, 31 Jul 2023 12:20:13 +0100
Message-ID: <xhsmh3514s4ya.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 29/07/23 15:34, Steven Rostedt wrote:
> On Thu, 20 Jul 2023 17:30:41 +0100
> Valentin Schneider <vschneid@redhat.com> wrote:
>
>>              /* Move along */
>>              i++;
>> +
>> +		/*
>> +		 * Optimisation: if the user-provided mask has a weight of one
>> +		 * then we can treat it as a scalar input.
>> +		 */
>> +		single = cpumask_weight(pred->mask) == 1;
>> +		if (single && field->filter_type == FILTER_CPUMASK) {
>> +			pred->val = cpumask_first(pred->mask);
>> +			kfree(pred->mask);
>
> Don't we need:
>                       pred->mask = NULL;
>
> here, or the free_predicate() will cause a double free?
>

We do, thanks for spotting this.

> -- Steve
>
>> +		}
>> +

