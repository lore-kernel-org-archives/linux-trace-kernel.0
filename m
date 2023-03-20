Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EABDC6FD1F
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 20 Mar 2023 00:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjCTArm (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sun, 19 Mar 2023 20:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCTArk (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 20:47:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D48F1A495;
        Sun, 19 Mar 2023 17:47:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B22E1B80CA0;
        Mon, 20 Mar 2023 00:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB50C433D2;
        Mon, 20 Mar 2023 00:47:35 +0000 (UTC)
Date:   Sun, 19 Mar 2023 20:47:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org
Subject: Re: [PATCH 4/7] ftrace: Rename _ftrace_direct_multi APIs to
 _ftrace_direct APIs
Message-ID: <20230319204731.6691dedc@rorschach.local.home>
In-Reply-To: <ZBdTA0gKh2xAk5Ay@krava>
References: <20230316173811.1223508-1-revest@chromium.org>
        <20230316173811.1223508-5-revest@chromium.org>
        <ZBcqWqWyq0uW/wj7@krava>
        <20230319135550.22aaa04b@rorschach.local.home>
        <ZBdTA0gKh2xAk5Ay@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sun, 19 Mar 2023 19:22:59 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> > > >  config SAMPLE_FTRACE_DIRECT_MULTI    
> > > 
> > > nit, we could perhaps remove this config option as well
> > > and use SAMPLE_FTRACE_DIRECT_MULTI  
> > 
> > Remove SAMPLE_FTRACE_DIRECT_MULTI for SAMPLE_FTRACE_DIRECT_MULTI?
> >   
> 
> sorry typo, I meant SAMPLE_FTRACE_DIRECT

I believe this was discussed before, and I thought we decided to keep
them separate. Or perhaps that was at least for testing?

Anyway, we could merge this in the future, but I don't think that's
necessary now.

-- Steve
