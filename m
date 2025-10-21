Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03A15D1;
	Tue, 21 Oct 2025 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066137; cv=none; b=P45Kc2BY4XI6Q7xwXCfHzkX98PNHQPILjR55EhmyO4drVMheOGWt0krnWKPiC7x/hA0Gu4GSfzSQWurdR3BOn/fL4yDmKGEXejFaZHm5nnELx3AOWhVtzSr+gNQjluirKns3PoLXOS0IwLGlpbkuBxOPq1GHHbm0+/Vj+TlnZBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066137; c=relaxed/simple;
	bh=KZq62huST1C1LOMNc9ke5GpImEBxzStX4a672owPssY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmKp2T3/T03vX5MvpUGmVOLlfuqmFJj9BP5gAwPcct1aQjTD2fttWXZ+RpmUs8hu+XiPW0et6O9Miba7xhdOccqm/RMG4BmVUVtSMOuW0+MuhXbWWyU7vS00xzlY/aZiXMMpK++NFvm74TTmJio3v5gA/h644zrrxDedwSAnBjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 879D111A93A;
	Tue, 21 Oct 2025 17:02:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 5B4AC20023;
	Tue, 21 Oct 2025 17:02:10 +0000 (UTC)
Date: Tue, 21 Oct 2025 13:02:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Crystal Wood <crwood@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur
 <jkacur@redhat.com>, Luis Goncalves	 <lgoncalv@redhat.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Wander Lairson Costa <wander@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
Message-ID: <20251021130232.2ca75863@gandalf.local.home>
In-Reply-To: <aa0bbfeec78bc90966e660af91eb39acccb77d73.camel@redhat.com>
References: <20251017144650.663238-1-tglozar@redhat.com>
	<20251017144650.663238-4-tglozar@redhat.com>
	<c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
	<CAP4=nvT8VGpYrqQDztmB1WJPEb6JXvUuL201ksWq6eSV7kn-oA@mail.gmail.com>
	<aa0bbfeec78bc90966e660af91eb39acccb77d73.camel@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5B4AC20023
X-Stat-Signature: duma3o7b1mwz8tsmhakoe188h5je1qgx
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Wx+hdjaU3Mf/09d4jAkqKraymKj658mQ=
X-HE-Tag: 1761066130-190712
X-HE-Meta: U2FsdGVkX1+10I92SV9iwd+/rtQagPAL8prZGBKFCrcQl/B9PZ3coPwgdbmhxR9FTY7VmYGbwt9nNvx+4KM5BAblX0asaKfUwzM7Td6rGj0dqqYoY/BUumMMefRKK2aFU8m9aXV7rq7kOb9mpkZCArCa/UpyQPu+/2xET/AaThCG9f8xQQbQ7ezhVsI1IsOTgRbX+m/2kSajqTBKx8QWNRS4YFxjBGgdaEKTgPucbU1wBZ4AjzLvdczlWQbglwxGSucUBvnjwAJqzd71k/y/kxF1ZTI73rD24/euo3EsQL6XDDYOIf74aESjVmn2uRl+QeE8lDm7+sVjUpf6/08dQUkcpXL2ja9R

On Tue, 21 Oct 2025 10:58:06 -0500
Crystal Wood <crwood@redhat.com> wrote:

> Huh, so I guess BPF is an exception to the "no generic printk to the
> global trace instance except for debugging that generates a big boot
> splat" rule?

bpf_printk() is an event and not the generic trace_printk() that would
cause that splat. You can turn it off.

> 
> Speaking of which, why doesn't trace_osnoise.c call
> trace_array_init_printk() given that it uses trace_array_printk_buf()?

Note, trace_array_printk() (which trace_array_init_printk()) only works for
instances and does not print into the top level trace buffer.

-- Steve
