Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3AF32D0D3;
	Mon,  1 Dec 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602642; cv=none; b=rVsCSOzEgZ7z+JtX5Tooyhl1qBJaodsMvAvv79Cm4NycNNjgah/JLVKU6nXT3YZIJJGObwu/tcdgmKbKQwip/njL5DwBl5d6BrU5wwhfoy/yR4RktTyAK54TsVZNkVNFu0cgil8vgYjl4FDZG8u3iESoOlB0L2SYZtz9tCRuyGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602642; c=relaxed/simple;
	bh=oPvvf0Ft27o2OHETbB++r47N2/0/KhY29FOaKq6Kr78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DI754lMhvHsOqVjkJMUfrx9yEq6KrxfqS6E5fc/d6czuUaStK6j+piXm1X03GJpkEMLX8UaARVDveaGWIo4i82FpSqje8lMkAVD5XGwPAbyenmOUreYrPRNwv8jvp3AqK7v8vcQCalNQpFhuqhuQqYMKTsFWBOEXbnZQnMf1+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 54E3857F69;
	Mon,  1 Dec 2025 15:23:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 6CF7860013;
	Mon,  1 Dec 2025 15:23:51 +0000 (UTC)
Date: Mon, 1 Dec 2025 10:24:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rv: Convert to use lock guard
Message-ID: <20251201102447.53f33be5@gandalf.local.home>
In-Reply-To: <2e46a7dc417119bb7e331ff14253b0ff678d697e.camel@redhat.com>
References: <cover.1763370183.git.namcao@linutronix.de>
	<dbefeb868093c40d4b29fd6b57294a6aa011b719.1763370183.git.namcao@linutronix.de>
	<20251125145736.48c3ed9d@gandalf.local.home>
	<e4838dd91f14024222eef8e705f2b1ae7945bb80.camel@redhat.com>
	<20251126095106.7eadaba6@gandalf.local.home>
	<2e46a7dc417119bb7e331ff14253b0ff678d697e.camel@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6CF7860013
X-Stat-Signature: intydn3etc1ehm76skdz97yrjnqff9pc
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+iX4WFJSZfX0j5TFIAahxVgmmWruviTeY=
X-HE-Tag: 1764602631-871821
X-HE-Meta: U2FsdGVkX1/L6b2w+nhVuJcNLkIZ18u7PjT7OGeKqQrRbzUpxSULga4qc3OZDWbGMgf0Qn3cnvXGJUxFLpvILyrjnz8eYmozAoqV2AB7Uh6KIVWkyrSOVmr6fBCSXXO0seINRGjzHgUXknsN2wpLSfaMbSVItIjazzEGHm9LiaraV5IbJpJcWU3zw+89w33Ne0q0jg4OU7hh3lGh5SOJsii/9z81OJAWZsh5AwKU4J/dfjd6GkaTMrIKl3BFUeaXowkk0uMRaA48iuxK88pPTtInJJwArAhycTX96JPtlhwHNeS5jmRCEJgsfCqiR5sY4w3R6giNcUgYno9gB4RdTMgvmSdiejttSSPIVBUZyn1knjU7p9SkCg==

On Wed, 26 Nov 2025 16:22:17 +0100
Gabriele Monaco <gmonaco@redhat.com> wrote:

> I can send it quickly since you already had a look at those two patches.
> It isn't a big problem you won't have time, though. It can stay for the next
> round.

Did you send them?

-- Steve
