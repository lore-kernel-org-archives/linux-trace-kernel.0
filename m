Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC961C7017;
	Wed, 30 Apr 2025 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746002308; cv=none; b=k5ZGiP2s7SIV/vpce5sSCI6eY0XRmB3pOsJ6p/Mzd1T7MbyrtQA28QeZW5eRnsnPC37I1Sr1J0EYryD4g/c3B9KZxKt77vFjqVoo6EP9HhYolVT1Wq5ra67ZFLrIhVNY6gDTTlm6DOwMyPJ9xTamDWtfZh8r/fzquMAy9fINTss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746002308; c=relaxed/simple;
	bh=5W+BttyNrx6QCpGXeulQZ8MO5gxve/TsYWvBDtxJqyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MI8vEOfdJRMyT162PMA/A0sZFcVoLws/Zl6GjcSSanGri4FourSA0Vae3MyqnqF2cUpNss3/srpdP9ANvTGrIM9ll6G7kRdo/cjW+R60C1ehuChcEuWRWL/0wHlgqL5rukxbpxqEMpdvjMgIKNSK4HsqzApa9vdoZfqnjVry2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eTnO9kFV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sPepPg7f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eTnO9kFV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sPepPg7f"
Date: Wed, 30 Apr 2025 10:38:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746002304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HG13rZ9/BdN7VQFKd7Jm7KmYTv9EqNp3CTV2ih2XQKE=;
	b=eTnO9kFVC/riHFiSA0xhXQ5jGUJDjElswE/MRvYmWsmvFQk5wZIa5GdgBGrhvpXh0Ut5Zc
	Hr3JsEI9/npeRj4PCSL+zPweP1VNZH36mDtwFuN2mOwolFGanjTJe00WOt59xp5SjKPZvV
	OT2hIp0bqhGzzpZG1ITl3/7Og9espBbIK9YSha7o5BlH+ajfIChDyauGNl9CD7Q9Aaimit
	K3LeST4SRGuS66pt12mIDKhRCmgLAzZENG0RK37q6Xd5nlGRLhohzEcEnTxelaUgc5s/x7
	UWg0BLK44XnarqbQlUTE7DR6d/zxIchZHymKeiYPIUWunu8T8AjcjQrlOm/waA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746002304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HG13rZ9/BdN7VQFKd7Jm7KmYTv9EqNp3CTV2ih2XQKE=;
	b=sPepPg7fCYJlcOfVtGUZgG9gHkA4Uj/JXvKzjOLf5SBJgluWKDYSwmOBbEcEndBrwmQbnG
	oypekW5SkjgUm2AQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 21/23] rv: Add rtapp_sleep monitor
Message-ID: <20250430083819.-UXxRu1U@linutronix.de>
References: <cover.1745926331.git.namcao@linutronix.de>
 <57ea14992e148121fc010a200986e4db60ac2de0.1745926331.git.namcao@linutronix.de>
 <bfe8322cf5817037af57f10ffbffcd9b30f43b42.camel@redhat.com>
 <20250429172055.QICnVQ2s@linutronix.de>
 <c0dca589e8615e1e0105cf1ae20f3f613992d33d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0dca589e8615e1e0105cf1ae20f3f613992d33d.camel@redhat.com>

On Wed, Apr 30, 2025 at 10:05:07AM +0200, Gabriele Monaco wrote:
> I've got one more small remark though, the name ALLOWLIST doesn't give
> justice to what you explained above.
> It suggests me something potentially wrong that we can't do much about,
> while in case of RT mutexes and futex lock, we just don't want the
> monitor to yell in a perfectly RT-compliant scenario.
> 
> What is happening here, from what I see, is that the kernel is handling
> the RT behaviour and your monitor is just meant to tell when userspace
> is doing something it could do better (unless we deal with kthreads,
> there we are in fact whitelisting the ones we know are not complying).
> 
> What about calling it RT_KERNEL_MANAGED_SLEEP or something along the
> line to say we just trust what the kernel is doing?

That would also work. The generated automaton should be exactly the same.

But I think this is quite subjective, so let's not argue too much about it.
In short, I prefer it as is, sorry.

I think "ALLOWLIST" is a suitable name. From Wikipedia: "A whitelist or
allowlist is a list or register of entities that are being provided a
particular privilege, service, mobility, access or recognition. Entities on
the list will be accepted, approved and/or recognized".

We trust rt_mutex and futex_lock_pi to do the right things, so I think they
belong to the allowlist. We also trust the RCU thread and the migration/
threads to be correct.

Best regards,
Nam
