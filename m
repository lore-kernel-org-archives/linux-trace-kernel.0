Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E00D213E61;
	Tue, 10 Jun 2025 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567134; cv=none; b=LR2PDiQSBv8Fi3AgJUCgfqrrFvZwD2Tq7/b+iCt1RvNblZh8qocs3WwXpP0FN/dCJ5U0UovmaebsqkqtiYr5uCUG1Svgx0MM9x2vxnjIASUbJGErUexv9iXtUCCxefNcZKDaV2EMrZDZHwPxE5YCioXShmIO2bMHm/legAq494I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567134; c=relaxed/simple;
	bh=UNSil0iwsJ12f0l4AtnUUBX+i+/RiXhRKBJWw+Wj+Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUlzYU94UZRsCxxqM7hkP0vMquTRCe/ykD5c5wkDwEA4SYTjT6+9stG0Bl0CgEofeGfJcJ3syppwF2kPr+iGjTLTePvj9R1in7UN2tkI+BxXmEnqBxFpnt54bdYBWZXPOris6KkwmoQF5KnYCJcTiZoDRcQxFyxbudDMvM9/bvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 4DDF9100AA1;
	Tue, 10 Jun 2025 14:52:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 338F830;
	Tue, 10 Jun 2025 14:52:07 +0000 (UTC)
Date: Tue, 10 Jun 2025 10:53:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, open list
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Stephen
 Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Dan
 Carpenter <dan.carpenter@linaro.org>, Anders Roxell
 <anders.roxell@linaro.org>
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
Message-ID: <20250610105337.68df01f4@gandalf.local.home>
In-Reply-To: <CA+G9fYsoCc3DnNGoavFiBdymVpdJiEfUSEq967GgThVQW7bTPA@mail.gmail.com>
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
	<20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
	<CA+G9fYsoCc3DnNGoavFiBdymVpdJiEfUSEq967GgThVQW7bTPA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 338F830
X-Rspamd-Server: rspamout08
X-Stat-Signature: pc43qwbd4quy5x73f9s5jri7am1dmyjq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Dnf2VYujNfH1wJviwfo0gmVI5+MFRJlA=
X-HE-Tag: 1749567127-244065
X-HE-Meta: U2FsdGVkX18WV4YDMOTDd3jHU7xsTn8XeCFWrkA2KWSkow9aroaCLRXmF/aegd1uL4g+QqTr4y75aZBH3M3hP3q7Umz/ezIhwOc/8mgTkR+7VqjrTnE4umG38ToQ7T3jYt2GrBmSUtYl7Ie/Fva3bjbuKg0dxV3s4ce8QpqV2dMkQ1dYVUz8bPZSOBfF/t1KNxhgSb/qPsGP1SogFNkZToGkAQwOKwUgJIoFVyZSCzy97aj609meYasRkNcpTwpLVh+E7ICNEoiuL2Qr3eZzftysoxquaOl33WXFfPIhM5PrGk2SX+NIZHWZILGQ9j2FoU37dOMMKBO5387gtNCz1+7TCkEDBMNDaRf3B3r3MhNLwn+YgjHdVM/kaKGbWrk5

On Tue, 10 Jun 2025 18:50:05 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> > Is this bug reproducible easier recently?  
> 
> Yes. It is easy to reproduce.

Can you test before and after this commit:

  4334336e769b ("x86/alternatives: Improve code-patching scalability by
  removing false sharing in poke_int3_handler()")

I think that may be the culprit.

Even if Masami's patches work, I want to know what exactly caused it.

-- Steve
