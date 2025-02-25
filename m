Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA441A238B;
	Tue, 25 Feb 2025 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516895; cv=none; b=fXn2Vomd8EVTq8A2jKdt69bRt01yeBR66JlpivdG694Cr/8jBCiLUyqS/4UwReF/d2x2jNuBFd5wzjzTXxx05P+0ky+4j6WlQBD5sm6K7kIP7ZUFG4cwqY5uk/m/wjfgiRecqXg1F+CzEbcIDRNXqb17uZSbklRKuh33McyMh/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516895; c=relaxed/simple;
	bh=Q8bOBbwK70JATCAXEsg1UCeZtitZYWqzs0E2yEcpOq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmHFrtl7TW8/x1XGD6BoGI0yfGc04zoOCgbheAJB5huWbl3f0bA5novjMwdQDBiKt7qlq4JDaAjAQUQborX3B9wmQWjzaj81NrXUvk6Pd7BEVQkS6B1S5ZF04eSDIpXfsVYnacIgTWpguXOHxxVgxxFpJtyH471aaX99eisAbS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5775CC4CEDD;
	Tue, 25 Feb 2025 20:54:54 +0000 (UTC)
Date: Tue, 25 Feb 2025 15:55:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 linux-mm@kvack.org
Subject: Re: [PATCH v4 0/2] tracing: Make persistent ring buffer freeable
Message-ID: <20250225155532.0eb75041@gandalf.local.home>
In-Reply-To: <173989132750.230693.15749600013776132201.stgit@devnote2>
References: <173989132750.230693.15749600013776132201.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 00:08:47 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 4th version of patches for making the persistent ring buffer
> freeable. The previous version is here;
> 
> https://lore.kernel.org/all/173928521419.906035.17750338150436695675.stgit@devnote2/
> 
> In this version, I used free_reserved_area() instead of custom releasing
> code. This seems working correctly. Thanks Mike!
> 

Thanks Masami,

I'll start testing this after the fixes I have get tested. I'm currently
testing the fixes for the sorttable linux-next fixes, after that I'm going
to test the histogram fix, and then I'll test these patches.

-- Steve
