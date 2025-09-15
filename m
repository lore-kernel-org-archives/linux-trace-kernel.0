Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD81C84C0;
	Mon, 15 Sep 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949060; cv=none; b=SQrgsjHRD7rGNRvQn57dCmrSwhAxmSr0UKk5T0QlxtnlOXH5ewqn932iAstVYFrBlThNfjWteYl7NSf2cQyJwkMDMuwbvTMs3w1b2D834GhJIle6R+wkDCpAdwUJL3+Ju1LLXGATYFsUwz71mEW1RCxSzmH4TMe6KGagWg9c4PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949060; c=relaxed/simple;
	bh=lOQsesSjhz8e79l3Spu+RP7vswtUlIm457YZy/lEGow=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TcvaWFl9tn71QaJGXHt49JY30xlktCZjnYl0qvlmaVtWPDUi5E0n63iobw5hFLtlxehKyg69BG86iCp2nDCrlMscFlJsR7aYxoyVqGiQZ919NrBDLUaq2f/h+zn2JPkeBXjJSY/wrcjykK8VpS2g3jxnnwP42aC6IHt29asWRpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eozcWgg7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eozcWgg7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF3DC4CEF1;
	Mon, 15 Sep 2025 15:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757949059;
	bh=lOQsesSjhz8e79l3Spu+RP7vswtUlIm457YZy/lEGow=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eozcWgg7rH+/eaeTTJecewUsdHETkLrLdVnhdLGWEENmO4+6sNuH1We0YsWvv/GcP
	 AsfvsftB3OT+MMfJR84CFY2iKTRuA8KB87gQiZqVvSKufd9qme7QOvjLuSGymBFspe
	 mIrAdsoahHZTIvUWqgVENFqIY7OYcAZqnu99SPA3Nijd/ixHfMZlhECdSXK79lcT5F
	 nMAr6S+ICGFFIgRkwTu45BGLqIQ24e2rnH3N/q3TqDuX4j3apD+ouZyHSXd4YuflNI
	 U1kD2WMxBaPxIgjZt309lQcr5ROG2edPSIMXrbiJF7UDSk37F5AngeAT5xBl1IjOYR
	 4kRwhXCiJSpPg==
Message-ID: <9d796d36d64e08fdb58630b5fe3c551754b6c748.camel@kernel.org>
Subject: Re: [PATCH 3/5] Documentation: trace: historgram-design: Separate
 sched_waking histogram section heading and the following diagram
From: Tom Zanussi <zanussi@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>,  Linux Kernel Tracing
 <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>
Date: Mon, 15 Sep 2025 10:10:58 -0500
In-Reply-To: <20250911042527.22573-4-bagasdotme@gmail.com>
References: <20250911042527.22573-1-bagasdotme@gmail.com>
	 <20250911042527.22573-4-bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-11 at 11:25 +0700, Bagas Sanjaya wrote:
> Section heading for sched_waking histogram is shown as normal
> paragraph
> instead due to codeblock marker for the following diagram being in
> the
> same line as the section underline. Separate them.
>=20
>=20

Small typo in the subject line, s/historgram/histogram but otherwise
looks good.

Thanks,

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

> Fixes: daceabf1b494 ("tracing/doc: Fix ascii-art in histogram-
> design.rst")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> =C2=A0Documentation/trace/histogram-design.rst | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/trace/histogram-design.rst
> b/Documentation/trace/histogram-design.rst
> index 231a12bd7d461c..4faff1669b77bd 100644
> --- a/Documentation/trace/histogram-design.rst
> +++ b/Documentation/trace/histogram-design.rst
> @@ -380,7 +380,9 @@ entry, ts0, corresponding to the ts0 variable in
> the sched_waking
> =C2=A0trigger above.
> =C2=A0
> =C2=A0sched_waking histogram
> -----------------------::
> +----------------------
> +
> +.. code-block::
> =C2=A0
> =C2=A0=C2=A0 +------------------+
> =C2=A0=C2=A0 | hist_data=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |<----=
-----------------------------------------
> ----------+

