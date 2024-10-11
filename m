Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28D198E63;
	Fri, 11 Oct 2024 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665040; cv=none; b=fPk6eUK9JQYoTVfvW0yJ/mGxdyRmMvqQOc6boJCk/16a4vVjwYBBuj/41TvxUmg1fADMlvqt1OtxvH1sZ2PLvnnwWZKFH3PO4BZMVGRbN2TWJFazVDoUutHhf6CHsa9RHu9CQ8BtGa8u+YVB5BhQvoGeKaGYOYpFzrW4+DTryPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665040; c=relaxed/simple;
	bh=Qlvl/Goc7wx4JFkpBrC/bRh66HnOp9fYgJSKRyt5/aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PO7O6B5l0EuMBp7MmnhMgqx0QpHCu2GuvpZjH3xa2j7K5ZShJZJmFLB6CJUMvIla8namMtTLmONLrATO46o1wcuLJNJciDOMCw1Kc0dZIGqhibd8a++nzLMtOibX3tH0yPmS8PTKpGvc52GEVyoIAmmKt/3OeqbFJqWxBYjzSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF27C4CEC3;
	Fri, 11 Oct 2024 16:43:59 +0000 (UTC)
Date: Fri, 11 Oct 2024 12:44:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Have the buffer update counter be atomic
Message-ID: <20241011124408.6783a141@gandalf.local.home>
In-Reply-To: <84179edb-dba1-42fd-88a9-70d05d8915ec@suse.com>
References: <20241010195849.2f77cc3f@gandalf.local.home>
	<1924e096-916a-4311-a3d5-07d3813f50da@suse.com>
	<20241011100132.456f903a@gandalf.local.home>
	<20241011104848.7f5b180b@gandalf.local.home>
	<84179edb-dba1-42fd-88a9-70d05d8915ec@suse.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 17:20:12 +0200
Petr Pavlu <petr.pavlu@suse.com> wrote:

> I agree, I also noticed the missing locking in this function and it
> looked to me as something that should be fixed. I happen to have
> a somewhat more complex patch for it from a few months ago (pasted
> below). I think I didn't send it to the list because I then noticed
> other potential locking problems with the subbuf code, which I wanted to
> examine more closely first.
> 

Hmm, I think you are correct that the buffer->mutex isn't enough for the
sub buffer page and it requires a bigger window. I'll look at your patch
and also the logic to see if it can be squeezed down a little.

-- Steve
