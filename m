Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A5446842;
	Tue, 11 Aug 2026 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457607; cv=none; b=RRM/BgRAvbL7/tgOW9BwBHm6EWh2O+ojjbvuec59rE0sTuFf18EYQFyhALWsQrHgjKkW9Tv7cUsr+t/8oBh+lOs8kowDHcT9rgeOEjsg3/do7QdB9DAjzUdeNOrlXxGYR9etC2fTe3GdW3+NLRFrfmNKEmj9cE48dfgotpzJZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457607; c=relaxed/simple;
	bh=qwTWTfDyOGww1E+Xdd0HkYGD4eGqQAaYvmshND2T8Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQ7MiLZedbfRbyNPOUL/ZXbQbjE1N2Cp+ZC5cppurbPe6QA2N8NI9/nxsQG4om4XQUpRIKXpori6fYYVF/FNEtdzh/pw/9EOgsBRSx6UUPu5DCaot2ImpifzujN/IjkXZuqm/2edJTqtio27+Qbu6wsFUSstJrfykLrD3SYeHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id DCC051A0446;
	Tue, 11 Aug 2026 14:13:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 08DE220027;
	Tue, 11 Aug 2026 14:13:20 +0000 (UTC)
Date: Tue, 11 Aug 2026 10:13:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/18] tracing/remotes: Add dmesg tracefs file
Message-ID: <20260811101332.4322a16a@gandalf.local.home>
In-Reply-To: <anstdpyNVXzYzTl3@google.com>
References: <20260804140333.797210-1-vdonnefort@google.com>
	<20260804140333.797210-7-vdonnefort@google.com>
	<20260810184216.3484cfd6@robin>
	<anrmx86wMG0Jh-E1@google.com>
	<20260811094857.69dd650b@gandalf.local.home>
	<anstdpyNVXzYzTl3@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: f4wbh5e36rzh6d1fgxm15x73khrhhmoz
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 08DE220027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19eUXDw18E85gixP/zTRtl9KlJKHukOrrQ=
X-HE-Tag: 1786457600-597930
X-HE-Meta: U2FsdGVkX19z2k+YAVxGlhgZikoE3aCihr9YaCg9WR1XMDVhO1r22eBc7Gnq5eYVCMGk1h/RqF0saYIWZ7/yOEi3k7qRR5re+lysX5fMBw9K1eOSax6I2L232sxgQNdVCTQGjjxzesVDBInCV/kh2UZgyrXMdvGLFECR7DC3ar9s6cVKg3vTk0CkCOF744OT6Q13EZK1hANy/W3RgRXzzFpXR4FyvGLy22Nd5gTI3wZaDzAg8BGZVYUILz/T/JJAH/4HYUyy6gMsM8AHcj4fgpAVZEzSPCwavHkWBOZ1R6EXAcLDH3QdTPRY3KtKHSlcDuBH0nbAM2rq6zPv7fRFpNvWmJ/fJ1br

On Tue, 11 Aug 2026 15:11:02 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> I don't see anything preventing the declaration of a massive print function at
> the moment...
> 
> ... and neither the registration of an event with a size bigger than a page.
> 
> Is it something we should consider? I have ignored it (in both trace_remote and
> simple_ring_buffer) as it seems very much unlikely anyone would do that.

Yeah, it's very unlikely that it will be hit. But something we should keep
an eye on.

-- Steve
