Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9813398B;
	Mon, 13 May 2024 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621213; cv=none; b=C+HhRKI7nSHIlMAjms0HEyp04N/9UmNBR0ZLcvESvAdDoauaFuRGC5Tz6YU/9DuVGPFg9CN6bR0qVjUwdkFOnWTyeZ/HSrcCsJWa7mPWVvRgn5+IZA/J8EAMdqdMJea9HS1bkiwBNDe9FbpVlao/x9Oz4Gtp1l8p+dxrRiAFqP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621213; c=relaxed/simple;
	bh=dbD3uJP//crk7zbG3JGEpMcw5M6x1oBmQ1U92lN7o3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEpcpboFgAfTJQzKRmtZjFMkbnGpgzDrXmJY4gYFbTUFBVJ23FFtY//I/K6pghI2J3v5IwDyb2zADdFr7+NpZtIrqKu07TU7wPzCDkoeQW22ngl7hzZ2zbptKfgHQn5XRWCK/nqgm6Y21Kdopq+89mxxiBK6bNNNZH7wegwgd7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MxgYCYpO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MxgYCYpO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MxgYCYpO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MxgYCYpO"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B6465C85C;
	Mon, 13 May 2024 17:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715621209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LHwhqBcJNb7hcRmxDBdb2RRQjH1GPK52RNyomipKXWI=;
	b=MxgYCYpOqPRV0h2hOCM8DsixEEmYjKw4Ifk/nVucpdcfVEPrAghfDU2uIgWTcb/iPaSB/1
	51fQXELtnfAjhQJrN3Rx0sAsHcK/y6D6vvODE+WdaLI8txHtUH9v1D97zZxjmCOqIsAiuC
	K8nPV9EDdkpc2fowqa+S8amjhKdt6HM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MxgYCYpO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715621209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LHwhqBcJNb7hcRmxDBdb2RRQjH1GPK52RNyomipKXWI=;
	b=MxgYCYpOqPRV0h2hOCM8DsixEEmYjKw4Ifk/nVucpdcfVEPrAghfDU2uIgWTcb/iPaSB/1
	51fQXELtnfAjhQJrN3Rx0sAsHcK/y6D6vvODE+WdaLI8txHtUH9v1D97zZxjmCOqIsAiuC
	K8nPV9EDdkpc2fowqa+S8amjhKdt6HM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB0D413A52;
	Mon, 13 May 2024 17:26:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hSXqOFhNQmaydAAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Mon, 13 May 2024 17:26:48 +0000
Date: Mon, 13 May 2024 19:26:47 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Kees Cook <keescook@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen <tandersen@netflix.com>, 
	Jens Axboe <axboe@kernel.dk>, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 2/3] kernel/pid: Remove default pid_max value
Message-ID: <dfoqa6pd2vyk6zcnc7zulojiho5uezgeyv2a7h6i7dm2oaawgt@7h33yk4pgiw4>
References: <20240408145819.8787-1-mkoutny@suse.com>
 <20240408145819.8787-3-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nkvry3sagr4djnvz"
Content-Disposition: inline
In-Reply-To: <20240408145819.8787-3-mkoutny@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-8.11 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0B6465C85C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -8.11


--nkvry3sagr4djnvz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 04:58:18PM GMT, Michal Koutn=FD <mkoutny@suse.com> =
wrote:
> The kernel provides mechanisms, while it should not imply policies --
> default pid_max seems to be an example of the policy that does not fit
> all. At the same time pid_max must have some value assigned, so use the
> end of the allowed range -- pid_max_max.
>=20
> This change thus increases initial pid_max from 32k to 4M (x86_64
> defconfig).

Out of curiosity I dug out the commit
	acdc721fe26d ("[PATCH] pid-max-2.5.33-A0") v2.5.34~5
that introduced the 32k default. The commit message doesn't say why such
a sudden change though.
Previously, the limit was 1G of pids (i.e. effectively no default limit
like the intention of this series).

Honestly, I expected more enthusiasm or reasons against removing the
default value of pid_max. Is this really not of interest to anyone?

(Thanks, Andrew, for your responses. I don't plan to pursue this further
should there be no more interest in having less default limit values in
kernel.)

Regards,
Michal

--nkvry3sagr4djnvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZkJNVQAKCRAGvrMr/1gc
jpSvAQCsSOm/I5e5OvSYLJxNDtQ9wak/VEONLbVa3cVJP2xHhAEApi2V5nn0hmbR
480flnaEOBy19fewu+8DXLEC1byvEQo=
=5y2m
-----END PGP SIGNATURE-----

--nkvry3sagr4djnvz--
