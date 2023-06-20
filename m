Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FF5EB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 20 Jun 2023 15:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjFTPDz (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 20 Jun 2023 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjFTPDm (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:03:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4279D2102;
        Tue, 20 Jun 2023 08:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A7B612CE;
        Tue, 20 Jun 2023 15:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF3BC433C8;
        Tue, 20 Jun 2023 15:02:29 +0000 (UTC)
Date:   Tue, 20 Jun 2023 11:02:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH v3 00/10] tracing: introducing eventfs
Message-ID: <20230620110227.6a944a19@gandalf.local.home>
In-Reply-To: <34E6364B-2B3D-4597-8143-1EEA645B6CDD@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
        <34E6364B-2B3D-4597-8143-1EEA645B6CDD@vmware.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, 19 Jun 2023 05:38:25 +0000
Ajay Kaher <akaher@vmware.com> wrote:

> # of passed:  65
> # of failed:  3

Unrelated to your patches, but have you checked why these fail? Do you have
the latest tests running on the latest kernel?

> # of unresolved:  6
> # of untested:  0
> # of unsupported:  44
> # of xfailed:  0
> # of undefined(test bug):  0
> 
> These results are same with/without eventfs.

I'm hoping to look at these patches this week.

Thanks!

-- Steve

