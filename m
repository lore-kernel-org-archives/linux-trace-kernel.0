Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0AE440641
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163939; cv=none; b=S+NEUcsaotoknYmgmD65rS7DaHsBcFJ9HmOYrQ4hFLsgMSY66kqmw/y4cpTiO3OMwNW6fEl+D3o3aMytbF35AZthCQ3JiVwlZu0McwzI3b6RgOgMvMsVaf76Qk4Y0qNWgaVGnLYOqITHc8XRnKzDTSaHbzSYBZiN2syHN5yigls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163939; c=relaxed/simple;
	bh=DxrNg90n8d7uVJxl/gTVTgXjOrElYxaMDeHtxnFUDsU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cyTmuvjXjedAznVhrgpUHuAsd68k0P9H+8rtyy6a6gcUTqZwZe6yCieUVAa74d9Bpq3amAuxuj2hcGrKnFYOlzhe17A0GBqiL1eQt5rfYnqt+OTg7kbBMVrs2xPAB25DM/PEjnk6fcwt0xgPQfDUI3uPtdGXed8+hn9BK7Dub54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkZ5+AAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkZ5+AAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5BD1F000E9;
	Wed, 19 Aug 2026 18:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787163938;
	bh=+yTa0HOphvnPXWi6fvYfNam0UKDaQyU6PHolqQG1kFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YkZ5+AASQTHSzauhNpZVESChLG/TRqZGBI3E8mjBy41y3ACG5snK8LVOE6mwbbbMr
	 3JBU9s31nackguWg6NuzpTKXWfHtrOtVTd/ZORwmiqjuNbRphfhgbVsqO7yC+x7T/L
	 AktVk6zlwdbqBerr3ryKjYk/I2e+3n8unjPcFsyyZOD88VnEhyTHwPKxlHFGAlfOS1
	 8Ed/7vbLAWWq0FUpT7X7uzTcbn61w3xuOXKhHejS84t6F2cQvCadHbHea4qDloM4w1
	 79Wt8kL0XdrxHz4ZIZtpsn+cFEnq6i71Ad9LzzzTrBeTUjap8CAA0D+THAJqQKo7uf
	 5vZjbZWR+jseA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/9] rv: Add tlob model DOT file
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <306910ca9aa71384ad3bea479a009fd921dc0aae.1787161646.git.wen.yang@linux.dev>
References: <cover.1787161646.git.wen.yang@linux.dev>
 <306910ca9aa71384ad3bea479a009fd921dc0aae.1787161646.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:25:37 +0000
Message-Id: <20260819182538.1C5BD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The 'running' node is defined twice with conflicting shapes, incor=
rectly designating it as the final state instead of 'stopped'.
- [Medium] The commit message significantly contradicts the implemented DOT=
 model's states, transitions, and invariants.
--

--- Patch [3]: [PATCH v5 3/9] rv: Add tlob model DOT file ---
commit a0f17b48f9f5df47c444bf6d511a4f8c03b0a847
Author: Wen Yang <wen.yang@linux.dev>

rv: Add tlob model DOT file

Add the Graphviz DOT specification of the tlob hybrid automaton to
tools/verification/models/.

> The model has three states (running,
> waiting, sleeping), five transitions (switch_in, preempt, wakeup,
> sleep), and a single clock invariant clk_elapsed < BUDGET_NS() active
> in all states.

[Severity: Medium]
This isn't a bug, but does this description accurately reflect the
implemented model?

The DOT file defines four states (running, waiting, sleeping, stopped), six
transitions, and the clock invariant is intentionally absent from the
"stopped" state.

> diff --git a/tools/verification/models/tlob.dot b/tools/verification/mode=
ls/tlob.dot
> new file mode 100644
> index 0000000000000..7f6f09c3d7cf0
> --- /dev/null
> +++ b/tools/verification/models/tlob.dot
> @@ -0,0 +1,25 @@
> +digraph state_automaton {
> +	center =3D true;
> +	size =3D "7,11";
> +	{node [shape =3D plaintext, style=3Dinvis, label=3D""] "__init_stopped"=
};
> +	{node [shape =3D ellipse] "running"};
> +	{node [shape =3D plaintext] "running"};

[Severity: High]
Is it intentional to define the "running" node twice with conflicting shape=
s?

Because tools/verification/rvgen/rvgen/automata.py prioritizes the first
definition ("ellipse") over the second ("plaintext") when merging attribute=
s,
this improperly designates "running" as the final accepting state instead of
"stopped".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787161646.gi=
t.wen.yang@linux.dev?part=3D3
