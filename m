Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1E2318B9D;
	Thu, 28 May 2026 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956671; cv=none; b=s4ByJBeyYdqSS7zmRsB/Ko6ngv5ZvgNLJxyx1Eng7CrZ+ELsrlGnt+FLzuXzYF3AiMjzkbFqY/UJIHzSGa7pi93ib0eoqGaNruJehpGZ/BQgbtora4IJ1qC7YFBZNYvRdv9JTxx49tydqU+iX17HG/CaXp3m+jbQNS9W4trzwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956671; c=relaxed/simple;
	bh=AUa5TnlyS895jGsXHFMjGnZlcUnhNU2UFLTkUoRK61U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HPbmGObNnVQzuNyMSxds5msoMrhjHvLwTQUAfPP89kWpuH1oA+zrYWgPHhwI4muM47Dw8UAkG9MqaOKgnKnj8vAzDDfR3IijzviTm+voFycTXN9/Dq3gBsgRUaoGZbXdSJcfw6gHMbyX2+t/PVe6cICbQhhnPa0yKRQBNHnAgiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zzmIC7dm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EikQM01N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zzmIC7dm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EikQM01N"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779956668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AUa5TnlyS895jGsXHFMjGnZlcUnhNU2UFLTkUoRK61U=;
	b=zzmIC7dmMygBkV1O0rXt75H55VbWg8kNdQXpuHGRx/wkRw+uEAT149LuYgTEmtah8TlUED
	46Ea4eY4iJ4Uww2Ia7b1b//pjle1XvNP/PUjUuZh0Wl5odraTcuqwtaD6BJw/2f9CQxVGP
	5+kmZvFzopvXAr8ZF7tjCuV6WXlXjVKqWBEBjAvkihly4tVRmhObOa7vfjRUmFaLP1jheC
	yRdUSRk82fXs79+3sAhxDY4tj/qj5H2MScAWHL48bID9mYzLyof+TEF/QNZhqWdymwIiIP
	sqYvDl61KQmU0h59DQJtqo0v1mz0l5ewj/OG42oYTUb4/XFIQjsEpPPX8jZUrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779956668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AUa5TnlyS895jGsXHFMjGnZlcUnhNU2UFLTkUoRK61U=;
	b=EikQM01NN7Nn+ObrM2dyiCYareDHRuW4IXXGiSKNwXmVpGxPcvK4RW9BxHn3NVZjvsKcQ9
	8H7NOvzsmQ29p7AQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Weissschuh
 <thomas.weissschuh@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, John
 Kacur <jkacur@redhat.com>, Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v2 00/14] rv: Add selftests to tools and KUnit tests
In-Reply-To: <20260514152055.229162-1-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
Date: Thu, 28 May 2026 10:24:27 +0200
Message-ID: <87qzmwndqc.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> This series adds support to the make check target in the rv userspace
> tool and the rvgen script, this allows to quickly validate its
> functionality. The selftest framework is inspired by the one used in
> RTLA.

Just a quick word of appreciation for this work. I use this to aid my
own development, it helps a lot.

Thanks,
Nam
