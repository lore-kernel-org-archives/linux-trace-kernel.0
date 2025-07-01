Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76921279785;
	Tue,  1 Jul 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383031; cv=none; b=XgRnDv5KT/DcbUzqE2He4WGEodoKeNyWO2cWmqDwsds/wPY6ovQlI1IVcK2WJfaC4O8nkGSOaTgS0KHaPHnqG6QGdXdeEtHwQ4gG54ksUTx9oT5KtCN1xhidAJfkCiBBQiDO0OOT1fF6J+wKXIEM5wd+pPdeue0QI0R389gBIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383031; c=relaxed/simple;
	bh=T6CC/bF+0UrpLoMFgTTdtIesr+jqgX9wVhcRDJoCjvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmYWTNVmyv6Dx0mLa30Quj1M4nJzIueUAZBxUNacdbxY8+8nC0LQGGrFaOz0u1OG04oJKY3uf/mGo4igqmseTpkzk0aV59hNx3QtOLAwrg3Lnr+GUhqRI/xK8GuwoGB3mmPeczHP2f6Chf3jIW8Aa2GM5zmAj5BElRIsq3Plw7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id E27C1B9A48;
	Tue,  1 Jul 2025 15:17:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 0BC7A20025;
	Tue,  1 Jul 2025 15:17:04 +0000 (UTC)
Date: Tue, 1 Jul 2025 11:17:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Subject: Re: [PATCH v10 17/19] rv: Add rtapp_sleep monitor
Message-ID: <20250701111704.00456667@batman.local.home>
In-Reply-To: <20250701151114.OJQTlRCY@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
	<d3cf55d3bf42a0f70a58c394b5cf6d603ca8a9f7.1749547399.git.namcao@linutronix.de>
	<20250630203401.1a11e58f@gandalf.local.home>
	<20250701051757.mBjQVdoo@linutronix.de>
	<20250701110218.5e742850@batman.local.home>
	<20250701110551.5c2dc2ee@batman.local.home>
	<20250701151114.OJQTlRCY@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 57fic98dhtr6rjtionmrhfukq7h6eqxg
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 0BC7A20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18MooYQoY8XdA99/UI9cZS8fiRimYxM4Kc=
X-HE-Tag: 1751383024-59033
X-HE-Meta: U2FsdGVkX1+i5PyWbO9ijWx6noMaTZwjyENR2apD4ZGj5GOCGIHrEQr+ouj2sjcye+NurUsT4ntGJW4Gwlwn2gHXKFco7OnEG+qWndwOmoQ9Yih5xFO2t4xT7BF2c0j9wNkx5f2jyLF2OMhk+KEZe9F9Sp5b8hfen/nK/ljCBqFhH2xxdAFdCIhFv3FrB3W02ZHSDGmQl4zcP2FobqayM/ePWKHmtcoNhhP70kEdNTmdIfCHxjsxdlxkCWNdT8CXBI3lBtDuohboqHJ4lWIRTZ9l5m9C+V4Qri3dRp8ef0SVo60pgC91HS42rxAJnXQO

On Tue, 1 Jul 2025 17:11:14 +0200
Nam Cao <namcao@linutronix.de> wrote:

> > There's nothing in the code that even states that this was generated
> > (if they were).  
> 
> Yeah this entire file is generated from the LTL specification. I will add a
> comment.

Yeah, generated code needs a big comment at the top of the file on what
generated it. Bonus points if it shows how it was generated so that
people will know how to regenerate it.

-- Steve
