Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C3731B83B;
	Mon, 15 Sep 2025 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949083; cv=none; b=UKJnYayAcKlBhhAFKGfXWF43XzS/PEGo4mFNM23SUm/py408Ym0FXD22Nzh3QFauiDM5m31JZKjIeXxleYzDXMO/FtpVbN0xQfQ+M237fYPqI2LuYJKhf/diCG6/FCE4CQmh/5jtJ/xj+5u/FO+zv3i2Vqhw6NESZ5Qk0QHrWRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949083; c=relaxed/simple;
	bh=L9w14qBQHX9irezWpEOPNo2UEv2JyimGlJsSHltkP0g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qvu6g3J4NsFhF9ZfQK63zkLWRVoC8TuTkI23F6hjFKJkvkRQRKpgT1dAGSJBevZUwzwuL961gWnNEoc7BV6eioClgQZe/5wcHNgLMGou/xizsr0SFUT5MvTRNU5FU5sC77Wy4Xno35pW6m034D9mCni8NtlRPtBi8PGcXM/OZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyaXo/qb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyaXo/qb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B6DC4CEF1;
	Mon, 15 Sep 2025 15:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757949083;
	bh=L9w14qBQHX9irezWpEOPNo2UEv2JyimGlJsSHltkP0g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XyaXo/qbx36J4JDfFzUKZ1oAsT6qyk2g1Fu8yDMlJf19GsV0igB2XCAhKT5X2YFbm
	 kN66LdWA6K88IrpVchU46WYliwEU4SlRmN6oQUKVox7MNJlSOD2UIWNylirQl/Retg
	 AkWC76B4dFLHvQ24HzeLBA/K5p9tkoqu4obC4jMqY/jjiaV1WKEDpa2v3/d1DEyOwr
	 7dODSZtmJ5tCPEGTLPl3WUDqjmn4UHxDvSqHis1XTChiCKqWT8eI6FMfhqVJs75S9q
	 B0yJquwnzPIVYqB1yY1xiRW4C5hZheJrx12K4b4dLf+1KHqyToSlIh0N4ezejbens6
	 l09eG2WelfKpQ==
Message-ID: <4639f5c311f6db8efe620bd9c7eae56dc15c5f8d.camel@kernel.org>
Subject: Re: [PATCH 4/5] Documentation: trace: histogram-design: Wrap
 introductory note in note:: directive
From: Tom Zanussi <zanussi@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>,  Linux Kernel Tracing
 <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>
Date: Mon, 15 Sep 2025 10:11:21 -0500
In-Reply-To: <20250911042527.22573-5-bagasdotme@gmail.com>
References: <20250911042527.22573-1-bagasdotme@gmail.com>
	 <20250911042527.22573-5-bagasdotme@gmail.com>
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
> Use Sphinx note:: directive for the introductory note at the
> beginning
> of docs, instead of aligned-text paragraph that renders as definition
> list.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

>=20
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> =C2=A0Documentation/trace/histogram-design.rst | 9 +++++----
> =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/trace/histogram-design.rst
> b/Documentation/trace/histogram-design.rst
> index 4faff1669b77bd..ae71b5bf97c6c7 100644
> --- a/Documentation/trace/histogram-design.rst
> +++ b/Documentation/trace/histogram-design.rst
> @@ -11,13 +11,14 @@ histograms work and how the individual pieces map
> to the data
> =C2=A0structures used to implement them in trace_events_hist.c and
> =C2=A0tracing_map.c.
> =C2=A0
> -Note: All the ftrace histogram command examples assume the working
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 directory is the ftrace /tracing director=
y. For example::
> +.. note::
> +=C2=A0=C2=A0 All the ftrace histogram command examples assume the workin=
g
> +=C2=A0=C2=A0 directory is the ftrace /tracing directory. For example::
> =C2=A0
> =C2=A0	# cd /sys/kernel/tracing
> =C2=A0
> -Also, the histogram output displayed for those commands will be
> -generally be truncated - only enough to make the point is displayed.
> +=C2=A0=C2=A0 Also, the histogram output displayed for those commands wil=
l be
> +=C2=A0=C2=A0 generally be truncated - only enough to make the point is
> displayed.
> =C2=A0
> =C2=A0'hist_debug' trace event files
> =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

