Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6736913DBA0;
	Thu, 27 Mar 2025 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743110402; cv=none; b=WO7XaHCYhpy82CjIIfu+vvrOSnr34h84Mt3hGcv3RUqhv39l9QTzISJQ0y8TfIPYimo6+ib+eIOI8VZhaxjDdQD5+C6gBDom8fHCzOYhABB7ejMU9YE19cIuIDsrcSJN+yDcVBH7ZJ6yBLjwHNDdyKjlFMOMS68CnIdYaUmopnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743110402; c=relaxed/simple;
	bh=y9C1eQrWoU8V+oa2czQCuEs64eG/zTKwQyj+/Ykm8YU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDOiQJXdbzoZ5tMivGd9a6E3e9i4JAb5P4SjSqpG21oPCfRHkIeROv9cUfZf9r3g4AgiU88sfvmHEBZ1kAzvA/eE19ZsZ4fH9hkJgddGoI0z6IBd7iEcL2HXM1qC+PAiuUlBZ5xOxXfUl4y7pAuCz77Ql+he6/YCnLp/MvWrjj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35704C4CEDD;
	Thu, 27 Mar 2025 21:20:01 +0000 (UTC)
Date: Thu, 27 Mar 2025 17:20:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Libo Chen <libo.chen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Verify event formats that have "%*p.."
Message-ID: <20250327172050.2be5b38a@gandalf.local.home>
In-Reply-To: <d9707265-d6bd-40df-8e7f-4213851ea33f@oracle.com>
References: <20250327114911.2c713511@gandalf.local.home>
	<856e7f9f-2a7f-4b94-b6b9-c1f7151a1f7b@oracle.com>
	<20250327143853.1cef38af@gandalf.local.home>
	<d9707265-d6bd-40df-8e7f-4213851ea33f@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 14:00:44 -0700
Libo Chen <libo.chen@oracle.com> wrote:

> > Ah yeah. I'll update. Note, this isn't going to go into the kernel until at
> > least 6.16.
> >   
> 
> Okay thanks for the note. I will stick to %lx for now and change it to %*pbl
> once this gets in.

This shouldn't be a blocker for you. Do you get any errors?

Hmm, if this causes bugs (perhaps you have arguments after the %*pbl) then
I can add this as a fix and not an enhancement.

-- Steve
