Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F32EB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 10 Jul 2023 16:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjGJQVR (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 10 Jul 2023 12:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGJQVQ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:21:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE93E11F;
        Mon, 10 Jul 2023 09:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o/ehgTocRh8PtfBK/UyzCrWNPNCGdZG+dLn8RGUzHow=; b=fl7piA8CKhbdAICst5HXBpJ1Ca
        UgLFxqYkeiIkabyFc9DM/4cNa8urEJws1pGpFIVZQFaYMgzCeRjjN86B5c7FE1Zi0r0wkdauLtB0R
        1K0StFLS6BRvsqnmUbZaA7kXHWoOZdJAT+9tAWz4sFucJAO2HeyVk85zNqaZYhjjdjpAAqWbGGn6y
        chi01CVAB/uXvBBUUZLiMYwYiJNZJONLEbGRvhdIdPBqdr/YzXdF22AS7ItWeJxJxQDQMGfqnaYMO
        VxsqahMbu5NqLs2Ar696eRP0xIKNJrO5rPbItddQLpoVG2QDhDGi9LgI8dn+USe8daIK8QM9giOPG
        kfkeT4rA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qItdK-00EkJA-SJ; Mon, 10 Jul 2023 16:21:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 746A43004AF;
        Mon, 10 Jul 2023 18:21:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B54E2B3B25DF; Mon, 10 Jul 2023 18:21:06 +0200 (CEST)
Date:   Mon, 10 Jul 2023 18:21:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] x86/kprobes: Prohibit probing on compiler
 generated CFI checking code
Message-ID: <20230710162106.GC3040258@hirez.programming.kicks-ass.net>
References: <168899125356.80889.17967397360941194229.stgit@devnote2>
 <168899127520.80889.15418363018799407058.stgit@devnote2>
 <20230710161643.GB3040258@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710161643.GB3040258@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 06:16:43PM +0200, Peter Zijlstra wrote:

> diff --git a/kernel/cfi.c b/kernel/cfi.c
> index 08caad776717..2656e6ffa013 100644
> --- a/kernel/cfi.c
> +++ b/kernel/cfi.c
> @@ -31,16 +31,22 @@ static inline unsigned long trap_address(s32 *p)
>  	return (unsigned long)((long)p + (long)*p);
>  }
>  
> -static bool is_trap(unsigned long addr, s32 *start, s32 *end)
> +static long cfi_trap_distance(unsigned long addr, s32 *start, s32 *end)
>  {
> +	long dist = LONG_MAX;
>  	s32 *p;
>  
>  	for (p = start; p < end; ++p) {
> -		if (trap_address(p) == addr)
> -			return true;
> +		long d = trap_address(p) - addr;
> +
> +		if (abs(dist) < abs(d)) {

Not that I expect anybody will care, but that should obviously be:

		abs(d) < abs(dist)

> +			dist = d;
> +			if (dist == 0)
> +				return 0;
> +		}
>  	}
>  
> -	return false;
> +	return dist;
>  }
