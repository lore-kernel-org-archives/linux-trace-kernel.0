Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1744925B090;
	Mon,  1 Jun 2026 04:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780288713; cv=none; b=ifaFm/67AsaUjdW2reTd0lvHyh/YZArceQ9EeNVkReRUDlGuKP6RIQ05it8cE4ufSBgorbhiUnDomaOEZgvaVAC2QNLdHA76fLrZfARW3HS1o8oslA8BOnxDmODtKxjdo9CMkID1zu5M9Qn7dGKGPgmbx+DpnBS4gYv/G2O4j8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780288713; c=relaxed/simple;
	bh=2WEUGLTDVlzZJ5Rn/VKE96JfwVVx2njMJl5eCci2mAU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UMTswR/11hwkIHVG9fPwgK2eE2omLm49x/U8eU/HGWHlNQupvThWg/kkN8JiEzevxXIWSN0JQss3ue011A3jg42HOqfL/mQbwgSruogmlODknKdAX9xPeW/GDvINlaSpgW+jNjT8KCnHYIqv5ho01NZBICK1TK/rWb5kt2pDl9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsXMcBmE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsXMcBmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE0C1F00893;
	Mon,  1 Jun 2026 04:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780288711;
	bh=ZfecxY3R7P/dN2XQVItXlRO8ySRUPuvI1yB4NnFaoqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HsXMcBmEcRgEtPyUXmqYVqgF0t73jDMiOCGToB0DB1QkYh5+DqRewreAqkTwKNtsn
	 roEJgbXrD3SZvaiAfBvgHIs1pxP2hXKTU2v9SPrpyH9n6MzlNhXncRq1hkYA+2K0jq
	 ebxZ6FwIMN9s6qIV0l+ALkANDk1wVnjovEqqeix981rRLYFGNjZydXARhBszyZLxEO
	 cxgE0QPo6lyb5tDLlRpcnriufSLNFO++GUGNhEV1bWQj0JT11cfuYnJ86it/8Y/EsV
	 RKygZ8RaXfpPmsZ8VjAAnNFZc8kmyAAT5Pd8dLMp49gWXK7iwRnTzSdZJX/+FveTKz
	 58ZaylVBxCXBA==
Date: Mon, 1 Jun 2026 13:38:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Theodore Ts'o <tytso@mit.edu>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] tracing: Record and show boot ID in
 last_boot_info
Message-Id: <20260601133828.42fd83ad8ae42b69abc1f299@kernel.org>
In-Reply-To: <20260528163633.5650f3d6@gandalf.local.home>
References: <177937541909.2596845.17729857441826694760.stgit@mhiramat.tok.corp.google.com>
	<177937543666.2596845.9748178606108139386.stgit@mhiramat.tok.corp.google.com>
	<20260521111630.1f558754@gandalf.local.home>
	<20260524104439.ec01284998cae6d4a5053e61@kernel.org>
	<20260528163633.5650f3d6@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 16:36:33 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 24 May 2026 10:44:39 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > If the get_boot_id() is accepted by the random folks, then I'm fine with
> > > this change.  
> > 
> > Yeah, BTW, Sashiko found this can be initialized before we get enough
> > entropy for random seed. Maybe we need one more delay.
> 
> Well, maybe for adding the boot_id later, but the code that initializes the
> buffers needs to stay early. With the backup instance, the persistent ring
> buffer can restart tracing immediately.

Agreed, so the buffer will be made in early stage without initializing
the boot_id field, and it will be updated when user reads the boot_id
from kernel. Anyway, without reading boot_id from user space, it is
meaningless.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
