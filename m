Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB890262FF5;
	Tue, 27 May 2025 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353672; cv=none; b=C4qT2lfo6PbgaA9IGtVLcgM7ajA8DbtoFa5LWpszKnMiY/nAOr8TEOUH5ZgPCVyc5YfnhbtoAj9NV2NTPNw51LHwHek+Jblq6jpAJ+njKbP3BalnkMGEcVX+LR6kQlNdEsVjc8XvQn831TOyx/eHrhQVJ/wjfyt5pDJGrnGpm/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353672; c=relaxed/simple;
	bh=Sjm8Kp0xGaQd/X+6jC8orqiUg+fXnCLx1tvsGr8dkxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGjBsFMJvjehIZ1E2MibmBH//jD+x2X6uaTL6zZ9inEEB3iT5zqNaP7kl8vFhYf5X+7Nilr1uSDZF4lAHB31oBNFiEO0qWQ7Jdlq6se2tQa4azNCLhkPNbUIkp9pOFoHPL3gBIa50W7JPxNB0holSWgImkJSixdanlud44y1nak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99509C4CEE9;
	Tue, 27 May 2025 13:47:51 +0000 (UTC)
Date: Tue, 27 May 2025 09:48:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: ring_buffer: Rewind persistent ring
 buffer when reboot
Message-ID: <20250527094849.49e56eaa@gandalf.local.home>
In-Reply-To: <20250526124403.3bf41a0634733b640620ad8a@kernel.org>
References: <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
	<174792928413.496143.17979267710069360561.stgit@mhiramat.tok.corp.google.com>
	<20250523165425.0275c9a1@gandalf.local.home>
	<20250523192053.47054e6e@gandalf.local.home>
	<20250526124403.3bf41a0634733b640620ad8a@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 May 2025 12:44:03 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > 
> > Now the question is, can this affect the persistent ring buffer too? I'll
> > memory map the buffer and see if it causes the same issue.  
> 
> Yeah, it can happen, but I didn't hit that.
> Let me test it too.
> 
> Hmm, BTW, is there any possible solution? records the consumed
> bytes in meta data?

After memory mapping the main buffer, I found a couple of bugs. I'll have
the fixes out shortly.

-- Steve
