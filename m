Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD0B40DFA7;
	Fri,  7 Aug 2026 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106875; cv=none; b=h69QIIj8s9MuQGnqQ3+mNl4BUZ9KrH/6J2qbv1aXVwBqqwFv3nv4Vp+d0BflEyfEL27KKCtgyYI0fciltFNkJo8PG0wSN8DjRl+tjY3TpkFoBSLRVKCAthxs6TGlUf9PZ5xpuoRCUZQ39lWVy8Oloy/ymNfa+tHjonITTAZPtTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106875; c=relaxed/simple;
	bh=XB0CIrl0aDElcy537EDcePdRRmo4KFnV8druLKD34m0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbbEFIQQ/y7Bw31LOzYEzLQgjD8QMWmxtl19hjBo3jM/72Nx/F5oT4JOarnW6FpVm7LxK4c+cHgwtpJSb6I7RtHe5ac8x68T/JgteavxujBCyfCLI3wIgjFHME9DbRSd3SKEN1zHaNZTgZrdrfY9wnxQKRDQWTHX15a8FJ1ooEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id EFF78C038A;
	Fri,  7 Aug 2026 12:47:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 245AC20025;
	Fri,  7 Aug 2026 12:47:43 +0000 (UTC)
Date: Fri, 7 Aug 2026 08:47:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Meijing Zhao <zhaomeijing100@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/3] mm: trace: decode architecture-specific VMA
 flags
Message-ID: <20260807084745.5d96995e@gandalf.local.home>
In-Reply-To: <20260807031349.3119855-1-zhaomeijing100@gmail.com>
References: <20260723092905.761037-1-zhaomeijing100@gmail.com>
	<20260807031349.3119855-1-zhaomeijing100@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 245AC20025
X-Stat-Signature: 65qcqfsb5yiju5g6iw3adn1gmkogbuyr
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX181hHT2nBucVmYFf8KtnO/F9MR9aIZ/VQ8=
X-HE-Tag: 1786106863-854382
X-HE-Meta: U2FsdGVkX1+DGLfRgjDbdG4UKHh8Gu55/3rIDNSaQyl2Xb1GYY78La1EEesiQjBRrHQg9Rhd+0/71lgcz4/v2rfh+zW6aglqTy44wpuxGQzdXV37eH/6VuGXT7D3XkaPgjSQe+VV+FIPH8AXSS9lq7ZeMU32m81oOpNWj3HSJZZk0VFzAhvmy7chWkLbb4l1Sj9+cAgpiNV+/KTQ+ksv81TY2/nT88V8uG3JCW2dDiXjessZkZ8JP4LcasniYxqjE5jnSLlOopohnKVyvZrBIulswfzu1a+TwjuNxJc9Zdl0kLT9llVgQx3nlurZPwgcGxHdzv2sr5Zc/Aye3pNtfb3H6XONtF0wrpb155mQcj6rVhiHfFtcZA==

On Fri,  7 Aug 2026 11:13:49 +0800
Meijing Zhao <zhaomeijing100@gmail.com> wrote:

> Hi,
> 
> A gentle ping on this patch series. It has been about two weeks since
> it was posted, and I have not received any feedback yet.
> 
> Would you have a chance to take a look? Please let me know if I should
> rebase or resend the series.
> 
> For reference, the original thread is available here:
> https://lore.kernel.org/linux-mm/20260723092905.761037-1-zhaomeijing100@gmail.com/
> 

You may need to Cc the MM maintainers too. Not just linux-mm mailing list.
Modifications of tracepoints in subsystems belong to the subsystem
maintainer, not the tracing maintainers. We just maintain the
infrastructure, not the content.

-- Steve
