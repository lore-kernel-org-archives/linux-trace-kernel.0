Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099A136681D;
	Fri,  6 Feb 2026 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389560; cv=none; b=UWldzVMOSt72tz9H5HeCXGO+J0ts9hD9CEygzh7v6lXzcqITCT/+goozDdnoRwUrGYDvwl2r09UNHmkGVtMtLkniTy94UMYHggoPBv74HiBzuM8qogj8/QrmCI+8hd6Y42OPrENJuREJDmsxXzUPI9uq3YM9kZAC4ETTMGh7y7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389560; c=relaxed/simple;
	bh=Imx+USg/DGgQS6B0wl/CEttehRxN6qu/JL/qMO3CiP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiA+y3+vDs8yH8HwhCGZ2C6uWdbjp63t8s9LDZcANnQhR5Asl9eJ2Gh7/X5ztXtir/kyP3Wmtxdwr4S27kqkAfw9gwP8x+dggOchuifDg/4JuXtndKij56206EqkDbC7Kd1XdMYiWLtpIYYaW1g4f/Lk+Q9Uj4zcLy2P1uA9mqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id AE56C1A01CC;
	Fri,  6 Feb 2026 14:52:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 07EC22000F;
	Fri,  6 Feb 2026 14:52:30 +0000 (UTC)
Date: Fri, 6 Feb 2026 09:53:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Colin Lord" <clord@mykolab.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] trace/hwlat: prevent false sharing in get_sample()
Message-ID: <20260206095309.2fe4f4d3@gandalf.local.home>
In-Reply-To: <DG7Q5K72T7AZ.2TGDSMRADSUD9@mykolab.com>
References: <20260202025838.32057-1-clord@mykolab.com>
	<20260205094722.6d21d8b0@gandalf.local.home>
	<DG7Q5K72T7AZ.2TGDSMRADSUD9@mykolab.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 07EC22000F
X-Stat-Signature: oy1ym6ndcjjh6inphmeeg64833uq87r8
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+AAK1AC7tDWiCTxOHd3LkOZmdyLtZzb9Y=
X-HE-Tag: 1770389550-914339
X-HE-Meta: U2FsdGVkX19N0SX2ceA8vSzjICv8JbKXrxNUPdSrX5efV2ZLEdfiIs2HGEmaRtHV3LaMGAdNOFHmcOfidvY+dxQa787YPq1ESa/I/n0a+IXXci2J8sUnCEcmPg28DF37kJi2oKnTClN3ljA8s+g5ME6nHlM4xMw5y6APtUKB8ofeO+y5QkI2pgRIw4zgYBin3MtAAhy7zl+KDZED+cihIYpFx7XWtYSeRtBJB4u/wSr08Nd00GHz/UgfzYoeUPlNgFBOkZcWS0XYwsB9RPF5rEZEPiYoreXAWzYMRMliEvDk2xBjJHZQOgphVbqA22bYQvleh8c0B9ygT1dlF3N9L8vXznW+xb9HjyuOvuaLLj8kjWWOubvXopYYx99lY9NZ

On Fri, 06 Feb 2026 00:09:49 -0800
"Colin Lord" <clord@mykolab.com> wrote:

> >   tracing: Fix get_sample() in hwlat from ...  
> 
> Got it, I can make that adjustment and resend. Would you also like me to
> modify the commit message with any of the above clarifications?

Yes please. Mention the cache sharing issues and that you saw
missed/duplicate seqnums too.

Not everyone knows what "false sharing" is (I forgot what it was ;). You
can use the term, but also explain it in terms of cache like you did in
this email.

Thanks,

-- Steve
