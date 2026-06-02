Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8891FF7C8;
	Tue,  2 Jun 2026 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391875; cv=none; b=T8G2gSiMWzvxoCSh6V/iUb1G01SvnqiAJoK9Sroa2NXkqRO+V1msZLKO5oOhmxnGShaNiDNJED9AFuex70NhUrbdA4dWVTl/KmrbNitT2O53GL3FBChH+BSIFQ34HsmJswX7zqE8UEkCaHS/MrDnL/TaUZ2F0GuDosM+X257Ua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391875; c=relaxed/simple;
	bh=KBeKd7huAPehTkEDX5d4E4I6UcJ0wiN6M4ZuApko36g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T9UrN27cmf+0Btno7Dju5YhBq3+2tBevX3bVfy4cIftKZH72gT7irIPyfIgvSrGtUTKvYHSg2iEpLyDJeqqZVP4Bqb/R2xCjA3EKmTSBL+GFdHfEqi9BmmPea+Y/8Lac//ysNCfO3Yyrj9IqPofKOpicWFGvCvDutIGSO1Ygt1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jqe9/2C1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9nnqIuHv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jqe9/2C1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9nnqIuHv"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780391871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KBeKd7huAPehTkEDX5d4E4I6UcJ0wiN6M4ZuApko36g=;
	b=Jqe9/2C1XTA6VIL2uPKdJi2pY9vCg+qEN0DK53q7LUPjQRlmuz6yH5RKpPke9dnqOZxw2t
	UHpkwvcksMdt1HoHSEtnmbAMfG/A7MIQWiH6Mcp6Ls+ePe8neeGQI4nMVrg7i78F70EP0R
	QWv5aldeAxkg7YfASYeDazcbxHBdgUN8xjn7HzvLQO9kVNtub9ORM1pP2ZC5RsAo1Av620
	51wT8Szkg/v6wCNNH5T2D5Aa555ylpusyWlRBGBe4n5dWUbnZ6cfAyJpF1vZ0iddcSpe5/
	h0Nr+jC3q9Fqv78z7nlSYQ9e40aM+WfDxM1X+awBxz6ZVFXB9NgmhuehK2A4Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780391871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KBeKd7huAPehTkEDX5d4E4I6UcJ0wiN6M4ZuApko36g=;
	b=9nnqIuHveAmtX+3nLp4SbyOUOlNNYJEwhP5vuPA5dCnLTeGh46aP1Idh77s+H5PmSfV1kB
	G/zM6wzLEJPqxlCw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v4 08/13] rv: Ensure synchronous cleanup for HA monitors
In-Reply-To: <20260601153840.124372-9-gmonaco@redhat.com>
References: <20260601153840.124372-1-gmonaco@redhat.com>
 <20260601153840.124372-9-gmonaco@redhat.com>
Date: Tue, 02 Jun 2026 11:17:51 +0200
Message-ID: <87zf1dxpvk.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> HA monitors may start timers, all cleanup functions currently stop the
> timers asynchronously to avoid sleeping in the wrong context.
> Nothing makes sure running callbacks terminate on cleanup.
>
> Run the entire HA timer callback in an RCU read-side critical section,
> this way we can simply synchronize_rcu() with any pending timer and are
> sure any cleanup using kfree_rcu() runs after callbacks terminated.
> Additionally make sure any unlikely callback running late won't run any
> code if the monitor is marked as disabled or if destruction started.
> Use memory barriers to serialise with racing resets.
>
> Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
> Fixes: 4a24127bd6cb ("rv: Add support for per-object monitors in DA/HA")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
