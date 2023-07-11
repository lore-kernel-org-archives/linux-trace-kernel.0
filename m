Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDBBEB64DC
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 11 Jul 2023 04:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjGKE4J (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 11 Jul 2023 00:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGKE4I (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:56:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77023FB;
        Mon, 10 Jul 2023 21:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15BFB61305;
        Tue, 11 Jul 2023 04:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92838C433C8;
        Tue, 11 Jul 2023 04:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689051366;
        bh=chk4w71SLL7ARWSfWIOfGyVEKHJpKgqbRxpzOCYROjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iHNxonMGPpYnEeoXRFGMUQX+9las/kq+zqzQrdMcsS++d2/3fHlc6RKnLv2U0L7mh
         IXWxymf9y3mnyKHFbAwaf+z9uoJSKWmzJZXRH+E7xNoAvLpKLegreg3eGjN8qotS6M
         L6MAQGuGpfr1PFV/0tKG2dvk4IkCHAkc6M/4JdomCIajGNjQSW0OGeoupruUsWmeUn
         3vUXZGXbVUUYjDPc2wBMCs7qKCRt+TTIZOcG0bSfQ5Ol/GtNsHLl4IYaJlxseRG3fi
         8/ov8nkewivTx73J9CcijwNwFePae72xlGFLnEGOZz2zst5r0bsDweqp7LhBqnXaE8
         5wfxf9uS3qapw==
Date:   Tue, 11 Jul 2023 13:56:03 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] tracing/probes: Fix to record 0-length data_loc
 in fetch_store_string*() if fails
Message-Id: <20230711135603.5c3724a57f1c064c672d99e1@kernel.org>
In-Reply-To: <20230710233400.5aaf024e@gandalf.local.home>
References: <168904147563.2908673.18054267804278861545.stgit@mhiramat.roam.corp.google.com>
        <168904151104.2908673.8401909922292791503.stgit@mhiramat.roam.corp.google.com>
        <20230710233400.5aaf024e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 10 Jul 2023 23:34:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 11 Jul 2023 11:11:51 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > --- a/kernel/trace/trace_probe_tmpl.h
> > +++ b/kernel/trace/trace_probe_tmpl.h
> > @@ -267,9 +267,7 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
> >  		if (unlikely(arg->dynamic))
> >  			*dl = make_data_loc(maxlen, dyndata - base);
> >  		ret = process_fetch_insn(arg->code, rec, dl, base);
> > -		if (unlikely(ret < 0 && arg->dynamic)) {
> > -			*dl = make_data_loc(0, dyndata - base);
> > -		} else {
> > +		if (unlikely(ret > 0 && arg->dynamic)) {
> 
> To match the current code, that should be:
> 
> 		if (likely(ret >= 0 || !arg->dynamic)) {
> 
> But I'm guessing that the original code was buggy, as the else block should
> only have been processed if arg->dynamic was set?

Good point, yes, that's right. Since dyndata and maxlen is only used when
arg->dynamic == true, we don't have to care about that.

> That is, it should have been:
> 
> 	if (arg->dynamic) {
> 		if (unlikely(ret < 0)) {
> 			*dl = make_data_loc(0, dyndata - base);
> 		} else {
>   			dyndata += ret;
>   			maxlen -= ret;
>   		}
> 	}
> 
> 
> I guess you only want to update if arg->dynamic is true (even though that
> wasn't the case before :-/) But in any case, I think you want likely() and
> not unlikely().
> 
> 		if (arg->dynamic && likely(ret > 0)) {
> 
> That is, if we only want to updated this if the arg is dynamic.

Indeed.

> 
> And I don't think that the arg->dynamic() should have likely/unlikely
> around it, as that's determined by user space, and the kernel should not be
> adding assumptions about what user space wants.

OK.

Let me fix that with a new patch because it is another bug.

Thanks,

> 
> -- Steve
> 
> >  			dyndata += ret;
> >  			maxlen -= ret;
> >  		}


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
