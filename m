Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D5FC4321E
	for <linux-trace-kernel@archiver.kernel.org>; Sun,  4 Dec 2022 15:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiLDPlw (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sun, 4 Dec 2022 10:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiLDPlu (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 10:41:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AC813E02;
        Sun,  4 Dec 2022 07:41:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55AAD60DE0;
        Sun,  4 Dec 2022 15:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69746C433D6;
        Sun,  4 Dec 2022 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670168508;
        bh=nsLGE+9nzj0MY4xQL+zl7yrSBLDxnEPZOV0snAd0dAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VzvyAz+CJ98VdMd3OEPxZ/Ybw4VugYP0Y5CcsrtsLCtQon5+/0H0nO1aZMBgWcxTP
         fcyRp5Up9jLSBgBoGySACVAFk6yxpM3NPzGIbK+EU7rHKL2y3zRkAY6/lUbD5HKmYY
         DYCb5TtO75R2lTJhsQWwV55XbdcW1WM7gaMhwk1M=
Date:   Sun, 4 Dec 2022 16:41:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        mhiramat@kernel.org, primiano@google.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] tracing/ring-buffer: Have polling block
 on watermark" failed to apply to 5.4-stable tree
Message-ID: <Y4y/uVWvF7FJvdzd@kroah.com>
References: <16690291284651@kroah.com>
 <20221123235555.6791e1b4@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123235555.6791e1b4@rorschach.local.home>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:55:55PM -0500, Steven Rostedt wrote:
> 
> After working on this, I believe the real Fixes tag should have been
> 
> 2c2b0a78b3739 ("ring-buffer: Add percentage of ring buffer full to wake up reader")
> 
> Which was added in 5.0, so this is the only release I'm backporting this to.

Thanks, now queued up.

greg k-h
