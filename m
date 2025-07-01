Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31350269CE5;
	Tue,  1 Jul 2025 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751406261; cv=none; b=qrNW0oQYqzoagHKBXmVyc9l4TZIxEWSlfMrqdbXRmRWw6ALvn0MqsDiRH9MshC5tTBjGwuOFmkGYrltV33QnUm5uNoR/KB8ZX9gO2CpL6s0fr/7YELjwfAT8s8kM7SNwQcckxLU/9IUjryud+J/3X5ExwLhcFzChYVeLWm5anzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751406261; c=relaxed/simple;
	bh=W7LKnr9BTr9RvR0PXGa2e5Z9V07E0/U6hof+n1GzTYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCmHRTkQ/8q5RUd9HUvlM5n94++0BIMO+P9h2+ieaCCgOJMffwSm9b1W4iwxk6pXNz6xRykby4KmJJ22j6DJE9CuF3Lz35A4J/47SLtBgbFlF6xSIgw30EBoH9YshwrmSNNRCd/Df8fGhPaVk20PbBsywPX0SDOtDtlSljET7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id BD86A80604;
	Tue,  1 Jul 2025 21:44:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id DE49520028;
	Tue,  1 Jul 2025 21:44:15 +0000 (UTC)
Date: Tue, 1 Jul 2025 17:44:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Tomas Glozar
 <tglozar@redhat.com>
Subject: Re: [PATCH] Documentation/rtla: Describe exit status
Message-ID: <20250701174415.69edef99@batman.local.home>
In-Reply-To: <20250608105531.758809-2-costa.shul@redhat.com>
References: <20250608105531.758809-2-costa.shul@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DE49520028
X-Rspamd-Server: rspamout02
X-Stat-Signature: fdxczjk7h9c8sjqqprppu773cntqnpyg
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/NxjR0UBRqlUphGddBto35IVNMCDqQDWw=
X-HE-Tag: 1751406255-218448
X-HE-Meta: U2FsdGVkX18oZXzUiLKUg2KU09oG603+uqoplxvOIspfh0sm2x7/LfPxDwr/xsuICCNHX2jSC9+aHLZAfv3uUTN7gziMXo45ijv8OSzpCCpZBiaFDKNtaaBB6BvrcvdVivvB3ZnzLcpZDcmCyN/7x7YjDkgM4H5WWpedQrNoO1pVctZm/aDew5/16+PCreNNSPFLjjHv1mN9Y14ELe2atr8gLTamPt8D6KsJDDGJzSzU8of3Kq/47KJlQ00aqt1XoVpFb189IlJYs4XJVg6pI9siCCG9f+F591BcJQgWy2CeLNRYSzlC5qej0oL8dMrn4GB/7d9/fQ2FklWRUyhCnV9OlAIJm9pLFYDJ9kl8ubKZi+CNun8Kyv1G1YEx949f9PA4BYHI9ooI3OU8cdX6GpEfeDQT2G9hFasxS6lfhPM=

On Sun,  8 Jun 2025 13:55:30 +0300
Costa Shulyupin <costa.shul@redhat.com> wrote:

> Commit 18682166f61494072d58 ("rtla: Set distinctive exit value for failed
> tests") expands exit status making it useful.
> 
> Add section 'EXIT STATUS' and required SPDX-License-Identifier
> to the documentation.
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  Documentation/tools/rtla/common_appendix.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/tools/rtla/common_appendix.rst b/Documentation/tools/rtla/common_appendix.rst
> index b5cf2dc223df..a6233ca8e6d6 100644
> --- a/Documentation/tools/rtla/common_appendix.rst
> +++ b/Documentation/tools/rtla/common_appendix.rst
> @@ -1,3 +1,13 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +EXIT STATUS
> +===========
> +
> +::
> +
> + 0  Passed: the test did not hit the stop tracing condition
> + 1  Error: invalid argument
> + 2  Failed: the test hit the stop tracing condition
> +
>  REPORTING BUGS
>  ==============
>  Report bugs to <linux-kernel@vger.kernel.org>

