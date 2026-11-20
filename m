Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186926;
	b=Ah0TT5h79+LnV4pT7xw0by5NIZUBGRNxAuARo7FGei4FuixZWfP09HIJHsjkWsH9eulf
	 YS3CnnG6GH/pFvAIc/hAFkKvM2QB4SBJa8w63v1UkyvlvLIsZBb4d3ftsjULiDrWWI/3j
	 AhLyYv2lPR2AiVdv4Zs92Tv6M/86GmpJgA2V4z7RCLZXZ+3h0Q/yO0FXF494KXfkybAG3
	 cOzvEvcLcS2+zbvURCCCiQZwjfC9xKvvrEiAhkwUrg32kC6UjVbFZ4UkqaAcsFMTQX18H
	 HZdRRhnsebJiiy5qf2PXkj9H5zb/DDd5kxS0hgNoVURIh6H7no1zHV7WOCxdSNdfmCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186926;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=BBFOIz+klR4QMUOeWXRV/f88UPnpaiHfbfIHkmv7NgU=;
	b=pQ6bhsy587abWyuHTWSQxAnktBparxSyMkV1Rjf64f1nY+naSyVnskJjMc4vFv0S4XPM
	 cuxekQvC666ZdfQd7vkXBE9e1sgWTOEWlvKNgirff2/9KxSIou49wzMefs6IQvoJA1dEr
	 nKFFXbUk8qlN7Kn1ptpxV6UH3TPhf0PDl5HtW9nQN7MT6rvYhtFlF2o20HsG/4z589MiU
	 gSGdVTl7fH10mWZcWa8zJnJpOAev8JLuP5xi4TJvRdOKjvvCXsCQfJxWmLQkE/NPnAc3x
	 NmekUCyNDJQD1yz0LaV3zrcRgOBdW/CD0stPUKnvAestuViwwYFoNUm91tfcxKaW5/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=VQ7RPYYy;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D326074D17;
	Fri, 20 Nov 2026 15:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5D326074D17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=VQ7RPYYy
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id B24E5A8FA4;
	Fri, 20 Nov 2026 15:02:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 7E2F120010;
	Fri, 20 Nov 2026 15:02:01 +0000 (UTC)
Date: Fri, 20 Nov 2026 10:02:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot+eb74dca0d1eb3ec227a7@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] ring-buffer: Skip time delta validation for the
 counter clock
Message-ID: <20261120100200.4f8ac19b@gandalf.local.home>
In-Reply-To: <CADZg-m3Wxkze0t9u1+dvn3Rrart54_eyi5XDcOSE+9W94s983Q@mail.gmail.com>
References: <CADZg-m04iG5kCZ5-yh=Vz_ysYjVDGSYn3je4_-8AzWWfiC-bXQ@mail.gmail.com>
	<CADZg-m0FeLntAS6XxE-kc74vwH-jAh+jXT68qnVwXuHZNUHzfA@mail.gmail.com>
	<CADZg-m3Wxkze0t9u1+dvn3Rrart54_eyi5XDcOSE+9W94s983Q@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7E2F120010
X-Stat-Signature: 7h3cf55ih1ubk61hsgqpahhxxbdqt4nz
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19P3U7rEiGgz/KaeMNUspQQiiLSVO8YZe8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=BBFOIz+klR4QMUOeWXRV/f88UPnpaiHfbfIHkmv7NgU=; b=VQ7RPYYyCGHLRJ31x+XnzR9jCiPYPDPKgjXNatxGiqpoVhP5wBiEhIw0L4YZMc8SuCJSLCh1wDYT23/J1g2J7m1iKJk8R1jSIvJ5DUDik8dt/VyDqJ276SX/TPvc+6YN2J94VGWrf5mMk0ZaTJr4LnNKBXF2AsW0rPjLx/6fnhE=
X-HE-Tag: 1795186921-332108
X-HE-Meta: U2FsdGVkX19cZamt8VBOOHAbsfurHqvPIqjcByT8+z1K2RNeQ6mU2WFp5JwjJs4FIwn69s5OGiEvGDmq8M00/KRdm4Q61HH9Y+IjQ+Lx4joB5kUKc8f3Fwwr5duD5m9RcOY1/TmipDQ0Z/s6PJWksbPY0IXoF5s87NtTMXjlFExZwR/0TEyr6TMZWR1VFOcvk1eFZ0oN+Ecvy5XVyXel/UGcDQSnj4bFbSuhoaAcVojo1lRyE1yRfE3vU8iT/Nr5Hmm0Y2pENjvwAGCD7gpsFHB4t0P7nNxwQrZIT6kyulQ4vRv9P0JHH0ygKrUq0V7Hi7qNh2ifpf02eYer7NvOJzAwMHDe0jio71HpJ+sH4aRzaWH1ntWceJVnWIOD8TBxQuzDDOoIQadM0f24U6bw9Tb6LMOPUpYW/XAz2MZfRm+2Hph5O26DNbjz/Dsf3Yi+LdU5N+Jh3hWYIonrKXEUj/EkbO2vvdEHRw5nOmzZbV0=

On Thu, 5 Nov 2026 06:19:54 -0800
Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com> wrote:

> The counter trace clock increments on every read. Time delta validation
> assumes that the clock values read while reserving and checking an event
> can be reconciled with the deltas stored in the page. With the counter
> clock, this assumption can fail for an intact ring buffer and report a
> spurious TIME DOES NOT MATCH warning.
> 
> Skip time delta validation while the buffer uses trace_clock_counter().
> Clock selection already resets the buffer, so events recorded under a
> previous clock are not retained for this check. Recording and reading
> counter-clock events are unchanged.
> 
> Link: https://lore.kernel.org/all/20260920161648.7d9fda60@fedora/
> Reported-by: syzbot+eb74dca0d1eb3ec227a7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=eb74dca0d1eb3ec227a7
> Signed-off-by: Kirtikumar Anandrao Ramchandani <kirtiar15502@gmail.com>

I'm going to hold off on applying this because I'm not fully convinced that
this isn't hiding a real bug.

I remember looking into this in the past and thinking I found the reason
the counter breaks the check, but when looking at the code again, I'm not
so sure. There may be a real bug here that only the counter can trigger. Or
at least trigger more reliably.

Until I'm sure there's not a real bug being hidden by this patch, I'm going
to keep allowing this to trigger on the counter clock.

Thanks,

-- Steve
