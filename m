Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C627FB30;
	Tue, 22 Jul 2025 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224064; cv=none; b=ohiMu9kuBwyRuxVZ/teYIoVAv11BKaPH4qGwfhGpKQapV9xvs1XKhz8OcKXW2pH0ueyESIpcqVZUdu0oHvGRVM4qxQcghO9uLi1Vw1vOwd8D1LwA+HYXY4CrTVDUO5jU4op8SW732vtxZa4pvvR1QSYYSoj3AAkC+OfHR7hGgCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224064; c=relaxed/simple;
	bh=Kl0KaWnOkDC2kpqnsSiUcTzjOm/zArpv4TYVzuI4zkU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3wxNjdElyuFrmRFUbtMpy33ZurtjBL0UKTdNg5g7YXwIXSQ25Jb1oJBfXp8dhO/WDhfleP/6qRQbu3b+WEWmxphv0GGDiGIUn0Ed73KINsMoDznYEosOcEy++gz63CxRJvAMhQmwOTWQQ0BRDE/RX6iviaw6hxZ5qoJJfd/wHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 40B4C1A0509;
	Tue, 22 Jul 2025 22:41:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 9432F2002E;
	Tue, 22 Jul 2025 22:40:59 +0000 (UTC)
Date: Tue, 22 Jul 2025 18:40:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] tracing: fprobe-event: Allocate string buffers
 from heap
Message-ID: <20250722184058.2f4e575d@gandalf.local.home>
In-Reply-To: <175322171522.44400.1130912986696109830.stgit@devnote2>
References: <175322168606.44400.9155291012158349647.stgit@devnote2>
	<175322171522.44400.1130912986696109830.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9432F2002E
X-Stat-Signature: wx8yh7z3ayur7m1moknhotoffx5xenip
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18JdkWLVOK+2yoQuTsG9sZv0qd2q3R9nzM=
X-HE-Tag: 1753224059-936280
X-HE-Meta: U2FsdGVkX1/ucKUXeUv1exd7+cNJ9lC59gTb0E6kJjV9HHlxc/fAv4LZ0vgihrOCiVCG2wzO1aTzsltJDqOCHil6OTEh4INfzQgFebixmrvqiGv+u16VU6XIXBCGZUn+L45U5RPBMons5PWOjJpVGOl+bG3VMpaoeFcDqhSBqp1qp4XFiEoYG6NzOVZic7HnhBiaNuoQm0ZmhTh7SbdBip5xdaZ01G/NuZSQQzlb3k5xZU1O4X6fpKq6tcaKqfDtZLGkkEfhHr2KqEsOi7lfJ74jLQZASTOcq70aJpX7Xj2hnQoFmwPimiWWnWcI7gkzyBtgWry/7/nVt0K4ZyIhbJ8BZksdT4gIP1B1JHpj2GA53hviyb10GEHv4fTneuaGn+bWVM6VFrnncqDRA0VY0dNzF+Vt9rUV0/14KhRzsHE=

On Wed, 23 Jul 2025 07:01:55 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Allocate temporary string buffers for fprobe-event from heap
> instead of stack. This fixes the stack frame exceed limit error.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506240416.nZIhDXoO-lkp@intel.com/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
