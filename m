Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73EB42F6FD
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661990; cv=none; b=oWu+J9ptV7OTbagN8gNyKPtfVH92RMvu/cgbJbJh0STHMqXsKoNnv0QuZhw0FGh/lMzPioZwaKpPj5Wj4ihrqVCWyUsDAQdNdUDnNoQcx3TCY2sBhHbzLZn74LaiLI4j1QGlYz7TBEMT7LGFSLsTsnx7jo8U88zszKJjVYYY5YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661990; c=relaxed/simple;
	bh=BqU1Ic8cU+MMHqRhWcAr3Ecs9EXpAwYgwQ75xSyoKLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEm1E9XuuAGzLZ+istN/u6rJw9cW0BIis3cm9XrTcpPHxajaVijR96/6TrwmZyp/zlHc1ujju+GgzZ/j6Su6fSr5ayMUGZnZcz7HPdosUHJW5pbuocd+RPthGiEVQOxyrQBKAsVXYj4Z+P04ZS9cSUoeIilj1Q87xFXWSjK+GzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=PPYMTydy; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="PPYMTydy"
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 9FCCC12040D;
	Tue, 25 Aug 2026 12:46:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id DFAB420025;
	Tue, 25 Aug 2026 12:46:24 +0000 (UTC)
Date: Tue, 25 Aug 2026 08:47:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <20260825084707.4c9cf9f5@gandalf.local.home>
In-Reply-To: <ao1Rn8ZKr5XafWRZ@google.com>
References: <20260817134750.3909384-1-vdonnefort@google.com>
	<20260817134750.3909384-2-vdonnefort@google.com>
	<20260817140812.2C7D41F00A3A@smtp.kernel.org>
	<20260822110424.346fa3c8@fedora>
	<aotTYT0zE5LNik06@google.com>
	<20260824105315.27377f30@gandalf.local.home>
	<ao1Rn8ZKr5XafWRZ@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tqoiiqzkq57g9q96amgizdiozbddfdfq
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: DFAB420025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Ql7psSTdepk06JSsePqqNUH9uIJPpFGk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=FuRnyYFQfobBVMPjG0Jfb3M3jATtZ0n/bAFTPvENTr4=; b=PPYMTydyfIlpOxPXGBRhf4dG4qxe0pOALk/F0jEezGkLvFadJvQdh0cllfIFRGr04vOZeuuAQYJVHbCQGPLrZahf/5dGiNBjd5UJdDijJNApoYw3pdLo8fcfa1nQAiGd+k6X/nd+3mQRTMNfqc58/ZWtz3N8uk81VMqvoJRGNVs=
X-HE-Tag: 1787661984-183421
X-HE-Meta: U2FsdGVkX1+cSHp7UwrORmGxh4sNFe0SVgWCOUKLTMudVrkZyuYNr+xvlPO9WfwGZewHVqCaLrgM0tTQdIIPvnhQDpbFzZHms0nXJYh4P63YsEcfM5OjFnwYkmRIA6TBJA/lxBABiHC96elq7DHsgHo2DG9uuhabJY+ojryuR4n1ePdh6yu1C7/fO6zHq7I0EKszwe6JHysfQHBKOyQAxsyalUbm0RCdi5JfaMlgggizjsAGrUTpIxWpVcbCmvZKAdG4LoAUTsJ9sgM80GWNxgf349empcjNtholty7oIZJsCpGBiuwaBBxIrNxQC2zRLc9145FV6wjKVtYgOis2A87VdTqKStcZ+H1jMzljcRW7JqUR+9pIbA==

On Tue, 25 Aug 2026 09:26:07 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> 
> Do you think it is still worth to reduce the window of discrepency between
> buffer->subbuf_order and buffer_page->order?

Can you elaborate more on what you mean?

-- Steve
