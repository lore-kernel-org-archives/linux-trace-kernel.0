Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8924499A4;
	Fri, 10 Jul 2026 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687059; cv=none; b=cLBO+j+VzpH/ESnK9fnvBMPFG+BAtDoBzNGp0TIcAe/AqYlh6sWLpws7WMd6OIfoy+aLWJHXGlpmUJVfF5g9ymOsC60z6RNFHZnX9R7N6KkyKg3wrUUx9PACtmLM6R+eqHxKrzL/46aT6nDfQ2KSelsLl0bwZ6Zm31dn413pw94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687059; c=relaxed/simple;
	bh=pRFMafwmY/qHVQd6H4XvdQR9GLKSILkO2XVvMJsAVio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7U3xSAhJb4lE8wCJE1896bNrhrd5ASyiWsG7EN7RfrEPO0GFDa/IfkEhBXcmGpG12SQz3QYcjhifyI6p1Zr7OOvyNg1EdrCPlzRs7sOP68H6oi6IhWge1tpDY7JRQ89HVZoQyXk8i1vmlFAsPyg83fk71EiZyxkJev7kqot4ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 6E0C0120449;
	Fri, 10 Jul 2026 12:37:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 56ACB2002B;
	Fri, 10 Jul 2026 12:37:28 +0000 (UTC)
Date: Fri, 10 Jul 2026 08:37:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/3] tracing/remotes: Fix leak in
 trace_remote_alloc_buffer() error path
Message-ID: <20260710083737.7a017771@gandalf.local.home>
In-Reply-To: <alDd8OrrcI8vcPDL@google.com>
References: <20260709160017.1729517-1-vdonnefort@google.com>
	<20260709160017.1729517-2-vdonnefort@google.com>
	<20260709191516.7a7ad6f6@gandalf.local.home>
	<alCmOw8l4e-DS44v@google.com>
	<alCm5fq3UC2JtzZV@google.com>
	<alDd8OrrcI8vcPDL@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 56ACB2002B
X-Stat-Signature: douxtrj3yyp1ushr4seyfsopyp4rqx3b
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Jt7icLNStswwg+Pwh3GIJNWJZOiejVeY=
X-HE-Tag: 1783687048-578449
X-HE-Meta: U2FsdGVkX18awOFMoFyZG4NS/15VejwLYmOKYA4maRXKZ6QYt2EjvmD3/1zvUE0FnWQzTNtgi/cq2OLTIsGBIkR+d3ToyFhGdyMhH1q29N9QuM7uWSNFtvHsdsSrru86WO6YIX+ExGU4n1YDfmeozSHtMdOvGbIJ2sid41OVZ8REdVbB1MgRUEhNiD24vJdcQfakkGEX66OBqJIQZZ/y65JA1wlCYuSmYYokRLnbPWL0av6bPz8gXNG31MhNXi433LQrJZl5DzyZDCO840LQ95VdzEBFf+G3rf6XDXACK7iA59hGLkLvWGtkAH1wP1q2HHxYO3Y3T+XmyM8eshdP5e3XfNSI7SHLlqtKFW5Zuw1E3mpROFzbfQ==

On Fri, 10 Jul 2026 12:56:32 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > Ha yes this other one is real too. However this is in arch/arm64/kvm/ so I'll
> > post it separately to kvmarm.  
> 
> Posted here: https://lore.kernel.org/all/20260710114819.2689386-3-vdonnefort@google.com/
> 
> Let me know if I should fold [1] into this series.

If they are separate, I'll pull this series in now and start testing it.

I just wanted to know if these would cause you to rethink this series.

-- Steve
