Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0FB1F09BF;
	Thu, 10 Apr 2025 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744313484; cv=none; b=rh8JwbUSPtI7EJ7Pbuo3L7HYAW9KrpmiNyNGrLsB5elv1vQDa/ARr9qqcxvBK9s6BhE2XS2ydTYQe9EOUgzeh1lSZW/pjdMUnTgZbnH6Jtdt0HW3Y3BD8gRIWaVgVPwspIwIowRUithNXrXMXt5aX3Nstbcv5od75M0BksseOe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744313484; c=relaxed/simple;
	bh=g9LeOhgeIAjh9ZIYPDVm5W33By15UrvShk6kiMyR5tI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQsNWFlC+mwQj5OjAEbjGi1VL2IeQaouG5wexf6dI280pzvyCVGDTQSswI3a4g+lN11EFrU0IwuhYOA5I+qtlJANaTBJs0Ny0zqThNHhe7JyB+v3Eex6s7WZo/+s+IMWlFNCGkI20I4FrjRPxzylEkfUDdj1pQDBb2sG6aHOkm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30ACC4CEDD;
	Thu, 10 Apr 2025 19:31:22 +0000 (UTC)
Date: Thu, 10 Apr 2025 15:32:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Junxuan Liao <ljx@cs.wisc.edu>, Frederic Weisbecker
 <frederic@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Interface for enabling context tracking
Message-ID: <20250410153244.6b20e328@gandalf.local.home>
In-Reply-To: <a9d1144e-0f75-4594-b85f-d66b1de623a0@paulmck-laptop>
References: <9e2ac1e3-d07d-4f17-970e-6b7a5248a5bb@cs.wisc.edu>
	<a9d1144e-0f75-4594-b85f-d66b1de623a0@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 12:10:19 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> There is some in-kernel support for turning the rcu_nocbs portion
> of nohz_full on and off on a per-CPU basis, but a given CPU must be
> offline in order to do this transition.  Last I heard, there are still
> issues preventing this support from being generalized to cover all of
> the nohz_full functionality, and I doubt that it would be exposed to
> user level until all of nohz_full is supported.
> 
> The rcu_nocbs in-kernel functionality is tested regularly.
> 
> Are you interested in working on joining the noble quest of getting the
> rest of the nohz_full support in place?  (Full disclosure: This stuff
> is non-trivial.)

I believe the request is more of just tracing entry and exit from the
kernel, which just needs a simple trace event at the border crossings.

NOHZ_FULL is to allow the kernel infrastructure to know that a CPU has
transitioned states (no need to do RCU or have a tick on that CPU). That's
a much harder task as you not only need to know the border crossings, you
also need to make sure nothing happens from the locations you mark and the
crossing takes place. That's a much more difficult task.

-- Steve
