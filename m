Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C946EF77
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787772667; cv=none; b=KWfEITZbXojpa9g291m0ixINI/UomeOglcDeNicjBRvLjWpfLGRMl0j6GtmRqTjFLINvRxhG0LfAdzB0gBxZ9N8vsscKuECwtSoEqHEy1iWN94K007FlMdRvVxcGflNftP3DEAO8CKOypF3XszvDb8iCf4yC2lXWimexF0OT4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787772667; c=relaxed/simple;
	bh=Z8VN425deblLzsIYui+i0IElvjrxli+pNaALHEoxud8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoAVeGezwh6dxSBh1TstwmHEBJ+duRqR9KpYtszuvtFtIZq/VECImMr0XmeX0eRZtk5FjO5wWr7r/jDzIpljVsWGssudG3z9pYQd7kVGYHiXULz7LowK5KePZolLX8qdDcoVeVbpYZrZtOI739cMQW0ly3vb8vYYXVY7KTetQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=29A6C2Bt; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="29A6C2Bt"
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 6A0C4160184;
	Wed, 26 Aug 2026 19:30:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id AE4C02000E;
	Wed, 26 Aug 2026 19:30:51 +0000 (UTC)
Date: Wed, 26 Aug 2026 15:31:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Crystal Wood" <crwood@redhat.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] tracing/osnoise: Per-cpu mutex and fd detachment
Message-ID: <20260826153132.1333fac6@gandalf.local.home>
In-Reply-To: <20260824213037.F41B11F000E9@smtp.kernel.org>
References: <20260824211544.3984835-1-crwood@redhat.com>
	<20260824211544.3984835-2-crwood@redhat.com>
	<20260824213037.F41B11F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AE4C02000E
X-Stat-Signature: 689hi1kzykjar7d8dgdyzxqfhp7a69xu
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX192nFEv+FQqRsDjOKinDwwvcFxXNBwVles=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=8BRbS569TzREgTJ5sWhIjfD8KpR5H0JZf7EhJp274y0=; b=29A6C2BtMCIeXA72D+XGbLhdFRokeq0mbyYytRMOemKF4ceYxfOwoFK5MAVm5Cveqj/Pb5LaPcQ15fn6pYeznswPJHEQUTyTpQQ9zDVU7s35Qa1OPtbWc8hzspx9420frjWXnVdn1lDncahPcRiFz93urSUgC01rz3gHY9FVaWA=
X-HE-Tag: 1787772651-733280
X-HE-Meta: U2FsdGVkX1/uQXuM9wOYlVB3ts2hvstwwAY5CaobMEgZIk+lcG0JyFrefUOKvGQzpg+RxnROwM/f7oMxRut9J9/6t9FLQ0Wfafb91DhmZBpHyuZahZcBmOOd2yBThRweRX41bl0v7zisvNLtnKj/Ijtd5dyzWy/Y6wGjmoG3Qq0+iVBPIfu0DTgf89hgqUBoBAA1HRwTgQcWyTD5eP33q4oSq8v4X+J8+c145mkHiKeN/X1mr/IQE3xZPquF8B7uSXWAfY78uFY74C4VDk+F+IRg0wXaXzBQbaFbMImg7ilHMMSeskHCLpGoH4+OJ6dR1kk2PoB3G7SMIeFmvKDigPaat9cUIZOoWD+/GqEUTtPB9UD/G858XZZtwBnR5+GQ00VcxOAuVS6Rv59k5Dh0HlBoyYqZjhshPx2LUmZtEAg=

On Mon, 24 Aug 2026 21:30:37 +0000
sashiko-bot@kernel.org wrote:

> [Severity: High]
> Can holding osn_var->lock while calling kthread_stop() cause a deadlock?
> 
> kthread_stop() blocks waiting for the target kthread to exit. However, if
> the kthread is currently handling a migration request in
> osnoise_migration_pending() (shown slightly earlier in the diff), it will
> attempt to acquire this same osn_var->lock before it can clear its state and
> exit:

This code has a lot of nastiness in the locking with regard to the thread.
I haven't looked deeply at your patch, but the fact that Sashiko pointed
out a possible deadlock I think you may be hitting the mess I was hitting.

Have you looked at this thread: https://lore.kernel.org/all/20240820130001.124768-1-tglozar@redhat.com/

It has some tests I ran along with tracing that detected issues. Of course,
everything needs to be run with lockdep enabled too.

-- Steve
