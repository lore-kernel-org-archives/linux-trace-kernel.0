Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F0327C15;
	Thu, 18 Dec 2025 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039557; cv=none; b=KLepPX3YrmJQeLBUHEyJCE8hxPMC4N8jBVgsqsSrDgnBYu+lwGu7iuAMs6uBWNDUijC4sqjOWnmno0AkU80O8CdI6W6+OY0DZUj+iztHlJJcGHGYz1GAb2QHnipt84owd2ckUuuK4dcuVxhqfCE//XAEV/19mrNaLpMMxYVaJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039557; c=relaxed/simple;
	bh=8yWek50NkVJ72M7bGCmnTou5Og5jhclrTkTic20rUOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GypBwZC2sXcbI2qKNyohlwVd51atVlUOj8f95k+hh4bSdrCEFURQuipj85nBp4J0ch0ksLGL3S3Cf4ysfHeSdW8SFJwQR9arveJHKY+fGRXrnP6jCSaJZ9oFjnl/Xk0XJ7QWPIkWX1RHCiZDeOGiyrRM/fPMf87hIrqAlw4fv2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=klwAVBgm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5D0vmXcO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="klwAVBgm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5D0vmXcO"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766039553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8yWek50NkVJ72M7bGCmnTou5Og5jhclrTkTic20rUOA=;
	b=klwAVBgmntDdO//TpkkzEeZtitlcuiSrspOt4KeUnEIP6geoYKA3K/c3xnGGmdQYLoMPLC
	Iz/V5J8dJV6An51lH9pdDD0KBn1kIk+EQcg/rYIPeBryXcm4kNh4ar8ty5hWGFNjFhVIvL
	pPmYHCGK5m6L0LGkyxZt170LHHV7sI0e60rJzkAnFjLJCYtHMokZYEq85danb3l5Wp2hEy
	ar7WM+3WGCZT/dWA9kGwl4uSufE0Uzz1ieKJIbAcqS/uDKeMD26mmnSBJXWkknD26zfcEj
	q4YfV+qu1luwfa19bGfK85HQUmelJKZAZpRNQqArIsafkazWRYeNXdantv45gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766039553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8yWek50NkVJ72M7bGCmnTou5Og5jhclrTkTic20rUOA=;
	b=5D0vmXcOmcCGxwNnHI2c+Gi72oFnClLb53xxU/TfoJyTBaGP0zBL/GrFPfeUialuh2by9N
	Ju4OR6fICyDIv2CA==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 Gabriele Monaco <gmonaco@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-doc@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 06/13] rv: Add sample hybrid monitors stall
In-Reply-To: <20251205131621.135513-7-gmonaco@redhat.com>
References: <20251205131621.135513-1-gmonaco@redhat.com>
 <20251205131621.135513-7-gmonaco@redhat.com>
Date: Thu, 18 Dec 2025 13:32:25 +0700
Message-ID: <87tsxoi9l2.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Add a sample monitor to showcase hybrid/timed automata.
> The stall monitor identifies tasks stalled for longer than a threshold
> and reacts when that happens.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
