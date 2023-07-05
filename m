Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6B9EB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  5 Jul 2023 09:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjGEJBI (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 5 Jul 2023 05:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjGEJBI (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:01:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A42611F;
        Wed,  5 Jul 2023 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hakQolOQjMnf+B++c/8vfOBnENC9wc+YeNh/Nom7T94=; b=S8aOPhEQBb4HZry+9oUF+BUGDo
        uZeTyCJcuVwLai6Ic1+5GsRIwRpOS/lb5lxjxbqCJRZWqOaNDcnrQEJns2w5PjOydMKrdvjkXwRcb
        vAj3bdrRPrumj03Rfb/J+t0pGx3RNajwJIk+IGBxlysGy3SVO5EJHr0XAsTBjPwQoLNF08rfNNXTi
        SIyfwSOm06qhBlxQSRMvC4BTUPlGyR2Oh+AZpaDjAn4ZJyAHLP/GF+84DR0a5Hwc0LQZ5aU2hHJ9U
        zOF5CLs0+Gd0DNx6SwkaNl+Eu8IX4BoZ+jrQV15L6+FWOX113ytAgi9qd5dC9Qnffaqyc/ayitBR4
        3KsQmVeQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGyLi-00C36Z-17;
        Wed, 05 Jul 2023 09:00:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 803B330012F;
        Wed,  5 Jul 2023 10:58:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6321A2028F056; Wed,  5 Jul 2023 10:58:57 +0200 (CEST)
Date:   Wed, 5 Jul 2023 10:58:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mhiramat@kernel.org,
        samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/retpoline,kprobes: Avoid treating rethunk as an
 indirect jump
Message-ID: <20230705085857.GG462772@hirez.programming.kicks-ass.net>
References: <20230705081547.25130-1-petr.pavlu@suse.com>
 <20230705081547.25130-3-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705081547.25130-3-petr.pavlu@suse.com>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:15:47AM +0200, Petr Pavlu wrote:
> Functions can_optimize() and insn_is_indirect_jump() consider jumps to
> the range [__indirect_thunk_start, __indirect_thunk_end] as indirect
> jumps and prevent use of optprobes in functions containing them.

Why ?!? I mean, doing an opt-probe of an indirect jump/call instruction
itself doesn't really make sense and I can see why you'd want to not do
that. But why disallow an opt-probe if there's one in the function as a
whole, but not the probe target?
