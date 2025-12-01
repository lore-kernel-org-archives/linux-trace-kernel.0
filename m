Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79B32D0E2;
	Mon,  1 Dec 2025 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602915; cv=none; b=NsaQKJXF8lqvJgP3wtuEI/jZUMSqEslHmHq0LMoaGzpY1Eq47vA29XdejomXM4d2KSBs5unKdvFYi82Tb8MhugHzSlLyyUIUwvpZoRpUvl7VoIDRVQxYAJFeDb+nk79VPlcx0YiRVs8DOE2HYIHZ8Iug15PYqnKvcOUUzVOKWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602915; c=relaxed/simple;
	bh=j90TmspklQNJCoFtGO+CIDKqicFJOkTJeCEiaoNNYFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dz6TvD4OCaWOcUiRfULiuvVg5oUZoH1w7fxvwB+8a/jDs7duFyV4mf71Jcg0YUrMWv+1Pvy8CiLzV6nO1IO4M7ggDEuNzYXSwKUOMEA83rZPkSQRJw8Neq1u2IUHt0PspeDDiODPlq6MhE5ob+ZHjy34KpwOsZJx4BYfb5p/3hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HVoBCUNO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eqUktx2X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HVoBCUNO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eqUktx2X"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764602911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j90TmspklQNJCoFtGO+CIDKqicFJOkTJeCEiaoNNYFc=;
	b=HVoBCUNODf+I/43L2iGsiKwomDWfGynJZpH6eZzBDOEskn0z/SCliDx/kj2GQIn0z2KRls
	5Y6edb67J7lXh7VOP9P+6eqya1E0Vbs5aPCehSnh5hzcpwpXbTrHG/52RZMxoign/EsgRU
	kpHm+njBZEtDGYwgmiUX598Etl8ZP+OVJ1t3zJ59ngejgozS2TZ0Y83a5w1kejv0IAwIcE
	mV2TRdd5bV6b7odnWQU7fRZE5lNVFojm283iGPAr60WwImwVyhM5frFoEA7dlbR0RL2KwH
	+sajPSpa8dcZKiWKGUYvyWDEOLFT3zM33fMih2JZDX2cuA49jpme3GwIh1SxVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764602911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j90TmspklQNJCoFtGO+CIDKqicFJOkTJeCEiaoNNYFc=;
	b=eqUktx2X8xDUn69uW87qsyQWwzLHCBguYF1wttyXlYx5G7FSlDFa3O53lahOlRtkg1SaGU
	TVnpesKg5LXrJICA==
To: Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rv: Convert to use lock guard
In-Reply-To: <20251201102447.53f33be5@gandalf.local.home>
References: <cover.1763370183.git.namcao@linutronix.de>
 <dbefeb868093c40d4b29fd6b57294a6aa011b719.1763370183.git.namcao@linutronix.de>
 <20251125145736.48c3ed9d@gandalf.local.home>
 <e4838dd91f14024222eef8e705f2b1ae7945bb80.camel@redhat.com>
 <20251126095106.7eadaba6@gandalf.local.home>
 <2e46a7dc417119bb7e331ff14253b0ff678d697e.camel@redhat.com>
 <20251201102447.53f33be5@gandalf.local.home>
Date: Mon, 01 Dec 2025 16:28:30 +0100
Message-ID: <87wm36p6g1.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:
> On Wed, 26 Nov 2025 16:22:17 +0100
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>
>> I can send it quickly since you already had a look at those two patches.
>> It isn't a big problem you won't have time, though. It can stay for the next
>> round.
>
> Did you send them?

Looks like Gabriele forgot to include you as a recipient:
https://lore.kernel.org/lkml/20251126152253.464350-1-gmonaco@redhat.com/

Nam
