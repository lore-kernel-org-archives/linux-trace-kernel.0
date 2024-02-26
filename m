Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1CC12FB28;
	Mon, 26 Feb 2024 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966529; cv=none; b=S6tz/8goQ5oe1X7xtJvIqCQAdeRrS4ZGUbItlR8gLaagyubt/0h2leeYL+v+YJCEbhHnhG60gA8BM2ol6EyGsduxiVN8ts22zD04t5KUlQzkCze/TdrEDidK8gxczTOBnfcpDWWNU3efkaHkTL9guk29dYRzFvjXjaQQ4l6/DAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966529; c=relaxed/simple;
	bh=CjYlvF1PkcXdWh85XRVSTZMPR+ij0q27bHrWUczGxSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmdvIDT6Zy/H/EPKpQnP5T0FfWopohx2mo56q2gnnWsXSRMedBSnIw4LEqWxeB08oBCY9cVl9+1J0c6+uvoIowq/D1+fHYITeCvHxQg3SK/qifbvnz/I+zTqrNL8Ij8UT+8ogvErMK3BRs6qpozTyc/vwo/LHs0GbDzeiylQMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018A7C433F1;
	Mon, 26 Feb 2024 16:55:27 +0000 (UTC)
Date: Mon, 26 Feb 2024 11:57:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] tracing: Add warning if string in __assign_str()
 does not match __string()
Message-ID: <20240226115727.09906783@gandalf.local.home>
In-Reply-To: <20240226093328.3022e75eb1d349aca51029cd@kernel.org>
References: <20240223161356.63b72403@gandalf.local.home>
	<20240226093328.3022e75eb1d349aca51029cd@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 09:33:28 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 23 Feb 2024 16:13:56 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > In preparation to remove the second parameter of __assign_str(), make sure
> > it is really a duplicate of __string() by adding a WARN_ON_ONCE().
> >   
> 
> Looks good to me. So eventually this is removed when the second parameter
> is removed?

Yes, I applied this after my other patches.


> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


Thanks!

-- Steve
