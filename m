Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD59EB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  5 Jul 2023 19:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGETAh (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 5 Jul 2023 15:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjGETAg (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:00:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767611998;
        Wed,  5 Jul 2023 12:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1449D616D1;
        Wed,  5 Jul 2023 19:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2C4C433C8;
        Wed,  5 Jul 2023 19:00:14 +0000 (UTC)
Date:   Wed, 5 Jul 2023 15:00:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org,
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
        Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH 03/14] tracing/filters: Enable filtering a scalar
 field by a cpumask
Message-ID: <20230705150013.5ba7ddb8@gandalf.local.home>
In-Reply-To: <20230705181256.3539027-4-vschneid@redhat.com>
References: <20230705181256.3539027-1-vschneid@redhat.com>
        <20230705181256.3539027-4-vschneid@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed,  5 Jul 2023 19:12:45 +0100
Valentin Schneider <vschneid@redhat.com> wrote:

> +/* Optimisation of do_filter_cpumask() for scalar values */
> +static inline int
> +do_filter_cpumask_scalar(int op, unsigned int cpu, const struct cpumask *mask)
> +{
> +	switch (op) {
> +	case OP_EQ:
> +		return cpumask_equal(mask, cpumask_of(cpu));
> +	case OP_NE:
> +		return !cpumask_equal(mask, cpumask_of(cpu));

The above two can be optimized much more if the cpu is a scalar. If mask is
anything but a single CPU, then EQ will always be false, and NE will always
be true. If the mask contains a single CPU, then we should convert the mask
into the scalar CPU and just do:

	case OP_EQ:
		return mask_cpu == cpu;
	case op_NE:
		return maks_cpu != cpu;

-- Steve

> +	case OP_BAND:
> +		return cpumask_test_cpu(cpu, mask);
> +	default:
> +		return 0;
> +	}
> +}
