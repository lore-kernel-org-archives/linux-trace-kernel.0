Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEB91E0E14;
	Thu, 17 Jul 2025 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784000; cv=none; b=o2whg827hQFaA9dSrLAZt8BQ3wFjFmumTCqDDTTqBQupWYyyGEV8HPgd/I7xW/pCm0qGhyiv5oMuGPUaXYVEL1XNwDzmjGkBDqQkvOyTyvS9cSSl0YyzK+75iEsGpS++Sc279qT2otWg2qTURucz/oRVO0Z+uuHTD5fYIY1FV10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784000; c=relaxed/simple;
	bh=sPo+4/oa3rLbdvV2gMkcoSm/rnFp+eN/PST5jTQkSAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ErINoOKnaY/MCIX+RQk3eA8TVEND/hjNDnmo70/qiX2bvlrjcSOGrYo8n1p80VDlQ6cviC/4t1GxVwj6pIfDoHCCNsnlHZotgXPR0EGcpAj6oddAzs+FvUaTHHvdZREveQH+jBP1W73l83yhcJizBNC9qMqaMJjzdzElJv8lgoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=bbzC7f1v; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="bbzC7f1v"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8E009403E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752783996; bh=NPJ9YsnfQ+n2xq93bf6JX1Wt0juDs+Pj9SJmf/npzvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bbzC7f1v/4hIP47S2JoNH8DQUC8HOefw4L3/Fob3rIpEWfb3HJtuZ3bjGVnoxAZJ2
	 pTaTd0PJMS/gd8iHFReip+zbn/FvGK5HFejEWPeMMQB/npj0WHDjtWt5IZsjWgF57Y
	 ZggbefkTUQfUJ2Nwx+TYfF1jyb852C5gegaoLQEqLfrPkwDcWleOCKCmwBdvOTeNky
	 BCVFQSSLycibdXO8SBol7542dN1pAwDEOqJ/kVQ4cjtffLbmLWHH1nhrzHnLvtMPWC
	 A1oNoZtfX0sV0ZnWPc1m+MquEwI8LK2holn/346qlKFdD0dMXQykK7IoVdCziz7/SV
	 Rboa580fNSUNw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8E009403E1;
	Thu, 17 Jul 2025 20:26:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Costa Shulyupin <costa.shul@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH] Documentation/rtla: Describe exit status
In-Reply-To: <20250608105531.758809-2-costa.shul@redhat.com>
References: <20250608105531.758809-2-costa.shul@redhat.com>
Date: Thu, 17 Jul 2025 14:26:35 -0600
Message-ID: <87bjpia7ic.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Costa Shulyupin <costa.shul@redhat.com> writes:

> Commit 18682166f61494072d58 ("rtla: Set distinctive exit value for failed
> tests") expands exit status making it useful.
>
> Add section 'EXIT STATUS' and required SPDX-License-Identifier
> to the documentation.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/tools/rtla/common_appendix.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)

So I have to apologize ... I just stumbled across your two docs patches
deep in an email folder; I had clearly let them fall through the cracks.
That said...

> diff --git a/Documentation/tools/rtla/common_appendix.rst b/Documentation/tools/rtla/common_appendix.rst
> index b5cf2dc223df..a6233ca8e6d6 100644
> --- a/Documentation/tools/rtla/common_appendix.rst
> +++ b/Documentation/tools/rtla/common_appendix.rst
> @@ -1,3 +1,13 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +EXIT STATUS
> +===========

There has to be a blank line after the SPDX line, or you get warnings
like this:

> Documentation/tools/rtla/common_appendix.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent. [docutils]

To atone for my dropping this, I went in and amended the patch with the
obvious - no need to resend.  In the future, though, please always build
the docs after making changes to be sure that all is well.

Thanks,

jon
