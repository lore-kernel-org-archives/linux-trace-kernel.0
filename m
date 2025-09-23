Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF92EAB61;
	Tue, 23 Sep 2025 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617047; cv=none; b=cu+tE5dCh/M/AfwNDV7QrufkIizWB95xbLLFENZzmBpZcUOf1FCq03rmveB6xjpQQG52EgQKgpXL10wPDC6iB6u0w+O388cJoZgnrQ1Srq8gZORne9LW0HWqSaGpObGZlRvTdtvPKvJ8GJdt+cYODs6fsQwm+0Xw4qX/hGBMV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617047; c=relaxed/simple;
	bh=aFfciuTWVSEKIapUzT6cgwuzeWlLOP2Hv5w71EiJr/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jz/Aoi4ZnYgSHo/xMZ0QdSIBGaTH6qMz3GVdTaA/DKXsaBamP76a7Hr74vtXnz4sVT6rpbvPWGfL3xYCjCDkXkfmh6Jx2mynsEHw6Hxp0exDB2rMhY2+Ele1XWL+FIABN/vRTbgZxuED/8bAAcQD06TlMXYD4XlVOe0lLm0PR00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zt1SnxhF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rAPEhT7y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zt1SnxhF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rAPEhT7y"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758617043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFfciuTWVSEKIapUzT6cgwuzeWlLOP2Hv5w71EiJr/o=;
	b=zt1SnxhFcLj+pXGyN88ewBVRsrAHawqVYBERp3haX3/q9q+bBpixxvAMzDMhPCp53scUNy
	YOkvpnRNtDr7wOapEUxk0ntsllI9ui51YRR3MPkp3YFdLxqbvQRGmukPR5jIOjQhjuZTWI
	rX4GwRv0N6n3lMiQCv2evig2ukoXFba6WkGj53TEYRy6BHEvPR2mmmcNdOG0z1Tr+Q8UOF
	hBpTopgMm36IHdOMRp2PaPMCRngMzv7C5mgHvdqErlxgFpKi/+VfnGid774d6D14ATgfUv
	LxoG7prlSPDsZxsVd50APSBwG67gcb1MnvwgU6QS00P/NpSzonB7opzBLfwJ1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758617043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFfciuTWVSEKIapUzT6cgwuzeWlLOP2Hv5w71EiJr/o=;
	b=rAPEhT7yMWshqY2n58CtxwgmFPwTzBXO4qrXbsLMWS99DASoLwvboWRF8ymvNMKzo7+dQc
	ti8PxH41uqTsP0Bg==
To: Gabriele Monaco <gmonaco@redhat.com>, Nathan Chancellor <nathan@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rv: Fix wrong type cast in enabled_monitors_next()
In-Reply-To: <aacdcc85c9f8d3a51a85b6429646c38d4b239449.camel@redhat.com>
References: <20250806120911.989365-1-namcao@linutronix.de>
 <20250923002004.GA2836051@ax162> <87tt0t4u19.fsf@yellow.woof>
 <aacdcc85c9f8d3a51a85b6429646c38d4b239449.camel@redhat.com>
Date: Tue, 23 Sep 2025 10:44:02 +0200
Message-ID: <87v7l9r225.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Looks reasonable, can you work on the fix?
> I see Steve is out for conferences so this won't be too urgent.

The fix is in my previous email.

I am guessing your email client is hiding the diff from you ;) (among
wrapping quoted reply, but that's not too important).

Nam
