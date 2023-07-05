Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152F2EB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  5 Jul 2023 22:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjGEWmS (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 5 Jul 2023 18:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjGEWmR (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 18:42:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882C01BCA;
        Wed,  5 Jul 2023 15:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=whnA/OVznVWcFaFcIYC0diM7lv6z3lBMMqb7ePGz5mQ=; b=SBYa5ul/YojgJayNbL5nIgSWxk
        aLsZEyN7JhOnzgsI0qiXJJ61u9NAVnSCtpm09RRNT//C5ozJlP3kromq72aejTynICWnQUsbi+v/b
        ZA9YiSJLZgUq4Gu8DYTHyUusLqa9T1u/To45CTISHPjsHU5ysYVBXMm+ZGPNXkLaL5RK8E/bPn62a
        Qcf5CMYS8dUJG+gJKXAcUhALxllaS/c2ve73SDpmle6i7hkoighnAlWn1Alj61QPXL7RC+QGGwHQo
        hxtNuq5H+tdpiWAay00KrOhF6OzyqmIvC+b2RO/WW1PIagkMuIXHVbAzOLW5mxM7r5211VHXGP66G
        ncygjUFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHBBI-00AUxf-Rx; Wed, 05 Jul 2023 22:41:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 61B6E3002B1;
        Thu,  6 Jul 2023 00:41:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54454284C9973; Thu,  6 Jul 2023 00:41:04 +0200 (CEST)
Date:   Thu, 6 Jul 2023 00:41:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
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
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH 11/14] context-tracking: Introduce work deferral
 infrastructure
Message-ID: <20230705224104.GE2813335@hirez.programming.kicks-ass.net>
References: <20230705181256.3539027-1-vschneid@redhat.com>
 <20230705181256.3539027-12-vschneid@redhat.com>
 <ZKXtfWZiM66dK5xC@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKXtfWZiM66dK5xC@localhost.localdomain>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 12:23:57AM +0200, Frederic Weisbecker wrote:
> If this is just about a dozen, can we stuff them in the state like in the
> following? We can potentially add more of them especially on 64 bits we could
> afford 30 different works, this is just shrinking the RCU extended quiescent
> state counter space. Worst case that can happen is that RCU misses 65535
> idle/user <-> kernel transitions and delays a grace period...

We can make all this a 64bit only feature and use atomic_long_t :-)
