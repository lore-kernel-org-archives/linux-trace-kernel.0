Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F705EB64DC
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 11 Jul 2023 16:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjGKQWQ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 11 Jul 2023 12:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjGKQWM (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:22:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14E910FD;
        Tue, 11 Jul 2023 09:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60E516155B;
        Tue, 11 Jul 2023 16:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FB7C433C7;
        Tue, 11 Jul 2023 16:22:09 +0000 (UTC)
Date:   Tue, 11 Jul 2023 12:22:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/5] tracing/probes: Fix to record 0-length data_loc
 in fetch_store_string*() if fails
Message-ID: <20230711122206.531a6504@gandalf.local.home>
In-Reply-To: <168908496683.123124.4761206188794205601.stgit@devnote2>
References: <168908491977.123124.16583481716284477889.stgit@devnote2>
        <168908496683.123124.4761206188794205601.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 11 Jul 2023 23:16:07 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix to record 0-length data to data_loc in fetch_store_string*() if it fails
> to get the string data.
> Currently those expect that the data_loc is updated by store_trace_args() if
> it returns the error code. However, that does not work correctly if the
> argument is an array of strings. In that case, store_trace_args() only clears
> the first entry of the array (which may have no error) and leaves other
> entries. So it should be cleared by fetch_store_string*() itself.
> Also, 'dyndata' and 'maxlen' in store_trace_args() should be updated
> only if it is used (ret > 0 and argument is a dynamic data.)
> 
> Fixes: 40b53b771806 ("tracing: probeevent: Add array type support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v4:
>   - Simplify the updating data_loc code with set_data_loc().
>  Changes in v5:
>   - Move out arg->dynamic check from unlikely() and use likely().
> ---
>  kernel/trace/trace_probe_kernel.h |   13 +++++++++----
>  kernel/trace/trace_probe_tmpl.h   |   10 +++-------
>  kernel/trace/trace_uprobe.c       |    3 ++-
>  3 files changed, 14 insertions(+), 12 deletions(-)
> 


Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

