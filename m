Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AFCC636D3
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  7 Feb 2023 17:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjBGRlu (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 7 Feb 2023 12:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjBGRlt (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:41:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C126B473;
        Tue,  7 Feb 2023 09:41:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26CDAB81A5F;
        Tue,  7 Feb 2023 17:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F0BC433D2;
        Tue,  7 Feb 2023 17:41:44 +0000 (UTC)
Date:   Tue, 7 Feb 2023 12:41:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] tracing/histogram: Wrap remaining shell snippets in
 code blocks
Message-ID: <20230207124142.17337fe0@gandalf.local.home>
In-Reply-To: <7370dc9a-8a14-4c38-028e-f44cd099dbaf@gmail.com>
References: <202301290253.LU5yIxcJ-lkp@intel.com>
        <20230129031402.47420-1-bagasdotme@gmail.com>
        <871qn8vsro.fsf@meer.lwn.net>
        <7370dc9a-8a14-4c38-028e-f44cd099dbaf@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 3 Feb 2023 16:19:41 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> On 2/3/23 01:14, Jonathan Corbet wrote:
> > So this is a good cleanup and I'd like to apply it, but it doesn't come
> > close to applying to docs-next.  Which tree did you do this against?
> >   
> 
> for-next branch (linux-trace tree).
> 

I'll add this to my tree. Thanks!

-- Steve
