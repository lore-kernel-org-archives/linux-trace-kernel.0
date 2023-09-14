Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB512EEAA59
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 14 Sep 2023 17:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbjINR3k (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 13:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbjINR3j (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:29:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D161FF0;
        Thu, 14 Sep 2023 10:29:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF80C433C7;
        Thu, 14 Sep 2023 17:29:34 +0000 (UTC)
Date:   Thu, 14 Sep 2023 13:29:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: [PATCH] tracing/user_events: align uaddr on unsigned long
 alignment
Message-ID: <20230914132956.569dad45@gandalf.local.home>
In-Reply-To: <20230914131700.0ba3ee80@gandalf.local.home>
References: <20230914131102.179100-1-cleger@rivosinc.com>
        <20230914131700.0ba3ee80@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 14 Sep 2023 13:17:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Now lets look at big endian layout:
> 
>  uaddr = 0xbeef0004
>  enabler = 1;
> 
>  memory at 0xbeef0000:  00 00 00 00 00 00 00 02
>                                     ^
>                                     addr: 0xbeef0004
> 
> 				(enabler is set )
> 
> 	bitoffset = uaddr & (sizeof(unsigned long) - 1); bitoffset = 4
> 	bit_offset *= 8;				 bitoffset = 32
> 	uaddr &= ~(sizeof(unsigned long) - 1);		 uaddr = 0xbeef0000
> 
> 	ptr = kaddr + (uaddr & ~PAGE_MASK);
> 
> 	clear_bit(1 + 32, ptr);
> 
>  memory at 0xbeef0000:  00 00 00 00 00 00 00 02
>                                   ^
> 				bit 33 of 0xbeef0000
> 
> I don't think that's what you expected!

I believe the above can be fixed with:

	bit_offset = uaddr & (sizeof(unsigned long) - 1);
	if (bit_offset) {
#ifdef CONFIG_CPU_BIG_ENDIAN
		bit_offest = 0;
#else
		bit_offset *= BITS_PER_BYTE;
#endif
		uaddr &= ~(sizeof(unsigned long) - 1);
	}

-- Steve
