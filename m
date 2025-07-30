Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B96E2288F7;
	Wed, 30 Jul 2025 22:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753913324; cv=none; b=Mmp6vCq6WfO4yBVvqCs2wZuqpvr4h+AwVbJQVd9kxQbPeC4AP4NdlEhVyrpYmUIAlZ90C/4XtI+h/AYn3z8ulc/9KvVxuCQdI4iv/cSPWLLO2DtPrXYi5xjlwnKZcyzDsCP1st5l17qmXednfMs8E8vVBpv/mjY3KF1r8q2ChIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753913324; c=relaxed/simple;
	bh=5DzTqdWYc14PEiKnsSSikRhRB45dtYdKZX03jUMGTgw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=elVYT8/AZIMbRUDGN9wLrDF3kDsVCFZEmnUVIjfsrYHfS/z5iilMWJ6ucNl1d5XONpaQ9lZDPAhZDOY9KdJpUcTt/dlXu4jNnxRYROmzUqkxcA4bJNR1BJtbq5qNdUMEQGShKmB6jWJ5akGyfM0Wf+mpaxb2OQvG0uuYGxVgItc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N221wvIa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N221wvIa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC94CC4CEE3;
	Wed, 30 Jul 2025 22:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753913322;
	bh=5DzTqdWYc14PEiKnsSSikRhRB45dtYdKZX03jUMGTgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N221wvIanmHlfTpJcA+rlcJpNPH8kjj3O44sk42ouZRnpMFr8DprkUAqN0EAQFlLc
	 hEup3TP40bmw/eoSvLPUf58EE2tRdMLmBAJEsl1nBLKlsnKUoujL9a25mONcEGFxL0
	 mvRLqv1pkIOHGNO2WPvt+XWI6FZshF5ysUad9nenV1gsZlw0bjqnUam5EzbObopD4F
	 vyyehZwoeCmOehW55Qd9QtCqwft11PIS36V1ZgYYTrPQOJvRCxjoMvnZe0NjaIR5VM
	 UzoTR91CQkwZtLPaKECJRtEMeNKAN2ImRKcFcPE4WTJjo2hw1WlJRhad1MAn5ZccVA
	 HlZHxAKk4QgIw==
Date: Thu, 31 Jul 2025 07:08:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linux Memory Management List
 <linux-mm@kvack.org>, Namhyung Kim <namhyung@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/2] tracing: Have eprobes have their own config
 option
Message-Id: <20250731070836.69c43401858db35dd3b43ff0@kernel.org>
In-Reply-To: <20250730100155.268d2442@gandalf.local.home>
References: <20250729161912.056641407@kernel.org>
	<202507301452.JPAcMvT0-lkp@intel.com>
	<20250730191101.7e6203f21b94c3f932fa8348@kernel.org>
	<20250730091727.7b3a8b96@gandalf.local.home>
	<20250730225722.c88d2dbd3dfa07310de7edd4@kernel.org>
	<20250730100155.268d2442@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 10:01:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 30 Jul 2025 22:57:22 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > I see you already did the probe pull request.  
> > 
> > Ah, I thought this was for the next one... (but I think it is a kind of bugfix?)
> 
> Yeah, as its not adding eprobes, but just making it configurable.
> 
> But you haven't answered my question ;-)
> 
> Do you want to push it to Linus or should I?
> 
> I still have the trace/for-next to push (I've finished testing your last
> "attribute" patch and now I'm just letting it simmer in linux-next before
> doing the pull request). I can still add this to that one if you want.
> 

OK, could you push this to Linus?

Thanks,

> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
