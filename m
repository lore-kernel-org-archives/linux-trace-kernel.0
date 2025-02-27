Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7AD1A9B2A;
	Thu, 27 Feb 2025 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692209; cv=none; b=dXrSwmOCeyGl1wZwITugvu1HCj7rze/eCiudPy8iBVKsxNJGR/DFmXJ5VeDlAG2SF5hBQ0K/uTJmlx1uJMLCkXJhq2W9D32M94D1gGdsaokL/IkWUkFYRx13tLdO4nftfiauPKWBYXmQWiVfa3PUkzI8GzakArJFPkaMmfM6cFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692209; c=relaxed/simple;
	bh=fUDknViC4Lj0sZ1uaGoe3/XueTkv6z/Nq/2lCkcB21o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tuXP0crnOmNjZjGiNbxVTe6/pMtcSowljCyPrEN6ogtcuFdx634LhHeIOWjZnMh7d5+KhTjpAt4lthPU3UhQtbreYP5KDfK0lCFmL8dxpyvCXjviJ6+EcXNWXXStSiJJaMoDZyhmOpxGJE5qnMQIHqIQ5U5kqcykQvxCsIwYSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27323C4CEDD;
	Thu, 27 Feb 2025 21:36:46 +0000 (UTC)
Date: Thu, 27 Feb 2025 16:37:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <zanussi@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers  <mathieu.desnoyers@efficios.com>,
 Tomas Glozar <tglozar@redhat.com>
Subject: Re: [PATCH] tracing: Fix bad hist from corrupting named_triggers
 list
Message-ID: <20250227163729.053882a2@gandalf.local.home>
In-Reply-To: <0af3b796add9016c6e34b0b9b3eca673aaaa3a7d.camel@kernel.org>
References: <20250225125356.29236cd1@gandalf.local.home>
	<0af3b796add9016c6e34b0b9b3eca673aaaa3a7d.camel@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 13:53:27 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> > -enable:
> > +	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
> > +	if (ret < 0)
> > +		goto out_free;
> > +
> > +  
> 
> Extra space added here.

Bah, I'll remove that when adding your tested by.

I've already ran it through my entire test suite, but I'm going to break my
rule and just build and boot to test removing that line, and not run the
entire test suite.

Now, if there's another bug that shows up, it will get run through that.

Thanks,

-- Steve
