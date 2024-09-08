Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650FC86AFA;
	Sun,  8 Sep 2024 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725802116; cv=none; b=GdzghuAabYpu7AGZ5UydKoIPeoIJXACfbPJ9oYaec3Ddr1jqZs33pY6ONJU3cmpRBEaPG2iK5p7keIx9kxfcN1Hp+Uufr987unsrK6q/nvh4pArCccB74ExNUkZQgvMErqNl1LJslZ6kzkX3WRAoSvisult71TFQu7+5m4/CA8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725802116; c=relaxed/simple;
	bh=Ri56JanrxzJT4UAsenigTt4NMozWGcCirDACmDKy/58=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uHfhHQrypSALubptFjb5KZC5KKIeIKxx0QFJp5CGcX7V9xsgOEPY8DOT66yv/BNZD0Pw5UxAhRJTTMxxBqykOvJpHbzklo4cPdlHP5I0+dJKylLggU6gr/tYNAtmr9OWD8+9b+Bpyvy7zmHK6YqndaTn4yPAqR+qaZJ8CeHcTwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7ebJUoT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7ebJUoT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146EDC4CEC3;
	Sun,  8 Sep 2024 13:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725802116;
	bh=Ri56JanrxzJT4UAsenigTt4NMozWGcCirDACmDKy/58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o7ebJUoTay3mWVdOCJ4YnYJZjSzmSnevlKrosJn8e6uCur1cUoVbw9AKKa6GDZXt1
	 qxExlBWFTKM5q7/LVzILs04dk1Pq0KKrLMfdXcFBLK8l5WMlySIzzvHOBnNy5W8lNJ
	 OPGhpYs0TrwJg+DYNRQHUBzF8/UvDPGLsiXswSS5Ko7wyXHPxVJSrcHt9v4OyO+BVE
	 nNLHP+i0KOG/K0u7PtjWKIwfZLaKZpWhUDJmBAeGhOGRrsRkh6Yc/IRSqYU7myASWp
	 aW/1VD16L2dLdm86/Vx+cuDhYrWRmEemikoIP+g4/KIs0YEJw+DmdL/j9CcjiEX9vL
	 zImcMKORyq8mQ==
Date: Sun, 8 Sep 2024 22:28:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sven Schnelle <svens@linux.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: Re: [PATCH 0/7] add function arguments to ftrace
Message-Id: <20240908222830.01a01b10d62d59ed73dcb676@kernel.org>
In-Reply-To: <20240906100738.2526cffd@gandalf.local.home>
References: <20240904065908.1009086-1-svens@linux.ibm.com>
	<20240905111620.5211d9f8@gandalf.local.home>
	<yt9dv7z9l2zp.fsf@linux.ibm.com>
	<20240906100738.2526cffd@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Sep 2024 10:07:38 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 06 Sep 2024 08:18:02 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
> 
> 
> > One thing i learned after submitting the series is that struct
> > ftrace_regs depends on CONFIG_FUNCTION_TRACER, so it cannot be used
> > with the graph tracer.

Yeah, this is solved by my series [1].

[1] https://patchwork.kernel.org/project/linux-trace-kernel/patch/172398532480.293426.13232399076477198126.stgit@devnote2/

So I think this series is easier to apply after my series, which
passes fgraph_regs in return handler.

Thanks,

> > So either we make it available unconditionally,
> > or use some other data structure. Would like to hear your opinion on
> > that, but i'll wait for the review after your travel because there
> > are likely other issues that needs to be fixed as well.
> 
> Hmm, I thought the graph tracer depends on function tracer? Anyway, the
> configs should be cleaned up. I would like to make CONFIG_FTRACE just mean
> the function hook mechanism (mcount,fentry,etc) and not be used for the
> tracing system.
> 
> Anyway, we can just make ftrace_regs defined outside any config for now.
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
