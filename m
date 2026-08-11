Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6984457C7;
	Tue, 11 Aug 2026 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456144; cv=none; b=GN9kADVRAR8fkD65nsndSmiPQol8VYNDxlfWYfA7gI9UUl39SGAI2pnA2SlxQxV34wNB43JWCCjLZNdEG8YjMQEgaR/zmOwpvoa7JETzvxLUOlOsGLcpe7lYRhdd5cjmzDxd8mKN4TmLLItsgMXzm4P0RGed4y/kseXjiyDpXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456144; c=relaxed/simple;
	bh=LcXuId6pnJWW5rMdnmvnoIAdJRRBOugRtX9FfWgo6Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vqcc7SymLR39/OZwGOL0yf+pGdxr9BWQbcqWLMZ4Y3g2J1iJOCCd0FZyMl+aSAYNfrUM4FuPQbmuxSJrUDGrtGyhcx8dnrCpXpk117eXDKr5iKcS3oDSbMa5ts/EbgztmB6STuKDpTv/hcMwiV5TpCkLsPr8GX76DZXKQwDkzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id A8C86803F9;
	Tue, 11 Aug 2026 13:48:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id BCC9C20027;
	Tue, 11 Aug 2026 13:48:45 +0000 (UTC)
Date: Tue, 11 Aug 2026 09:48:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/18] tracing/remotes: Add dmesg tracefs file
Message-ID: <20260811094857.69dd650b@gandalf.local.home>
In-Reply-To: <anrmx86wMG0Jh-E1@google.com>
References: <20260804140333.797210-1-vdonnefort@google.com>
	<20260804140333.797210-7-vdonnefort@google.com>
	<20260810184216.3484cfd6@robin>
	<anrmx86wMG0Jh-E1@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BCC9C20027
X-Stat-Signature: i1ixbqixmnj7hx4zy7hyh94bcjkdmp4t
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19lCkiFheqeD1sq7CunsKsN3qj1lYPi/08=
X-HE-Tag: 1786456125-532884
X-HE-Meta: U2FsdGVkX186DZIAxlBmHt412R2R+G71fDfbrJFkhLQ/C3b2tn/CTdkY4m4sOS9en/3z49J0glfcBtlUJyI2IRd/DfJyR+hDwzXtLc2vMmc5SZziohGnBFOaukC+CpI4fdJl82cFI6lg1dj4XmiCeI6ga2GWfkvgSgBewpP2SBGI6J9GDeh/aWuZGZzaLtEaNMAfAmxQ1fPkpbwMlMnvPpoy6G1m76/AqgWmOwY1PFlBT0VphtU4K1plIdfnuK3r1luWvfyiobVnB4oL8HXaENGF+k4lmlEMpHaUFku+Ggt14O1SfNj0CbwzCHvI2W341KFFidC2sVYt57+CEbyN2AdiAfkLJCpU

On Tue, 11 Aug 2026 10:09:27 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > > This is a pre-existing issue, but if an oversized event causes
> > > trace_remote_iter_print_event() to return -EOVERFLOW, will this break
> > > the loop without calling trace_remote_iter_move()?
> > > 
> > > Since the event is left unconsumed in the buffer, could this lead to an
> > > uninterruptible infinite loop (hard lockup) when reading the trace pipe?  
> > 
> > I'll let you answer the above.
> > 
> > -- Steve  
> 
> I don't believe this can realistically happen, trace_seq buffer is 8K and remote
> events are really small. 

They are small until they are not ;-)

Is there anything that forces their size to be small?

-- Steve
