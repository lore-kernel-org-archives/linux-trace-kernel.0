Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E6E1C860C;
	Wed, 28 May 2025 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447264; cv=none; b=pOhclGbcu6kNssxm4c/lyO8bk1Ta68DKJxzGd/TwLu1M6dfFzhuZVmV8BmCZJQJZ1D1yCXc0JAa5Zmgn0/nDK5duiH+Sq8G+nKcl/GIoXbCC1GXd1AP/4l8xwWNWPY79wpEisdMWt5ltF65XgvxIOckErM/UHX5Zh9zQV1XhwGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447264; c=relaxed/simple;
	bh=wk31ZC40KMxXRWB3u+i5vzCJ1XRX25kSYlq/FWxj5C8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxnAzHfGRn/nbx/Tmrm/RWxMau180zEgqXSOx9oda1oAAsEfNK9o3pFw1hnnOd0YoxMGu/VT5F1FY3E5ueRpQf/VScuBbSWTM/f0RI0S1rXmqUb9ZnzfZTMQe798NZDixh6mwpIxzr7NEeOiFC0PGZDZEm95+Dsr+oKt3Om4YAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C28C4CEE3;
	Wed, 28 May 2025 15:47:42 +0000 (UTC)
Date: Wed, 28 May 2025 11:48:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] ring-buffer: Do not trigger WARN_ON() due to a
 commit_overrun
Message-ID: <20250528114842.7b9e696a@gandalf.local.home>
In-Reply-To: <20250528113439.3fa4f245@gandalf.local.home>
References: <20250527121140.0e7f0565@gandalf.local.home>
	<20250528104203.d6f509c5d9c30dec1e024587@kernel.org>
	<20250527221735.04c62a3c@batman.local.home>
	<20250529000342.5218ac7b90c99f3636edd5ab@kernel.org>
	<20250528113439.3fa4f245@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 11:34:39 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> And even in that case, it triggers at most a couple of times a second:

Forgot to cut and paste:

[  367.010564] Ring buffer [1] commit overrun lost 1070 events at timestamp:367737571566
[  371.328151] Ring buffer [3] commit overrun lost 21442 events at timestamp:372051356588

This run had only two prints. I've had at most up to 8 prints for a test
that runs over a minute.

I updated the code to print the per CPU buffer it happened on as well as
the timestamp.

-- Steve
