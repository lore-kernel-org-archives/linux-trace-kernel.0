Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748EC360751;
	Wed,  1 Apr 2026 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056521; cv=none; b=r4IrGapC6uPw71DH/SU1/fNNBDY3eAqEZo6lmBOFHHN1jvbzTWLF6x+9yUFCsKN40b+0jEgLLlw2z2huphxpZWIvW9zDHA17bUNbbwFrlUyPavrXOhSSVsWvBy5iZSFifqkJy74CweDYSvahygS5SF9Ak/pZShC5ZVwfANeEMVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056521; c=relaxed/simple;
	bh=qri3T0bS5A0UHjEm2Rks1p3oramhXQ8dOvH+gmV+Px0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5Q1CuYrSMt1kY0a6WkEmBVyg8UbA6xdDbHuaKX1OmQEg+7gtjNC62MNtoPEf1cJj8ktI8TxFeRzZmJA4taTk81ujBxRFNkruFA/i9ufN1mkC/N/XZ9agV0kFAXsQMILB7/settymb7ZbanBhiFAWRMFiQUOWHwI+o8vavCMaMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id EE4F3160926;
	Wed,  1 Apr 2026 15:15:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id EBFB71E;
	Wed,  1 Apr 2026 15:15:12 +0000 (UTC)
Date: Wed, 1 Apr 2026 11:16:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix trace remotes read with an offline CPU
Message-ID: <20260401111613.5bb90ec9@gandalf.local.home>
In-Reply-To: <861pgy4t1i.wl-maz@kernel.org>
References: <20260401025003.3258729-1-vdonnefort@google.com>
	<20260401103159.747ae168@gandalf.local.home>
	<861pgy4t1i.wl-maz@kernel.org>
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
X-Rspamd-Queue-Id: EBFB71E
X-Stat-Signature: u7xa3mua5n8nf61sgq1t6y33zrqnfdxf
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/2ZP0Qk+5sLt8Ykei3HIL15nu/Ew9WCkQ=
X-HE-Tag: 1775056512-791772
X-HE-Meta: U2FsdGVkX1/pFobWu3Bxwz3vXr0Z07iAVZiDHfPJ6jt55Pc2IX2AFHmOp0jD+QxsV+DKDAhiTFAguSqNc4U4Y+vwIX7DkeWOEcoYh6cqbXyu42OFgTBqAQx0uIji44AVQ2GIyi6uaJk1Hoc3dzKiNJWQ8u+Ifv0uvK54wPMH3ebvKipxuMHmxJpXBTDdfeTq44sbRNP2beflx8Tk3D9t9OW+347paz/RY+VRt9w62pi9D85xGoHYFIM7OPkHYDntsb9802Xe6Cx881U7mFS2Alod1bf8jgkIz22RtCcfryzTSPaNTe3Hrs2qCxd/eT0q9eOmpNp4NAN7q2QzsYkqMdbObjwSw8OxP8MkUFsOQsKGRa9xhCBgZw==

On Wed, 01 Apr 2026 16:08:41 +0100
Marc Zyngier <maz@kernel.org> wrote:

> Do you want to look at v2 [1], which was sent two hours later?

Yeah I saw that right after I sent my ack.

Yep, my ack still stands, please add it to them.

Thanks,

-- Steve
