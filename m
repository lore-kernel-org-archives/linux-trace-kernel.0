Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3673F1F3B8A;
	Wed, 14 May 2025 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227715; cv=none; b=XENFvDQFNBDv3C2tP09Wyp+xiuJAsdCBSjHx1F+20YFHwCVcjghf1aCdtuoeD79b/Ht5yFp/FsnURdnv2ZHlEZaAwuYmjJ0ETXQojek35WmOLnPqouGVwPOeGHwrnseNM5akk+dueEMizlY6kjJoEneGIVvBLWnNl5fNP6z2D84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227715; c=relaxed/simple;
	bh=y0neAnZoopDbDZRz8nWzGM4PtthvI3+E3tZARmRTycw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwoZWbkcffWC1L4pspN63pCyCpJUcflZWdo1l5oXf2HUTUpqpLlZPJbPnMIZqV2hDKyvbOiFWWOT/y1JZwbu/9N98Bw/cOIWRn1JLMJFmlzHMih9Cn2QQz6UR4/NlXLMq66BNgqzE6zyW888nh9OZIB6oS4iI/07vE3f+buMAkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D02C4CEE9;
	Wed, 14 May 2025 13:01:53 +0000 (UTC)
Date: Wed, 14 May 2025 09:01:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tasos Sahanidis <tasos@tasossah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Fix persistent buffer when commit page is
 the reader page
Message-ID: <20250514090150.2063a838@batman.local.home>
In-Reply-To: <d60729c2-9fb4-4fa7-9e4b-070127d8943e@tasossah.com>
References: <20250513115032.3e0b97f7@gandalf.local.home>
	<d60729c2-9fb4-4fa7-9e4b-070127d8943e@tasossah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 09:20:12 +0300
Tasos Sahanidis <tasos@tasossah.com> wrote:

> > When it works correctly, it has:
> > 
> >   # cat /sys/kernel/tracing/instances/boot_mapped/trace_pipe
> >         <...>-1137    [004] .....   998.205323: sys_enter_fchownat: __syscall_nr=0x104 (260) dfd=0xffffff9c (4294967196) filename=(0xffffc90000a0002c) user=0x3e8 (1000) group=0xffffffff (4294967295) flag=0x0 (0
> >   
> Tested-by: Tasos Sahanidis <tasos@tasossah.com>
> 
> Patch resolves the issue on my end. Cheers!


Thanks for validating!

-- Steve
