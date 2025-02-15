Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E865C1DFD89;
	Sat, 15 Feb 2025 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636516; cv=none; b=FDU3LpQwOd9gerxA77RHj5MEb6imgGI0336E8yerk5wSC54ipb1h0TJQ8Yr0S8i6RDDz6C+BHjCsvtwvLBpLIgu/IFndDPzvfb/ngChVC2hiJEm7bLOMkzHxxgAJdXp0fEToUCAt0ih/MVpVZfsh8fTiM1WWKzil2AwN3iBMM9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636516; c=relaxed/simple;
	bh=BP+YPu3eg6w0mwyThJQZSCiwmbhSDzVtyn8WubQxsgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osmm9OpHJS/YI0BFq9hxdm+ggbUuFXqakvTKvhR8S0nVjXkA5QK5BG66lQ1SdQx9+koqO0R9IhsRiO/sODu/2qmOVklfvQFEDFk2tKfqRyxT7BA2zriuvrgvN4GsUTuQGR9zWcNtkwfUzTDcjtAzMFtYGFtQbLCdnbtmnqjpqes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AD1C4CEDF;
	Sat, 15 Feb 2025 16:21:54 +0000 (UTC)
Date: Sat, 15 Feb 2025 11:21:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] tracing: Do not allow mmap() of persistent ring buffer
Message-ID: <20250215112153.55e56284@batman.local.home>
In-Reply-To: <20250216003702.eef00d543ebbc3b16140ed9c@kernel.org>
References: <20250213180737.061871ae@gandalf.local.home>
	<20250214110722.7eaf35b42c4858e6b74500f7@kernel.org>
	<20250213212147.6511b235@gandalf.local.home>
	<20250214161332.8797b20f09e068c33f872698@kernel.org>
	<20250214070712.01997ea1@gandalf.local.home>
	<20250214233613.bde0638f393186f56f0b30eb@kernel.org>
	<20250214095943.178501fa@gandalf.local.home>
	<20250216003702.eef00d543ebbc3b16140ed9c@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Feb 2025 00:37:02 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> My concern is related to the fixes policy. If this is a "fix", we will
> backport the new "disables mmap on persistent ring buffer" limitation
> to the stable kernel (that was not documented previously.)
> 
> However, from the user point of view, "mmap() ring buffers" is already
> supported (although it did not work on stable kernel for now). Thus I think
> the "Fix" is expected as "fixing mmap() persistent ring buffer". 

This only disables mmapping of the persistent ring buffer. Other ring
buffers can be mapped. We never supported mmapping the persistent ring
buffer. Even in stable kernels, if you mmap it, it will crash just like
it does now. Thus, this doesn't cause any regressions. It's a fix even
for stable kernels.

Or did the virt_to_page() change recently where that wasn't the case?

-- Steve
