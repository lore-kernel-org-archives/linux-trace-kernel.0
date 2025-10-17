Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB0B3203A9;
	Fri, 17 Oct 2025 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732825; cv=none; b=sb6mlqorOf6GOE5NYXrgQCqlH+e5EjNByUelQgshzZiw1tGnS1sKBWx06VLm4+iGIR1zHPAEBn8PKa8D46ZE+I32OzVlvd4b30d8b9AqC2e8hyH2bU19C6nZ3L3bNDZ/L06JyWofDnecioQU3q3TCTEr8V+4lk/wppiKTXSymv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732825; c=relaxed/simple;
	bh=H1fx5Ow92ImRO7PmOhwMOL9clNPkHgCSG+bUCh3LLUI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pTlKYusJl3/IWNTMF2FdFF540A71KrNGluLlJtrHKHXGqLB+L9g9+x3v4cd3XutCglx5k4VbeB24gjrD9SlrYD78OInPGtY5L903vd6H+9akB56nCTviOVcsh52D3cvuUVyEDsVMO1pt9/qrVNL0XhmIEJx3cxHeCPJOF2BaH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DzYaIxZa; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DzYaIxZa"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 814E740B1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760732822; bh=H1fx5Ow92ImRO7PmOhwMOL9clNPkHgCSG+bUCh3LLUI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DzYaIxZa7md1iLrV3oBBZtKke92x6Ofxb7dguVi0Jg12p+Am0HU1Ehh8FYEfjHpr+
	 lrVwCkOgriznqLzmv4CeIKoiPfCsddfFKvLGQ57xeeYX+0LnAok/7K3qvEKA6JOtUq
	 o8asHa9E84nobacJI9VaxRD7nUSWHilReyWscZkJarWy4ilF8y4GNFh8cwVStmTTDF
	 jQRKTITuoZjKjomBTRWus15KZFy/bDhAWlIFUWCsOKkzOzUi5DFlO/9a0ASFJSA1MK
	 DCxWZLg51T8M2jse9llPvfSW2u6eeIrZn6z9mX00zSxxiyUDZGWU0GdTjFElM8CVdL
	 nyHvnaFwP1TbA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 814E740B1F;
	Fri, 17 Oct 2025 20:27:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Tracing
 <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
 Crystal Wood <crwood@redhat.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Gopi Krishna Menon <krishnagopi487@gmail.com>
Subject: Re: [PATCH] Documentation/rtla: rename common_xxx.rst files to
 common_xxx.txt
In-Reply-To: <20251013092719.30780-2-bagasdotme@gmail.com>
References: <20251013092719.30780-2-bagasdotme@gmail.com>
Date: Fri, 17 Oct 2025 14:27:01 -0600
Message-ID: <87zf9pz33e.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> From: Gopi Krishna Menon <krishnagopi487@gmail.com>
>
> Sphinx reports htmldocs errors:
>
> Documentation/tools/rtla/common_options.rst:58: ERROR: Undefined substitution referenced: "threshold".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "tool".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "thresharg".
> Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "tracer".
> Documentation/tools/rtla/common_options.rst:92: ERROR: Undefined substitution referenced: "tracer".
> Documentation/tools/rtla/common_options.rst:98: ERROR: Undefined substitution referenced: "actionsperf".
> Documentation/tools/rtla/common_options.rst:113: ERROR: Undefined substitution referenced: "tool".
>
> common_*.rst files are snippets that are intended to be included by rtla
> docs (rtla*.rst). common_options.rst in particular contains
> substitutions which depend on other common_* includes, so building it
> independently as reST source results in above errors.
>
> Rename all common_*.rst files to common_*.txt to prevent Sphinx from
> building these snippets as standalone reST source and update all include
> references accordingly.

Applied, thanks.

jon
