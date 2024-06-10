Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE255588B;
	Mon, 10 Jun 2024 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055742; cv=none; b=h7VKuxlYkE3KFU3ILgzZ+a2FGvxCuuGPMYCGXbq8oJ+EuaSf4r713Rj8f73/K5TNLUdWIVGTPJp/AoMdgumEajuWIxactWN3JPAtPI8Y8z61I+Y6zwr5rKUw2WYFFzEqPTlTwlfcjsZLMP8kV0d1sX0cG/X28fdIFglaTDpcxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055742; c=relaxed/simple;
	bh=eXTyBhBShucN1cEt9swmerSYcLuvMKcIKFBCAgG/+LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eW09yKmqoWulC3Cz+zVJmwHnwFp3kRC9ckCJA+cUPRA+oDM0NfCn/F+sGi1K6jRvL0T7QSub/kUDGExhB+a+J6lnh1o8PrDGyxGxSmvdfLi+LbwciZNMEKugWRI9MBsPc6w3qz9BCmPSyoPX1Rm2YQfHxziqiloqwtOKYPNjowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BD7C2BBFC;
	Mon, 10 Jun 2024 21:42:19 +0000 (UTC)
Date: Mon, 10 Jun 2024 17:42:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 1/3] tracing: Build event generation tests only as
 modules
Message-ID: <20240610174232.307c2cf6@gandalf.local.home>
In-Reply-To: <171805479486.52471.17705516519375193975.stgit@devnote2>
References: <171805478534.52471.6269290579314514778.stgit@devnote2>
	<171805479486.52471.17705516519375193975.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 06:26:34 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> The kprobes and synth event generation test modules add events and lock
> (get a reference) those event file reference in module init function,
> and unlock and delete it in module exit function. This is because those
> are designed for playing as modules.
> 
> If we make those modules as built-in, those events are left locked in the
> kernel, and never be removed. This causes kprobe event self-test failure
> as below.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
