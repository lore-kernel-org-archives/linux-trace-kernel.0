Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36305EB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 21 Jul 2023 17:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjGURah convert rfc822-to-8bit (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGURaV (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0873A8E;
        Fri, 21 Jul 2023 10:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 076E961D6D;
        Fri, 21 Jul 2023 17:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE68C433C7;
        Fri, 21 Jul 2023 17:30:05 +0000 (UTC)
Date:   Fri, 21 Jul 2023 13:30:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ajay Kaher <akaher@vmware.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        Alexey Makhalov <amakhalov@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Tapas Kundu <tkundu@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: Re: [PATCH v4 00/10] tracing: introducing eventfs
Message-ID: <20230721133000.763cd3c3@gandalf.local.home>
In-Reply-To: <66DACCE8-1C57-4A30-8ACF-D88179CA6381@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <20230714185824.62556254@gandalf.local.home>
        <883F9774-3E76-4346-9988-2788FAF0D55E@vmware.com>
        <20230718094005.32516161@gandalf.local.home>
        <2CD72098-08E2-4CAA-B74D-D8C44D318117@vmware.com>
        <20230719102310.552d3356@gandalf.local.home>
        <899D0823-A1B2-4A6F-A5BA-0D707F41C3D4@vmware.com>
        <20230719144046.746af82e@gandalf.local.home>
        <20230721084839.4a97a595@gandalf.local.home>
        <20230721091947.0df9fd73@gandalf.local.home>
        <66DACCE8-1C57-4A30-8ACF-D88179CA6381@vmware.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 21 Jul 2023 17:17:24 +0000
Nadav Amit <namit@vmware.com> wrote:

> [ And “bool" is clearer type for is_freed. ]

Oh, and to answer why I didn't use bool. I want to make sure that it
doesn't use just part of the other elements in the union. If the compiler
decides to use one byte for the bool (which it is perfectly valid to do
so), and it happens to map over a zero of the other elements in the union,
then it will give a false negative.

By using unsigned long, it will be guaranteed to contain some content.

-- Steve
