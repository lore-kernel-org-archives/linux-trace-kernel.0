Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C181C5F2C;
	Fri,  8 Aug 2025 05:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754629940; cv=none; b=GzFvrpWplK0CCUhuZJhlrwieexmzrHm+AkiEAWH9/GKwR76sCbRbM8rehU9b1o9PG3kqz6pIPBB60UC7NLuMPKsfYlBukCXafh1PmU5qqCMxR4uiAFYdGTXHuOCNkfh/bRmOTFoz/Zqy1dhXBPhEftqXMaozL7ezBBVABh9rQcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754629940; c=relaxed/simple;
	bh=JePby3LynBt2EamhXGDR2pCcDuW93SWFbdrkEr7YO5I=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Aw6JNMKlwkKjMEUNyO70pD5Q4aHJskhgi2qvhV5z2KiDhk7zfon9CxW1j9DpeS5Gc713jcmIU3ZLqRm+PpR74TSf9Y0YV7MFsRgypdaeO5X33bauXx0fYY1CcvtD1iEe+4m/199DlCYLZpmpWmqdceYiGInS63wKoXFCR3oLDQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jVagqRyo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uNipW5YA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jVagqRyo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uNipW5YA"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754629937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JePby3LynBt2EamhXGDR2pCcDuW93SWFbdrkEr7YO5I=;
	b=jVagqRyonN+sfCNgL1NnggHAv3Q7adSqt91y8FAmjy7J59PZ/07tDw+vd/D5gll9JzWEXo
	ue8Yo6Am81rCZv7v/MCljfVyHnlvjXv2qC6YbNFTBxrX2AMJcLuqhp8zJhMmacnhgVwdA3
	1nq8Y8v4O/SkzP9wgzlMTZNn310iWMSDtmdymgYv1Bbe4RYjGo5HLvRe+jVNTcMQJOMrQB
	0I4FUtG+tP9pWEKHvj1UJ3FODlNYNo5tnMNV6dZr+HDVM6XJ4ByHBHzVUaFY5jcny87JRU
	KPWEJWouIdRW1zEVUGIIbQsVWrBOgxCRj3ADs0r+GCGfgxw8ELuB2HjBVojzXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754629937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JePby3LynBt2EamhXGDR2pCcDuW93SWFbdrkEr7YO5I=;
	b=uNipW5YAEaX5LMMslbLVwnvODloV2Ij+y7MIX01+/H4U8B7cdMZ5JeRkJH+ABkeZsqhL9d
	1t0CyEOLqsFlLYCA==
To: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] verification/rvgen/ltl: Support per-cpu monitor
 generation
In-Reply-To: <6754c61d60fc161963d0625a4b647a241b363fc5.camel@redhat.com>
References: <cover.1754466623.git.namcao@linutronix.de>
 <ccfa5ee80e6114b046f04dc1bf1de0c4e7a11c09.1754466623.git.namcao@linutronix.de>
 <6754c61d60fc161963d0625a4b647a241b363fc5.camel@redhat.com>
Date: Fri, 08 Aug 2025 07:12:16 +0200
Message-ID: <87o6sqpfbj.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> I get you're trying to be more type-agnostic, but I believe this
> /online/ is a bit imprecise, unless you register a hotplug handler and
> just initialise the online CPUs (much of an overkill I'd say).
> What about something like "this is false if the monitor exists already
> before the monitor is enabled"

Sorry, after re-reading this one day later, I am still not sure why you
says "online" is imprecise. Due to hotplug, CPUs can become online and
offline.

The current implementation ignore hotplug and initialize all possible
CPUs as if they are all oneline. But if hotplug becomes important in the
future, I may add a CPU hotplug handler.

> Other than that it looks good to me.
>
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks!

Nam
