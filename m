Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2432B99E;
	Mon, 18 May 2026 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094650; cv=none; b=T0jewpRvkIOS66OLgXGmc5ZSxBx6jL1nZfvNedF2VL3uc1BBwX6pQkxkGGxX43L4uG+l5u9OibQY8l2FulCu8fzp9zqNPQoCvKoja4USmWTlNMiPQi0G4lGYpM6P9vXqxOU4ZwCKbucp9wddhyxGw1Brtqexe60FXdiaB7eLKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094650; c=relaxed/simple;
	bh=e/YFCy3PjE8oBDs5pOmcAAozZ4a4veWAsJkxcqmh34A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gY9uH2DDRDFj7Lvp1K2HD89SmwkiDycl2hCHV5aq4CcfLwYj8XbsBesDZtsUvFDeD4N1mW0F10Iusw3TGioyelLk6cgl1tMc8fr0J+1Pf2cbzNbClprITymjvovuX1u5W2ASBBk+B9+9XU/qPlFiMQ2bF92Xvd1zzU3pyI5IRxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gnV7Hfoe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MbpOYVF5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gnV7Hfoe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MbpOYVF5"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779094647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e/YFCy3PjE8oBDs5pOmcAAozZ4a4veWAsJkxcqmh34A=;
	b=gnV7Hfoeo0gtvXrw9uRCPElhYFXCgZj0ps3nwUVpTv6+wY0MtgWql2HVzpKLr2TgFTbAKW
	NcvwQwNZ+Ls4s0/MmH+Pn6x2IuWebWnPeK3OnwSOVM+o/95oMTwYxETi3D8RkSDf1i/PUT
	6BwDKinbV5TkbL4ibgZcDWsrkRRvgFUeGR/CV/vtWneKlHuuOdkFFVXG3CVrt7IKwS4gzN
	qPjE3I1hbaMw+qtjo+tcUuE+E25a3+yMJnps5gxhjePDxqx6mhK1qjJZWHfE/iuUV+zSsd
	ls7i9pUgJ37IBelCrrFvDxGtwf3PCefpZCqyAVFrTwiyr4btE35/Er4BbrWUew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779094647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e/YFCy3PjE8oBDs5pOmcAAozZ4a4veWAsJkxcqmh34A=;
	b=MbpOYVF5ltwG04+gXcCcluSpox7cHaI1diHeFF2wJfHd8iZk0zYzmlJ+o4DtlBKQ8ViT8o
	YoqWkFtQq6tqEcBQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v2 08/14] verification/rvgen: Add golden and spec
 folders for tests
In-Reply-To: <20260514152055.229162-9-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
 <20260514152055.229162-9-gmonaco@redhat.com>
Date: Mon, 18 May 2026 10:57:27 +0200
Message-ID: <87pl2t6qo8.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Create reference models specifications and generated files in the golded
> folder. Those can be used as reference to validate rvgen still generates
> files as expected in automated tests.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Didn't look at the "golden" files, I presume those are generated.

Reviewed-by: Nam Cao <namcao@linutronix.de>
