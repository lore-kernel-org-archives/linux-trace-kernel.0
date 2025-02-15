Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE0219DF66;
	Sat, 15 Feb 2025 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739637942; cv=none; b=PSuR/uOe85/TPiL+lH9ERn3QSgaAxUludPpYdfzd33lk4q6BHYHv6yOcZKBtnsxREEaOS+fUGyVb4akRoDcnWuPWb5d/kKYTfFzJ1vtsD/IbgFwmdqDMRp4wU3VB8IZvTt0vgXEWp+f2mjLJ7qYyvvjrSsEotZ/uj8hO9WE6r88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739637942; c=relaxed/simple;
	bh=YJmUOYGlFTMGO8pF4nJa8HE02Q17Rc8kUn/v8uk7b58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0vRNqrjmNfzKGqGrQkQVjEAXUSTO1XM9zw1KDT/V1bbqrtqxfB++PKGetOvTEP2yQH+V8JaidBEG8Ezq3mE+z5q/Cwczq3Twv0BXoVI4cijY24i4LxibCUUMfDOIWHqj50BYWO26+n0wJxTGmyhQ7WLPP1WD+hnqzHWK+QXxKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9435C4CEDF;
	Sat, 15 Feb 2025 16:45:41 +0000 (UTC)
Date: Sat, 15 Feb 2025 11:45:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] tracing: Do not allow mmap() of persistent ring buffer
Message-ID: <20250215114540.7203feaf@batman.local.home>
In-Reply-To: <20250215112153.55e56284@batman.local.home>
References: <20250213180737.061871ae@gandalf.local.home>
	<20250214110722.7eaf35b42c4858e6b74500f7@kernel.org>
	<20250213212147.6511b235@gandalf.local.home>
	<20250214161332.8797b20f09e068c33f872698@kernel.org>
	<20250214070712.01997ea1@gandalf.local.home>
	<20250214233613.bde0638f393186f56f0b30eb@kernel.org>
	<20250214095943.178501fa@gandalf.local.home>
	<20250216003702.eef00d543ebbc3b16140ed9c@kernel.org>
	<20250215112153.55e56284@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Feb 2025 11:21:53 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 16 Feb 2025 00:37:02 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > My concern is related to the fixes policy. If this is a "fix", we will
> > backport the new "disables mmap on persistent ring buffer" limitation
> > to the stable kernel (that was not documented previously.)
> > 
> > However, from the user point of view, "mmap() ring buffers" is already
> > supported (although it did not work on stable kernel for now). Thus I think
> > the "Fix" is expected as "fixing mmap() persistent ring buffer".   
> 
> This only disables mmapping of the persistent ring buffer. Other ring
> buffers can be mapped. We never supported mmapping the persistent ring
> buffer. Even in stable kernels, if you mmap it, it will crash just like
> it does now. Thus, this doesn't cause any regressions. It's a fix even
> for stable kernels.
> 
> Or did the virt_to_page() change recently where that wasn't the case?
> 

Although the fixes tag is wrong. As the persistent ring buffer didn't
even exist then. It should be:

Fixes: 9b7bdf6f6ece6 ("tracing: Have trace_printk not use binary prints if boot buffer")

As that's what added the BOOT flag and is in the same kernel version
that added the persistent ring buffer.

-- Steve
