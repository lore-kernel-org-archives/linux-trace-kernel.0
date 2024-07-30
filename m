Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F11A2C0F;
	Tue, 30 Jul 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352478; cv=none; b=W0vVdUMFat9XAVjbcBPCDKnCLv+KbFwZ9P+kWnMrZ4GhemLhETTxadxu6/hYWcG11Q7X2Tur053Lir/oTaiv3flEJ1JTABD0XlllhhB9a8XxQ9WSS1M7lyer7jARy2L5H7AZYUGz0C8K7g4h2L0mcIRu/DFqbdpah3/+SU86yNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352478; c=relaxed/simple;
	bh=8Jbg6LHk1KAJjYZSOJbfES+Zl/Rn4Egzg5VItgVW1lg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMt44veBwSlUd9ahcfwl4kWJRn6CGiaSD8UzAXKnqnH7SGsWujlvgxbg6GVYsiPHlmBwk8PpRig2zk/4xIcQktG0DR2fzEf3m3T3qX7fa+V5TWYG75/ZE6LdM5G+c1M+2tcn23zNmPyj7s8IDJJyPuvkg0JTjGsm6hhCDSSho1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCFFC32782;
	Tue, 30 Jul 2024 15:14:36 +0000 (UTC)
Date: Tue, 30 Jul 2024 11:15:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers  
 <mathieu.desnoyers@efficios.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Mathias Krause <minipli@grsecurity.net>, Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?=
   <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Al   Viro <viro@zeniv.linux.org.uk>, regressions@leemhuis.info, Dan
 Carpenter   <dan.carpenter@linaro.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Florian Fainelli 
 <florian.fainelli@broadcom.com>, Alexey Makhalov   
 <alexey.makhalov@broadcom.com>, Vasavi Sirnapalli   
 <vasavi.sirnapalli@broadcom.com>
Subject: Re: [PATCH v3] tracing: Have format file honor EVENT_FILE_FL_FREED
Message-ID: <20240730111508.75448556@gandalf.local.home>
In-Reply-To: <20240730110657.3b69d3c1@gandalf.local.home>
References: <20240730110657.3b69d3c1@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 11:06:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Link: https://lore.kernel.org/all/20240719204701.1605950-1-minipli@grsecurity.net/
> 
> Cc: stable@vger.kernel.org
> Fixes: b63db58e2fa5d ("eventfs/tracing: Add callback for release of an eventfs_inode")
> Reported-by: Mathias Krause <minipli@grsecurity.net>
> Tested-by: Mathias Krause <minipli@grsecurity.net>

Hi Mathias,

I kept your "Tested-by" tag because you did test the part that fixes the
bug you reported. I just added on top of that one to handle other possibly
cases. Let me know if you want me to drop that tag, or if you tested this
version as well.

Thanks,

-- Steve


> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v3: https://lore.kernel.org/20240726132811.306a449e@rorschach.local.home
> 
> - After inspecting the code, there's several users of event_file_data()
>   that return the trace_event_file descriptor when it could be set to be
>   freed. Add a new helper function: event_file_file() that will make sure
>   the event_mutex is held and check the flag and return NULL if the file is
>   freed.
