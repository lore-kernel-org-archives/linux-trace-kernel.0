Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E750194096;
	Mon, 30 Sep 2024 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716857; cv=none; b=IXl0MJyOhSUzvqrWsnvbUJaXMWuALjX7lCN5TYxNGF9DFjozxzR6u9qP3S2LLqtHIcOF0Y8GDRxzQ8a8VJ9mC+wochGjZE8QuvIUBLSkpa8qz3Sx3fl3XdOCU7hRPqGFAJYXv6R3bQH/Odgy+qwAzNslqvK5psGlO6ZpOSlY9GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716857; c=relaxed/simple;
	bh=gCGwduzLFKbfMo5sOtW9HBBlHG7VBpwpUBFvEKyrqp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=giqfVRlP15HwcXtODpdZSGaftA1kD7NnmANzm6Mg9fOerOoCjhkuhyO9DKe3dZEhIpXxy0Iq7xV2MO1HOX9nOlTvbbeqP5Y3gi1I6s6vrOepC6t/uea5yCEcEa9yDaIu/GN3GI3yIJH9IF2weOJ60QmH9YY9y2UDIGMtYkXpbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qnzVrDOb; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qnzVrDOb"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B511D42BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1727716852; bh=VTA67/hhIeEVZwR1EvSjGu05ItIa+ynNR72w32LLj5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qnzVrDObJkf3RfxcfOH80UDiO0PIiouyZ01YuYEc8oKjfx8v9zeYDBD6WPn1JEfdU
	 +f9KosDqMHbcV63VYHOgCDpEx1iDtbFPkG864ubyFTMB0mCUVcBIUjb6Lg6HN2p/zX
	 6crT1BV0azMPnoWRgUkzpXbWJutJQEXuiTVWBpt7h+7w1wTTrh0JSkZdbkOXRER8Tv
	 8SbdwfpTdG+MwwKzqKUGOPYSKyJvFbyuFxhFXmFsrsw2fiqu45jQbvg9UX61bPfnZl
	 0gcAY8mtcpVMHfGmfTYMHQIQxfruMo1XSYqIGKbgsyp7lAsPtb8azOTXxL6KrmB5lu
	 kk1Q4MIj1AzQQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B511D42BFE;
	Mon, 30 Sep 2024 17:20:51 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mike Rapoport <mike.rapoport@gmail.com>, Kees Cook
 <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/tracing: Mention that
 RESET_ATTACK_MITIGATION can clear memory
In-Reply-To: <20240930131415.1438c0b7@gandalf.local.home>
References: <20240926130159.19e6d0e2@rorschach.local.home>
 <f8546c5d-fa2e-416f-8a1b-431025b4df4d@redhat.com>
 <20240930131415.1438c0b7@gandalf.local.home>
Date: Mon, 30 Sep 2024 11:20:48 -0600
Message-ID: <87ikud9hxr.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

> On Thu, 26 Sep 2024 19:54:48 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
>
>> Hi,
>> 
>> On 26-Sep-24 7:01 PM, Steven Rostedt wrote:
>> > From: Steven Rostedt <rostedt@goodmis.org>
>> > 
>> > At the 2024 Linux Plumbers Conference, I was talking with Hans de Goede
>> > about the persistent buffer to display traces from previous boots. He
>> > mentioned that UEFI can clear memory. In my own tests I have not seen
>> > this. He later informed me that it requires the config option:
>> > 
>> >  CONFIG_RESET_ATTACK_MITIGATION
>> > 
>> > It appears that setting this will allow the memory to be cleared on boot
>> > up, which will definitely clear out the trace of the previous boot.
>> > 
>> > Add this information under the trace_instance in kernel-parameters.txt
>> > to let people know that this can cause issues.
>> > 
>> > Link: https://lore.kernel.org/all/20170825155019.6740-2-ard.biesheuvel@linaro.org/
>> > 
>> > Reported-by: Hans de Goede <hdegoede@redhat.com>
>> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
>> 
>> Thanks, patch looks good to me:
>> 
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Thanks,
>
> And I forgot to send this to the Documentation maintainers :-p
>
> Jon, could you take this? Do you need me to resend, or can you just pull it
> from lore?

I'll grab it in a bit.

jon
