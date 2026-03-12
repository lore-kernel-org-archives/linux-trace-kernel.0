Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06DC3932D1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334224; cv=none; b=QPjS4vOLrPkk2vA2x/A4hnVk4wojsYI3rBSzNSJK0oaE83xJARn1ONHfGvkPPRPHWBG9Y9767K3fHn57/bKveeh1GwjzNoed/Ii5VvGxpo23Z4kvREhCYWf982E4IdiCu6w0dbdKNcVG8+rHSeNCds34R36XtjLPCfp83grT2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334224; c=relaxed/simple;
	bh=Vu/AtXeAuApZgvU55tsnXQV9qTS+ilZ6eVLKJtSSib8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YauZNDLKXpUES0lBgwJzNyp9+ekAUHxaEP9+laaf+eKZ322NZziA6D+Iuo1riM+k5VE8hdnaG7KqFEYnozmywvm1LMDCRBLtjWl+iwPD1FkTe2ItWHP28waLjwgM47WrMqKTa/+YQ8nphXtH24OHKa6zB+T5nx+3pIqBhhgm3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DIajkH8a; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DIajkH8a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=jgDs
	ke1It431HYOLY25QmR9+rotAbe+iAMW/3tgAjDw=; b=DIajkH8asd8LF+/wo1Oi
	ZBm/9XdJmdslwQXizqy4Kxixgt7wVsvj4b8209fi2901aPVG0iQXAlahBkUah88g
	asLaL4nMnJXkCrqD3FniI/Ob1Q0BkdYBIFLNsxwk+HKDonnjAOpOeGRoKtOW+pVv
	n6Tc9cOQmnMxoauR9xdZStBk0tDN59xiezfTDtXMBuTcX3gSJeQEsNH8XpXVr8+c
	GLTAaG6QF57KWZUr632gbelox3AjaJXxjZQ6uYF13ZO//FMitnTZ6bIeYUtr3ut8
	4L16VBpw5KZIMgytzbBcoxV0reOqyffUJnov5Pva+tyaSAgK7CjtXyPfCgRHVa1R
	6A==
Received: (qmail 4160860 invoked from network); 12 Mar 2026 17:50:08 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Mar 2026 17:50:08 +0100
X-UD-Smtp-Session: l3s3148p1@9u2Ki9ZM6KoujnvS
Date: Thu, 12 Mar 2026 17:50:07 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] i2c: Use trace_invoke_##name() at guarded
 tracepoint call sites
Message-ID: <abLuv627ILX5E7Jy@shikoro>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-13-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312150523.2054552-13-vineeth@bitbyteword.org>

On Thu, Mar 12, 2026 at 11:05:07AM -0400, Vineeth Pillai (Google) wrote:
> Replace trace_foo() with the new trace_invoke_foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_invoke_foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6

From my side, this can go upstream with the rest of this series (when it
is ready). So:

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

