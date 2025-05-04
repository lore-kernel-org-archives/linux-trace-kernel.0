Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C27193436;
	Sun,  4 May 2025 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746351037; cv=none; b=SRZHqG4DfeafHYNLaaHx0tJsqQKYyiCJtA0od9D4VI8kq4KRY30bob5C2+2/26a5rp+UWKurX2PRyafo3p/mqJGOxYgnC0p1hkkJHWl42VLCPt1TfdlTyaY0D/APlRny1A6zh5XXHl2pceD8MtAidooSZcfEXgVoCDCMoVH9Z24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746351037; c=relaxed/simple;
	bh=DxnjVROM3FnmNDxFGOZkKW9YPv5L0ay1Z872NjSjL6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmVBXIdXIWoSH0OJlrGJBU6rxebt9vKoRWAJESYHfvdXRSnd9ANbuhIQmW4Lmfi1ZdwzQl4nFSUq1YY0IFM5AU5wNzVbrcXcN8zA1vLNE8oW+/GPTQCQ1Wr2dd5WGTuS7641P+0h8u9Dmv+Ws4W01HC3R+A1cM2ks9/qmNAAJdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtDovcuA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtDovcuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B62C4CEE7;
	Sun,  4 May 2025 09:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746351037;
	bh=DxnjVROM3FnmNDxFGOZkKW9YPv5L0ay1Z872NjSjL6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mtDovcuA3A3oRXT52rIWoS160JlK14bM4FpETYkBFD5RM9XgmUJWqbhzri291YxpE
	 o5tAwtS/GxXA2d98XazNPLCDGDWfXnqMAwo6lM4GZ6c4vy4iRjBVsfTL9lBedclwpP
	 QSyIeMMf7Hz10h4vyq7XrZardq6EVpILnNgR6zEc1tcrcxCHzkKJ09gFKBNC0vddzk
	 rNGlv9Wm7EaC9Xz3DltXZ5Lk1SRGBnkxcz6kPmGdBNeEbXvB6WALbZYQ6eM8prSqJs
	 j470pE1YHHLPgZuLceOktjOw/ANmnJZZu6mWjJZeMJOyxM3r4rMqcI/ZIfUzqaaVda
	 PavUf1nQKHayg==
Date: Sun, 4 May 2025 11:30:32 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v7 01/17] unwind_user: Add user space unwinding API
Message-ID: <aBczuIoPIV3kkCnu@gmail.com>
References: <20250502164746.178864972@goodmis.org>
 <20250502165007.549687075@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502165007.549687075@goodmis.org>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> +++ b/include/linux/unwind_user_types.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_UNWIND_USER_TYPES_H
> +#define _LINUX_UNWIND_USER_TYPES_H
> +
> +#include <linux/types.h>
> +
> +enum unwind_user_type {
> +	UNWIND_USER_TYPE_NONE,
> +};
> +
> +struct unwind_stacktrace {
> +	unsigned int	nr;
> +	unsigned long	*entries;
> +};
> +
> +struct unwind_user_frame {
> +	s32 cfa_off;
> +	s32 ra_off;
> +	s32 fp_off;
> +	bool use_fp;
> +};
> +
> +struct unwind_user_state {
> +	unsigned long ip;
> +	unsigned long sp;
> +	unsigned long fp;
> +	enum unwind_user_type type;
> +	bool done;
> +};

Will any of these types be visible to tooling via ABIs?

Thanks,

	Ingo
