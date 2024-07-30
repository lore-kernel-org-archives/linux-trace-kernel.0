Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A681A6169
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357491; cv=none; b=RQCEAba2EFIvu3GdBtSMI1g6S2HcnE34hP8jNyEQXLYyXuujvmxGjl+Xh7iRyZHq0tLRzgttX7OGAhsY27TgacR3CCComujSpuyZF6cHAnHkukqypur/Crr0uUVHTw+yrAAgFmOs3LZZQwbfyrwOBmppmT52VsPSSxWkVDnzm78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357491; c=relaxed/simple;
	bh=FG/9u8rky7/xeVG4CYpBmZ8wmRuVLDjAV9kL7W4NCEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xwsnqi5WeZWfEknHCGmMJCyLNE0CbNIdm6/MWuVEd2GNsWnWpaNSfwEfVRVe0fVWE7n2VrPDv/oU2OHcQFeaOFHxkQsW5VTxsCvRshgGxHzx8Xn01TNjvBkhgMVAfp+U6NoTu/C7UE/aU4PACjZeulH4isNdy2Z/CJ0kmUdv19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=IdJDp7xm; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="IdJDp7xm"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E620ADACB4;
	Tue, 30 Jul 2024 18:38:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1722357486; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mpKvc1ugYuHtHCUgQp2676XbBIBv87Jkojq2xxe/WFg=;
	b=IdJDp7xmTOXuB3XS1WTLR3BBC9xKqJkMvsNuCzmheFAYVa7h8nedJ4a8iSeyFFsZy4SG8G
	f9v027aJ8xJe88SQHRdO1sKAINiue85Je93EnVMRTvnc/PifnnkgIrHrYKHx6p7OVBx6sW
	qWRuJeg9A1Nqi7oALDhUUQ4zaz0rszURxwKa2/9gzpXerhKzjsggQTl2gMUVR8Gu26xIFT
	c3lh8Q1jcKk/SO9w+8COEEG6WA3GEpH6fVA/Yh1DrOIePQ51bjVTncnFoZTnnJ1lHpWnoQ
	INcSwHTziU+YHMj7QCSxm3qwytq21YwRVYvK5ZpcklsLvZ9i71ltInyr1M5CxA==
Date: Tue, 30 Jul 2024 18:38:04 +0200
From: Daniel Wagner <wagi@monom.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] trace-cmd: Add meson build targets to Makefile
Message-ID: <iod3kgxb42n4z2kujsin6d6fgkkjoupsbli2z6p6zxc6q53q24@qcfo4yfl2gnm>
References: <20240724144247.783134b5@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724144247.783134b5@gandalf.local.home>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Jul 24, 2024 at 02:42:47PM GMT, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Add make targets for building with meson:
> 
>   make meson
>   make meson_install
>   make meson_docs
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
