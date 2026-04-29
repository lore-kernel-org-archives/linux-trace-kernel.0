Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE02D6401;
	Wed, 29 Apr 2026 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777477843; cv=none; b=BqXy8qFK1iyu/oL+5lTsuola5EKfxf6gTPYRtab2xCYQzg6eaqtJeuCNUxDhZeSIu3XZi6YmFFvBRxm00Z5mti6MW7+bmo1mQVpjYMRKJCHrOfGk+vKyLtLnSRfu34MCPnFuMK5OdLBQLL0djN71Vdfy+3m+zreQ8nY9xiAcHZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777477843; c=relaxed/simple;
	bh=g8+8ihWtQK5zfYMQi5wlLTVqAKF0THNtFB/Mk/Y0kQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pF9e9N9myG8znHBTvRUTBRD3Rb1eRepobHJh5pN4u59NEgc4I2+Hx6W3KcYz3jAQjaq+Bvnt8gtH8Y9d6+U3Qih+Kg+IbRw7vQAM8XsnfuZTO26yttlnNAj++DqVeVDzHhe2nSWQI7HvfazQ+/Os5AoJTzHF4Yd+a3GoNkMUK5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 84BD8160247;
	Wed, 29 Apr 2026 15:50:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 8698A20010;
	Wed, 29 Apr 2026 15:50:38 +0000 (UTC)
Date: Wed, 29 Apr 2026 11:50:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v18 7/8] ring-buffer: Cleanup persistent ring buffer
 validation
Message-ID: <20260429115055.5382d7c2@gandalf.local.home>
In-Reply-To: <20260430002139.c3b0e4c92ae52aeeaf86e1bf@kernel.org>
References: <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
	<177701357903.2223789.1327164275262010250.stgit@mhiramat.tok.corp.google.com>
	<20260428162457.1ca8c4b6@gandalf.local.home>
	<20260430002139.c3b0e4c92ae52aeeaf86e1bf@kernel.org>
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
X-Rspamd-Queue-Id: 8698A20010
X-Stat-Signature: sqrnemtznnzr7j56kukz5uhwuwn85jcm
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19JJhd9jU6CcP4uqZdlABo4JmBtPjiC1l8=
X-HE-Tag: 1777477838-188142
X-HE-Meta: U2FsdGVkX18zimWYBuHxHvIEw6uRwdwrcz7J0yENChFgJ4XFT4TmvocOC2OcnSBx/1vztgK3qewSHr5b7ivIGfFzOqRaucCO4YxXKB0oXTsKN6CCISljeYYxD73IVV2F9gbzOfWn71hFJwsjwkZS590gVtiSd4u6eMVT13CKMd380U/UyAg1KDdfzeFw9SvsUwktu1UVce9BSXwzLcGeIbEmJtfiOZwbLD+gvkS50IKtGILnfAeBZbWFsaMEjfgwX1I79JfJDR8Z5SMVRGuOliqTqz5Cc1jHRCeFx6vMtWjdkjiZwCCW4eSoktzSJa5p8LHXz4jIhulS0KOV8ckqpqmPR1AkqxiB

On Thu, 30 Apr 2026 00:21:39 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Also, could you rebase on top of v7.1-rc1?  
> 
> Is it v7.1-rc1, not ring-buffer/for-next?

The ring-buffer/for-next has been merged with conflicts. I rather not add
more conflicts ;-)  v7.1-rc1 includes ring-buffer/for-next.

-- Steve
