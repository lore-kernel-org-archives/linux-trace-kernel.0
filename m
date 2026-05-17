Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781C5307481;
	Sun, 17 May 2026 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779001755; cv=none; b=KbkarX+9Mpbyoi8RIaDmlBQ2dRiDBDL5TrNlr3fg730Tn8Dtg6iPZGbWruUERUKIAWUnEBiiNEXpgETbg5IEuMzVwevA4NvKo4cD8T6ImNbd2wPwXg0+dBlYSasRONXiURXamBNkQtuRzNdKpm81LBQgprRu6v2FNunmOIJVfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779001755; c=relaxed/simple;
	bh=7uzwglyWXzlOBwSwv4u+X+T6l/MZTfVHbMBY+L5MVdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgDDB/yuAvgyUEk4yzzsxcJcRGzzKQxLXzNYjUw7ubYKwEaFKgwJuraeYApMZYIBcfsNdFdJ/3AaAxnMZ1VQWm4QQXsYIOqLA0kJPnlgsvn0djk80aGmEgwrjE6KkyTpF+CT4VFYO/xTfpTkmn29WN1cc6JZmfbj5c1gIuRg8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2TjzgL3h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2TjzgL3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65A7C2BCB0;
	Sun, 17 May 2026 07:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779001755;
	bh=7uzwglyWXzlOBwSwv4u+X+T6l/MZTfVHbMBY+L5MVdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2TjzgL3hMcoXsfwaRrGeTYymKASCgfo5XoMdCBu40n1SX8+G6j8JUA+g/l6qibmRb
	 +Tm6iyylSBlgU/sgjppKwkxGCieJNZP0Fde0mmu+/ebXWr4Pq0H08LrEPcScrWZKTl
	 7mJ3qCl25Rlu+A6CL+4SEnIxRhpg4VJwpfQDEaCQ=
Date: Sun, 17 May 2026 09:08:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Afi0 <capyenglishlite@gmail.com>
Cc: security@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org
Subject: Re: Race condition in __modify_ftrace_direct() between tmp_ops
 registration and direct_functions hash update
Message-ID: <2026051708-exalted-pectin-1686@gregkh>
References: <CAEABq7fMcvHpp4+59Mt-QdgGNpWhOqrGWHKmy+qt3tJSYb69kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEABq7fMcvHpp4+59Mt-QdgGNpWhOqrGWHKmy+qt3tJSYb69kg@mail.gmail.com>

On Sun, May 17, 2026 at 06:24:11AM +0000, Afi0 wrote:
> Signed-off-by: Afi0 <capyenglishlite@gmail.com>

Again, just send a patch with your real name as the documentation asks
for.

thanks,

greg k-h
