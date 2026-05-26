Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA153FE343;
	Tue, 26 May 2026 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814090; cv=none; b=GKTlvKRGr7fmP9CA85Vs9E/nG1sfG0tleQLsN5cu6EOrmgIJx+EjlZljT8zhECP2Jam2vp/SyANrGjBro/aq+0K0B05dcjbh1xRwlf45J0iO+wOVdwHp7PKIC0REDOAuW+3BdfOvCmbR/Sk7hP7Go2BrSIWIyUZy5uswhmELxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814090; c=relaxed/simple;
	bh=QJcbart5qBnIkJcO72MOSr2Lt86MHUMqXuALN73NAUY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MYGb5YpcIUp0Rx5deDrfuZACb4/xLgOr9uhU3bcLhP8JznmIndQ6EY6iZN4AaQvYstW7g4u49Gp30iCipA/vZ1vf9BQDQkplIwYjr1E3KHxREyB16POmG5M/v1ObEYHKIPV4kpLDCg0GoYmLI4+1Rfp7edgpEDXbc5KGEucGVHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMmN0Txq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMmN0Txq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C230B1F000E9;
	Tue, 26 May 2026 16:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779814089;
	bh=wyKCWS+5EwPuvulQlXEjoBphY6jqgnwWWtFmgyQLZIA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oMmN0TxqPhD6tkJwGjazaPbx5QiKQUGnaSCItBOFwVdavTL/cEnhWEMXqrpSqQU1I
	 cIQAJFipwvt34x4z1vdBsRAV5LI04+ai0L/zqQv22pWdvj5nzyCAWVYrw3Ka6E66uK
	 TiRJ8z0jJZtec5ifc6hZcDuL33NsoByI1zagDBxNJXHX8SKoUFeSiMtaMTDsrmIGx4
	 12XTQYq35quGjZ/ms7mLk6FR8PFOgT/vX7/8p33tN9zr4kTSVtYIrEE+PZ+f3k4eP2
	 8+eMJTuQTkyWQ+zVmA6TQnjSyzvFfdfgCUNQvEshVekD6Bpu1e3NMh2/GQnHFGVe1A
	 5hTy347PK7QYg==
Message-ID: <ba5df6966f6a8d44c3754a7ab598c5ad4060111b.camel@kernel.org>
Subject: Re: [PATCH] tracing: Do not call map->ops->elt_free() if
 elt_alloc() is not succeeded
From: Tom Zanussi <zanussi@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt
	 <rostedt@goodmis.org>, Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Rosen Penev
 <rosenp@gmail.com>
Date: Tue, 26 May 2026 11:48:07 -0500
In-Reply-To: <177933895460.108746.5396070821443932634.stgit@devnote2>
References: <20260520223101.34710-1-rosenp@gmail.com>
	 <177933895460.108746.5396070821443932634.stgit@devnote2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Masami,

On Thu, 2026-05-21 at 13:49 +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> In paths where tracing_map_elt_alloc() failed to allocate objects,
> the map->ops->elt_alloc() call was never successful. In this case,
> map->ops->elt_free() should not be called.
>=20
> This bug was found by Sashiko.
> Link: https://sashiko.dev/#/patchset/20260520223101.34710-1-rosenp%40gmai=
l.com
>=20
> Fixes: 2734b629525a ("tracing: Add per-element variable support to tracin=
g_map")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org
> ---
> =C2=A0kernel/trace/tracing_map.c |=C2=A0=C2=A0 17 +++++++++++++----
> =C2=A01 file changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
> index bf1a507695b6..0dd7927df22a 100644
> --- a/kernel/trace/tracing_map.c
> +++ b/kernel/trace/tracing_map.c
> @@ -386,13 +386,11 @@ static void tracing_map_elt_init_fields(struct trac=
ing_map_elt *elt)
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -static void tracing_map_elt_free(struct tracing_map_elt *elt)
> +static void __tracing_map_elt_free(struct tracing_map_elt *elt)
> =C2=A0{
> =C2=A0	if (!elt)
> =C2=A0		return;
> =C2=A0
> -	if (elt->map->ops && elt->map->ops->elt_free)
> -		elt->map->ops->elt_free(elt);
> =C2=A0	kfree(elt->fields);
> =C2=A0	kfree(elt->vars);
> =C2=A0	kfree(elt->var_set);
> @@ -400,6 +398,17 @@ static void tracing_map_elt_free(struct tracing_map_=
elt *elt)
> =C2=A0	kfree(elt);
> =C2=A0}
> =C2=A0
> +static void tracing_map_elt_free(struct tracing_map_elt *elt)
> +{
> +	if (!elt)
> +		return;
> +
> +	/* Only objects initialized with alloc_elt() should be passed to free_e=
lt().*/
> +	if (elt->map->ops && elt->map->ops->elt_free)
> +		elt->map->ops->elt_free(elt);
> +	__tracing_map_elt_free(elt);
> +}
> +
> =C2=A0static struct tracing_map_elt *tracing_map_elt_alloc(struct tracing=
_map *map)
> =C2=A0{
> =C2=A0	struct tracing_map_elt *elt;
> @@ -444,7 +453,7 @@ static struct tracing_map_elt *tracing_map_elt_alloc(=
struct tracing_map *map)
> =C2=A0	}
> =C2=A0	return elt;
> =C2=A0 free:
> -	tracing_map_elt_free(elt);
> +	__tracing_map_elt_free(elt);
> =C2=A0
> =C2=A0	return ERR_PTR(err);
> =C2=A0}
>=20
>=20

Looks good to me. Thanks for fixing it!

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

