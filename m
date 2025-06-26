Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA741F5828;
	Thu, 26 Jun 2025 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750959722; cv=none; b=P+skOKn5EGabNUPn1G8vO4DkPoDstjhweZhBIa4dazKN9rusfX+vjP5Kh2UhrlDOBUfeZE01k8bcE//nUNgqVSL7Aj+eu866vTKJJmowilVU3w08Y7v3+mtmcvpbj8U7E6MI8DNtdR8mSIJ/0azuXSfpoYS8u2MeZ65Fnj98w1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750959722; c=relaxed/simple;
	bh=qmFia7iLnoS8TBPc4/gOMbKi6Y0VoHv/lRWuxR/OWO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Env5EdsO7ALXXm8p0zyGznwM3fjHoaU1heGYjt6ognRoeSoAoFJ1KIGKHU1zsiA6DjekuEh3VxcG6NCNEhttFkOvZT9eg7ciQJXBAz1zYyRUzyB8OCXqJXtyTnHXAGyl42f8MkJevT3GwVZCfG7rpj3Jf9X51O9uCUDiVU9Jaw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ttJbr47F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KYFarEOM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ttJbr47F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KYFarEOM"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750959718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qmFia7iLnoS8TBPc4/gOMbKi6Y0VoHv/lRWuxR/OWO8=;
	b=ttJbr47FZ+mSn3WE4r7U6rE1dykVY2ZwPoSPrQCD/hJNdGKK8qiIiup+QjCkCP7J4upEsE
	16DVRnNUScDLY659ullrPpgeSiti7OzqQIClFT3U2tIXMbrzrd8OJrswh2UNed3jUKYn2X
	umTlaTx/5+JMKs2k8D+5LNNzRTNszhS+9F8ReCnVP2W69LOBnixWz47/gSZkykfZpswfcB
	F+n3U5ZkRWrC+szrH93p1FC+pgPb2BiIIwDP0rvHjNkto8hlOpuQxsD7MPCDges7c/lOQQ
	zzdLe4s7NDctmym7jyhdhNwqu6H0QkSSO3YT/zJwbzjIZXLYTTZ9sskhx73gaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750959718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qmFia7iLnoS8TBPc4/gOMbKi6Y0VoHv/lRWuxR/OWO8=;
	b=KYFarEOMxmbi1dQP6DBsMWOIh2AFW1e8t5aXBW1PffSL9Zl3teizjvL0S3v6WTkwvL1chx
	E8h3wSSiZEq5DaAA==
To: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH] tracing: Remove pointless memory barriers
In-Reply-To: <20250626123445.5b01849d@gandalf.local.home>
References: <20250626151940.1756398-1-namcao@linutronix.de>
 <20250626113520.315db641@gandalf.local.home>
 <20250626160459.soHxOROG@linutronix.de>
 <20250626123445.5b01849d@gandalf.local.home>
Date: Thu, 26 Jun 2025 19:47:57 +0206
Message-ID: <84o6uatn6i.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Steven,

On 2025-06-26, Steven Rostedt <rostedt@goodmis.org> wrote:
>> Your scenario can still happen despite the memory barrier:
>
> Yes, but the point isn't really to prevent the race. It's more about making
> the race window smaller.
>
> When we disable it, if something is currently using it then it may or may
> not get in. That's fine as this isn't critical.
>
> But from my understanding, without the barriers, some architectures may
> never see the update. That is, the write from one CPU may not get to memory
> for a long time and new incoming readers will still see the old data. I'm
> more concerned with new readers than ones that are currently racing with
> the updates.

Memory barriers do not affect visibility. They only affect ordering. And
ordering implies that there are at least 2 pieces of data involved. A
memory barrier has no meaning when you are only talking about 1 piece of
data (in this case @buffer_disabled).

For example, update_traceon_count() has an smp_rmb()/smp_wmb() pair to
make sure @count updates are ordered to be after @buffer_disabled
updates.

read(count)
smp_rmb()
read(buffer_disabled)

write(buffer_disabled)
smp_wmb()
write(count)

But what exactly are the memory barriers removed in this patch ordering?

John Ogness
