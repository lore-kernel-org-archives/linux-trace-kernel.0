Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C3136326;
	Fri, 14 Feb 2025 02:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739499698; cv=none; b=Q0sMgyk1HngSnoiYMrt+cN3ZWC/l+5uu7W8ivvf18Yz9QBDvYMbX9C7wIOKu1eXn6rZUQVtKgmps+11l/PQp4fvmK7ufePQZdSJIFAtzi0+1DTBfepLWkDokVbo8AQvPPY6jadh/AiRXQqMa2aov06Vt3gneJ/dJaD2Uyjfwqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739499698; c=relaxed/simple;
	bh=gxJh86ts2CI7/CpOOHrAOlj9FKsKa3Y7dzlchAKgUGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIQ5o+Yl/V2nFKy79lKCZ7Le+u1FOlklOqeEs7tmmgfkghP+XouKaZ5TJRJuuFzADS5IwFx7HZZQeEo8iY5sji8HiRoJgLSUYfBuzTs6MC54B4tohkwGvc28DTZZQ4KXzTJfk5d4bIH+Qd7ZTAmO/RcIBXo7AHihXv+9nLvm03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F585C4CEE5;
	Fri, 14 Feb 2025 02:21:37 +0000 (UTC)
Date: Thu, 13 Feb 2025 21:21:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] tracing: Do not allow mmap() of persistent ring buffer
Message-ID: <20250213212147.6511b235@gandalf.local.home>
In-Reply-To: <20250214110722.7eaf35b42c4858e6b74500f7@kernel.org>
References: <20250213180737.061871ae@gandalf.local.home>
	<20250214110722.7eaf35b42c4858e6b74500f7@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 11:07:22 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> This may be good for fixing crash short term but may not allow us to read the
> subbufs which is read right before crash. Can we also add an option to reset
> the read pointer in the previous boot for the persistent ring buffer?

I'm not sure what you mean here.

Note, this is just for mmapping the buffers. Currently we never tried it as
if we did, it would have crashed. But this does not affect normal reads.

-- Steve
