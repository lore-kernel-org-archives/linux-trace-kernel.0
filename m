Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F383002CF;
	Thu,  8 Jan 2026 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767850204; cv=none; b=AuITwQBVdIk+Dd0XrEZd/3oaTrr+mTH5fMHWwSEeh19/ooeHjC2DD41udvBrDqrkELwM6/7/mFSGdPyOl2ze+GmvLUaWI0g+uyZApfdO2kX837hcmXYml1Fd9fMG7CQSapgZPmBtrL8LJ5WPfnvtLBCvnRDn3NGd86FNNInmWzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767850204; c=relaxed/simple;
	bh=Q4mxnyg+sI5KPbe0gC+yq+6wPRUv6KpgFrv3+Rl9MVg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=W+6yAQA0ntX2BvpUE+Mcuqdp3hqeyq3AYk1n0KdvOrA7GL4JCqK5Fg/tr8SbRlUYx60IdgebBCz6DjztxaN9n0BDh658LW6fmvj0rAaQ7kU1U15fljB8Ow9vQr1fLOiZBsZgBetMCrk3oRM5ymqVDtuuxsinHaDwvXPughJmNMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLbYFnMo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLbYFnMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712CBC116C6;
	Thu,  8 Jan 2026 05:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767850204;
	bh=Q4mxnyg+sI5KPbe0gC+yq+6wPRUv6KpgFrv3+Rl9MVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jLbYFnMo7LAZ+HH6va4GpA9FSadz5rEMrvON8YdTSHPB1OLRixIqeC5GxJsvyrcTE
	 8MEF4kqayOewIQ4BH+9+n5o3I3Jmw2uobAwXRQqothUSJ9A3CWuzMsATVZ/yTx349C
	 Udlf84D1rHYfRegVvU87tCTZLg1Td/pxrc3qrpZhv07CzeswJWSH7Jo2o/+eDpY2EC
	 xu1563KgW9fGejGYI88N3BTfQNib1KAPnI8F29U4SXmSl7GH5xj/2moqOOxgxHCzss
	 MdGZ8IPqKUNVvltshCsANLHaGlhga6cV/xZ6XoHE7j4T/nqaxn38zv6rGpzq4iS9Az
	 P9pEMdzGAVY4g==
Date: Thu, 8 Jan 2026 14:30:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Make the backup instance readonly
Message-Id: <20260108143001.95237e93acda8c03e617b116@kernel.org>
In-Reply-To: <20260107220542.0128abf1@fedora>
References: <176779714767.4193242.1978666866487010024.stgit@mhiramat.tok.corp.google.com>
	<176779715937.4193242.8486149802702305279.stgit@mhiramat.tok.corp.google.com>
	<20260107114133.7f14dac2@gandalf.local.home>
	<20260108115125.b832464d94ebcfd0ea3b5af4@kernel.org>
	<20260107220542.0128abf1@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 22:05:42 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 8 Jan 2026 11:51:25 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > We may need to make sure they can't be changed to write as well. But that
> > > will require a change to tracefs (and eventfs).  
> > 
> > Ah, you mean the permission check is not correctly done in tracefs/eventfs yet?
> 
> Actually, i think we could use a different fops for read only instances
> that do not have a write callback. And for eventfs we could have it for
> read only instances to only create the id and format files.

Ah, OK. Let me update it.

Thanks,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
