Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E7DC2FC14
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 17 Aug 2023 13:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243977AbjHQNGH (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 17 Aug 2023 09:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351440AbjHQNGC (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BACC30E1;
        Thu, 17 Aug 2023 06:05:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AA286717F;
        Thu, 17 Aug 2023 13:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B8DC433C8;
        Thu, 17 Aug 2023 13:04:33 +0000 (UTC)
Date:   Thu, 17 Aug 2023 09:04:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Yipeng Zou <zouyipeng@huawei.com>, <shuah@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2] selftests/ftrace: traceonoff_triggers: strip off
 names
Message-ID: <20230817090438.1d784051@gandalf.local.home>
In-Reply-To: <20230817090233.1e0a139e@gandalf.local.home>
References: <20230817025028.3953490-1-zouyipeng@huawei.com>
        <20230817141603.7815300ef7a15df1872bb603@kernel.org>
        <20230817090233.1e0a139e@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 17 Aug 2023 09:02:33 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Shuah,
> 
> Can you take this in your tree?

Actually, hold off please.

> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve
> 
> 
> On Thu, 17 Aug 2023 14:16:03 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Thu, 17 Aug 2023 10:50:28 +0800
> > Yipeng Zou <zouyipeng@huawei.com> wrote:
> >   


> > > Fixes: d87b29179aa0 ("selftests: ftrace: Use md5sum to take less time of checking logs")
> > > Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
> > > ---
> > >  .../ftrace/test.d/ftrace/func_traceonoff_triggers.tc          | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
> > > index aee22289536b..c5783999582d 100644
> > > --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
> > > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc
> > > @@ -90,9 +90,9 @@ if [ $on != "0" ]; then
> > >      fail "Tracing is not off"
> > >  fi
> > >  
> > > -csum1=`md5sum trace`

Yipeng, can you please add the comment here:

# Cannot rely on names being around as they are only cached, strip them

> > > +csum1=`cat trace | sed -e 's/^ *[^ ]*\(-[0-9][0-9]*\)/\1/' | md5sum`

--  Steve

> > >  sleep $SLEEP_TIME
> > > -csum2=`md5sum trace`
> > > +csum2=`cat trace | sed -e 's/^ *[^ ]*\(-[0-9][0-9]*\)/\1/' | md5sum`
> > >  
> > >  if [ "$csum1" != "$csum2" ]; then
> > >      fail "Tracing file is still changing"
> > > -- 
> > > 2.34.1
> > >     
> > 
> >   
> 

