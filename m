Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FB1282F31;
	Wed,  1 Apr 2026 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775058718; cv=none; b=YM6GyW5H9rzlwQ0B3uZnid5+eJrsdx2aa0Ja3vaGnO415aT2cPsnc3vZN+2yeRRd9jkavPmA78WhNWUeNBjJXscQJIdxIshade91b+883y3ux9ucLRj6mrvZOhFZSGcNi32hQHsN9N7815HgcuDCgjX/m3jShQxccOw1dMmm8wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775058718; c=relaxed/simple;
	bh=aOOaMvt1xtlVBCMcc4f9K3NLrHZY534eh4d5eAlAxeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhXjcNDtveRaU6bMSab2+KBsMBelm6Ha+kbeH/C8kcfzCKvsIyOVNYKFXjJdbvI8ARp2u0IURMklmUIBSL9h5BlvP5wcHp/22tZhnLHul2yi7yfQf7+8Ki7Vkj2Qj3TZO1nFniUtoLGQwde23ckh8MkjEFZ4MVNfMLvmZQUbwJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=KR7RaNHA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="KR7RaNHA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6As43NF5tE3RU0gTTtV1B7z9eZjIfwil3C7MyjZ4D00=; b=KR7RaNHAVe2POIB/SXyQo3L+Mf
	Q1zkAa41t+UC8GWgRkdkss9/sU426qRBMwQ4aPGYOJMBjb31a4JzfZrNfsSrhEWDb0rZreCWigWVR
	z6lRfHf1YlrAEHBWVVTm4cvV7ZpPAV9fANj3NKyDL+3k5nJo5qYw5KMkXUVT+6qRppzDLmG0GD+wo
	DfmJifSVcNmhZ1AjsQg1I0wE06YqR317JO8qMRZ6HvbOapU2pKXQ6CbfnipTN7qGqTDtmqYyLEAfb
	sLMtaflZUggV06LDJqiAP/tAnFPvqU8i4+tUQyuG7UedITf74DhC2AOjmHbPXYmmv9sLbNZlTAONR
	oUQenI7A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1w7xrG-0035qf-05;
	Wed, 01 Apr 2026 15:51:52 +0000
Date: Wed, 1 Apr 2026 08:51:48 -0700
From: Breno Leitao <leitao@debian.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: Skip printing early params to cmdline from
 bootconfig
Message-ID: <ac0-rrQk8BoS9B5k@gmail.com>
References: <177505217508.1807250.22866077077504564.stgit@mhiramat.tok.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177505217508.1807250.22866077077504564.stgit@mhiramat.tok.corp.google.com>
X-Debian-User: leitao

On Wed, Apr 01, 2026 at 11:02:55PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> If user configures `kernel.key` in bootconfig, the 'key' is shown
> in kernel cmdline (/proc/cmdline) and kernel boot parameter
> handler associated with 'key' is invoked. However, since the
> bootconfig does not support the parameter defined with early_param,
> those keys are shown in '/proc/cmdline' but not handled by kernel.
> 
> This could easily mislead users who expected to be able to specify
> early parameters via the boot configuration, leading them to wonder
> why it doesn't work.
> 
> Let's skip printing out early params to cmdline buffer, and warn
> if there is such parameters in bootconfig.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

> +static bool __init is_early_param(const char *param)
> +{
> +	const struct obs_kernel_param *p;
> +
> +	for (p = __setup_start; p < __setup_end; p++) {
> +		if (p->early && parameq(param, p->str))
> +			return true;
> +	}

nit: I don't think you need the parenthesis ({) for the ifs in here.
