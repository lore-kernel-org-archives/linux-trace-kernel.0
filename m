Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097445A2B9;
	Tue, 21 Jul 2026 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667903; cv=none; b=gdZTWUNNyr8678kJcNWWEUX1BudRTGglVR5ZO1u155a6tL+FgdXKKfTgII+utq8h8EZ/e3llaI3ZxjNCaotUJxwkm/2ov+TFs32WCX6Gl5A7PFLtZ9IldkeJnm9oKPFyTFOyGdFOnsXYBGNNV0Px72o6xwq8rc1wBXog1v0awXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667903; c=relaxed/simple;
	bh=eyv1GNGK6dJw9+4Xxy1d8wcEydwBpBLqLIIlqvFp9d4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4hJBD5UDjBl/6i3cBqK496hXlv4oYAm60MHhFJPSIW5EPAtnUwu44MyYpmtdV98SdA8nRsPmPnQARi8JWk54E6y7vrQUPn3vLnNQS1nBvg+4DPx+i581mf2BouDA3RaFcfUvxCwxka7EkBIdvo7VmWnIkxVCnZIXBKEpLn7cE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 096D3A07EC;
	Tue, 21 Jul 2026 21:04:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 3441830;
	Tue, 21 Jul 2026 21:04:51 +0000 (UTC)
Date: Tue, 21 Jul 2026 17:05:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, leitao@debian.org
Subject: Re: [RFC] tracing: Try user copies with page faults disabled first
Message-ID: <20260721170509.3d372897@gandalf.local.home>
In-Reply-To: <20260717173758.3644427-1-usama.arif@linux.dev>
References: <20260715155454.4127988-1-usama.arif@linux.dev>
	<20260717173758.3644427-1-usama.arif@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8z5oetnzjb31arzwwt9bp9x739pzxr77
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 3441830
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18tXkh/O3XY5wVfw/kl39sKjqMnbr3hHT4=
X-HE-Tag: 1784667891-977218
X-HE-Meta: U2FsdGVkX19xWnICzRfCHUz3qZL7q7S0D/K2CCi8L19o4oJFO2ixvAJo4lq88uAKquE9t82YRc86omnFe+XK/xxCvnD3ucYM6IJL6a40DUjXUO39j5e9f/VGcLCrLoNJe5ZS0wv84bEugTJqpKlx/WmrIbD3keGz67v3cfYZqqsQlS6/vzdq87J8Vs3GHJ9eyE9u0CXZQANsbmfZnTBSy+UtJb9uL59SmeYJrqWUz1NL1LZxEz8vdHtmOO855f/+0moJRYLhfxHKQ4kSZcO5mbo1ka4dKXd+PBxDcMOUjhM22wOI4fixmI4g4PtFvNt9vrbsSqGr+DOnpIEzFblbI2wyWI7Ab4Ts8tbvrV66nRgX9U1emvpbSg==

On Fri, 17 Jul 2026 10:37:57 -0700
Usama Arif <usama.arif@linux.dev> wrote:

> I think the actual problem might be:
> https://lore.kernel.org/all/20260717173252.3431565-1-usama.arif@linux.dev/

Ah probably. Thanks for finding and fixing it. I'll add that one to my
queue and set this patch to "superseded".

-- Steve
