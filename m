Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134E51BD9D0;
	Tue,  2 Dec 2025 01:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639445; cv=none; b=bgzpFsRaDeeFgcTxL0GoOnBQkv/JcMenS8NU90pSDbQCxSbE+E5A/OQSAEvusC9/HKUuUdEcnj2/OcvTR7+QdZ3UBLxMwgkycQ4AwYkRTu+mXdngI0g3X1WF1kA35v4KJ/jpheHbOnJ12AAMc1vGrG0tR8ncXjGKmweBfNdTF+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639445; c=relaxed/simple;
	bh=c0t4i72+iTM0oAeEbLlHMkRWMHjkcnigGRguy1X/CI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJFIjNgPCGi1SjEd0viZq62anVGY0ZM+HxSkeePcEZz+uqqfITpurvOTtTdfbbTknWjkiArAnaEoOhLLdEKewnPaOk8hkJY5a3VwS5n4owywczL8zKdt8EvETiaeu1YLQsGIU4Pg7G2QX8ioY44ClpTkCdB9KmEPg6pyPZmIQNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 79DB189AAA;
	Tue,  2 Dec 2025 01:37:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 9F2C120030;
	Tue,  2 Dec 2025 01:37:18 +0000 (UTC)
Date: Mon, 1 Dec 2025 20:38:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rv: Convert to use lock guard
Message-ID: <20251201203816.5e777f12@gandalf.local.home>
In-Reply-To: <8f98932a8fa9c3e63c9a5cb7ba764e9db968bada.camel@redhat.com>
References: <cover.1763370183.git.namcao@linutronix.de>
	<dbefeb868093c40d4b29fd6b57294a6aa011b719.1763370183.git.namcao@linutronix.de>
	<20251125145736.48c3ed9d@gandalf.local.home>
	<e4838dd91f14024222eef8e705f2b1ae7945bb80.camel@redhat.com>
	<20251126095106.7eadaba6@gandalf.local.home>
	<2e46a7dc417119bb7e331ff14253b0ff678d697e.camel@redhat.com>
	<20251201102447.53f33be5@gandalf.local.home>
	<8f98932a8fa9c3e63c9a5cb7ba764e9db968bada.camel@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 9F2C120030
X-Stat-Signature: gk81ggzrup1psb5g819abnwhoapj9j89
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Inf5V9KMOVQmmRtkeLDDwokeqDBdMWkQ=
X-HE-Tag: 1764639438-331325
X-HE-Meta: U2FsdGVkX19SzTweaxqa6fwM+w2QGshZNlMPOblgtaLUeIvFDEFnsdGMsx2ddX5o99SUj41y6Gi6+mV79Dt6QkLYX/eGdYwyilrAB7COYr6jLLBRr80JgIXib9/KL7WCDt8h5R28zYkImzMLoSg2ss0oQe5/nXcqII5dFuKy4q8u8pb8Qcr57XHIu0bmt6b6y3LM+bZLrO8hov57nYpVHnvhm0AbCNCqDu+44qK1Zx4bCPDEcWdhJIfPOu31xeEsRWlK6qEaBgB9Ybn4hl1N9aMZLfGJkQZNjw/o8e64o86XDd44YTUCHau4xfw5UECZI7+7j/p/ur50pFH67K0uF1PhIkItbykuonVlLQBER/gjOtwz8QLCrw==

On Mon, 01 Dec 2025 16:28:21 +0100
Gabriele Monaco <gmonaco@redhat.com> wrote:

> I'm stupid, I sent it [1] but the script somehow didn't add you in the To: field
> and I didn't notice..
> 
> I'd say since the merge window is open, this change can wait.
> 
> Sorry for that.
> 
> Gabriele
> 
> [1] - https://lore.kernel.org/lkml/20251126152253.464350-1-gmonaco@redhat.com

I can still pull it and run it through my tests tonight and push it later this week.

It's just clean up code. Linus doesn't get too upset if simple cleanup code
gets added just before the merge window. It's new features that he doesn't
like added late in the game.

-- Steve
