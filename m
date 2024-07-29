Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE083D9E;
	Mon, 29 Jul 2024 23:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722294163; cv=none; b=JUPAW58LcRxllMKnUSPYk5gXHgHjoxlrnVJywXaw2iGUEh3qgbWY1oTJn+Rh3m76Bc+Wl7QineATwzZJXT5cLNeFhfhrpp4tvGDdf59mXHFcMr2O5Jhz1ZlbMokQ6D4l8RFSKXGQ46PIp4KBI8qxqUeEitJz6SfSbVwAVQ5RVKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722294163; c=relaxed/simple;
	bh=dL8VBL1zodt6nAtXY2V+cc/hJ85kn3KVrZDLkCEX0W8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spZ5xU7cuxy4/LkazpUkAajLpJhDe1KQLHbwkO0zLZiOao0ABRvHFPYOZm9Q0G1Mqp+phzLSuCXw4NzBpY2Hi14kMcRlZYTZMjUHWZPm6hhUP5BZBgSVZ6jZxopvI0q//IBXOscOtEXiCZ9FcG6DoSc5py9nv4wgfowJj+q/mxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866D8C32786;
	Mon, 29 Jul 2024 23:02:42 +0000 (UTC)
Date: Mon, 29 Jul 2024 19:02:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Use refcount for trace_event_file reference
 counter
Message-ID: <20240729190241.47e52c05@rorschach.local.home>
In-Reply-To: <20240729234924.6accc2e6216e3b7be1a97e61@kernel.org>
References: <20240726144208.687cce24@rorschach.local.home>
	<20240729234924.6accc2e6216e3b7be1a97e61@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 23:49:24 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 26 Jul 2024 14:42:08 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > Instead of using an atomic counter for the trace_event_file reference
> > counter, use the refcount interface. It has various checks to make sure
> > the reference counting is correct, and will warn if it detects an error
> > (like refcount_inc() on '0').
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Looks good to me.
> 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Is that an ack or a review? ;-)

-- Steve
