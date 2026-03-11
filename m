Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F25320A0E;
	Wed, 11 Mar 2026 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250791; cv=none; b=LHtM9VEPEGZ90XMQMKXrX6E/dU0fEAbFCCzKC1WQUcNMXaH8GmOO5u+f1t5+EC6noFBoieCwe7BTsxNiHVAU9xEcR4x62MJQAJy9/RuLjyuJfx8HDydnI1IPEE1psqvKbUxAxwMfZKXzFTwiS139lDTMtdfHjZQcGGMavaLk6sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250791; c=relaxed/simple;
	bh=4W/2p50BtvDPqYevYA0CZrb3DELaMSk/nUR7ZUJPlnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1WzznHbjqfsqUgjCKi0LZEEBfQmIR431CwQTdihMo6RtdIpyCLMeefcFIkKHk42F5EERsvHkqQswIkbUgI7Ol0sDKHIBuC3q6CuTcPvW3bryNVDhaVwYJoeA3eXSbwyYUbFRpBLvF6XpYLlJ+vK32oA9QIrvIIuZyPlXo3R1nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 648041A01E9;
	Wed, 11 Mar 2026 17:39:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 9C87760010;
	Wed, 11 Mar 2026 17:39:39 +0000 (UTC)
Date: Wed, 11 Mar 2026 13:39:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, longman@redhat.com, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] disable optimistic spinning for ftrace_lock
Message-ID: <20260311133951.106e67c8@gandalf.local.home>
In-Reply-To: <20260311130743.63c997ec@gandalf.local.home>
References: <20260311115250.78488-1-laoar.shao@gmail.com>
	<20260311115426.GN606826@noisy.programming.kicks-ass.net>
	<20260311125350.1d89341f@pumpkin>
	<CALOAHbDqYjJngQmmOaPRA=k4Bb8Or39YNp5R98f_op4dti2_TQ@mail.gmail.com>
	<20260311130743.63c997ec@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: wotek3qwjxh4emup9bszk1kmzagnkdw9
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 9C87760010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+vYFyhUAxgNaxRmAanNX907bI4Ci8dVCk=
X-HE-Tag: 1773250779-660315
X-HE-Meta: U2FsdGVkX1+KwsOdFlIVRmHUWTTVOpC+Z7jHN9+v88YcXoQpf3uxMyfbCbCO05n2Jhr6w4x/0BC+VWXKToC3jFaIZg+/koW4fyrVfw69sQ1EJP9hyBP6nFektNkXw0ol25gXndxJRi2eznT+iwhySOQ5rMSXOcMBS1oMbZLFczHyz7FazB5EOSjAfBQ16OeIMdmmGgwmM/TTfRsMJSzLqi9YSJsLdoefulUXR7kRp42W/DSprPElYU5haPyVsfHe8UQQFORtSxE6STRSPk9zrHbu/whhMX+Ud5xt2/i8jxvpPLZ/Gd0YRM0qVTnjhDfXb/54gdZwP3x0EjcO7nFkKdH1yLSHFUaMSTlO6lwwTZXRHiisEPxWKEK9AfHrwiGe

On Wed, 11 Mar 2026 13:07:43 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > bpftrace reads the complete list of available functions into
> > userspace, then performs matching against the target function to
> > determine if it is traceable.  
> 
> Could it parse it in smaller bits? That is, the lock is held only during an
> individual read system call. If it reads the available_filter_functions
> file via smaller buffers, it would not hold the lock for as long

Hmm, I guess this wouldn't help much. I ran:

 trace-cmd record -e sys_enter_read -e sys_exit_read -F cat /sys/kernel/tracing/available_filter_functions > /dev/null

And trace-cmd report shows:

[..]
             cat-1208  [001] .....   142.025582: sys_enter_read:       fd: 0x00000003, buf: 0x7fa9daf21000, count: 0x00040000
             cat-1208  [001] .....   142.025995: sys_exit_read:        0xfee
             cat-1208  [001] .....   142.026000: sys_enter_read:       fd: 0x00000003, buf: 0x7fa9daf21000, count: 0x00040000
             cat-1208  [001] .....   142.026392: sys_exit_read:        0xff8
             cat-1208  [001] .....   142.026396: sys_enter_read:       fd: 0x00000003, buf: 0x7fa9daf21000, count: 0x00040000
             cat-1208  [001] .....   142.026766: sys_exit_read:        0xfed
             cat-1208  [001] .....   142.026770: sys_enter_read:       fd: 0x00000003, buf: 0x7fa9daf21000, count: 0x00040000
             cat-1208  [001] .....   142.027113: sys_exit_read:        0xfe0
             cat-1208  [001] .....   142.027117: sys_enter_read:       fd: 0x00000003, buf: 0x7fa9daf21000, count: 0x00040000
             cat-1208  [001] .....   142.027502: sys_exit_read:        0xfec
             cat-1208  [001] .....   142.027506: sys_enter_read:       fd: 0x00000003, buf: 0x7fa9daf21000, count: 0x00040000
[..]

which shows that even though the read buffer size is 0x40000, the size read
is just 0xff8. So the buffer being read and return is never more than a page.

Unless you are running on powerpc, where the page is likely 64K.

-- Steve
