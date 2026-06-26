Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182B7344D92;
	Fri, 26 Jun 2026 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469248; cv=none; b=nhGqa6bqlD6/19dqBigKCnJ4h5yyYeUPwP30INOJWyO18poiV3jg8XhK6Fk4R6UZ8z+KdUZvfyxWKCgyGA6HlJ4fG22Gojz5tkCr+krzOOXJM1UMM477IuSPawdb+ZAhmyq8fDRWTDx1aVBwOHmCoHLZvpP6B06yY20/os/c1wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469248; c=relaxed/simple;
	bh=H5Lbg8pFMaezW2osqiC01azN7ZXn2CKmjRG8QlwGERE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZqVF+l0VSSOEt9buXsCZToBvWe2OLFbWrN5ir0DhD32VvFMBeHW4k4bxLOX+h0gD2ac7GSz2/0X4NKGLDS4YZozTKNAK564ksOfpnw3am4x2x8w0thjrVufa0Cjukla3pAC8HGtio8Z5rj7OeLWVb3dy9uuayQ+n269N+U7VWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.98.2)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1wd3fo-00000000U9H-1S1w;
	Fri, 26 Jun 2026 12:20:36 +0200
Date: Fri, 26 Jun 2026 12:20:36 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: eprobe: read the complete FILTER_PTR_STRING
 pointer
Message-ID: <aj5SdK9gUIVoPmmE@akranes.kaiser.cx>
References: <20260615145500.2662456-1-martin@kaiser.cx>
 <20260616110910.e6420488b6a798d49951cde9@kernel.org>
 <ajJbkeK0zXb8MtcS@akranes.kaiser.cx>
 <20260618105227.c58c85e9cb19bce673d9a79b@kernel.org>
 <ajasLMUt_AMM3ztH@akranes.kaiser.cx>
 <20260622125815.7416792c020bd3d81c01e51b@kernel.org>
 <20260626055440.76c28d25@fedora>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626055440.76c28d25@fedora>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Thus wrote Steven Rostedt (rostedt@goodmis.org):

> On Mon, 22 Jun 2026 12:58:15 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > The problem is that the event does not provide the information that
> > the string is in user space or not. But actually, for syscall events
> > all data pointed by syscall parameter should be in the user space.

> I think we should make this work then:

>   echo 'e:open syscalls.sys_enter_openat file=+u0($filename):ustring' > dynamic_events

> That is, to have +u0() say "this is going to be dereferencing user space".

> I'll add Martin's patch and see if it makes the above work.

I've just tried your command with my patch. It works for me, filenames are
logged correctly.

Martin

> -- Steve
