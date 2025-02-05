Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAA2219E8C;
	Wed,  5 Feb 2025 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738795916; cv=none; b=glU6I+kLtAv03qJMXo6p2bJND2QigCL0Z7tgvvpfBGS5z3gza2Fd0Xz5CH9ZYSseJO8curuyQmjxnOEpj7FGHjFTyM3sEXbPkXp7WoaAWVOMDpqkdE2g9ctFrwv6zry1T/FKUU+Zql79tq6Qd6yruVXyR1TDC0HxjQuPd0Dp6ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738795916; c=relaxed/simple;
	bh=4NyqJ2Q2HBRi3lDSQ8aZjlLbNJ0TmyufNNV1zblHzq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnUJ1/BoMVPPLyYz7B7oigMzf5N4aUFJaK28MxO+TRE9FUy0vdZfR90hWwTOYkgbR61V1OpEJ/Ar+9gkI442GsUTjvBmnR6FxjafndP6kQ8UuXf7j723hcEzHwsO8Y5T/wNH0/uMgxIVUjWr4RtJq3qqwEp206KFHFPuMV46aAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A55C4CED1;
	Wed,  5 Feb 2025 22:51:54 +0000 (UTC)
Date: Wed, 5 Feb 2025 17:52:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 0/2] tracing: Introduce relative stacktrace
Message-ID: <20250205175234.2c16671a@gandalf.local.home>
In-Reply-To: <20250205095322.308234eb@gandalf.local.home>
References: <173839458022.2009498.14495253908367838065.stgit@devnote2>
	<20250203103234.79c4a388@gandalf.local.home>
	<20250205212543.42bd11a8093a074e9df27670@kernel.org>
	<20250205095322.308234eb@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 09:53:22 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 5 Feb 2025 21:25:43 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Anyway, let me try storing the module table.  
> 
> I have the module table code almost done. At least the recording of the
> modules into persistent memory. Exposing and using it is not started yet. I
> can send what I have and you can take it over if you want.

I finished what I was working on. Can you start with that? I can push this
up to the ring-buffer/core branch. Although it's not fully tested.

-- Steve
