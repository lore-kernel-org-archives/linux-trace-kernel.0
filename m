Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B170E3074B7;
	Fri, 31 Oct 2025 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913624; cv=none; b=X5Ff6pLjpsrtU5L5j3OBdMISt72F1ijL2EjX57BdezMzT974gNZOWzk1s4+fAIAK/n6xMKH6rCg2m7GqlOAFUUAq/w5phYZd5wKXCwO+B8wfmSFu33cy8B0+k47dy2uxxjeGXe76XhQZTEnGGlj7MZ2plYBuUrkLI5Ep+LwlFZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913624; c=relaxed/simple;
	bh=fVFMpcUYzC7lROgUiN+Kd68HAS4hARr415HOhh5fqQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSrpfCwVghp8Tz3987lE3xvm5K1RuMbWxK+Of/DIGuuT6wIVn6q6TY6hB77ITdRpWNxASz1iD5OLx+5EISgOi/V0YUeGtD87n7kStkmXXbQrn4K6nQVxNi+QisExirRxsTpzuQePAzhyZq9xQdZUBI9KcC031VDwqnYaz0z0/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 79DD588883;
	Fri, 31 Oct 2025 12:26:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id C6CAA20027;
	Fri, 31 Oct 2025 12:26:51 +0000 (UTC)
Date: Fri, 31 Oct 2025 08:27:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] tracing: Add an option to show symbols in
 _text+offset for function profiler
Message-ID: <20251031082736.1a2c4660@gandalf.local.home>
In-Reply-To: <20251031102947.c2cc7f437db1399c7ebc1863@kernel.org>
References: <176179500583.960652.5730113001091388258.stgit@devnote2>
	<20251030052548.31130e33@gandalf.local.home>
	<20251031102947.c2cc7f437db1399c7ebc1863@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6fwz4nd6whrukrcio93uzcdkn19sq1rq
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: C6CAA20027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/edgf66x+Btf8xQ8WQhG1sdAO8qOqjXWE=
X-HE-Tag: 1761913611-768975
X-HE-Meta: U2FsdGVkX1/19D0SJZyDdU2GtP2lleHfsL+rRxEhg3mLlEq1/IdF80+pSu4QrdnrNu8PcHrNQxBipxlWXo5JpBM3X1RoW+L6SYiea71TXX1/Iv8CwuUuEm2RBA9xwfWkmgtDzz4WTf1CBJkhI2HtYTGGnaBsM9nckl2Vhjl0cMqz6mTQ9rvMy4ZvW1cl/5c/1t9Fx0zwe0WicDHcQNJROZHxdCDvVFZmffskY85vScz0KFtiO04AHd/lmQSGoNdMhWIJooeJVRjFzTm4rK3pNRYb8xm0dF7A37F/O32p9HiO8NnrJj+tekopGUWiiA3mxGxlMTApX37TmzK9tzqQByis54X/XLf+

On Fri, 31 Oct 2025 10:29:47 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > +static inline int probe_print_ip_sym(struct trace_seq *s, unsigned long ip,
> > +				     int flags)
> > +{
> > +	retun seq_print_ip_sym(s, field->ip, flags | TRACE_ITER_SYM_OFFSET);
> > +}
> > 
> > And use that instead.  
> 
> Shouldn't we make it trace-wide function ? 

Sure.

-- Steve
