Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4E2383;
	Wed,  4 Dec 2024 04:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287428; cv=none; b=ugymIIuDhLM7daga6O2x5+kMBfcKJgOAyu9vkedjXTwylrh8j4qrvANxCZXSIeM0jWfz4lo/nR4Csm2sO9e6JaHYsp5nmQByH/pSdCfdx0zFAMeXpBwtDWx8CiyKOtYKh4ibBEjBIYjhtkJaxtDnRvhUEx0C4WCvN0h/QyTNNdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287428; c=relaxed/simple;
	bh=VikVBngIR2iw2QV+AjlPwfnxaCoCRbCvepiSjxjLVts=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KPFtoeS7+QeVUflJB585z0Vz8S9Lo8TOseL+BBzAn7oCodTPitc0712sL4yP1zZyOjxWzv4GWZQBszksdYNlcPVIs3Au092TpjAFnh/cY0VgiCY6KKfcxTbQ/3JVg2JDizoMectGFD39Gj6U4BWSXyOolrVThze3woVfYUwdWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tMaF4MOW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tMaF4MOW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=DvN7pa0xfMr6rM7m9u5XBR7o4RI9Mngw7jOzpcjkALA=; b=tMaF4MOWa0a335Z1c/PBgCmNBP
	LdTYhxMnCfqEU7cQ1yoTBs+qHsnPM876/8e3EuMYgQ6VliVfJAOShaaU2RU32a4U90sESoVipDtsK
	IVVHb/t9qNn+ujj10nw38radHrnYaDwoFExzChSIKHW7vGr1sgbvdzBLa8d78CjL/9st2QNWjALAF
	1ByYwM51LenNXdXDCw6eAQxADIriPMvn4yUoEtZPRmv4/Bzw3ImNp4aPYpCeNVldLoKWfFYb0ipwQ
	fh/cQMtFnOyHWpYlahg7fet5oXdhApnVyuqReqTzyxnfngWgfJD7cve5z4wM5uGPBANPjS4ssqyqb
	uVJ62eIw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tIhEk-00000004e1K-19RJ;
	Wed, 04 Dec 2024 04:43:42 +0000
Date: Wed, 4 Dec 2024 04:43:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
	linux-kernel@vger.kernel.org
Subject: [heads up] microblaze ftrace breakage since 60b1f578b578 "ftrace:
 Get the true parent ip for function tracer"
Message-ID: <20241204044342.GQ3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	For one thing, microblaze does *not* have kernel_stack_pointer(),
so defaults would not work there.  That leads to build breakage in
kernel/trace/trace_function.c since the commit in question.  Breakage is
trivial to reproduce - just enable FUNCTION_GRAPH_TRACER and try to
build the kernel...

	Moreover, unless I'm misreading their mcount.S, the registers saved
there are *NOT* in their pt_regs layout - the stored data is
	r15 (return address of _mcount())
	r2..r14
	r16..r31
and all of that is at r1 - 120, where r1 is the kernel stack pointer at the
time of _mcount() call.  So those defaults would be all wrong anyway.

	The last time I touched microblaze assembler had been a dozen years
ago, so I'd rather avoid trying to patch the things up there - not with
live microblaze maintainers around, TYVM...
