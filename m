Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262DAC8CE;
	Tue, 26 May 2026 00:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779754158; cv=none; b=Uv+N9clJCRnoWmg9B1y+FktpCIxju1NUzBTbWEOJ0RIzv8GOuEDjNXN2x4b+S6Dr2vh04IdW/VFVOPhAMhDbPz/CSVVaRbPBLr7aOT2h4KlyT4fxR2wGuhNqKTD4w/v3r+q6Sw3stUl5dgM/lHhx9VS/XnmPAjPNA/xjupTFWfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779754158; c=relaxed/simple;
	bh=LxBIxdDESFLHMSqu9MmuHHe4Vd4ap1yMM1Rs7m0/Nm8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VN9kSxMzSZjNmO0ceYcqib9kTrxW5+qMpXp8qcy5cVOae1Ffd9ItX1dDR9H4q+bINDorIhg+qIvB2RjBFZCpxxBXkAq4kFPHWmia3SkZZ9pslE04DQTVeZbELrCFWMz6Cr1ZKENBqqWUW1hxIAKvjKNNTQgeJHDNPs8Xb5cb4MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSkTzsY+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSkTzsY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E0B1F000E9;
	Tue, 26 May 2026 00:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779754156;
	bh=XLzFIJZhRP1VZ9L4+8fw3LvwZz0RoT/Dy8EF0lJSmkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FSkTzsY+QgsDOIwlgW/2cEGKkQ4Wmf/SlaHJRhGnl3LNHrBOvRtbKqE5u2OA5xdJA
	 m5TPuBX18CiVIacKiOZAH7Vt2xJN8QqU4wcTnh2JDu4tMBmgBAdsvRSSJLZLxZa06t
	 1wbud2fymZMQtOkriroIeX2debNKfNPInJFLyhVYIeiPsUBf+xEQOZkQeWttSLDFh4
	 cZOARUaca+E9YGQlqKlcoobrwEXdxGgzNJCPhOw55Xp2lFIwdifwGJCaovpHQi9gbg
	 cJ6m5Af0tbb88TCsQNe/2A3KE9yPZYUhq/epvwybjJEwmR2clzbc5JCuN+446Mbk0Y
	 uy/GiRWP1UOOg==
Date: Tue, 26 May 2026 09:09:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>, Tom Zanussi
 <zanussi@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>, Jiri Olsa
 <olsajiri@gmail.com>
Subject: Re: [PATCH v6] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-Id: <20260526090910.8aae5c9357e119bd0043b18b@kernel.org>
In-Reply-To: <20260521225033.56458336@fedora>
References: <20260521225033.56458336@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 22:50:33 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> @@ -640,7 +673,7 @@ static int parse_btf_arg(char *varname,
>  	int i, is_ptr, ret;
>  	u32 tid;
>  
> -	if (WARN_ON_ONCE(!ctx->funcname))
> +	if (WARN_ON_ONCE(!ctx->funcname && !(ctx->flags & TPARG_FL_TEVENT)))
>  		return -EINVAL;
>  
>  	is_ptr = split_next_field(varname, &field, ctx);
> @@ -653,6 +686,20 @@ static int parse_btf_arg(char *varname,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (ctx->flags & TPARG_FL_TEVENT) {
> +		int ret;

nit: parse_btf_arg already declared @ret. So we don't need this.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
