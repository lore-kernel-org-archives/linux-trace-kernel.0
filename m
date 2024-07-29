Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208B548E0;
	Mon, 29 Jul 2024 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269437; cv=none; b=HU8M6ZkoyeZ9PFQpJDpLvTLqaxmHb6cbyR35b2c5QNOlm0E7F4Ealedhieze/STaZY1WdPNrEXlK7PsqYnL/yh1bAP6BNf/upTeyJSkbXkSwnijNPYTjKcr9n0fc3y890S9yo/pXdYf1qODov5FdurBSCr8pAIAHf9PvCHc8ojQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269437; c=relaxed/simple;
	bh=KS+pRoGbaMyjrqtczLoSk4VOPFwwhPyipG8+uSdqaOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ui/EpieGO01uAxZXxR93oLsHflSv+3H1do5PEuZxEXkI+7ja3I27xhTYWX99DrkdqgAw8Zm9gcTRJS8iaNH7NjCCDWnRYsuFQem3DLseFPNnYJiGl7LC8I1JwYM40ZHRp2G42HwOdD30U4ErebJCGVnouqo1gmoedj2S8Qgoetw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC25C32786;
	Mon, 29 Jul 2024 16:10:35 +0000 (UTC)
Date: Mon, 29 Jul 2024 12:10:34 -0400
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
Message-ID: <20240729121034.455fe04d@rorschach.local.home>
In-Reply-To: <CAD2QZ9aFHOTLSryw88PKdvXBQaug9di=CDQ9KjPBhuOTNhjxTQ@mail.gmail.com>
References: <20240725201517.3c52e4b0@gandalf.local.home>
	<CAD2QZ9b7=Y_x6o6R2UGwDRCky522A0fbiX_BxrY9w2LPyd=0sw@mail.gmail.com>
	<20240726120337.40e77833@rorschach.local.home>
	<CAD2QZ9aFHOTLSryw88PKdvXBQaug9di=CDQ9KjPBhuOTNhjxTQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 18:29:49 +0530
Ajay Kaher <ajay.kaher@broadcom.com> wrote:

> Following is not related to this bug:
> event_release callback executed once 'dir' closed (no more ref), any
> specific reason to register with 'dir'/'enable' file. If not, could we
> register with the 'dir' instead of 'enable'.

I tried that at first but it got messy. The files are saved in an array
for all files in the directory. There is just one array for all
directories that gets passed to the creation functions. That is, it
doesn't grow the memory footprint with the number of directories and
files created. By adding a callback for each file seemed a bit more
robust (and easier to implement as it only modified what the array
pointed to).

Although, I could change this array to a director structure that has a
callback for when it is destroyed and an array of all the files. That
may be the better approach but it caused a bigger change to the code as
it changed a lot of the prototypes.

So I ended up with the per file callback. But it could be updated if it
is appropriate.

-- Steve
