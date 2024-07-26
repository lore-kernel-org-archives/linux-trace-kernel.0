Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEBB1CD00;
	Fri, 26 Jul 2024 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722009821; cv=none; b=H/ohJb0NwvVxifrXGLIbVxKN31Qx451Aqf3CCeSF/zTTeuiEdIlt8fhmLp5aQwIrhK9zmqqf1C7jVE3j2z0W+sGVNh6W+JlXfipMdelDCiUboDL4Spw+PTEEtRPaaFohvypRiesFJ3RlvSat4VxqsyvuLJSUpL8XN0gDV1JvFIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722009821; c=relaxed/simple;
	bh=Gyg9lFbCiuBbufg8p6eIfdE1uTo8a3YxXyjdHDvtB7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jy9/81MM6/En4NIOztzRTs5QyZ1ISSXQ0k98Im13e2b1pZsTM7KygM9JiKYLSNgoY8P9pcZXAfiAN8tbju21Gl8UXeUe8l2zJhk9mMnijzSCumCBWvET2IVAbgsSEI3tIUjqm8zOCHTxUT7DyAiXecWJE5wGAeX4kDXIBq07FLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832DDC32782;
	Fri, 26 Jul 2024 16:03:39 +0000 (UTC)
Date: Fri, 26 Jul 2024 12:03:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mathias Krause <minipli@grsecurity.net>, Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al
 Viro <viro@zeniv.linux.org.uk>, regressions@leemhuis.info, Dan Carpenter
 <dan.carpenter@linaro.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Alexey Makhalov
 <alexey.makhalov@broadcom.com>, Vasavi Sirnapalli
 <vasavi.sirnapalli@broadcom.com>
Subject: Re: [PATCH] tracing: Have format file honor EVENT_FILE_FL_FREED
Message-ID: <20240726120337.40e77833@rorschach.local.home>
In-Reply-To: <CAD2QZ9b7=Y_x6o6R2UGwDRCky522A0fbiX_BxrY9w2LPyd=0sw@mail.gmail.com>
References: <20240725201517.3c52e4b0@gandalf.local.home>
 <CAD2QZ9b7=Y_x6o6R2UGwDRCky522A0fbiX_BxrY9w2LPyd=0sw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 18:00:18 +0530
Ajay Kaher <ajay.kaher@broadcom.com> wrote:

> Some doubt:
> Because of the same race condition, it may happen that kmem_cache_free(file)
> was executed while f_start() is waiting to get event_mutex. Once
> f_start() acquires
> event_mutex, it will access the *file which points to the freed cache.
> I am assuming in this case KASAN will not show anything as *file
> belongs to cache.

No, the file is freed by the callback from eventfs when the last reference
to the file is released. That is, there's no more references to the files
(nothing has it opened). As this code is only called when the file is
opened, it will not race with the freeing of the descriptor.

See event_create_dir(), it registers the dynamically created directory
and files. It will also do call event_file_get() that adds a reference
on this file/directory descriptor. It also registers the
"event_release" function to be called when the last reference of all
open files are closed in that directory.

That event_release() will call event_file_put() that does the final
release and frees the file. This prevents file from being freed while
anything has it opened.

While looking at this code I did realize that the "format" doesn't
register an "event_release" and there's no bug with its data pointing
to the call with respect to freeing something it shouldn't be. But it
still needs the file pointer anyway so that it can have access to its
flags.

-- Steve
