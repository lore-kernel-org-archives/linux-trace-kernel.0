Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE04D37B9;
	Mon, 12 Oct 2026 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832903; cv=none; b=BueSe2gBvGoXoXw1fMWMSLDX5cF32HWD8oRTP8E9MDrcuoRrTuuJnyShsInqXYHlVkZtb5OW4D1taP51SFq3omU/QMMSgEzpIe3+drq1QXAwyujPP7+IYQXLXNxEltZps5AcKpyFFX2CQS+FOU5oRwJyBSMMdSBPs5vEjr5SPP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832903; c=relaxed/simple;
	bh=WovZxVKaZ7McOM8h3AbkTrVG9gDYGH8gE547m+K2XLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyH5x2vJzX1cp9VJfzeM4PbsCjDMRcduXItrRCnoEjYeJor3nHh2XPb+CWeklqP7/bOPbn0WipFvPgPp+uAcHB2s+osr1qII05D5M1aAXzSU8m7R1ZsdG43Fy1WFq3m/vQftH5xXXfziMekr/rXDROcHSPeqDa3mrpnRUpH1UBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=n+lXEJ5W; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="n+lXEJ5W"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id A76321C4C80;
	Mon, 12 Oct 2026 19:21:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 1DC8820032;
	Mon, 12 Oct 2026 19:21:30 +0000 (UTC)
Date: Mon, 12 Oct 2026 15:21:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 rpm@xenomai.org, jan.kiszka@siemens.com
Subject: Re: [PATCH v2 0/3] rv: per-edge dwell-time statistics for per-cpu
 monitors
Message-ID: <20261012152129.4c57786c@gandalf.local.home>
In-Reply-To: <cfd7123a-e83d-490d-918b-154d45aad92d@siemens.com>
References: <20260911123439.463052-1-tobias.schaffner@siemens.com>
	<4759c9b0dacdf1f9c0cf47158895860dbd0ec401.camel@redhat.com>
	<cfd7123a-e83d-490d-918b-154d45aad92d@siemens.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 1DC8820032
X-Stat-Signature: k5g8nf5cmracfxb8etejzcef68697w5o
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/LHhjODesxKHkmKZPZ24+4fULWt9TuWUU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=WovZxVKaZ7McOM8h3AbkTrVG9gDYGH8gE547m+K2XLg=; b=n+lXEJ5W9jY2/VPYwkQThytHBgga786HfJgk9+q/jCuwoFP+adt7kPnxBM6Jrehh1nOTW3ns2ZrimC3xZSJGZqP7ov7vKQ6n5gCGn5nkxwaay5fnZzP7ZcouRr71XddiMt+PgZ8HZX3ERX8y/rUAH3nBLbcuhraT0F7+NJ03zwY=
X-HE-Tag: 1791832890-873550
X-HE-Meta: U2FsdGVkX18Z38EoVZaLVKv1KgFWq/X1ChjGpD7F5T90APg3DKeryhGdo0LRScODfPGISQvyyIPXdsqDBjJCiAPJ3ve5j8nuJ7KM6thgAve6wxtLqrOl+1Zanjrbo6NioP71udrYDj3fLw0qie5+DJbw7FI6vjAmRrjYUL8kRJ7Ey9UArO8EqDv44mXkbtqQE8Xg8VJFM+ENaXzJrvewAZM39FIF+E8o2RB/eTQuWT23MuIYO8YHN/v1j79u5xSPCslFTY1D1gsXxyPk/WuAXSzJFONg9+X/AjzwU4DRCR2Gzw5GG91ZqxebDQ1wX0+WLg+jZKCoyfLuinaDCwYjCsvzXRogrBwA

On Mon, 12 Oct 2026 18:18:52 +0200
Tobias Schaffner <tobias.schaffner@siemens.com> wrote:

> Regarding verification:
> The path I verify is deliberately kept short and simple. RV fits well
> because the probe is a plain function call and the state update is a
> try_cmpxchg that cannot fail, so it adds very little. A BPF program
> brings more machinery into the probe path doesn't it? I fear that adding
> this would force me to verify that the new RV system does not change the
> behavior of the system we are trying to verify, and I suspect that could
> be harder than verifying the system itself.

This brings back memories of conversations I had with Daniel. When asked
about how this is being used in formal verification of safety critical
systems, he told me that only the RV verifier itself needed to be verified
and to show what it is verifying can be verified via it. For example,
running Linux in autonomous vehicles handling critical systems the watchdog
had to be verified that it could catch lockups. As the watchdog would
trigger fail-safe mode if something went wrong. RV would be monitoring the
watchdog and if RV detected something it would panic the machine, which
would immediately force the vehicle into fail-safe mode (stop lots of
features and only keep those that can stop the vehicle safely).

Can using BPF as the RV verifier be formally verified? As verification for
RV monitors did look at the binary. Is BPF optimized to machine language
before it enters the kernel? If not, can we formally verify the BPF
verifier created the correct binary? Maybe, I don't know.

Maybe the safety-critical project was canceled and this is no longer needed.

-- Steve
