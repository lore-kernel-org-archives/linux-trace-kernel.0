Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05462BEFF5;
	Fri, 23 Jan 2026 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185614; cv=none; b=fKrUdQa+FGSA5cTqcXAgIFTq5Zk9IskMfVyCEU8LyfhNmac7oDYIaIQpS6WX8DPS7fAcWq4cp5ICDlpsHtFmPVfhysJ0e238t+Sk9A5MUp8WfJcIGi0RBrSzzNllp0ws5UbnCEdjaFqQJ6UJm7GEbWXots9m98N51XCdHQCV7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185614; c=relaxed/simple;
	bh=vKEHkpncetxR0bd+3WV+CMHCN1JOtGbjGNKg1WUuf2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EA6YOsfiWZuCE76i8136iquos71GA/71M00vR5XiwvTFTE4miF+JZG+W2cXWmKzpjK4LVOOrvAZVNNGGSrnTWyLBhx65s6vs4P4ch3ts05ryodsBOLhgfRinN+Ccv94G52YPnmx5x4qdm4BDSQ05B9o41NrKhoWsAzP4NrNvv3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id B6250B9097;
	Fri, 23 Jan 2026 16:26:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 1A89B2000E;
	Fri, 23 Jan 2026 16:26:41 +0000 (UTC)
Date: Fri, 23 Jan 2026 11:27:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Up the hist stacktrace size from 16 to 31
Message-ID: <20260123112710.7add47cb@gandalf.local.home>
In-Reply-To: <20260123105415.2be26bf4@gandalf.local.home>
References: <20260123105415.2be26bf4@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 1A89B2000E
X-Stat-Signature: z99tegmrzucgcnezi8w7kyew6kkz43db
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Dibyrk4T9fjkoQzuVNj3H4zoUcBSkFCo=
X-HE-Tag: 1769185601-269146
X-HE-Meta: U2FsdGVkX1/Ltr8PGQIThv/nbQak989s+xu4SvJAl2fGLlpEGu87tG+Hn3TiXKcGsdbOllCI+5sLqVjIqHgKJhadwVJzyh7PySGhccXX8K+kwDZFCm6m0pZyYnd5jBRcf/giMWxzXRvIIysa1G/y6coI4+9q8LTwU7jdpbOuw30g1bI+dUmlUvAcVwCeq32QCOkLQAEs5+fDQrxTMdrBVqLFp6q2tu2KYtCpRJcOt1EJFCk+WDGxnnTUolkQf8bQ1Ub7ZD0GBpHxPDxa2MLiYYrcj/yr2mPT8bwOkVVxcPeMoAOsGIUlGhiE7IopiH4JKSJL94TCzfjR2HD5TMfX3UNlZA1Rjcw7wEx1zUqSXc7SiaxS0g9bWmyQVU9jJs06QcIvhrOcqMFEpT0Oiidvdg==

On Fri, 23 Jan 2026 10:54:15 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Also change the BUILD_BUG_ON() to allow the size of the stacktrace storage
> to be equal to the max size. It already accounts for the empty slot via
> a "+ 1":

Correction. One slot is used to hold the number of elements in the stack.

-- Steve
