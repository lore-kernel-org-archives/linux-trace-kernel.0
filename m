Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4BF3A1E90;
	Thu, 25 Dec 2025 01:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766626525; cv=none; b=Cpc5iBRWn6izUjm5SNcbYihV4tlFx202OVbk//LNGtUadqoDn6A8mW23o2kjSTMd8gsI8EK4REI2Js4yZlybB8edLMQdCjzZex7+1YAC91maRGrs+KHmqu9yeLd8kQBt2N4ZsNAfbiE5MVmd+N3ZRiruIBGjCgT2Pho5KOaJ9Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766626525; c=relaxed/simple;
	bh=4k5Vh63TfKbbtmXiNbg0EnRUPOlUjZwmEv+D2oh9WjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N1IuOm0ofFBo8UPNCC2PrUyDlYjhDJa31cFEOwHxIAcV6QErwfPvSqcQIxKQYHqNuD2T3+22Et58hGjn6OucsIO3Dc1J+uibrrpjGnoqJynsLSE6qiGuaC+4OAguKbY1LWPOE8MS7J/QZIkaEvLIOjaHNDXMVPzVsgAtqx+ARaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MQ7lYWLa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ti6a1Kgr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MQ7lYWLa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ti6a1Kgr"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766626521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W6P5PsP0rcCMugTHiacRPCl9s22uAJFGr3/d5SQkINw=;
	b=MQ7lYWLae8uwkBUfd8nTXhekcFM/ToNgl3OMopBEHV45fRLRAZNpWwFt3MUx8n7FS9YzEg
	RZ6+jYfwJXN5oZbsHm4LOH5xBz722xP09BUrTpJHKcneIkx2av/aUvqgKSIGzzL6e66rRm
	LjcuKcHbKqnD8DVt5OR2RxGUyWBcF2qUZFOKRNnCxqU/aD7wexRKn9qXRnhrMGg83ow04l
	G888cxaLOQQAU++B793eQpDUE/HXk2/OO4Qys1UQ/7ZGOcjiAiIdhAH9Ql7SwBy1p/zKDi
	d024FNmUI15mhlI1CYmQF2QNL3HdfgOTzvogAUhdQE2jjy8QtwPkvDglWXlTgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766626521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W6P5PsP0rcCMugTHiacRPCl9s22uAJFGr3/d5SQkINw=;
	b=Ti6a1KgrsMHUSV2aBkkSB7HZVhT7uOW9AspY6tV/uLrT5g5NlGM71JLRRyeygKcWjUspHd
	3neRwQaMiCwTswCA==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 12/13] rv: Add deadline monitors
In-Reply-To: <20251205131621.135513-13-gmonaco@redhat.com>
References: <20251205131621.135513-1-gmonaco@redhat.com>
 <20251205131621.135513-13-gmonaco@redhat.com>
Date: Thu, 25 Dec 2025 08:35:12 +0700
Message-ID: <874ipfbay7.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Add the deadline monitors collection to validate the deadline scheduler,
> both for deadline tasks and servers.
>
> The currently implemented monitors are:
> * throttle:
>     validate dl entities are throttled when they use up their runtime
> * nomiss:
>     validate dl entities run to completion before their deadiline
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

There are some helper functions that I am a bit uncomfortable with
(e.g. pi_of, is_dl_boosted, dl_is_implicit, ...) because they are
relying on implementation details of deadline scheduler which can be
changed. So ideally this patch should have an Ack from the scheduler people.

I can't comment on the model, since I don't know scheduler. But from RV
perspective:
Reviewed-by: Nam Cao <namcao@linutronix.de>
