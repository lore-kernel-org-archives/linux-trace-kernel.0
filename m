Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E71BC05027
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 10 Feb 2023 21:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjBJVh7 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 10 Feb 2023 16:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbjBJVh6 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:37:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F323760E7B;
        Fri, 10 Feb 2023 13:37:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E36561EB5;
        Fri, 10 Feb 2023 21:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2032BC433D2;
        Fri, 10 Feb 2023 21:37:56 +0000 (UTC)
Date:   Fri, 10 Feb 2023 16:37:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 20/24] Documentation: trace/rv: correct spelling
Message-ID: <20230210163754.3b215c19@gandalf.local.home>
In-Reply-To: <ac5e8ede-2a56-4a7c-b4c7-77dc6216a194@kernel.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
        <20230209071400.31476-21-rdunlap@infradead.org>
        <ac5e8ede-2a56-4a7c-b4c7-77dc6216a194@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 9 Feb 2023 12:45:27 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> On 2/9/23 08:13, Randy Dunlap wrote:
> > Correct spelling problems for Documentation/trace/rv/ as reported
> > by codespell.  
> 
> Many thanks, Randy!
> 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>  
> 
> Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> 
>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
