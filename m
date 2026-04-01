Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141E33612F8;
	Wed,  1 Apr 2026 22:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775083744; cv=none; b=cqZFQBULHw+o5gil7/EAJhm311i72ep3q1gslqdeJFMicTmBH0geCGSjJNMb6snmowL/NL9QhhnTfcXnelWjHS/YEct4i79AGm79k+Gt7wWHXKPMdFKWR4N3S3yGCvKcxgYPJl484hv+1a4gEviLYmRyBko5oNIUDfmuWMXtKGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775083744; c=relaxed/simple;
	bh=ieTVD85BIvdtErYKdNexK+N6jMQxiTCPDoGtB4B+0vc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZBs+nFltrgdkW3TMmUqy2ev7EbDF+gEKpI0DkLzrklTB3qNLe3/W+PQYuktcBbbcOkx21KVWL+SzG12VEPPNPu3wVFYVv6UrrFDjJBod1WGGY0VVOFQ+QIpk+t+34TbqK61ofDyPWDuw/F8XqU5K0Uzj8tV/69pJPDmomFq81M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id E9B8E1B70D0;
	Wed,  1 Apr 2026 22:48:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id E013220033;
	Wed,  1 Apr 2026 22:48:55 +0000 (UTC)
Date: Wed, 1 Apr 2026 18:49:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v15 5/5] ring-buffer: Show commit numbers in buffer_meta
 file
Message-ID: <20260401184956.05779460@gandalf.local.home>
In-Reply-To: <177494619878.71933.15471023049227398684.stgit@mhiramat.tok.corp.google.com>
References: <177494615421.71933.3679132057004156013.stgit@mhiramat.tok.corp.google.com>
	<177494619878.71933.15471023049227398684.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: E013220033
X-Stat-Signature: 7ydm64zs6q36ih5bj874tya8q5qabn4d
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18xLFCJtgW/6rywKwhgmPKhOSFSTeWl0O4=
X-HE-Tag: 1775083735-804413
X-HE-Meta: U2FsdGVkX1+j77FDIruY/liap/2/xGIhwkL3Xxjf2K2oz+mQkua4FjGbaV6N59lcO4fkGZu4yb2B+rW0QG3TniRRWNscjngWlKXzNwGu7AZQasRaMeJwuatEZQUf9VufPAP6B5shQvs9SOnOHKP0RkvMJaGQnqBpwt5qxfERNQ2bSgS7kW132DMucNe98hx4ZUjCbWiS2uIUwpZ8CF0GbxuEPOYBynsQsHsN15cQLww32+s0Qi4k6RL/v8vTz542sR8FL01us0QiPk98+Y4tugWRhMPffTcR4oxdHwwODL3slPH2dzpgjkuy8bBwiHT4rs+4nUDRzRODd5cQBHfPYIuglP3kzbFO

On Tue, 31 Mar 2026 17:36:38 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> In addition to the index number, show the commit numbers of
> each data page in per_cpu buffer_meta file.

                 in the per_cpu buffer_meta file.

-- Steve

> This is useful for understanding the current status of the
> persistent ring buffer. (Note that this file is shown
> only for persistent ring buffer and its backup instance)
> 
