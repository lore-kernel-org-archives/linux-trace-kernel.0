Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662AC421896;
	Fri, 10 Jul 2026 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683980; cv=none; b=b3fv6YtxacJHMu18eVE08xMrU1LJwv9tBFTTLuMh+TsTRC/ehbJU3nlpkBO7v+xM7gaU7MNgLE+h23Klgnx4S/GE4mm9GABa7JWpNGcBamZMQYYzKnBAi+i/rAZ7i6apELoJ0gx7WJ+RfViKT7VjOKLsx0oYjIejl0P4JO1/SZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683980; c=relaxed/simple;
	bh=3WUqUT0Tc1HqFjFdKHjGyulKS00jSkZE2th5QVog6is=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8pwt/16joOVvGLsZ+w+1DAD9e1SHOO5wmYl+sL5jHp7jpdrQoAQt8TJ6jK3P36aYxZ5bDxV0sgoYLR/KbsaCfLB9Cunp+QWVhgXeig3Lh5Dtqp/nr3Wqa++kPDjo9Hw4LEYwdSn7UyOA6xM3EOgTXIHUNHeZDHUxNF6ktx6uy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id ACEEA1A041E;
	Fri, 10 Jul 2026 11:45:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id AE90D2002C;
	Fri, 10 Jul 2026 11:45:56 +0000 (UTC)
Date: Fri, 10 Jul 2026 07:46:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jeongho Choi <jh1012.choi@samsung.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ji2yoon.jo@samsung.com, minki.jang@samsung.com, hajun.sung@samsung.com
Subject: Re: [BUG] tracing: Too many tries to read user space
Message-ID: <20260710074605.33802554@gandalf.local.home>
In-Reply-To: <20260710122231.9bc9fae3dcfc72215f4a2dcd@kernel.org>
References: <CGME20260708123754epcas2p1f15cc305ddb09f97164491d750769ef7@epcas2p1.samsung.com>
	<20260708123753.GB1386@KORCO121415.samsungds.net>
	<20260710122231.9bc9fae3dcfc72215f4a2dcd@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: h1m6tcty99mtqieb7oxrw8dgjt5m6qis
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: AE90D2002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/OB/QiX/m42WFK/n0n22+BpqJpdRVs6Kc=
X-HE-Tag: 1783683956-974702
X-HE-Meta: U2FsdGVkX1/Ndmau3aHu9iJ0KLxTw1GH5ROgNr/uiJrum1XYFK01qF/IWi1Nl2+7qtQfe6PMuDmCEhPf2HIt4qN0VyeYk48Pud00P1WXOARYVXcWNXKdQQ9cL6ch12I4U1Q/B0zJ8fX3B2/njE7ZWe/PUQqXh2D/tyB0++3yMZWGZWk2eWkIuACTU8ECdMSHJ7O2EE1raWKSksQJN0GcM7Mjv8lorbuHbtXficvGa/igVDzISTD+KtkM4uLAfabRa2fH/M/7Dzk76gei1B6hP+yhMBOnRyL1at9EKwP4Syz5iMQVyUtPkd538P+glSMPpWCpkgt/4lOoJGt3H8JoFkkvhJY9XorwxbwI3Yg9+ufaLTBky8tebZuOPjcNGK0EzEQ47aOSoslzOg7iJBN1o8ctSMCr7N/u

On Fri, 10 Jul 2026 12:22:31 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> However, this seems a bit strange that we only checks the CPU-wide context
> switching in the loop. Instead, can we introduce a per-cpu sequence counter
> to per-cpu buffer, and check it? 

I originally tried this but found a situation that it fails:

  tbuf->sequence = 0;

	Task 1				Task 2
	------				------

   tbuf->sequence++;
   seq = tbuf->sequence; (seq = 1)

   preempt_enable();

   [schedule] ---------------------->

				  tbuf->sequence++;
				  seq = tbuf->sequence; (seq = 2);

				  preempt_enable();

				  copy_from_user(buffer);

	     <--------------------[schedule]

   copy_from_user(buffer);

   *** BUFFER NOW CORRUPTED ***

   [schedule] ---------------------->

				  preempt_disable();

				} while (tubf->sequence != seq); // tbuf->sequence == seq !!!!


This is why we use a CPU wide counter.

-- Steve
  

