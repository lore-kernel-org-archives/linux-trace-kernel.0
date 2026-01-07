Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581154758;
	Wed,  7 Jan 2026 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747168; cv=none; b=ap1WSSzr+vLcMZEN8er+vB1uPR4pelHK2NOWt/OigUZ5VxXbBV97jmUMumGSCczVrc3K6xSvexZ0GnHchqJJNgzckJtHWDQvd04/drxJj6Qt7DsXM5iEo2PnWUrbDsKOo2s9NkFsQ+TsXtBNCexdFxD5PrDWLhZlRFQJ/TnyCqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747168; c=relaxed/simple;
	bh=yZKLx4cqGrNJi3aJl4ZhY+wnjrsqnLP1vAPRnibHq0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBPUfQf15esaqrxY5LX8zFD/0BWiqItJymqg14spLTa1CPxjDYapefh9Pa3LS/IzKOgfZN3qJIiuo6gSE1gI9W2w2gOhP9o4XGbFWyFLsD6060NAcDVFVhJvN4YF89vKQyQoJoNGi3CXhBKcaBLZpSom57HWYr1m53XAyiGJyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id E49265E96C;
	Wed,  7 Jan 2026 00:52:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 1CF1220024;
	Wed,  7 Jan 2026 00:52:43 +0000 (UTC)
Date: Tue, 6 Jan 2026 19:52:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: Do not over-allocate ftrace memory
Message-ID: <20260106195241.166f4115@fedora>
In-Reply-To: <20260107002428.2904852-1-linux@roeck-us.net>
References: <20260107002428.2904852-1-linux@roeck-us.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zmek84ye9qw85xot7oi8dz7r4bd9kk71
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 1CF1220024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ekf+1iuEWM1fOeWrDrch1wz72aWjOReg=
X-HE-Tag: 1767747163-526167
X-HE-Meta: U2FsdGVkX19roQeVg941kGvoBxtvMgUR/te7ybEGtkhwkI0l6EE1ThZx6wjnUtHTRb972DXMXddCbvi/IdSFTw/Vq/Sf8pMp7y6QzKDjc0UJk1QwbR4JjfM9kgdCf1Xzh1a1oNds/xvPx4/ChAzRAkFlPFPPcSg7F2xxNRoZe6wycibVZw/XnqYBZsd874g7J2HpZ98J+jOLG7uUWta8+6IE2iZ3rFmkn5knN7VeAR9dPzr6dNWffy3L3KRl6QggfALzuI/kz5cCiazwzpPb1edswB4CxX638hSImye2Xe/GyjrheSPiHH1pme0UTd8pMFR91HG1DaMB8I0fWb3vMfoCCmeiL9FGDvRMWySC0Sm6UApkAPMWuYojfSzqXprg

On Tue,  6 Jan 2026 16:24:28 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

>  	if (pg_unuse) {
> -		unsigned long pg_remaining, remaining = 0;
> -		unsigned long skip;
> -
> -		/* Count the number of entries unused and compare it to skipped. */
> -		pg_remaining = (ENTRIES_PER_PAGE << pg->order) - pg->index;
> -

The above needs to be fixed though.

-- Steve
