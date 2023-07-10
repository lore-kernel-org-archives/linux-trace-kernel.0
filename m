Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC72BEB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 10 Jul 2023 23:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGJXu3 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 10 Jul 2023 19:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjGJXu1 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80641A2;
        Mon, 10 Jul 2023 16:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63141611A5;
        Mon, 10 Jul 2023 23:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA55AC433C8;
        Mon, 10 Jul 2023 23:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689033025;
        bh=VD/tpU/eNJTlw2/chOqcbgRdtXfwm4YHsFrm91jQzac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cze55vC2yZSvF5pub95qzYvtk3UPQNfgCU3ha3zsUHm1x4WsN1QC/DvOvDq+g3bjt
         FT5wvi6c2jJhtKixMWJqIvcDI2J0bSGcsz6Q5xF7RKwvbzzOAB3xHPiOtuy1t5UiGX
         9LhvtoMfupbyF8y6GgPGmq/fjwFzMBHhq3MDuYk1UAO3crqEw6dPaqASuA/WRpmeYN
         wTK9MDtwxfrP2VIxVlxNLcwATSEqamRJFKQcVGllWno7J3Rbxup/ObGMlszPkEKfb0
         3JdTE7tpeLnNn8hioJFaNIWcs1jqNe+gg4klBvrSx+vt0O46bBWp/YiiIrrscD4DBW
         H7kGHkqF1VyaA==
Date:   Tue, 11 Jul 2023 08:50:21 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] kprobes: Prohibit probing on CFI preamble
 symbol
Message-Id: <20230711085021.9b32eeaac1070439bae0b8a8@kernel.org>
In-Reply-To: <20230710153724.GA3040258@hirez.programming.kicks-ass.net>
References: <168899125356.80889.17967397360941194229.stgit@devnote2>
        <168899126450.80889.16200438320430187434.stgit@devnote2>
        <20230710153724.GA3040258@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 10 Jul 2023 17:37:24 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jul 10, 2023 at 09:14:24PM +0900, Masami Hiramatsu (Google) wrote:
> 
> 
> > +#ifdef CONFIG_CFI_CLANG
> > +static bool is_cfi_preamble_symbol(unsigned long addr)
> > +{
> > +	char symbuf[KSYM_NAME_LEN];
> > +
> > +	if (lookup_symbol_name(addr, symbuf))
> > +		return false;
> > +
> > +	return str_has_prefix("__cfi_", symbuf)
> 		|| str_has_prefix("__pfx_", symbol);
> 
> The __pfx_ symbols can happen when !CFI_CLANG but still having
> FUNCTION_PADDING_BYTES.

Indeed. Currently __pfx is not probed via tracefs interface because it is
notrace function but kprobe itself should also prohibit that.

> 
> > +}
> > +#else
> > +#define is_cfi_preamble_symbol(addr)	(0)
> > +#endif
> 
> As such I think we can do the above unconditionally, without either
> there should not be any matching symbols.

OK.

Thank you!

> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
