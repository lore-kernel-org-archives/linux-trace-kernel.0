Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EAFEB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 10 Jul 2023 22:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGJWie (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 10 Jul 2023 18:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGJWid (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 18:38:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AC81702;
        Mon, 10 Jul 2023 15:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E3D06124A;
        Mon, 10 Jul 2023 22:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA068C433C7;
        Mon, 10 Jul 2023 22:37:43 +0000 (UTC)
Date:   Mon, 10 Jul 2023 18:37:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/ftrace: Correctly enable event in
 instance-event.tc
Message-ID: <20230710183741.78f04c68@gandalf.local.home>
In-Reply-To: <20230626191255.53baab4ed48d7111dcd44cad@kernel.org>
References: <20230626001144.2635956-1-zhengyejian1@huawei.com>
        <20230626191114.8c5a66fbaa28af3c303923bd@kernel.org>
        <20230626191255.53baab4ed48d7111dcd44cad@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org


Shuah, can you take this?

On Mon, 26 Jun 2023 19:12:55 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 26 Jun 2023 19:11:14 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Mon, 26 Jun 2023 08:11:44 +0800
> > Zheng Yejian <zhengyejian1@huawei.com> wrote:
> >   
> > > Function instance_set() expects to enable event 'sched_switch', so we
> > > should set 1 to its 'enable' file.
> > > 
> > > Testcase passed after this patch:
> > >   # ./ftracetest test.d/instances/instance-event.tc
> > >   === Ftrace unit tests ===
> > >   [1] Test creation and deletion of trace instances while setting an event
> > >   [PASS]
> > > 
> > >   # of passed:  1
> > >   # of failed:  0
> > >   # of unresolved:  0
> > >   # of untested:  0
> > >   # of unsupported:  0
> > >   # of xfailed:  0
> > >   # of undefined(test bug):  0
> > >   
> > 
> > Good catch!
> > 
> > Fixes: 91e6f1ce8657 ("ftracetest: Add instance created, delete, read and enable event test")
> > 
> > It seems this tests internally broken but the result is same because this disabled
> > error checking ('set +e').  
> 
> And
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>


-- Steve

> 
> Thanks!
> 
> > 
> >   
> > > Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> > > ---
> > >  .../testing/selftests/ftrace/test.d/instances/instance-event.tc | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> > > index 0eb47fbb3f44..42422e425107 100644
> > > --- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> > > +++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> > > @@ -39,7 +39,7 @@ instance_read() {
> > >  
> > >  instance_set() {
> > >          while :; do
> > > -                echo 1 > foo/events/sched/sched_switch
> > > +                echo 1 > foo/events/sched/sched_switch/enable
> > >          done 2> /dev/null
> > >  }
> > >  
> > > -- 
> > > 2.25.1
> > >   
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>  
> 
> 

