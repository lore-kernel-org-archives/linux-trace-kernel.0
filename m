Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22ECEB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Sat,  8 Jul 2023 01:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGHBay (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 7 Jul 2023 21:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHBay (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 21:30:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEB1120;
        Fri,  7 Jul 2023 18:30:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA14261AD8;
        Sat,  8 Jul 2023 01:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07A4C433C7;
        Sat,  8 Jul 2023 01:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688779852;
        bh=DmfRozlHJtD9tTHV8wdKHv9m+DkM4y8VaF/ATtnlPPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e8kH3fjS6eKH552qPlwZYIte8BO4T7J48MVaB+g0e5pkodJLQkCohf/Y9t2UUO7rJ
         HPhSzGgrjFll8kceIEJlbHRpf2OdW6kMUKmSRR+ESUPHcryMegADFRAArC7ynmvJwa
         ypLhZvcod5taBmUf1Sy1JEdK+NVQj+Yd03RfQ8pgnVnEm882w2YgTi6jp6JgJx+zgT
         albOQ5n4p9Cs9V0uZShl/xJfObtLASuwy7Ci7ot1npNsin5EbjTiY2Lmn8r3llYPRF
         1ctvt5548G5Emxbu30GDX1a4sXTiNWVsOLT12r4dRpHam4eOduXXPUDHxb70bSDFn1
         teW5borZz0KUw==
Date:   Sat, 8 Jul 2023 10:30:48 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] Revert
 "tracing: Add "(fault)" name injection to kernel probes"
Message-Id: <20230708103048.de1706999001cd20f27455d6@kernel.org>
In-Reply-To: <20230707114817.308ff5e3@gandalf.local.home>
References: <168873724526.2687993.15242662075324919195.stgit@mhiramat.roam.corp.google.com>
        <168873727209.2687993.6806850187024303094.stgit@mhiramat.roam.corp.google.com>
        <20230707101420.49b1fd54@gandalf.local.home>
        <20230708004643.8f6335a2fa682d7dae1f0d0e@kernel.org>
        <20230707114817.308ff5e3@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 7 Jul 2023 11:48:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 8 Jul 2023 00:46:43 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Indeed. So can I tweak the revert patch more for this?
> > 
> > I would like to move the definition to trace.h.
> 
> Sure.

OK, let me update the patch. Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
