Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F171E1C84BB;
	Fri, 13 Mar 2026 04:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773375500; cv=none; b=g3n03IAV+6KtvL1+HZ70ao3pluQz3SFpWOVqLQAjfyhNUCbdo/vUvmstBJ95lS9BBZAWM3fIJfcoyrrgopViUR8M6mF8DchzNq9TTcKSne3MAZri6G/HpRJw/3Y3tSk4R/2YFqSiKSp1SGQPdIb7SGA/vufE9VLU9YuSlfu+Q5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773375500; c=relaxed/simple;
	bh=wf4o7CHHEQB5Bi1XLV13vdCdgX+DOxeXEcyRPvg1LbY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bzf2qr0mQwr1mVXOnRonoaeft0jIrvWSUDhbDy6cTr3g76FHw5eGkWOkKK0xlCRJAsvtmt00OkelDwZXQ4R3zrwrBf+0M9Gg/aUINjMcHDW5MKfN0nOvJPsMIecFr9+5DBJOZOHhhZOSryJe3ROYRwHdf+P7lVvyjGpek3v2jbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhrta65K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhrta65K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A107C19421;
	Fri, 13 Mar 2026 04:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773375499;
	bh=wf4o7CHHEQB5Bi1XLV13vdCdgX+DOxeXEcyRPvg1LbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vhrta65K7N8Mk8jUGl7t3WJ3HIAo1ss581KvyKSU2lNrwNuwa2X5/FqvE0GIPBGHR
	 iBgvYc7qP+n5jJRSTQpJYuaHC/QHA3AHhzF1mqu5/iioHVf6aZLydYp2NbcGNT2cC5
	 eK9xScQPbylD0flmzYTt9dNejlSZHi1rqlVF98U4G5erMn5J7TAOaJ4Bx8pbHeoTtQ
	 MCl69zd5BDd7PZLVuD0vV6w3a37zEgeW3VRIqfdc5MbHh9Kce8IjoQiZ1HUj0jIgQP
	 gd5qdMjfwSDkac9OhGhA8zGqQmn3Vzupd7+KMZXSGVTZ5NCYu4iUmoQgI3kae2e0MR
	 U8VjfXb+PQjTg==
Date: Fri, 13 Mar 2026 13:18:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <hlcj1234567@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Law
 <objecting@objecting.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] lib/bootconfig: check bounds before writing in
 __xbc_open_brace()
Message-Id: <20260313131815.3d4eb53cee5f3f6defaf384f@kernel.org>
In-Reply-To: <1bd0e36d-0ea0-4a79-bbee-e38de553f1ea@gmail.com>
References: <20260312191143.28719-1-objecting@objecting.org>
	<20260312191143.28719-3-objecting@objecting.org>
	<20260312170643.4b0f926b@gandalf.local.home>
	<143ca1aa-d053-4947-9817-72462876c224@gmail.com>
	<4c426803-91f8-48fc-ae8e-20676479b370@gmail.com>
	<20260312142809.cb92d6b5197e89645edab80b@linux-foundation.org>
	<1bd0e36d-0ea0-4a79-bbee-e38de553f1ea@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Mar 2026 21:30:10 +0000
Josh Law <hlcj1234567@gmail.com> wrote:

> 12 Mar 2026 21:28:11 Andrew Morton <akpm@linux-foundation.org>:
> 
> > On Thu, 12 Mar 2026 21:09:52 +0000 Josh Law <hlcj1234567@gmail.com> wrote:
> >
> >>> That's a fair point, Steve. Given that brace_index isn't touched elsewhere and the current check effectively prevents the overflow, I agree this isn't strictly necessary. I'll drop this patch and stick with the fix for the off-by-one reporting error instead. Thanks for the feedback!
> >>
> >> Wait Steve,
> >> Thanks for the look. I see your point that it's currently redundant given the call patterns. It looks like Andrew has already merged this into the -mm tree, likely as a 'belt-and-suspenders' safety measure. I'll keep your feedback in mind for future cleanup, but I'm glad we got the other off-by-one fix in as well!
> >
> > Please wordwrap the emails.
> >
> >> And in my opinion, merging it is a decent idea.
> >
> > You've changed your position without explaining why?
> 
> Sorry, I think it should be merged because it's better to be safe than sorry, I know there is different methods of implementation, but this one still works... I know it's churn (and I'm sorry)

I would like to keep this original >= because it is safer.
Andrew, I will pick these patches with my test patch.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
