Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5BB194AE6;
	Wed,  9 Oct 2024 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481043; cv=none; b=t32K/l8nkK8g+G4fSEJoXUbU8Z76V/WuGCiKvasI56QpW9JT5Vx80SpQq8GOB6oqVbLuAbUaiKCBaHyxt4f/0SpWnt7lnR/rAIZ6qs+G6s87/oWFEVduYgADw6tiPAeAgX6LHlTZ5gDd5tRByUuMyO+6+B27c0Ce7cT3C/1HfeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481043; c=relaxed/simple;
	bh=4x+DjWEWW/g2qDtgfiW8HbmZDDg8PDZam+6X3h2se0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sC9xhDu2zCxz5/6oer0ipeoJHx2yJ3lTQrYzucfcy5RwdgzEP1jSzLApFgnzCSIHJnjLYtESP7x0R6S8EQOre5mOvr5eiIraKu5j/xWLLauYt/nSW0BKExUyj9R+Ws+5l7yJIh0N8j6MHcGvjEddrdtG9NUVQpZcODXAZ2KWCCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B5CC4CEC5;
	Wed,  9 Oct 2024 13:37:22 +0000 (UTC)
Date: Wed, 9 Oct 2024 09:37:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 RESEND] function_graph: Support recording and
 printing the function return address
Message-ID: <20241009093727.4e99c1e2@gandalf.local.home>
In-Reply-To: <20241009030340.16400-1-dolinux.peng@gmail.com>
References: <20241009030340.16400-1-dolinux.peng@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 11:03:40 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> From: Donglin Peng <pengdonglin@xiaomi.com>
> 
> When using function_graph tracer to analyze the flow of kernel function
> execution, it is often necessary to quickly locate the exact line of code
> where the call occurs. While this may be easy at times, it can be more
> time-consuming when some functions are inlined or the flow is too long.
> 
> This feature aims to simplify the process by recording the return address
> of traced funcions and printing it when outputing trace logs.
> 
> To enhance human readability, the prefix 'ret=' is used for the kernel return
> value, while '<-' serves as the prefix for the return address in trace logs to
> make it look more like the function tracer.
> 
> A new trace option named 'funcgraph-retaddr' has been introduced, and the
> existing option 'sym-addr' can be used to control the format of the return
> address.
> 

Is there a reason for the resend? I already have it in my for-next branch.

-- Steve
