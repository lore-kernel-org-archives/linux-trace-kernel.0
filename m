Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B8A3019A0;
	Mon, 15 Sep 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949115; cv=none; b=IWZxu/G7dendqWCjz3SbhlaBOWLYvv4RWwGh8NNzpWz5fEbWu8vDtA7DC1W4cjlaSXuoN9RpcUGSXQvpI2Gr3/8WAADkYo8dX1MRms7maJ/h1a0b6qDGnIkQK3aZImipHurroIDfUP8cMauQ/TK/EdbaGuyGBFaRMVAk4oJf2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949115; c=relaxed/simple;
	bh=nTXpQDVvV8j8rKPIT52IwtLs5XT4P3l3xVE00vGwQ+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oQw4deFqrEddELzURYKpS11jl+x7768vvHg14RYxiteQX2kZmsGUQr3s3cl8YL0rc19aBAqbume0ojdMDYcf7REjztKLjuzxnrpIXnS+UcU0FcSqNztni0A1CL2SFt2RtkiZqGVpidMEvb4Jl2/Q5SIgAfjSU/gboLLQEsGSwpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gn3Cicqu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn3Cicqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063EDC4CEF1;
	Mon, 15 Sep 2025 15:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757949114;
	bh=nTXpQDVvV8j8rKPIT52IwtLs5XT4P3l3xVE00vGwQ+Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Gn3CicqumKez3duR++U1ozva7Mn2qarveuL1RqsCuvodOtMTVcDjrwjmbvi3TANR1
	 990teqrISA6/K21EOHfaNBlNooiouW19f1+D4QPsv7W1f39UNZ9YmoexEfJAn8APdv
	 7WvLlvTjepZ9+r4SDGKc9LZoWmmEJhXw9vj38X9ZNvyKRpA1IYe3sXGsaXk1NVDX6D
	 aa8py9kQht7IGg2+V187f8+UUQHiaLVFAlrNhuTzmpmCTZElPixUzAkdEjqIF6QMy7
	 060qzSFNLKw/MJc2IKcihoAwklZycqZ4dQbpBMJEFo/2UBPpUZWlQNzByvMdyiC0PK
	 9J2oHkHGKp27A==
Message-ID: <a7f481f21c8a70b44d9d067bde0d5d1b6ead36ed.camel@kernel.org>
Subject: Re: [PATCH 5/5] Documentation: trace: histogram: Link to ftrace docs
From: Tom Zanussi <zanussi@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>,  Linux Kernel Tracing
 <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>
Date: Mon, 15 Sep 2025 10:11:53 -0500
In-Reply-To: <20250911042527.22573-6-bagasdotme@gmail.com>
References: <20250911042527.22573-1-bagasdotme@gmail.com>
	 <20250911042527.22573-6-bagasdotme@gmail.com>
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
> In brief "Extended error information" section, details on error
> condition is referred to ftrace docs. Add the link to it.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

>=20
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> =C2=A0Documentation/trace/histogram.rst | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/trace/histogram.rst
> b/Documentation/trace/histogram.rst
> index d158dadaa42447..340bcb5099e7a4 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -209,8 +209,8 @@ Documentation written by Tom Zanussi
> =C2=A0
> =C2=A0=C2=A0 For some error conditions encountered when invoking a hist t=
rigger
> =C2=A0=C2=A0 command, extended error information is available via the
> -=C2=A0 tracing/error_log file.=C2=A0 See Error Conditions in
> -=C2=A0 :file:`Documentation/trace/ftrace.rst` for details.
> +=C2=A0 tracing/error_log file.=C2=A0 See "Error conditions" section in
> +=C2=A0 Documentation/trace/ftrace.rst for details.
> =C2=A0
> =C2=A02.3. 'hist' trigger examples
> =C2=A0----------------------------

