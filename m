Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201CE327C08;
	Thu, 23 Jul 2026 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784848714; cv=none; b=seXdmnaXbRpc9xUpu3yiNfDH572WiE3F9xEU9+jnKbNuVSq9iNPfftI+Pk6Z2U7Bog2ihv6KjBQ7El24sgy6YjbovPQZZwmw0XYhZ/nAQdI1nziXC+XxNkqZ6GS+S8rNdvmbPc0VN+A17oDcBqRvrdi7xt1SN+yInVRE8egBh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784848714; c=relaxed/simple;
	bh=0OqNFBpx1sXpWAlXc38A230gOUkiTujT4KXhwcACZP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyQhP7VTqj9+ytqZda6y/TRmYcFEofHi3y7vCYGGUw6SoFRKRZHWtrM6iWv29ofKX8DMYT3WiVl4zcTA5FW08unFD8ilR6K+okIo8djm2N/dhb6uBs8NgAduFeaKQM+VBZWKsjIHC5yi3eAMgtcmWTDp3qWz8yqsnHLMMevkmm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 2AE64401D7;
	Thu, 23 Jul 2026 23:18:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 7267D2001C;
	Thu, 23 Jul 2026 23:18:23 +0000 (UTC)
Date: Thu, 23 Jul 2026 19:18:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: David Carlier <devnexen@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Restore synchronize_rcu() before freeing
 trigger private data
Message-ID: <20260723191846.16a9cec9@gandalf.local.home>
In-Reply-To: <20260724063315.b5ab5f8519c1555fa0d49756@kernel.org>
References: <20260723170212.55325-1-devnexen@gmail.com>
	<20260724063315.b5ab5f8519c1555fa0d49756@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: wkzyq53e5jurtoniuqojpscjo7sam337
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 7267D2001C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/a4tT0P1Y2Xb+7juL4QaP67QAdNUdvPPY=
X-HE-Tag: 1784848703-304799
X-HE-Meta: U2FsdGVkX1+mgCmRTrxdMZXa48Hxy4VD+XKE4iWW3Be485mhxk2ZAhCO7uMeBO6834WBuQWhQ8Z17SSrPh+Ns0Iyf+8MRPahEBGng0Y+RUgnBk81OTSjdC7w5KCNwlhG6GUSD+8+Wgk7AXoLhWLeOuIFq68UPn6c0n5Tyspk222Nf+J9cxCvb3LliqFFlpKK4pCnzU4A94kirxfOwSfPPv/DV1KO33zx37pxqN8wpZLh1btC5lASbvmX98s5qaBtZeu5NzIUAWSHcnGbGvFJxMisq7n+lKKOWyEgguexPTDXt2UMRLEpmxrQBBIVNjovuPKxRTZganvwwgmKoPOGBi9o5DoiLiuPGUn6dGxDCFSASw4nYr3C/A==

On Fri, 24 Jul 2026 06:33:15 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi David,
> 
> Instead of adding just a synchronize_rcu(), can you reconsider to introduce
> .private_data_free() to event_trigger_data? I hit the same issue on wprobe
> and fixed it with ".private_free()" (I think private_data_free() is better
> naming)

You mean like this?

  https://lore.kernel.org/all/20260723191534.67136-1-devnexen@gmail.com/

  ;-)

But yeah, David, can you send a v4 that renames private_free() to
private_data_free()?

Thanks,

-- Steve
