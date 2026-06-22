Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6A352C4F;
	Mon, 22 Jun 2026 04:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782104223; cv=none; b=EoN/AA64v8lUyYU/H7Wk58elnHwoKuW5DCe5ivBJdD2VOR8FgdmNycKrw9Db6gmmctEmP9M+BKNtFkL1BcaH9smquCG6ycCynUNpQpXfz15U16b3MOd3FnarhXSjoydZ66PhH7r97vrUiXduIALr00+SE//YdUesAFpF7SbnK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782104223; c=relaxed/simple;
	bh=la2zHYFOMrPCn0tgxeYuc9w4Co6TOCJvjE/tmTCGozw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hZJJwh5jYsAM5h0FecLsILoI2LoUT4EXyaU1BLZvPU+uyj2rpJtYEoZAhM3KvpdJcQBOo62CDRL1q8NeSXLwMDWqEHp7yEeD09ZsqtRqOdP5+jS5d5+41hnBQdKE5Xz6mWKGOSde8KMN/IitHlFX6YssofxtSFDBJbT68qnSr4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTBfikGU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTBfikGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3646E1F000E9;
	Mon, 22 Jun 2026 04:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782104222;
	bh=KizX25jDjeoIEF3w5CzydjKnqG5rqIztZN1pRVw0fwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PTBfikGUJg73FwwqJWn+iLkcexKjF4sOogL2dAKMKWd07PI1YNzbV3UKEX0upyccD
	 36KF1kyDcalpnUlaMyjLwgLbSzRq13YQhYA0NeNdbktDTfzbFxerfJTZk9gaJndbMF
	 tZSEq3yjvBztzIOLjDlnZGMrIg9BGfVnGKjLibmykJDjb+hTC9FCX3LOP7pQqi2AkO
	 aVq5+BS0iCtTzyc01p//do59gc3AZhQK9WovBoJhU26ba519MWi8ZBwDo3EBb5UGLg
	 HJFO8TgVJtVTQY3t4i0qjn7wrdJ5L9OaDroVbOpptFDFpvfdO6Vpqb7KJPN32ORXIY
	 U3KMDsAR/7g2w==
Date: Mon, 22 Jun 2026 13:56:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Markus Schneider-Pargmann" <msp@baylibre.com>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: fprobe: Remove __packed from generic
 __fprobe_header
Message-Id: <20260622135659.ff84ef3b831a464b802d7c33@kernel.org>
In-Reply-To: <DJ59B5LEGPER.3UURGUC8IW7E2@baylibre.com>
References: <20260428-topic-fprobe-packed-v7-1-v1-1-9abc9b866b4c@baylibre.com>
	<20260610171740.c30c43c5faee0beac3ad7546@kernel.org>
	<DJ59B5LEGPER.3UURGUC8IW7E2@baylibre.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 11:20:24 +0200
"Markus Schneider-Pargmann" <msp@baylibre.com> wrote:

> Hi Masami,
> 
> On Wed Jun 10, 2026 at 10:17 AM CEST, Masami Hiramatsu wrote:
> > Hi Markus,
> >
> > Thanks for ping me.
> >
> > On Tue, 28 Apr 2026 10:30:29 +0200
> > "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com> wrote:
> >
> >> fp pointer and unsigned long have the same size on all relevant
> >> architectures that build Linux. Furthermore this struct is only used in
> >> architectures that do not set ARCH_DEFINE_ENCODE_FPROBE_HEADER which is
> >> set only for 64bit architectures (apart from LoongArch).
> >> 
> >> Both fields are aligned on these architectures so the struct with
> >> __packed and without it are the same.
> >> 
> >> Remove the __packed as it is unnecessary.
> >> 
> >> Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> >
> > NOTE: This is not a Fix, but just cleanup or minor update. Or, you have
> > any problem with this __packed attribute?
> 
> Thanks, yes it is not fixing a bug, I can remove this.
> 
> >
> > Unless there is no problem (or any concern), I would like to keep this
> > as it is.
> 
> There is currently no problem with __packed in the upstream kernel. I
> just thought this would be a good cleanup to remove the unnecessary
> attribute. I am working on CHERI architectures where pointers have
> capabilities. __packed breaks these capability tags and therefore
> doesn't work on CHERI. When looking into why this struct has a __packed
> attribute I didn't see a reason, so I thought this would be a good patch
> for upstream as well even though CHERI is not yet relevant for upstream
> linux.

Hi Markus,

Ah, OK. CHERI makes pointers to non-long value. Are you sure
removing __packed makes fprobe working with CHERI? If so,
please describe it. Then I can pick it.

Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
