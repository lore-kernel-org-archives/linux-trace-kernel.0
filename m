Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B1448B384
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139603; cv=none; b=uegTaQ3Sgn/YhOBQNZPTcw53mB/83plqu578mryx41IdjDEAOMj13quW+Nr3IyjrxAE/E5Lvg7phaKUo20LPwhutwXzFEhAHTsy+D/m8qzdfmdEgtxAjIqkIaq2R9DF2EXB5TvJ4jzS606fVyB5j+8eIAdB6aUaTAccld0UGLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139603; c=relaxed/simple;
	bh=rEJ9k9LvMiEa+gnLkL7zxz8PDRSXvcay1A4TkIJP69E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G47P2c93oXEgZ6lky04Lyy49tHaQY0du0PdyXKrfXrReFkQ5fopLVFyr9aXNezlt2lKZUuA19R7QA29Go5xFF29musqF+QAifsCpXyFmWaW9z3bMU/2d5e6qgOEkwpentYjR2EjsvRSKpJ2w73kqIjSKlLlpiz76EsemIGn6Jmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 104A7C025B;
	Wed, 15 Jul 2026 18:19:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 51CF817;
	Wed, 15 Jul 2026 18:19:51 +0000 (UTC)
Date: Wed, 15 Jul 2026 14:19:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Jackie Liu <liu.yun@linux.dev>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Propagate errors from remote event bulk
 updates
Message-ID: <20260715141956.6baf0134@gandalf.local.home>
In-Reply-To: <alc11bkkDvpaqYrh@google.com>
References: <20260715060448.17674-1-liu.yun@linux.dev>
	<alcsNLVLhWOH3KbJ@google.com>
	<f9050a5ba183da3c9071c5be5172c4e814972836@linux.dev>
	<alc11bkkDvpaqYrh@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cxtpehetnky7ebxnruh81myk8j3xiawy
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 51CF817
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18/nWPW81ULCnIASdWBpsRWj5tekJeQQ/w=
X-HE-Tag: 1784139591-364277
X-HE-Meta: U2FsdGVkX1+28MKANGzAScn4aat13uJtViTHUWv3+ZaJ1BDGMfWIKAGmqHr71KyKDXdYiOAQYkf7sdyru7OX8GXKcy+yM8Xin8H0FAMei2pBaRxDFkJQO7nAT0F2EeGRPwfF1sdP/F1N2bBGbn2UdDsYs/UkloKIH0SRHsjrqLuWGTsENd8kdOjBcguCgzWy1lEk11RpvhqRfmKtPc1vLNHcMWft8yBBUce1oza2qJPHXomvxrGHkQvs/mOz1dSXiDa3wFe3GklJoXP172vRNc3YUXkp2TBo6r2lQNJIxludpAGMsOdPkh4YC1TVgVq/4LZUfmn5aIhB5uhZu45BaBC7J2bdT420

On Wed, 15 Jul 2026 08:25:09 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > I checked the v2 series. Patch 02/18 handles registration failure cleanup,
> > and patch 03/18 changes the boolean parsing in
> > remote_events_dir_enable_write(), but the loop still ignores errors from
> > trace_remote_enable_event().
> > 
> > Would you prefer this fix to be folded into your series, or should I resend
> > a v2 rebased on top of it?  
> 
> Ha yes my bad. Then no, no need to send it separately. 

So should I take this patch and send it to Linus now?

-- Steve
