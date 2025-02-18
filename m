Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2DC26B2DD;
	Tue, 18 Feb 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892091; cv=none; b=sER+WmmJdYYBpiZhsJel5E1Q0hRfaFWXytepZ8MTxJd2M43tmElzB8D0KVIXU7EWzCaHGsm8S6IejtGlmwuOIyW0/V8ZzsFo57NHfKMllp3rdG6wIbQ6DcVRFy6+42XXtwEIDxGDLPCDmPMjRbznjw7GtzzTotb9PsmI9KgAIKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892091; c=relaxed/simple;
	bh=hfFhVGiN5UfXcXYYQJEXVD+sAosakg3odHDITTnhFNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGSaZW56Vbpb0VBRjwYSGPyc6bQ8exm/eUM373Fqk1A1UHb94SROol69lre2/ZwAlwtxseSRLksEAWQ6VJWc8Ee5P5eHPRUyvA1mMVSEatxQfEJLlln965aD7r4ja1QrcFhU2rNEJdeq+Owvkq8pcI8UQB1zvhPcCn9BBYiQX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6206CC4CEE2;
	Tue, 18 Feb 2025 15:21:30 +0000 (UTC)
Date: Tue, 18 Feb 2025 10:21:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] tracing: Do not allow mmap() of persistent ring buffer
Message-ID: <20250218102151.56cf169b@gandalf.local.home>
In-Reply-To: <20250219001424.c457366901b9327a79e2b83d@kernel.org>
References: <20250213180737.061871ae@gandalf.local.home>
	<20250214110722.7eaf35b42c4858e6b74500f7@kernel.org>
	<20250213212147.6511b235@gandalf.local.home>
	<20250214161332.8797b20f09e068c33f872698@kernel.org>
	<20250214070712.01997ea1@gandalf.local.home>
	<20250214233613.bde0638f393186f56f0b30eb@kernel.org>
	<20250214095943.178501fa@gandalf.local.home>
	<20250216003702.eef00d543ebbc3b16140ed9c@kernel.org>
	<20250215112153.55e56284@batman.local.home>
	<20250215114540.7203feaf@batman.local.home>
	<20250219001424.c457366901b9327a79e2b83d@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 00:14:24 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > As that's what added the BOOT flag and is in the same kernel version
> > that added the persistent ring buffer.  
> 
> OK, so this fix is for the limitation of the buffer which has
> TRACE_ARRAY_FL_BOOT. When this flag is introduced, it should also
> prohibit the mmap.

Correct.

-- Steve
