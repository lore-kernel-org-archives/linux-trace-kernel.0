Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45C2426D26;
	Tue, 31 Mar 2026 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980191; cv=none; b=aP2WaePraqMYR6riWsPkF7z1NzUpQJTum1Sr5QjDvxa8UU9kmqjRAXgUEYcLjebihvTOmU2mMUwGoXJojAvlBwQOeMd3q2l4eeUyQOC06C0UDJDw4nZ6lExmfSnZgOXMElr0nNv5Sy58sC4W3XY8UqwCMpMa0h+fxkmk4HZ5i3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980191; c=relaxed/simple;
	bh=IEIsKpVdgW+CezsNR1X6h4M0lrLA9DsVcyRqJD0xbXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fvd4zirD8mj2o9nuRkNLYHJkOMIm+iNxZ2mHihoKsK5mX8INF7bR0Fe5/1MD3w4UoTSkjON4JFw3YwLXN9fC9H+xbyXVz4zoFQAEaZMRw03Ong4oYooBlxIUZdjF8/irdhPT890tXpJtMY9foBZ54MWaaaaCM0ZdDDestH9y3FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id D37EA160374;
	Tue, 31 Mar 2026 18:03:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 968C720015;
	Tue, 31 Mar 2026 18:02:59 +0000 (UTC)
Date: Tue, 31 Mar 2026 14:03:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org, Robin
 Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v15 1/5] ring-buffer: Flush and stop persistent ring
 buffer on panic
Message-ID: <20260331140357.43731429@gandalf.local.home>
In-Reply-To: <acwK-Xu-Mon2_6bT@arm.com>
References: <177494615421.71933.3679132057004156013.stgit@mhiramat.tok.corp.google.com>
	<177494616630.71933.2941681397188791689.stgit@mhiramat.tok.corp.google.com>
	<acwK-Xu-Mon2_6bT@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5gpg5dq1wziwms5kahogiegw19p3jr1f
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 968C720015
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+00qx5ZZTRLH6y/fEb9PB20zgKWv6BfZ8=
X-HE-Tag: 1774980179-110066
X-HE-Meta: U2FsdGVkX1+l6HXrKgbWJUZdv3pPnplpcCf8NkR89+/4q1pnapmY+m/tN5jVzwbQ/6B3FYfdUdA+104U46Gw0aqu5rIrDVl5xMhT5Ge+L4364inSPcleZ4qyX+1XvYnkDfQCImdD2BpMpF/bZ+NEiI46CWG58kCr/Fz6IuU5R/pmX2jbIuxa4geT/PzSrooGI+ILt2CF63xqzH76BMvEw5/CzYIzr11LRnQbNrEdYeg0a01vwJhpIpRYLqQ2lnoBc4lPZui9LaWrfti5XhYsaqBTPFBgsn3iinKnnExuHUbO8Mdefj7jc/U/pHNu1CUkEynLGCOPJpwhgfJANaWbI42VWShaSNbqinELCSVZ0sOOcw14DmS7ZDLQbXGLrJWn

On Tue, 31 Mar 2026 18:57:13 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> I assume the ring buffer here is cacheable memory, otherwise we'd also
> need a dmb(osh) as in arch_wb_cache_pmem(). If that's correct:

Yes, it's cacheable (I couldn't imagine the performance overhead if it
wasn't! ;-)

> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

-- Steve
