Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF91EB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  6 Jul 2023 02:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjGFCuC (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 5 Jul 2023 22:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjGFCuB (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 22:50:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDB91BDB;
        Wed,  5 Jul 2023 19:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26DC16171C;
        Thu,  6 Jul 2023 02:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF63C433C8;
        Thu,  6 Jul 2023 02:49:57 +0000 (UTC)
Date:   Wed, 5 Jul 2023 22:49:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tracing/probes: Fix return value when "(fault)" is
 injected
Message-ID: <20230705224956.1c5213e6@gandalf.local.home>
In-Reply-To: <168830925534.2278819.7237772177111801959.stgit@mhiramat.roam.corp.google.com>
References: <168830922841.2278819.9165254236027770818.stgit@mhiramat.roam.corp.google.com>
        <168830925534.2278819.7237772177111801959.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun,  2 Jul 2023 23:47:35 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> When the "(fault)" is injected, the return value of fetch_store_string*()
> should be the length of the "(fault)", but an error code is returned.
> Fix it to return the correct length and update the data_loc according the
> updated length.
> This needs to update a ftracetest test case, which expects trace output
> to appear as '(fault)' instead of '"(fault)"'.
> 

Ah, because of patch 2, the ret < 0 makes it return without printing the
"fault"?

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> Fixes: 2e9906f84fc7 ("tracing: Add "(fault)" name injection to kernel probes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
