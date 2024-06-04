Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D512FB0B;
	Tue,  4 Jun 2024 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514496; cv=none; b=ckZu7/aA6Iud4xbGlGvBmxeu9Q2y5FzszE/nl56qNaQXLcADb6BrVeDIJurXHcWtuICSdB5P8dgF12STIsKxS2AK7kZ5UmxgDMe6T4APebijxiqFdl8WntP2rMJDb6hjHr8YJAETJOwB0nppdA8DRXqrrLT0AMVHai8gRgC9yP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514496; c=relaxed/simple;
	bh=p9uNWDaWGqDK9AZkwGIZT+s0wPEqqgkKX6uerXOG/Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p397BlcF6lef7vt1SvcmiN9Mr7cQ6c0zmHc3NChJmC+diY9iWcxmQbc7fZ2a7JQEuJbRAKxMbppGmSEoa3NsRCMU2+GLBktkE3t+797yLdF7QxJtWQ5YI/nDahp+tvPnQexephA8KT4Bix7lCFp/EAOhyYQM9Qyzk0iLixDuMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9609CC2BBFC;
	Tue,  4 Jun 2024 15:21:34 +0000 (UTC)
Date: Tue, 4 Jun 2024 11:21:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, don
 <zds100@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] sefltests/tracing: Add a test for tracepoint
 events on modules
Message-ID: <20240604112131.25ad0a21@gandalf.local.home>
In-Reply-To: <171723017495.258703.11572784928592807749.stgit@devnote2>
References: <171723014778.258703.6731294779199848686.stgit@devnote2>
	<171723017495.258703.11572784928592807749.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  1 Jun 2024 17:22:55 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a test case for tracepoint events on modules. This checks if it can add
> and remove the events correctly.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
