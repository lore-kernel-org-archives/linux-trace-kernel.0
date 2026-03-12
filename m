Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9C03D9022;
	Thu, 12 Mar 2026 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350891; cv=none; b=LCevu2fDnok7H+nyctiZEgMWnkibcAVqp05TI9tKsc2UThPgW2kXbRQZ9/nQDxeRqN0rPsYwVTpwjarG8020grkycjNoXh9+fYgp3Is3OrNir4VvRqhik99RzB/BaNCNeENOhwTC31GGiMEh1NcTjFKpySgPVWd51a8gPDLF68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350891; c=relaxed/simple;
	bh=1dVyXhY7iNmFzLziqYSLF7MUxZK0iyPrE17EHEoiWxI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RFRlEk/PazY6+Kq/KIB2nfC1qzgUUcu/SnQ118Ck88YNntGDuhnyJIYRjlyMYoW4fB1hBDuxumBSTCVe+3yyBxN/aalCDlDGU7Nc+vYhu3WBI9sBi7Ef8FpN84RXHbSaC8EuY71LPhYImpJS+96PR7bDG10W332CNTNbS0Urqng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FxZtoAkB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FxZtoAkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF09C4CEF7;
	Thu, 12 Mar 2026 21:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773350890;
	bh=1dVyXhY7iNmFzLziqYSLF7MUxZK0iyPrE17EHEoiWxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FxZtoAkBGYrxx4NlGYAT5luTQ6gr/2PAjlUsLmnG/3jAlSvugOODitdaxWDcWOpDq
	 OFqPIg8CChTS0rWONgR/zgPMYfSxDv4mkzicsPQfEqX4OOD0p0869VxGq/EWkRdMEM
	 /QO1q0Hi4UuI2ECw48XAOkbSSYenl6i0LtkSglJs=
Date: Thu, 12 Mar 2026 14:28:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Josh Law <hlcj1234567@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Josh Law <objecting@objecting.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] lib/bootconfig: check bounds before writing in
 __xbc_open_brace()
Message-Id: <20260312142809.cb92d6b5197e89645edab80b@linux-foundation.org>
In-Reply-To: <4c426803-91f8-48fc-ae8e-20676479b370@gmail.com>
References: <20260312191143.28719-1-objecting@objecting.org>
	<20260312191143.28719-3-objecting@objecting.org>
	<20260312170643.4b0f926b@gandalf.local.home>
	<143ca1aa-d053-4947-9817-72462876c224@gmail.com>
	<4c426803-91f8-48fc-ae8e-20676479b370@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Mar 2026 21:09:52 +0000 Josh Law <hlcj1234567@gmail.com> wrote:

> > That's a fair point, Steve. Given that brace_index isn't touched elsewhere and the current check effectively prevents the overflow, I agree this isn't strictly necessary. I'll drop this patch and stick with the fix for the off-by-one reporting error instead. Thanks for the feedback!
> 
> Wait Steve,
> Thanks for the look. I see your point that it's currently redundant given the call patterns. It looks like Andrew has already merged this into the -mm tree, likely as a 'belt-and-suspenders' safety measure. I'll keep your feedback in mind for future cleanup, but I'm glad we got the other off-by-one fix in as well!

Please wordwrap the emails.

> And in my opinion, merging it is a decent idea.

You've changed your position without explaining why?
