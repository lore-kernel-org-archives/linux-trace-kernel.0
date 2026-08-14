Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389F03AA4E0;
	Fri, 14 Aug 2026 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728476; cv=none; b=F8BGE6FbsNbhyghHLJ/Sq4+IhP6iJ5Waf8VcZZnGq1MxHh7H/+76dWm+qf8zoDdlsDQo4/Ea5boL0UjYB3mfo5wOai6ckHWBiOuJ5IEqzt3+81lGjv6WBMK4tBiHHR2hPghXz+LZ76xS+NY89eg2dTVcRomodFEWWzXhPngbj1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728476; c=relaxed/simple;
	bh=y6ehLL6sazDqNUK5hDtC6HnpY7DhqTmw3ZEsi8t7fWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjiGmIJIvPG4C9xs8quwPV6q7wwZlVQ5oAayc8eoOqEzU24t82/3ZOpIJljAsH2ASyw3ffXdPGOXgVdD7HUEOvt7lmQSgq8bUvLi3DtEpy9c8oClTy5rprpUckbfPqfJyW3ymn4EtyECKubyZxP/X+8vzGS+GS53PoaG7AfjBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=pL4vgdMD; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="pL4vgdMD"
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 905E9A01FA;
	Fri, 14 Aug 2026 17:27:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 7403F20013;
	Fri, 14 Aug 2026 17:27:43 +0000 (UTC)
Date: Fri, 14 Aug 2026 13:28:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, linux-kernel@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH v5 04/10] ring-buffer: Fix subbuf resize race with ring
 buffer readers
Message-ID: <20260814132801.544cfe98@gandalf.local.home>
In-Reply-To: <20260815003211.3d47c7a14f84e286258871a6@kernel.org>
References: <20260813131152.3589632-1-vdonnefort@google.com>
	<20260813131152.3589632-5-vdonnefort@google.com>
	<20260815003211.3d47c7a14f84e286258871a6@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: txbspojx6izeqoj6rwcw4tmj5nsupju6
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 7403F20013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX186chTQNRj9il8sR4QSzG6BBCMhbTIrKGc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=vBSRVPKFW4VEqNAMycPxb4nngCezAbdcPntem5hRZHo=; b=pL4vgdMDhgfIVjH4ynyTO8g6CkyZVeigBiIpRSKsDkzI5qnKTamH6inUcUGSpDxyp1S9rMidMN8A8deeoC3kJqSsN2Ge1jfzIXg3p/yADGyOpMWiRPcJOkXaRArQT8ZEwsAdd62HzKh+BWI51GBfAN50EfyAmuulsQ/FTeK62Qw=
X-HE-Tag: 1786728463-359508
X-HE-Meta: U2FsdGVkX18jZ+/9fNETHuO61UwydStphDy9OaLXq8PY3vFVib3aTaOTasbvLkxcAslRori44WNnQ2d9TCr6PJHEj6Dg3uqvPOTCj9dr0M7nxkQfKiB2OW6jSj0XyRnf8myHtLnSLOLIHI3j5jhBIz/m8lwSjTr4dCZlR1/uiDGBe8a8yKjdEGgRYIxiSRr4+ZvS/fnzTk5S/DqFuJKGdb760AZ/DRiVpj8U1iNx4R+dGNP/us34K/SWSY7ZkGR9GyF9RDUYqs6q7EW+T1pWFsOKi921UllzvK02bxq9PB+ivvSUQihcRvtce1Qck9F0AzOqkBWaF+p/bWqKMwvL8eXod8mdvY5D

On Sat, 15 Aug 2026 00:32:11 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Can you add Closes: tag with Sashiko's url?
> 
> The code looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

I tried to figure out which Sashiko url went with which patch and added the
Closes tag to each. I also added your Acked-by to this patch and repushed
the for-next branch.

-- Steve
