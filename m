Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CB120DF7;
	Mon, 13 May 2024 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621453; cv=none; b=Pbrs7njxqDX8Kd3gsyUgnOLa8HXhnNTymeyjiq8+cxWCDzZfyBcCzxOye14s1pKJBvepz0ENrufoOgi246UC1kAmCnKpoBNax71dDc4TsqvFwel3byPJKo1MR7woZvBTgqM9HIVudHaOWkrdpepGOwli1rczbF64PWl/rQRSPv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621453; c=relaxed/simple;
	bh=dEWpL73/G3L/agPWxFvIClOdCN8Npjgde9rmhlcynwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDO1w3mNSKwh5h7JykuEZz/BEN7o4eXKc+MVw2KaSRgYIzFzVxPcz0n+4l7MBqZDDZytHkeVUOUe+JrHWbjfnuztc3DRyNplHm2taC9DWcKfmzongw9txmTsYhL2l13vl6ayMi2eAn5xaGpQjuY6Xqsle/rVepHMnccbbKsZUVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RoBd39bG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RoBd39bG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RoBd39bG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RoBd39bG"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5AC7D5C894;
	Mon, 13 May 2024 17:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715621450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWsm72q9eu1VHpbY+LKUmMDUatEzX8mREe9jVdywOgo=;
	b=RoBd39bGPLdW8lDwy9ojb/qIWoGNIaP2brQwHgE5+r0Tz0IC3fHId030WMbGXTYgD4vuIn
	ip0rzwoQaBs0AJ4hC1QIqxlxucjEobRC/EqdFPKqAKcr4Y5Oba74V9wACXrsi8yGMMdFDE
	PnIl82KbGP3ENnQA45h0F2zzi7/LLbg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=RoBd39bG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715621450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWsm72q9eu1VHpbY+LKUmMDUatEzX8mREe9jVdywOgo=;
	b=RoBd39bGPLdW8lDwy9ojb/qIWoGNIaP2brQwHgE5+r0Tz0IC3fHId030WMbGXTYgD4vuIn
	ip0rzwoQaBs0AJ4hC1QIqxlxucjEobRC/EqdFPKqAKcr4Y5Oba74V9wACXrsi8yGMMdFDE
	PnIl82KbGP3ENnQA45h0F2zzi7/LLbg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4372313A52;
	Mon, 13 May 2024 17:30:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yPoQEEpOQmbMdQAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Mon, 13 May 2024 17:30:50 +0000
Date: Mon, 13 May 2024 19:30:49 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Kees Cook <keescook@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen <tandersen@netflix.com>, 
	Jens Axboe <axboe@kernel.dk>, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 1/3] tracing: Remove dependency of saved_cmdlines_buffer
 on PID_MAX_DEFAULT
Message-ID: <eteswsookugqwr5pju5fuzc6m2wly4pxrbp3y2umke6ojvwo3x@pwjqsu77yh6s>
References: <20240408145819.8787-1-mkoutny@suse.com>
 <20240408145819.8787-2-mkoutny@suse.com>
 <20240409110126.651e94cb@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zkpfq5nfsruo2pew"
Content-Disposition: inline
In-Reply-To: <20240409110126.651e94cb@gandalf.local.home>
X-Spam-Flag: NO
X-Spam-Score: -7.97
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5AC7D5C894
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-7.97 / 50.00];
	BAYES_HAM(-2.86)[99.38%];
	SIGNED_PGP(-2.00)[];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]


--zkpfq5nfsruo2pew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 11:01:26AM GMT, Steven Rostedt <rostedt@goodmis.org=
> wrote:
> > -	tpid =3D pid & (PID_MAX_DEFAULT - 1);
> > +	tpid =3D pid % PID_MAP_SIZE;
>=20
> Does that compile to the same? This is a fast path.

I didn't check.
If fast is the intetion, I would change it to something
like BUILD_BUG_ON(!(PID_MAP_SIZE % 2)) and keep the bit operation
without reliance on compiler optimizations.

Thanks for the response (I may not follow up on this single commit
though).

Michal

--zkpfq5nfsruo2pew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZkJORwAKCRAGvrMr/1gc
juwFAQDBe2s/17ASgBrvfEF2JeszX6QHNDTWC+passHlgM1YEwEAscayN2Es6GV6
HNEqE1pw+AK/Y3sC+HqlfsWgHQRpZQY=
=GZFY
-----END PGP SIGNATURE-----

--zkpfq5nfsruo2pew--
