Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204374;
	b=19CLhkxa7CoPPMo62F6jL/euncV0QizrEAsPS0YU4on5ODwjOJvyxXaCNic07qP6hQLv
	 HxzDWg+F1sGY7Vd651hbfm8t/V4wpXiSbOVZfFZBq9Q9kQ0+cRHIMhS4h+7hXVQIk3e7O
	 BcjkNHt24uNM6wLjjXvFiSLTGMEDGvZxbqNXee9VpeOgGKQxuS64ifz+QC0rsxIZ1t5qi
	 NRQqbC0hDnRxwITYuExR608+8o7QDNYBeOStzQVVkc+EwJq35Yo7YbQlkBgN5qsxAervz
	 7N+HgSdGR/IoWsqZAiWEqr4fb9a7fuVBd9+ZzwGMFkzktfSdx+Wqgf1OGaPD6Ah8wmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204374;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xSmb3XvaT7w3iZQmPT+hXfc5t8hLhalNMocO6CgIACE=;
	b=i+5zEkhrw90wBoc9C4tT31WVL+CP+UtmWuW4bGMcM6bvJUfM/MnqGVJRdDiAwcd0qGEn
	 mar1tevl3E+aPcCTiku1KuMYYxhNqDrOR41yWuc+3g43rPpfdFGXEbuH2GkV89e+oKxvc
	 EooSUGWDjgSDYCj42VzShN35XCQIxj2noL2KaJeK9qlqNe9rsihrc6n09m3lQ1ylr4024
	 LqQb//t+o4owq5kHvGdWsRHs2suMe4dr0GV1/gtxgVIXwos1K2FHgCZdJmmIszCcRMv+g
	 B5Tpk8vrejoxPCLVjWIuRi+eNmqU+TiIf2QCflQ9IwM1L5v0XJ6QOI5JzPkAKd3oqKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XiVoXp3v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDDF606A337
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XiVoXp3v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1630F1F000CA;
	Fri, 20 Nov 2026 19:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795204374;
	bh=xSmb3XvaT7w3iZQmPT+hXfc5t8hLhalNMocO6CgIACE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XiVoXp3vbzwiqWj8ksXH0i5rKB+YVpJ/HSSuBZtokhhxn5MINEYdHF4S3e1oQzegL
	 hhTAUBOag2raU4vnr2P5Zda3pbGqbJoO1AEv2DsROR+vY7wwvRJyDt8Vz066ex/0MR
	 YUZL9MgR9ZGFncLSZHmeXTcJheIZ/hx12CN9ixSuL/60IPmXHy0DMtKXYqr6Gh590G
	 gtgd+YoX7ct8n+DBOkLq2g2j1CCcHg0WBtP+9Rd53GKliU3dhZMCVpWpccEOqwAfVG
	 cSP3mUWuqDGlkFmrrsuz8NpAVrx+4+QK7hes4P9dUqCExYCxEJtYdDu7A3UCe8B7cr
	 PREtN8CANhaVg==
Message-ID: <sashiko-outbox-225971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] tracing/probes: Zero out faulted dereferenced fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>, "Linux Trace Kernel" <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261120143002.18b364b3@gandalf.local.home>
References: <20261120143002.18b364b3@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 19:52:53 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] tracing/probes: process_fetch_insn_bottom() string array loop
  checks val
--

commit 1bda61677a4b06fd01938014840ab606ebd55bfe
Author: Steven Rostedt <rostedt@goodmis.org>

tracing/probes: Zero out faulted dereferenced fields

This commit wraps probe_mem_read() and probe_mem_read_user() to zero out
the destination on failure, and continues through stage 2 of
process_fetch_insn_bottom() with a zero value rather than returning early
when a pointer dereference is NULL or faults.

> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_t=
mpl.h
> index 8db12f758fdae..4eb0ebe5767cd 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h

[ ... ]

> @@ -225,11 +263,15 @@ process_fetch_insn_bottom(struct fetch_insn *code, =
unsigned long val,
>  			if (s3->op !=3D FETCH_OP_ST_STRING &&
>  			    s3->op !=3D FETCH_OP_ST_USTRING) {
>  				dest +=3D s3->size;
> -				val +=3D s3->size;
> +				/* Only update a non NULL val */
> +				if (val)
> +					val +=3D s3->size;
>  				goto stage3;
>  			}
>  			code--;
> -			val =3D lval + sizeof(char *);
> +			/* Only update a non NULL val */
> +			if (val)
> +				val =3D lval + sizeof(char *);

[Severity: Medium]
Should this check if (lval) instead of if (val) when advancing through a
string pointer array?

For FETCH_OP_ST_STRING and FETCH_OP_ST_USTRING arrays, stage 2 saves the
current array slot address in lval and dereferences that slot into val.
If the array pointer lval is valid but element i is NULL (or reading it
faulted), val is 0 while lval is non-zero.  Checking if (val) leaves val
as 0 instead of advancing to lval + sizeof(char *), so jumping back to
stage2 overwrites lval with 0 and causes all remaining string elements in
the array to be skipped and recorded as faulted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120143002.18b3=
64b3@gandalf.local.home?part=3D1
