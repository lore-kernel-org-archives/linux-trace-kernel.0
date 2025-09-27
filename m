Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B6B1F541E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758963663; cv=none; b=LuyuTafxiYkwtGju7xupFW02iXlEJVJ+ab/lvWPLQXmd843BRQc4j8YyIsoQXockI2lNyyjJZPLaCgkSh+TnhBhuZqrMWBFe726D/aegvCmPlQ/Yx8e8pXJjaKH6EfIVZ1rWMlAaBf+VDlGefp7ziO5JitpIcPFJrIbWwObp/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758963663; c=relaxed/simple;
	bh=jaWx1TutNoeio+fxhKW1wAKRkijnfkd79A0kC7h0I8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qw8gue/Qydvo/CDyPxBjPCl6KYOJOiqL5MYtzle4otkyfEcZpMvE2mvc9JY4yuxQbn+iLJ7BHf+SLM1v7VXVF6O86pnXOk6qgc85APAxTBm7cbmq7mqqxMygOjSN1GNnqXUCDx2mjUoQG4r+c+k1yClCwXNYY6w9SllC7jQH0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id A070EBA7C8;
	Sat, 27 Sep 2025 08:44:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 6B6442E;
	Sat, 27 Sep 2025 08:44:56 +0000 (UTC)
Date: Sat, 27 Sep 2025 04:44:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>, linux-trace-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH v2 0/7] tools/rtla: Code consolidation and osnoise
 actions
Message-ID: <20250927044454.0525d39c@batman.local.home>
In-Reply-To: <CAP4=nvQR3YDNVhka9QCNQVB=QEytxLPdFrx_nNJbNm7-r9ujDg@mail.gmail.com>
References: <20250907022325.243930-1-crwood@redhat.com>
	<CAP4=nvQR3YDNVhka9QCNQVB=QEytxLPdFrx_nNJbNm7-r9ujDg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6B6442E
X-Stat-Signature: wy6cqmx1h9hnsj1kjjywampcmtfjnz9i
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/NYNQm4wNmxIEWFwl90Rv6ngP72wziCQk=
X-HE-Tag: 1758962696-617476
X-HE-Meta: U2FsdGVkX195S6ZJ9yROdoXOX+HcBB2015fk1ebLXPXZEp3lT0/zy+W41fHn5pIdXzYbg66RbTHQl8FPx2WxNGX+IteKGjlt3cN74Oiwt93MVvcVw37HOnJFDvWaVh/M1dzvecPjXxyEm7am8iBufbsLKNj792HevyOrO095rKGYCDnWfBbO0pSvqFysyrPKRlm+sjUdcxqWIb1ti5TLv4J9UjN2n5GZ08dpV0t5UizVDFJH52imgKMj3ZmV+XpGJb933wtB/8wQE/D4wzDqL5X5CzqvtCWLRMonfaDc3kKUWDW3avh1EVAV9v4PHrEMcbAca2JKujFqKUPRrTGEzrhBDI7KVq6F

On Fri, 26 Sep 2025 16:19:28 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> Can you take this patchset? (As a major change, this should go to
> linux-next first I guess, not sure if the timing is right for that, my
> knowledge on upstream kernel workflow is still a bit flaky).

Normally, new code now would be a bit late for the merge window, but
code in the tools directory isn't as strict. Thus, this is fine to push
for the next merge window. I'll pull it in and send it to linux-next.


> 
> I reviewed it already, but it seems that patchwork doesn't understand
> Reviewed-by on a cover letter (even though b4 understands it). I did
> Reviewed-by on the original patches where I didn't request any
> changes, but v2 did not preserve that, so I put it on the cover
> letter.

I'll add the Reviewed by manually if need be.

Thanks,

-- Steve
