Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47A114C5B0;
	Fri,  7 Feb 2025 01:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738890154; cv=none; b=S/g1JDmlLW2cAX7JFFzvKRkfl6GkTbTAEpm2rLCoxtjrIiW3ukvSCGDHTP7HHq2YRzrvMQ3fy1CbXZ3JYzJFWULWp/yLTBkQspa5Q1VDUDwxLtD0LLma6iWD2igAQmDyIAOHBYyY8uWkTQwnMPHXOZj0UwFtx5X2slqIHUHzcf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738890154; c=relaxed/simple;
	bh=CTSAxet3NWS6r9DB6Hbm4mKts4YVe1G+CZfNktVQoiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLvsKU2cQlRzenXzLBP9oK1YgjlbwPOxKysjOIDskUKX3sBuuYtezjJrmlYB7GIftAtJcbUnqxj2x/XbpGc0sThhdbMREvtQx2E6vRQr4CwHqMsPI7pG+KKG4d/2Ze4SXs8ZQZoB/kfDW+vOGuyAe8XRsBgKq/IVxV6S/fxQppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DE3C4CEDD;
	Fri,  7 Feb 2025 01:02:33 +0000 (UTC)
Date: Thu, 6 Feb 2025 20:03:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/8] tracing: Have persistent trace instances save KASLR
 offset
Message-ID: <20250206200316.1483aa59@gandalf.local.home>
In-Reply-To: <20250207095844.c2d761f3a3588f705e5c5832@kernel.org>
References: <20250205225031.799739376@goodmis.org>
	<20250205225103.596907199@goodmis.org>
	<20250206142232.5a10545649210f3b3ba172c2@kernel.org>
	<20250206102425.2d1f71ad@gandalf.local.home>
	<20250207095844.c2d761f3a3588f705e5c5832@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Feb 2025 09:58:44 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Which would make sure that the scratch size contains enough memory to hold
> > 128 modules.  
> 
> Yeah, this idea looks godd to me. BTW, the scratch size will be aligned to
> the subbuffer size (or page size?)

I don't think it needs to be. I think it just needs to be aligned to word
size.

-- Steve
