Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57B1361DC3;
	Wed, 27 May 2026 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896505; cv=none; b=aqiQTg0101rGj36RnXYyIoumDEQwCVXYYIppBuo9YbSnMAGpgyDgoigXUGygh+++3oIrRewWTxNv0knJwjbfQLmg7nEC9ASasJIv8eg9wz7L7g9YZvrPeyDWnzLuBjYp7Oz/JfiomnENbPD3iqpeOG4TH83MdXg7Xb0G8TD6DXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896505; c=relaxed/simple;
	bh=WEm76enc6H+K5mPbHLMuCBCArMseBDCTswzdymF2e+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pVlnVt+yzWbiEh2N9CIxyTB8UqyZratWhCTnCy8webRKcxdc0VXjPeFtpZSycRed9erFMU7yEHAXuRmNGylIPgx7KhvxXKLejjTfMu6WOMMZgIiE+yTcu/fXhB3ZrCJbmqCjjR1OsA5tEG3k/SifQF+rzKHPVjMswCnTNe8xMJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EDl5SRl1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TBYQNt3E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EDl5SRl1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TBYQNt3E"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779896502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WEm76enc6H+K5mPbHLMuCBCArMseBDCTswzdymF2e+A=;
	b=EDl5SRl1PwnqaEHPJajzMhK5PV8eXjo4phcTzyWxO0CDqU5xnLJRhnIvY7Fj5/BHsiN387
	qMRMGO34F//io/CXQci3mi+2liGM2WfqzJcd/HUlqGDOWZj9RI2axYRJUCC2FimiRJYIiZ
	lsrr17rMPhnhu5+oFQtyYxXUaONRY/S/980wY5wAveKL+3aN0l98P5Z//rxRHZ8CPHCMHm
	b65NDce71lWzQ6gZ4JeiHWhxekncigADvQVB9za76mY8wvNUma3RaBlJyv0/sjVvxklyoh
	xn/R0w/UKKkwEJb9Ej377uftIlkf0r+/DR04QpYq21xRiBey4TDEpvYsVnbwPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779896502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WEm76enc6H+K5mPbHLMuCBCArMseBDCTswzdymF2e+A=;
	b=TBYQNt3EIt4crZoNt8ZjnEHnBx0YQwDQMik1/K8ghSlmavsm5fNL9V6IgNSHtPb/yOIzL0
	VxNIcy56kvI3e5AA==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] rv: Simply hybrid automata monitors's clock
 variables
In-Reply-To: <054cfff25288a98a7d7922de149be91fcbc79bc0.camel@redhat.com>
References: <cover.1777962130.git.namcao@linutronix.de>
 <a779af6dc89721179e0dbab08623e42aa0191275.1777962130.git.namcao@linutronix.de>
 <054cfff25288a98a7d7922de149be91fcbc79bc0.camel@redhat.com>
Date: Wed, 27 May 2026 17:41:41 +0200
Message-ID: <87bje0vozu.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> I'd prefer if this was consistent with the above as in (now - env <=
> expire) or (env >= now - env), whichever you prefer but let's keep it
> equivalent.
> Or do you have a reason to rearrange it here?

No reason. Let's keep it consistent.

Thanks for the comments.

Nam
