Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1690828A2AA;
	Thu, 13 Feb 2025 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465233; cv=none; b=b5R1u1oIuSN3zVdYeqjcUNlwOXJjRb3i0OwInCv6puxMhZ/x7I31lmCYZKpIx8eONDRNAvk4on4GS++Kx7FkrYmMutg7+Mcgv0NyttymSdGziiDO5BR2j9vg0udIx+rjLbz5a9uRAfuBhhu86zKftZXYLWLyTJ2SkvzXIalHdeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465233; c=relaxed/simple;
	bh=Q+7RTh/pTrWkDGeB5wUpAsRMuOZ7iBoJrIrT5Q6Tqpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVQV0mBUXrt/cecamvVre44vzAWTkCOZCOjdhcR4dngFx6wmm+Ku0b++zIAqaExMbNG3jC5Jp5tH2OpQRiuJF3j7x2HXtTIPpyDophgHmlPx3pCCBpxFixEUik2K7oTqSERCYLaY6ZbxKsSMsC/wG0WiidleOGCxCZ4pqsbGEws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABDBC4CED1;
	Thu, 13 Feb 2025 16:47:11 +0000 (UTC)
Date: Thu, 13 Feb 2025 11:47:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: mhiramat@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs: trace: Refactor index documentation
Message-ID: <20250213114721.23d07909@gandalf.local.home>
In-Reply-To: <1906f93a-dc32-4dbe-9b11-eabd4aad196e@gmail.com>
References: <20250206141453.139613-1-purvayeshi550@gmail.com>
	<20250210174556.70fc53b7@gandalf.local.home>
	<1906f93a-dc32-4dbe-9b11-eabd4aad196e@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 17:26:21 +0530
Purva Yeshi <purvayeshi550@gmail.com> wrote:

> >> +Tracing in the Linux kernel is a powerful mechanism that allows
> >> +developers and system administrators to analyze and debug system
> >> +behavior. This guide provides documentation on various tracing
> >> +frameworks and tools available in the Linux kernel.
> >> +
> >> +Introduction to Tracing
> >> +-----------------------
> >> +
> >> +This section provides an overview of Linux tracing mechanisms
> >> +and debugging approaches.
> >>   
> >>   .. toctree::
> >> -   :maxdepth: 2
> >> +   :maxdepth: 1  
> > 
> > I don't really know what the maxdepth gives here, but there was no mention
> > in the change log why it had to be converted from 2 to 1.
> >   
> 
> I changed :maxdepth: from 2 to 1 to simplify the table of contents, 
> keeping only document titles instead of also including second-level 
> section headings. The intent was to improve readability and navigation.
> 
> Additionally, I referred to commit '270beb5b2aae', as suggested by 
> Jonathan Corbet in the v1 patch, to align the documentation structure 
> accordingly.
> 
> I'll update the commit message in the next revision to explicitly 
> mention this change.
> 

Can you make that a separate patch. A commit should do only one thing and
that change isn't necessary to be part of the rest of the changes.

> >>   
> >> -   ftrace-design
> >> +   debugging
> >> +   tracepoints
> >>      tracepoint-analysis
> >> +

> >> +
> >> +Hardware and Performance Tracing
> >> +--------------------------------
> >> +
> >> +This section covers tracing features that monitor hardware
> >> +interactions and system performance.
> >> +
> >> +.. toctree::
> >> +   :maxdepth: 1
> >> +
> >>      intel_th  
> >   
> >>      ring-buffer-design  
> > 
> > The ring-buffer-design should be in "Core Tracing Frameworks".
> >   
> 
> I'll move 'ring-buffer-design' to the Core Tracing Frameworks section.
> 
> >>      ring-buffer-map  
> > 
> > This describes how to map the ring buffer in user space. Maybe it should go
> > at the "Introduction" section?
> > 
> >   
> 
> For ring-buffer-map, placing it in the Introduction section could 
> provide early context, but since it is more implementation-specific, it 
> might fit better under Core Tracing Frameworks alongside 
> ring-buffer-design. Would that placement works?


But it's not kernel implementation. It describes how to use it in user
space. That is, it's not part of the tracing framework.

-- Steve
