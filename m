Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E971F8AC8;
	Thu, 22 Jan 2026 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092803; cv=none; b=mmptoMzDYZfzNNcGgQ6DGx9DcnhH7EhF/UmLUy42+mEaG+P+PYuTcn/iyuwAqG3uttSzLDNQrsO2Qx9lb7ZOtZz49/7oIkkoyfGH1a/7Q8dwhF1aJ5CH+9k40qNsnIqCR99nwwJYXK5ij4BtD6QDOD3XMxkRMraLdA6keHKxMSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092803; c=relaxed/simple;
	bh=Cd7f3A9GqhLNPaSZyYZjrztwoJlDUQehfPo1kePr9eg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AoTZLiKQxywgBi+VfCyz3sPVC4kyCPmCuS4s0Unh8LpFyd85j0NH0Rr/BlIn0A39Uwj7XG3OcGHa1hAotNoxHl9mBT4DayVpv1y/Iu7K1JKy/ykVj0yHfKaQ6YzsZfBloaKrHGQFym52HF8KEwzoBznH+LZAcq2D7yXE08r/3+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wmH+HaSi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lKqB79N7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wmH+HaSi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lKqB79N7"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769092798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cd7f3A9GqhLNPaSZyYZjrztwoJlDUQehfPo1kePr9eg=;
	b=wmH+HaSiVtoDNAGBdE3TG558BXMLaFej8kWN+fHuqAb+twTixdgdLyVJb8IWEpk0GwmuZL
	n7NxxCgeUk8BmeNjghhDR9GxwP0iTpDZ1K04mHvuXVnOlHehjDNGpbmQLVud3x1Ub+9D/C
	dF0naReXejf/Dndo3T7pPekEDrrsD/bKXLeGyd5yp7AaX33qsmkzFlOPLstcP7+g6PxIN1
	FliP4Dil6AO0D6lEwMGWqkq+KjRSemjomK6k/V9OB8lLNCYxGvvdzxDUbceFd/VC1z3HXz
	/8UD6y/0tBk0XZXjSQEq9lwMrobvqmSK2kf6TS2Cwd4L4XDTmrWrBSgOPWHIrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769092798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cd7f3A9GqhLNPaSZyYZjrztwoJlDUQehfPo1kePr9eg=;
	b=lKqB79N7/2PLfTgNy/zu1bSSuRQhLudsEg0VO3wLv6DV+f0tGg1WpuE40RWhnxH1p03I6X
	wJyvUCMhxfW6umAg==
To: Gabriele Monaco <gmonaco@redhat.com>, Wander Lairson Costa
 <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/26] rv/rvgen: introduce AutomataError exception class
In-Reply-To: <fb6b81910e32dbf7aa16e1961dc1dca0a9bfbf57.camel@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-2-wander@redhat.com>
 <24e308b019cf9272884091f85b6675fd05201a2b.camel@redhat.com>
 <aW9ySuaPMZVm-MrN@fedora>
 <fb6b81910e32dbf7aa16e1961dc1dca0a9bfbf57.camel@redhat.com>
Date: Thu, 22 Jan 2026 15:39:58 +0100
Message-ID: <87ms25soch.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> That could be a good tradeoff. Users are developer but (although I'm not sure if
> it really happened yet) are not the rvgen developers, they don't need to know
> where exactly the code complained, unless it really broke.
> All errors that are expected (OSError or wrong format) should have a meaningful
> message for the user, I believe by doing that we'd have a pretty clear idea
> where the error came from in the code too (e.g. event parsing, opening a file,
> etc.).
>
> If the code has a bug, then yes we should throw the exception as is, that's why
> I think it's good not to catch Exception, but to catch only the few exceptions
> we know can happen, all others would be bugs.

I second this. We should only catch expected exceptions (e.g. the .dot
file is malformed) and print meaningful message. Otherwise, just leave
it uncaught.

While working with rvgen, I usually just remove the try-catch, because
it takes away all the useful debug information while not offering
anything else.

Nam
