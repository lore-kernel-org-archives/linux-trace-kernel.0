Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8D5BAF0;
	Sat, 12 Apr 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744474035; cv=none; b=ElsrMTPny23shYlR7N9pUa3mJMlDAUCNCk2xzTtpx/+AfdXdVrskTsmbLKx8Ys3v8N6FG7L8CshkmBAkHmpA/sRApIsQ98qLGA1l436SRd6yWACyjJUaodBY26qtKtXnCjLvNblN9+MAQ1gl1/lDDla0SU0YHVNU6YTr3IrpMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744474035; c=relaxed/simple;
	bh=/TIdMQSF7o9d9SbA7Dmum5BQV8Q1xkG1vjA1pySG6/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JucmfnJvf/NL0QeHUCTP61+u+HAQtfucirYd/6u12quIB0Zx11AsjpSesRdTEH3h2Tj7J3EAtSEq0rryB9DZgripFdI+OtHLbIbLFrucgQPUWVehkUFQOk2t8o7Cys2L2jC4culPf1OGn+uTbiR01bxYy5PHom5V8a1MkXyRJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A9EC4CEE3;
	Sat, 12 Apr 2025 16:07:13 +0000 (UTC)
Date: Sat, 12 Apr 2025 12:07:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] ftrace: Fix type of ftrace_graph_ent_entry.depth
Message-ID: <20250412120712.67fc45d9@batman.local.home>
In-Reply-To: <20250411172207.61332-1-iii@linux.ibm.com>
References: <20250411172207.61332-1-iii@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 19:21:41 +0200
Ilya Leoshkevich <iii@linux.ibm.com> wrote:

>  
> -	F_printk("--> %ps (%lu)", (void *)__entry->func, __entry->depth)
> +	F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)

depth should never be negative. Why did you use "%d" and not "%u" ?

-- Steve
