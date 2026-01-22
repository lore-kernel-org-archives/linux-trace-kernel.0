Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32375361DB7;
	Thu, 22 Jan 2026 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094134; cv=none; b=V/qcwwZzbbkyKGLe+L0Vh3MS7tVidx6lNU1LlLd3R5nPlZrfLyqe7zvDnoKzpj2TVcp403OpGxpd4RMOV2899tigwduq0dZR+jE0hrAhJPp1FnTkM2NklP+aUBKymCXaMxYHTdHOPaNaAttedJLo7SUjtnK51CwOQ6kv2zm01Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094134; c=relaxed/simple;
	bh=gB3sQve8L+/eJBqysgrdAgXC1SIubQ83LacLgAs02K0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kWKVUAQSNmBvzBp5gVtIY0MIpncRR6pEyv8Ok15FgQT+Y+Yj4MdzrTR1Rx4Y9kkzY6SQ79RGmga4ALFx+6MplBMpeHAbMpk4lcg4NgCWhhgkF8ONtZzKrtGJW4WKV70yyXP5t/yT3plCmzyrtN/1LIgol6kHVY0qf7VB7li6XrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rz+DvZhr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BmrzVWUq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rz+DvZhr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BmrzVWUq"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769094131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gB3sQve8L+/eJBqysgrdAgXC1SIubQ83LacLgAs02K0=;
	b=Rz+DvZhrIKFr03BFF8jJw/PSANflvvCUN09DPMcgBnrLpXm1jy2SdRbgo0odRp9ih/IxYc
	6OjLtf3JFNPy9C/YB3Gl04bavZHC1lVTOqE0tLGfXVp7dMIYw9SEaJ4kD5VIO3dXN0GCjP
	cpa3fRMBqjXuoUHk/nTnXUjoA5QxyhFinccEse88vF3EbYpIfUw3uavWAiaDCoUmGDFt8S
	6pQ5lpT8s57roaGsaqGfCF670vvnD7MOFVQHs3BUReMbP7a8ndjzRI2cx/99ArtRSsIIQh
	LdVlue81URvBPIc9NMfnTWGBg3QSSm7V8g91p+9gH3gVZMvdNrMVmSq93g2d1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769094131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gB3sQve8L+/eJBqysgrdAgXC1SIubQ83LacLgAs02K0=;
	b=BmrzVWUqm6c0wqKhTpv9XA7JunWRDMU84ki3EY3bMnjMfcjrYcAKWNAvDwlRfIugptNRAL
	j4g3qus4hnrFlbBQ==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/26] rv/rvgen: use class constant for init marker
In-Reply-To: <20260119205601.105821-16-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-16-wander@redhat.com>
Date: Thu, 22 Jan 2026 16:02:10 +0100
Message-ID: <87ecnhitcd.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:

> Replace hardcoded string literal and magic number with a class
> constant for the initial state marker in DOT file parsing. The
> previous implementation used the magic string "__init_" directly
> in the code along with a hardcoded length of 7 for substring
> extraction, which made the code less maintainable and harder to
> understand.
>
> This change introduces a class constant init_marker to serve as
> a single source of truth for the initial state prefix. The code
> now uses startswith() for clearer intent and calculates the
> substring position dynamically using len(), eliminating the magic
> number. If the marker value needs to change in the future, only
> the constant definition requires updating rather than multiple
> locations in the code.
>
> The refactoring improves code readability and maintainability
> while preserving the exact same runtime behavior.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
