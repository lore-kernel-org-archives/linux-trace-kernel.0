Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F203A9DA5;
	Thu,  9 Apr 2026 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744680; cv=none; b=NqAUhTWQEZW1TdTeGuwuoWIjyoGAEN3+1oU+qZPnD2n9IleG/F4HpDI/rQrtcM0Z3Ygyl5JI7/4sj366hFQ6+x5dVmlw8QbWQ9IlZffQ2O61txphahSk49FupEICgq2G4d4d3ves8waoIPE03Sa5u+fSH053SFhw4ZSLtwmlFso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744680; c=relaxed/simple;
	bh=oSVaBGQFOwUJHWFcJSPRlvw3axFPX2a7KKThb4g3xfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lZJeYC/lwUGNNWilspyR1EA5qEVCcOTPCNkowxXUX5ccAo2d07ZBvCX2oUR3sMnme9VyB7dVxbLvrE8JS6uegKpJ9iu0vr0g2QClZGW8YhqvSHBgilWzuu05diiV7DRrRUo7pgU7STGPW+54AahX75stVlZZVxGYM41DxSEUOtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=gAzURvvc; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="gAzURvvc"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 20C5640B2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1775744675; bh=QeS1aPHYSidRL3WhDx7dePwakay0nQrlXyf8wc4nHb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gAzURvvcLhZqe0DwrkiFXcg6a7zQ5WF3azttw1l9eMbD0w/H6drQrU528JhDXo67W
	 XUeUwbU7Qijp+JGxdFTsImSokbYbImTgcdz6M0zRDX3XJgS+jlDJv+8b0u6rJot/x1
	 DiIxsaWXIjKTWkjQGZp8/utualWKWQV55Aymh0CI+jtwJELSMS33R21jolTZ3Gidso
	 GqEolJENHEvnlBL4quMMFDnwDroyBamAEch//at0RqQ0ZyTEgKtXL/+DIdDBzsZsdG
	 U8YSi3Ggt10VGgpNLt3fXwz8BepHRz9GEzjskua7UYwXmY7kRmPy1JYXqPeX0wztmf
	 prFhGoG/KojTQ==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 20C5640B2D;
	Thu,  9 Apr 2026 14:24:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Costa Shulyupin <costa.shul@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH v1] Documentation/rtla: Convert links to RST format
In-Reply-To: <20260405163847.3337981-1-costa.shul@redhat.com>
References: <20260405163847.3337981-1-costa.shul@redhat.com>
Date: Thu, 09 Apr 2026 08:24:34 -0600
Message-ID: <877bqgciu5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Costa Shulyupin <costa.shul@redhat.com> writes:

> Web links in the documentation are not properly displayed.
>
> In the man pages web links look like:
>   Osnoise tracer  documentation:  <  <https://www.kernel.org/doc/html/lat=
=E2=80=90
>   est/trace/osnoise-tracer.html> >
>
> On web pages the URL caption is the URL itself.
>
> Convert tracer documentation links to RST anonymous hyperlink format
> for better rendering. Use newer docs.kernel.org instead of
> www.kernel.org/doc/html/latest for brevity.
>
> After the change, the links in the man pages look like:
>   Osnoise tracer <https://docs.kernel.org/trace/osnoise-tracer.html>
>
> On web pages the captions are the titles of the links.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/tools/rtla/rtla-hwnoise.rst       | 2 +-
>  Documentation/tools/rtla/rtla-osnoise-hist.rst  | 2 +-
>  Documentation/tools/rtla/rtla-osnoise-top.rst   | 2 +-
>  Documentation/tools/rtla/rtla-osnoise.rst       | 2 +-
>  Documentation/tools/rtla/rtla-timerlat-hist.rst | 2 +-
>  Documentation/tools/rtla/rtla-timerlat-top.rst  | 2 +-
>  Documentation/tools/rtla/rtla-timerlat.rst      | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

jon
