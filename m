Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45117145A0B;
	Fri,  7 Feb 2025 02:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738893727; cv=none; b=e8Uhi9yqfWVFy8nc2o5Ep6HG4i2qSL0Tg/B+7zGOtQsxoNJk8/zgOmuzZPuHoCeIkWg7lVtk6z+hbzyZ2Es06CfNmMoI6CjtFwvV3/SSOJCHZON+R7ldvbH+qFVrI9ox+feMuqYrn7MhL1H6pEC2dEBuHauM08tkfMOThUFRLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738893727; c=relaxed/simple;
	bh=kuKBGXfWF72GPnn9aAJK/5eaTrwvDCrw7ihGfLyKqrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rj2qZO7YH4Tyt/U1vLDljb5bxeERIzLhXYsNXG9ZvNYQGuXtIKoT5zc5Ej1qNtPprXgmRNEMkSSB0k0fs16KQ4XVZY6YwotdRwpGjIDQGEz9p0rdcK2fbkucVUcWZp6ADuN1OHI9aReGzjh0nwbM7XvD9xvZxD+frxZLvTLjdKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3AAC4CEE0;
	Fri,  7 Feb 2025 02:02:05 +0000 (UTC)
Date: Thu, 6 Feb 2025 21:02:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7/8] tracing: Show module names and addresses of last
 boot
Message-ID: <20250206210247.4daa94c8@gandalf.local.home>
In-Reply-To: <20250207105111.1067fc1421bf682818e488c1@kernel.org>
References: <20250205225031.799739376@goodmis.org>
	<20250205225104.096389081@goodmis.org>
	<20250207105111.1067fc1421bf682818e488c1@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Feb 2025 10:51:11 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> >   # cat instances/boot_mapped/last_boot_info
> >   Offset: 10c00000
> >   ffffffffc00ca000 usb_serial_simple
> >   ffffffffc00ae000 usbserial
> >   ffffffffc008b000 bfq  
> 
> This is just a suggestion, what about using the same format for all
> lines? For example,
> 
> # cat instances/boot_mapped/last_boot_info
> 10c00000         [kernel]
> ffffffffc00ca000 usb_serial_simple
> ffffffffc00ae000 usbserial
> ffffffffc008b000 bfq

This can be confusing because the first is an offset, and the others are
addresses.

> 
> > 
> >   # echo function > instances/boot_mapped/current_tracer
> >   # cat instances/boot_mapped/last_boot_info
> >   Offset: current  
> 
> And this one is empty if it is already for the current.
> (because last boot information is cleared)

Hmm, I have to think about that.

Thanks,

-- Steve
