Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E84C4A35;
	Wed, 30 Jul 2025 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884107; cv=none; b=NN/Tr71nMpExJ3atDQjhZRnAl8MTHZcZam1MB9/NlnnIL88MuheA/Up0JfU9f10W7qF+qd0ixhOvpBuk5AethWbEOjd6kJ98gEjlotQ6QtT7tPLG8uBdeVqHJQTcaAWvUy7NLU+Wh2fZvFbnIr3s2HFFmSmuPozGaC1jO6mokvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884107; c=relaxed/simple;
	bh=7RnPBP22ydtmNfvMaNDWqH0JdrLnHI/M2PBXtkcuFxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpiwFgRx1T3tkdk/7wQ+3qa5XIVuO2kuWI6KGSuVA/H2M4XQ+suMbtryJBs+lyEnigDp7gJeLq0BNxwTWRhaxZwyiU9b6/Nbgwt+QY4i+FBczLaKBluXYE4F4DTLqRXSxHSPbECcW1S3V08KKpQxWm0ufaqBQRbcrvLIMEXfpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 58F1C160462;
	Wed, 30 Jul 2025 14:01:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 917A41A;
	Wed, 30 Jul 2025 14:01:39 +0000 (UTC)
Date: Wed, 30 Jul 2025 10:01:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linux Memory Management List
 <linux-mm@kvack.org>, Namhyung Kim <namhyung@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/2] tracing: Have eprobes have their own config
 option
Message-ID: <20250730100155.268d2442@gandalf.local.home>
In-Reply-To: <20250730225722.c88d2dbd3dfa07310de7edd4@kernel.org>
References: <20250729161912.056641407@kernel.org>
	<202507301452.JPAcMvT0-lkp@intel.com>
	<20250730191101.7e6203f21b94c3f932fa8348@kernel.org>
	<20250730091727.7b3a8b96@gandalf.local.home>
	<20250730225722.c88d2dbd3dfa07310de7edd4@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8bdr1qaiuyiqeg9bhfbz1td1gb4gms7k
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 917A41A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+/YoaC5S0m6XgLEI0KXUlT7Ux5npWQxGs=
X-HE-Tag: 1753884099-284807
X-HE-Meta: U2FsdGVkX19fNWmLTzEFbGr2d8oyKHH1JxLjen/f4/Pq5ZFXK8n1OCSZYlWKoRxJjvbVP1eZx2Z+YU1Vpu+9GeZeuzlfTnEqu7ftGHkC+D5raU1QP/7i60awdafBIT+ByL2WPuB9n3BPwnn6m5KlvxrCTRoGpEbwYw3/2Ip/qhCOkYST0eKSpo7BkeHKSe9/peJwCwGlRYNyRg7WSL4AS2OEvyrVCwLgW2aOmRvz1eY9o5NzbRQKm8XH2ZvO+Pw65mDq8IMzB5m0PuoXE0uVRWKrqDrS7X+QWDcZWcT82Xk/VUhryK/7MRTKmZERDPdoB+94XmgxR+n9lYsrje3SIygbYUAJlwTo

On Wed, 30 Jul 2025 22:57:22 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > I see you already did the probe pull request.  
> 
> Ah, I thought this was for the next one... (but I think it is a kind of bugfix?)

Yeah, as its not adding eprobes, but just making it configurable.

But you haven't answered my question ;-)

Do you want to push it to Linus or should I?

I still have the trace/for-next to push (I've finished testing your last
"attribute" patch and now I'm just letting it simmer in linux-next before
doing the pull request). I can still add this to that one if you want.

-- Steve
