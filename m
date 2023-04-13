Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484C1C77B71
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 13 Apr 2023 02:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjDMCmB (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 12 Apr 2023 22:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjDMClo (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 22:41:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD38D6EA1;
        Wed, 12 Apr 2023 19:39:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F20263ABE;
        Thu, 13 Apr 2023 02:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA1EC433D2;
        Thu, 13 Apr 2023 02:38:36 +0000 (UTC)
Date:   Wed, 12 Apr 2023 22:38:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Lin Yu Chen <starpt.official@gmail.com>, corbet@lwn.net,
        mhiramat@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: trace: Fix typo in ftrace.rst
Message-ID: <20230412223835.3da23ab5@gandalf.local.home>
In-Reply-To: <4b17c67c-4b3d-4326-37e7-949a08d03f55@gmail.com>
References: <20230412183739.89894-1-starpt.official@gmail.com>
        <4b17c67c-4b3d-4326-37e7-949a08d03f55@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 13 Apr 2023 09:19:12 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> On 4/13/23 01:37, Lin Yu Chen wrote:
> > There is a typo in the sentence "A kernel developer must be
> > conscience ...". The word conscience should be conscious.
> > This patch fixes it.
> >   
> 
> Please don't say "This patch does foo".

Yes, that part can be left out.

>  
> > -waste it in functions. A kernel developer must be conscience of
> > +waste it in functions. A kernel developer must be conscious of  
> 
> Alternatively, what about "aware of"?
> 

As the author of this document, and the one that doesn't have a conscience
about using conscious correctly, I approve of Lin Yu's change.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks!

-- Steve
