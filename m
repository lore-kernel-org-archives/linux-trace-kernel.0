Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E583A35E92B;
	Fri, 29 May 2026 02:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780021786; cv=none; b=FtfeeJhIe3lQIp12VNr5yWBxIHiq39ryIn7wE4KxliWoS2gJ6UnbK+N6TXixbEmQRKHUgPe0XfvoHZkXkNRMUWDVteO0YvUJHp9SPYnWpIxGkP1ZqEcEY5cFApecKHrGzbqzRmi6kXJRS//JVrt+ZLC6yvQZ3bY5dcSJyD8kD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780021786; c=relaxed/simple;
	bh=BXxr8EjaTYUkM09XE36KlGi1GUMl4OE8zFupUArcG6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+6KzLPATscJgkbH0C4IJGozQEowViCuTVbSikWT26vu0Gc11rmO6XUsAKXIppv0Ccd68ZpaW/FCcRm5KWCUhVyDQX3XTKN6kcFq0gy+YH8aFG48mWYSJgpZXk+N0j/DUqG8unQIjxs0KinqxwV8b7zBxptn7xKYJnTkNHWRIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id B23871C0E8A;
	Fri, 29 May 2026 02:29:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id E567430;
	Fri, 29 May 2026 02:29:35 +0000 (UTC)
Date: Thu, 28 May 2026 22:29:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tracing/probes: Point the error offset correctly for
 eprobe argument error
Message-ID: <20260528222934.7d0b1881@fedora>
In-Reply-To: <177967567399.209006.1451571244515632097.stgit@devnote2>
References: <177967567399.209006.1451571244515632097.stgit@devnote2>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uhqpxxzw8pu1n5ankrtydqmausczmzou
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: E567430
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Q654nJpbnZRxi/Cl2bgWbcojzWW4CSgs=
X-HE-Tag: 1780021775-425232
X-HE-Meta: U2FsdGVkX1+84LBjYxWHY6sVrsWNg+23aeciBAzbt4nPXwXNG8OqIyGq/pw1I3JZozZeRBUpGoiDTBX1xcALYwmPfE5+8z5Cot2v34jK67mdWmuTob8LtWW/6SP1abIrfj0XynKAT9vEqsXNrcyYa8sJuCW7XA8sY9QJHDK2/zFap5C86+qIv3qBot/UFJR1vPwdUgtIaFDVueh6VRnM+ym91JaNwLqKFR3/vmNKMvmVPGztEPEbtdJd6jFUkFhte8KUgejjTDNkDI46cix5BlQipjWWCptx08rZBaG3dK4zt3fSFpRZgUlr2YekeiRlLwJ0MqHc5QyghK45gRv1caoqf6HgaxjYOI/mFeZ/XEszzrWAuKM7h6ZX49Z2JUUygLp4DAOAw6WAWD45jnl1Wg==

On Mon, 25 May 2026 11:21:14 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix to point the error offset correctly for eprobe argument error.
> In the cleanup commit 1b8b0cd754cd ("tracing/probes: Move event parameter
> fetching code to common parser"), due to incorrect backward compatibility
> aimed at conforming to the test specifications, the error location was set
> to 0 when a non-existent formal parameter was specified for Eprobe.
> However, this should be corrected in both the test and the implementation
> to point correct error position.
> 
> Fixes: 1b8b0cd754cd ("tracing/probes: Move event parameter fetching code to common parser")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
