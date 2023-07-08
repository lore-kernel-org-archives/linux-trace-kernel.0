Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E390EB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Sat,  8 Jul 2023 13:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjGHNtD (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 8 Jul 2023 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHNtC (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 09:49:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C8318F
        for <linux-trace-kernel@vger.kernel.org>; Sat,  8 Jul 2023 06:49:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC5CF60C6D
        for <linux-trace-kernel@vger.kernel.org>; Sat,  8 Jul 2023 13:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB9CC433C7;
        Sat,  8 Jul 2023 13:48:59 +0000 (UTC)
Date:   Sat, 8 Jul 2023 09:48:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] x86/ftrace: Make function graph use ftrace
 directly
Message-ID: <20230708094858.51bbba51@rorschach.local.home>
In-Reply-To: <2344e517-cdce-42ef-868e-6b9ae8b4ea2c@kadam.mountain>
References: <8d9bf4bb-693a-4368-8db1-9de1b80a33e1@moroto.mountain>
        <20230706133734.499e9cbe@gandalf.local.home>
        <2344e517-cdce-42ef-868e-6b9ae8b4ea2c@kadam.mountain>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 7 Jul 2023 08:37:29 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> > > This is a sleeping function.  
> > 
> > Hmm, this is an interesting scenario. If this triggers, it means that the
> > system is likely locked up by the function graph tracer. The only way to
> > stop the hang, is via calling ftrace_graph_stop(). But you are correct,
> > that's calling something that can crash the system as well.
> > 
> > If anything, it should be called after the dump_on_oops output, with a
> > warning to reboot the machine.
> > 
> > IOW, yes, it's doing something buggy, but pretty much the only other
> > alternative is to call panic(). Not sure that's better :-/
> > 
> > Perhaps the solution is simply to move it to after the dump, with a warning
> > saying: "Dazed and confused, and trying to continue, but please reboot the machine!"
> > 
> > ??  
> 
> I feel like sleeping in atomic bugs used to be more of a big deal back
> in the day when systems only had one CPU.  In those days it was way more
> common for it to lead to a hang, but these days we quite often
> re-schedule the sleeping process on a different CPU and recover.  (I
> haven't actually looked at how processes are moved to different CPUs
> but this is just my theory of why we see fewer real life hangs from this
> bug today).

Sleeping while atomic is still a bug. It's just this particular code
path is where I don't know the best way to solve it. It's a start up
test (only enabled on development machines), and when it gets to where
it calls that function that sleeps in atomic, the system is already
hung. That code path detected that the function graph tracer is in some
kind of dead loop (which it may have caused), and it tries to stop that
dead loop by disabling it. But unfortunately, to disable it, it calls a
sleeping function!

Perhaps we just comment it and say, "Yes this is is buggy, but if we
are here, we already hit a bug". ;-)

-- Steve
