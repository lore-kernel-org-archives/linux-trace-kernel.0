Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1647BAEC;
	Mon, 30 Dec 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735580091; cv=none; b=s2WtCHTicN7a1BH+XiugJw4l6qNfVRHf9lhtxLJQBWJlf6CkpS0PpcMECcLvPycLnjYRGQlGIK3KwFfvVmM2MpBM4pBOG32eV7xrShnPsvaUPmLqIY696AzujZ4kSJFVwCplggdCrq5gCNGLVVPcjEju+PaG1+VBDJp6Wl4CkHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735580091; c=relaxed/simple;
	bh=O06inQK3fg9McB+awicfip3+3UbD4h501v5FSRrhOSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqwWMBtCYxEIGCO9nqxNTbNRcY3OvDDF/iGpu/vPZOx9YGMEazq8SgKTHgJuUuwt7AosUSGVyIOSCHFITfl4V38XvMU3H8akMNo7LrMmxj4PaXW7ecmlIj1ZknC+/SHgbmzOBU+g8S8yN+Z6J8ZWxNReySlX+J/HCLn2eCW1IGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA76C4CED0;
	Mon, 30 Dec 2024 17:34:49 +0000 (UTC)
Date: Mon, 30 Dec 2024 12:35:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Naveen N Rao <naveen@kernel.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] tracing/dynevent: Adopt guard() and
 scoped_guard()
Message-ID: <20241230123558.533a12c8@gandalf.local.home>
In-Reply-To: <20241227101218.5948129c@gandalf.local.home>
References: <173289885627.73724.13632317993038475335.stgit@devnote2>
	<173289891992.73724.9491350426847416169.stgit@devnote2>
	<20241227101218.5948129c@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Dec 2024 10:12:18 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Are you OK with dropping this patch?

Masami, I can't make a new for-next branch with this conflict.

-- Steve
