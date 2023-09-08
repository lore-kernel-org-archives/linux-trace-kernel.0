Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F85AEE7FE5
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  8 Sep 2023 12:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbjIHMbq (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 8 Sep 2023 08:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbjIHMbq (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:31:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538FD1BF1;
        Fri,  8 Sep 2023 05:31:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4040EC433CA;
        Fri,  8 Sep 2023 12:31:40 +0000 (UTC)
Date:   Fri, 8 Sep 2023 08:31:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Ajay Kaher <akaher@vmware.com>, shuah@kernel.org,
        mhiramat@kernel.org, chinglinyu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, amakhalov@vmware.com,
        er.ajay.kaher@gmail.com, srivatsa@csail.mit.edu, tkundu@vmware.com,
        vsirnapalli@vmware.com
Subject: Re: [PATCH v4 09/10] eventfs: Move tracing/events to eventfs
Message-ID: <20230908083156.7d261adb@gandalf.local.home>
In-Reply-To: <yt9dr0n8kgkj.fsf@linux.ibm.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <1689248004-8158-10-git-send-email-akaher@vmware.com>
        <yt9dr0n8kgkj.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 08 Sep 2023 14:14:20 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Ajay Kaher <akaher@vmware.com> writes:
> 
> > Till now /sys/kernel/debug/tracing/events is a part of tracefs,
> > with-in this patch creating 'events' and it's sub-dir as eventfs.
> > Basically replacing tracefs calls with eventfs calls for 'events'.
> >
> > Signed-off-by: Ajay Kaher <akaher@vmware.com>
> > Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Tested-by: Ching-lin Yu <chinglinyu@google.com>
> > ---
> >  fs/tracefs/inode.c           | 18 ++++++++++
> >  include/linux/trace_events.h |  1 +
> >  kernel/trace/trace.h         |  2 +-
> >  kernel/trace/trace_events.c  | 67 +++++++++++++++++++-----------------
> >  4 files changed, 55 insertions(+), 33 deletions(-)  
> 
> With this patchset in next-20230908 the following crash is observed on
> s390 while running ftracetest test.d/instances/instance-event.tc:
> 
> (It also crashes without KASAN, just not on every try)

Yep, and I've spent the last few days fixing this :-)

  https://lore.kernel.org/linux-trace-kernel/20230907024710.866917011@goodmis.org/

-- Steve
