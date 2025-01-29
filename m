Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025F1B4250;
	Wed, 29 Jan 2025 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161702; cv=none; b=oGuKxv4Z4Rfiw0iiZvrL4k60QVU6SfG5cNOOwBLCDpJdGa/gNeZ3vyXkoeLNmPp/ddffoxEF/TwuI+Ktz09Nq+EiXLauo6i528gsBeiSeMBmu34CAa91YGbs9ecHW8uf3F0+9oR1IXvBWf+P3mXwgt+8jYs/0l3bs0PwmWi530c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161702; c=relaxed/simple;
	bh=+4BiM/kVUevvWdidfZzsSQWNbRoG4SzxnF+mDzbNgTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJ5/V9uqTPvnIxQCwh/Xt/xgxbTFmB0Vv1ysZeNFna0PYn3CsingKQyuoJgd+gPtgSSNERngGRW+wh5AE/jDCdgAloJPp4gujpcryd/SNhZck+HzTvEbjfhLjOvfbeuq4YoMXqOH/AOt6W4ujWM/x2UC3pmN0tLn8MYPgH/4uGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B382CC4CED1;
	Wed, 29 Jan 2025 14:41:40 +0000 (UTC)
Date: Wed, 29 Jan 2025 09:42:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] tracing: Introduce relative stacktrace
Message-ID: <20250129094202.0d8deb73@gandalf.local.home>
In-Reply-To: <20250129162538.953578b387bd4067afdd15a0@kernel.org>
References: <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
	<a7a171c4-7feb-4f26-a832-18d38a3ee973@efficios.com>
	<20250128112733.37d7c771@gandalf.local.home>
	<c3842632-cb15-469f-a6e8-8e9ccb3fff56@efficios.com>
	<20250129095819.fe6846ddab613460647db919@kernel.org>
	<20250128200939.0cbce825@batman.local.home>
	<20250129162538.953578b387bd4067afdd15a0@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jan 2025 16:25:38 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:


> > Actually, if we save the addresses of where the modules are in the
> > persistent ring buffer, and expose the addresses only if they are from
> > the previous boot (if it's the current boot, it just says "current"),
> > then we can decipher the modules from the previous boot.  
> 
> OK, but when would we save it? it is OK to do it in panic()?

It would be saved in the persistent memory region, and added when a module
is loaded. That is, it will already be recorded when a panic() occurs.

-- Steve
