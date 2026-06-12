Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A866C3859F4;
	Fri, 12 Jun 2026 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282201; cv=none; b=WvG8XduUsqpuc09z42YSeE5YOyZwdQHcTm+Ph6wBVB96pujAzRvrS4vX5s3UKd0PUabuotCfi4hxjFuKzZXy7BEx9I8HnWJP18IzfvH4JiZ90fKGO8HSQsHvr7k46H6MizC7FqFd/KgkkxY2EfzCiIPaMqToRFe1WeuRSUxc5FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282201; c=relaxed/simple;
	bh=nVYgp6NJtU9LlCnfvt6zqqO6+y5aMzqeURwph/cnq6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3z6mjgAP/Vw3J73rk5lbV/GkbA/sNSLi78sSNkNjR8TtsOMOrRfI6NL/ZrCOAEWjdlRil5WjKXgA3etVtfNPGe3/qX1O486CvXr/GY1/e/u8YYzjeFzJyVBc8K3x7JPwxnPc4qHvR1LCZo0TFo+jZUJrCWc9jErLnc77lfgBCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id BC2301A01A4;
	Fri, 12 Jun 2026 16:36:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id C3A0680013;
	Fri, 12 Jun 2026 16:36:33 +0000 (UTC)
Date: Fri, 12 Jun 2026 12:36:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Markus Schneider-Pargmann" <msp@baylibre.com>
Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "David Laight"
 <david.laight.linux@gmail.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: fprobe: Remove __packed from generic
 __fprobe_header
Message-ID: <20260612123632.6f50ba8a@robin>
In-Reply-To: <DJ7328G40P9R.YB03MWLT8GQF@baylibre.com>
References: <20260428-topic-fprobe-packed-v7-1-v1-1-9abc9b866b4c@baylibre.com>
	<20260610171740.c30c43c5faee0beac3ad7546@kernel.org>
	<20260610120659.7c61cfa6@pumpkin>
	<20260610155139.01b6def4@gandalf.local.home>
	<0ea2ae74-7452-4ba5-9549-59197c766c25@efficios.com>
	<DJ7328G40P9R.YB03MWLT8GQF@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C3A0680013
X-Rspamd-Server: rspamout01
X-Stat-Signature: 8tbma8f147goxg389k3q4qr7cxzkcxru
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+DcCYBr2ws4DUXNFdhu9oQwdLvkM1mQTE=
X-HE-Tag: 1781282193-19551
X-HE-Meta: U2FsdGVkX1+4vIAfMNjgEEOG3iKRC2Eb+0tHrr1J22G6y9tdflcgx+xIsUuEBIUH0UcxO9lYIkA/SCAjuJfP3nfEFCDRdivizqiBq5C1dIFwZw8io4xwZJOSb+Y9LSso0RJJEYnM4PVTZegmjnCPePQswXducMuCuwN8NJidlXXoGqNTx1loPDlxqD0wQeivbmnR7gt8NYKziHhGf1baiQur50JDx17dB/gXlkIM9Pbksfp+8gw4xyKwkLSzRUVObpKZKZ/rR1jqBjor2YmUtqEyAOY1np/KWlMreguLZjtyzWZR7IjX20lpNoDTb6RnaGA9feEdoHS232WLxKgEjkZQjbYpeK98xY033jUjMaIlMCuKUmLZG7gYDBDa8uDz

On Fri, 12 Jun 2026 14:51:58 +0200
"Markus Schneider-Pargmann" <msp@baylibre.com> wrote:

>   fgraph_data = fgraph_reserve_data(gops->idx, reserved_words * sizeof(long));
> 
> fgraph_reserve_data() returns a pointer into an unsigned long array
> ret_stack. ret_stack is allocated with

Correct. It is in fact a requirement that fgraph_reserve_data() returns
a long aligned pointer.

-- Steve
