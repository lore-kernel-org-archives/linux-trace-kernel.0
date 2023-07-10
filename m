Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D2DEB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 10 Jul 2023 21:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjGJVkZ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGJVkY (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 17:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055FCE0;
        Mon, 10 Jul 2023 14:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 975C16113E;
        Mon, 10 Jul 2023 21:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6893C433C7;
        Mon, 10 Jul 2023 21:40:21 +0000 (UTC)
Date:   Mon, 10 Jul 2023 17:40:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Florent Revest <revest@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, kpsingh@kernel.org, xukuohai@huaweicloud.com
Subject: Re: [PATCH 0/2] Ftrace direct call samples improvements
Message-ID: <20230710174020.37cfa376@gandalf.local.home>
In-Reply-To: <ZIQ0NBiNOEkzC33Q@arm.com>
References: <20230427140700.625241-1-revest@chromium.org>
        <20230609162046.13d19398@gandalf.local.home>
        <ZIQ0NBiNOEkzC33Q@arm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Sat, 10 Jun 2023 09:28:36 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> > Is this going through the arm64 tree, or should it go through mine?  
> 
> Feel free to take it through your tree.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I think I missed your email and let this drop. I'll add it now. As it's
sample code, it should still be OK to add to the rc releases.

-- Steve
