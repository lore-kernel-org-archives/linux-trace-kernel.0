Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBD8396B94;
	Tue, 20 Jan 2026 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893617; cv=none; b=Xn239iWD8AKXdlvoOLkDRE56gXQHyAs+KjyiDjRbg6qh4cB1freZT/b12BGsTnR3V5qi+SNvvhbtisNPNQv0y3LrWwGghoSXWzON0UqvzIoIzozN2/0zBmQPrK1emvjSZzm13BtWL9DSxbuEVRdewdylDutkZoLFXruUBPIzjyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893617; c=relaxed/simple;
	bh=fDiALRHr72kelCEKObWA8S9GaUKGXArPYQlQZgKOHeg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VwiiRGHZJ3xrZn60B3qlBxBvZaKftZK8Loyc6YOiJi+oRsoskYv/RMvrYpWuZHCO3icI5UdsTOVpXWg9Kl2GRFGkyEUCVkMh0yzf2jZzouWE2KAf7MbsivDXLohyUgRhOZ3dtOySftJhfzZyoA7oBbZs+1xqV/OpYcs7GIx5P9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gx4K3vNy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gf7aVsnT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gx4K3vNy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gf7aVsnT"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768893610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fDiALRHr72kelCEKObWA8S9GaUKGXArPYQlQZgKOHeg=;
	b=gx4K3vNynDDMXpE2n4pPILtLou2T9JTHsz/k33tXXkrEXmdfDj8PMZH/14WzkzjpMJAywX
	/5kcAD4RR3p+mOGCkSlIuYU2wVmNFDNtNNwhUFtACrRYFNCD1y2heZbir0k2gAOgWD7VeF
	aTsj5ADBSESzhksmyF+Js4/r392kGYVVY5HY6ksxIcW8gdQQUFU6i1xqxPpwvcsT80Zgfs
	iaYGLRYa7iijv22pADbZSI/Kq5cnM5/NxzaxATAzzJP62yiXtldm/KOV4lmvApLZYmE2Oj
	I+fosocDopQBQ9e3ABy5YaNXJWmcWLpR83GuKz/wCuHaS7JtuHYw1x0lGYiu9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768893610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fDiALRHr72kelCEKObWA8S9GaUKGXArPYQlQZgKOHeg=;
	b=gf7aVsnTn9y8nau1C13jhHqx5SDu8WEiMrYIngZF/RxtL8jtW5Z4HdViIVPE6iG4HrXTXO
	VCKVRtZyisThTjCA==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/26] rv/rvgen: Robustness, modernization, and fixes
In-Reply-To: <20260119205601.105821-1-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
Date: Tue, 20 Jan 2026 08:20:10 +0100
Message-ID: <87h5sgagyd.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:
> This patch series introduces a number of fixes and improvements to the
> RV Generator (rvgen) tool in tools/verification. The primary goal is to
> enhance the tool's robustness, maintainability, and correctness by
> addressing several latent bugs, modernizing the Python codebase, and
> improving its overall structure and error handling.

Great, someone who knows python is fixing our mess.

I had a brief look and they look reasonable. I will do an actual review
when I have time for it. Thanks so much for this work.

Nam
