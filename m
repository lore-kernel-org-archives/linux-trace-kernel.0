Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE8DEB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  7 Jul 2023 15:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGGPsY (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 7 Jul 2023 11:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGGPsW (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11017173B;
        Fri,  7 Jul 2023 08:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A12DB619EC;
        Fri,  7 Jul 2023 15:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828F3C433C8;
        Fri,  7 Jul 2023 15:48:19 +0000 (UTC)
Date:   Fri, 7 Jul 2023 11:48:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] Revert "tracing: Add "(fault)" name injection to
 kernel probes"
Message-ID: <20230707114817.308ff5e3@gandalf.local.home>
In-Reply-To: <20230708004643.8f6335a2fa682d7dae1f0d0e@kernel.org>
References: <168873724526.2687993.15242662075324919195.stgit@mhiramat.roam.corp.google.com>
        <168873727209.2687993.6806850187024303094.stgit@mhiramat.roam.corp.google.com>
        <20230707101420.49b1fd54@gandalf.local.home>
        <20230708004643.8f6335a2fa682d7dae1f0d0e@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat, 8 Jul 2023 00:46:43 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Indeed. So can I tweak the revert patch more for this?
> 
> I would like to move the definition to trace.h.

Sure.

-- Steve
