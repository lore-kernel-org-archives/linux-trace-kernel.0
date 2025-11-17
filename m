Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2256132D422;
	Mon, 17 Nov 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392827; cv=none; b=NB0wWHJlmiHo5YE3pGNJ+F7OGEsxXPAf09YbZdSWjWNkr7RfZfbJefDsDhS/g1XTZv3LB4JYbDV5fXEIaMzHhzHD1vD3JUlXcO+L/6Z4IvgPClRQXWK71yklhcf+4mkgktTY3czBJEzJIhKjhP/GDCKwj6hzMNJFbjZrDEL22Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392827; c=relaxed/simple;
	bh=U4HGRPJm3Z90274kUDYelEyG+c9qpjOgBxd3TkWvcxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WHAMRfWRg/UVpixz0rLNDRZG4v0i2IarZn5C94mLPY9Gj/EL31doK6RBZqCpN+oK5ssyA7eO7MAn8Owq0d3dK4pAT2ch/iARMutgOdMviKl8243iJaspWe7G3nJmINvhzbEDUjBFxowZLzppwRj4zQ1f/7g3HQKUEt+OMhHBpGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Rig1aWO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VNl/ftej; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Rig1aWO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VNl/ftej"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763392824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Okc2tOhfNMOvJaBEghCnnpcNvAiizNtd+a2AMZGZHuw=;
	b=1Rig1aWOcaNyRlsyx70uXULScn7IGLRCIwT34ZPCJi2B8VGDNvjeJGUhCmNg/KBSdBq3x0
	uPc0br1jIhbWi2qwXoAudOFhJXMd81YrS4xYaorEUjcw1zExRFf1u9xZAMnCbFd6j9TJjc
	rUKdkGYJhNXsXPN5a/Jz61j+Y27ho+c5bPGpebaWWfv7NO0aEPaVCKYgQuPfoQDbtL0PYK
	ELfeVFGprDKLsVH+uBhqJ1pE3gxeHShwkMAP2mu9iTpl6Y82ZijHq06899wJU10cNbUTkP
	whIrF8TRXT445UeFr+z9EkJEo7fV8DeZs1Sc4Z8IAzcjkOwtoN188aIhGxVT1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763392824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Okc2tOhfNMOvJaBEghCnnpcNvAiizNtd+a2AMZGZHuw=;
	b=VNl/ftejbMyQ5nz2gj5GHjk7Ks8P+gw2cqUoNxSiwollEaGH8fZbP4RNcSRKVYNZiV9x4s
	MZtm8pUJdGhMDODw==
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rv: Convert to use __free
In-Reply-To: <20251117100735.71466d12@gandalf.local.home>
References: <cover.1763306824.git.namcao@linutronix.de>
 <6b2a618815b45ac4ac09976ef4fb0bd3635c143d.1763306824.git.namcao@linutronix.de>
 <20251117100735.71466d12@gandalf.local.home>
Date: Mon, 17 Nov 2025 16:20:23 +0100
Message-ID: <87o6p0heiw.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:
> On Sun, 16 Nov 2025 15:35:12 +0000
> Nam Cao <namcao@linutronix.de> wrote:
>> +	mon->root_d = dir;
>> +	retain_and_null_ptr(dir);
>>  	return 0;
>
> Why the "retain_and_null_ptr() and not just:
>
> 	mon->root-d = no_free_ptr(dir);
> 	return 0;
>
> As from my understanding is that the retain_and_null_ptr() is for use of
> passing the variable to a function that will consume it. But for assigning
> to a variable, I usually just use the no_free_ptr().

I wasn't aware that no_free_ptr() exists. Gabriele has pointed this out,
and I fixed it up in v2.

Nam
