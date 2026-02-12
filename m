Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF333EBF17;
	Thu, 12 Feb 2026 06:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770876918; cv=none; b=bxx30M2sCnL5TwS+IPwSJjpDN53eDmjTdAfU8WHGMyQQ6CbGSEbzOogI0ACmfuzZ0u0owuTxYXYNQh26wfT3dCTi5oM4WqbnQaKbZGptbdq2BGbTU54OinYpPracUn5Rw1Lm0BcfmJ5u4prFhDlSoOjbrtWpwtU/Y5xvXhi1XOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770876918; c=relaxed/simple;
	bh=FwpbOKhloeDXfTYS3+0SbtUUrNDjQf04F/wfUbcHq/c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OuP7J4b89/hcNaE/TydQg2b3u8FzreNknMLWldcX6GLJFqAwrE6/pKpjlY1TrMNYweypehK27xmCk5Q+CIkI1gy4H6CGUSyWHqZDCsNx9MQnh8+yvjy4dMX9JKdmpaOBtWB9fBOdysdnlZ6/JZ9AyWFY7Of6dpYSdpal3Vx7ZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUIeMvJt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUIeMvJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC847C4CEF7;
	Thu, 12 Feb 2026 06:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770876917;
	bh=FwpbOKhloeDXfTYS3+0SbtUUrNDjQf04F/wfUbcHq/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RUIeMvJt+9uywgIGMscRd6HfoO2S0Tde+O8lAI+wch8t6S8NIBzLsU3yzc0T1Owwo
	 b1zIZJLq6P/mon+oyXGrO9S7710keamno9beJbzdGamPxGlZhasiZrRNPZjqv/RzLC
	 Qil1R0P3WXb4JU5HtHDr9HW5Ha1Pe14SBo7DZu7hK08xt+1qdsRGLkZf/mcnLBmP0a
	 Z8iCM8S2Tf1D+4N3M2bSBJqfzgnCGhHgPDtPH5J8h2r2m91SxnULavD7e91O3T6DTZ
	 kFZAzy6QLnLhYcJbjidUWGPgNjM0S2fY6KVP8KBl0tVY2oljx5R1VDc43uvlrdR6Iy
	 fS4kvJaCW+hvQ==
Date: Thu, 12 Feb 2026 15:15:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] tracefs: Check file permission even if user has
 CAP_DAC_OVERRIDE
Message-Id: <20260212151515.b384ac24de9b736d10387d21@kernel.org>
In-Reply-To: <20260211104623.73fd4fc3@fedora>
References: <177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com>
	<177071303130.2293046.2400906233143699263.stgit@mhiramat.tok.corp.google.com>
	<20260211104623.73fd4fc3@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Feb 2026 10:46:23 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 10 Feb 2026 17:43:51 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Strictly checking the file read/write permission even if the owner has
> > CAP_DAC_OVERRIDE on tracefs as same as sysfs.
> > Tracefs is a pseudo filesystem, just like sysfs, so any file that the
> > system defines as unwritable should actually be unwritable by anyone.
> 
> This is getting too complex and still doesn't work. As I said in my
> other email, simply check for the trace_array being readonly on opens()
> and return -EACCES if it is and was opened for write or read-write.

yeah, I understand I confused "permission" and "possibility".

> 
> With this still not working this late in the game, it will need to wait
> until the next merge window. I'll take the first two patches of this
> series now though.

OK. I will send the next version without the first 2 patches.

Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
