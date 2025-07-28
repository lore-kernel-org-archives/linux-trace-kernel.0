Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BAE2512FF;
	Mon, 28 Jul 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695618; cv=none; b=UMoPt4i5QxjGfhPkm+CjcHuUYvb5xigWurv7XR+tu8R74wmyUXUx6wzGitQRNlQ724c/EoFkXFuM4J1o0O0Le5mdNdQ9lx1mNgvbK6k5vEntH8K/rMALDJAf8lPnzSzlqhr6pK8r+rpNmHh+vvMnE9btG/OnSbeEuAeBoxXzo7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695618; c=relaxed/simple;
	bh=lMvxGJZpsSf56cq8qaikTJtt9arUXiBOQ0MWPziv6W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7bg8P5w2I1OKIbqIXYsSHWo8jmJA/E4X6IFRFNSSGLkF2Las27UtR81O3mYpTwPBLwJz5fHUSp0sxm8AhEAdHnhzYQhDexfmvFJC8yt7Z1nwjVTWt9jzNu2l3QNtOm++QCRAilkJQonOKdXBqvXLuQMn/SUNndDXDakxvXiq5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0PChzioq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h6cLiTK2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0PChzioq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h6cLiTK2"
Date: Mon, 28 Jul 2025 11:36:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753695611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMvxGJZpsSf56cq8qaikTJtt9arUXiBOQ0MWPziv6W4=;
	b=0PChzioqAIumewPn2iW+W7Tc9Dxcy4CtKbjrr4frhwq8exHVMFRopFz5l9i7qOSUN9qKra
	J4yd7inVkStWkeYXJsen0hC8DF/bY/eHpiNK3DPFVZ4YpFOZ+kzTmaZKt27DtGzUFHkK/8
	GoM/NMY3C4kg8dODvnRtrl5BEvpZeMprRmLULzinLkVcwvbpAGY43f9Oz4FPHmYFWuyRE3
	BQe6HHmX/+zRNkzEyzZjPGcPfn24/pw1WkzgUckyQQ4RrEmQj8Aq9oAO0fJdVGPTdwt1Lh
	46YyFZ2TdQ37PvgSXCw+oEzhAADujnSl3BmHOViGpH8OoGqkr/YPtqo2qE0pig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753695611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMvxGJZpsSf56cq8qaikTJtt9arUXiBOQ0MWPziv6W4=;
	b=h6cLiTK2DGC8IJ6jO+nrUveq45HasrZ60spd633KOe32Q9wVF1cDbcatPNNYSxkWGqnlCt
	638b4GnBiajzaYBQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rv: Fix wrong type cast in monitors_show()
Message-ID: <20250728092756.C8zMlJtT@linutronix.de>
References: <cover.1753625621.git.namcao@linutronix.de>
 <35e49e97696007919ceacf73796487a2e15a3d02.1753625621.git.namcao@linutronix.de>
 <786688d8a5ab0d5228d271861416d49cc3a8ebc3.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <786688d8a5ab0d5228d271861416d49cc3a8ebc3.camel@redhat.com>

On Mon, Jul 28, 2025 at 10:59:01AM +0200, Gabriele Monaco wrote:
> Good catch, thanks! The container_of is the way to go.
> Do you have valid reasons not to move the list_head to the top? It's
> not a big deal but it would save computing and summing the offset. It
> doesn't seem name (the current first element) really needs to stay
> there.

I checked x86_64 and riscv64, the generated assembly of this function
before & after moving the list_head on top is almost the same except for
some instructions' intermediate values. Both architectures have
instructions which load data at (pointer + offset), so this offset
computing does not require any extra instruction.

Best regards,
Nam
