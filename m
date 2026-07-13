Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84532DCBFA;
	Mon, 13 Jul 2026 02:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783909424; cv=none; b=riPUApzjGEqYWkaez07aT+3XryezAZqK/AiuC9+0UQ9Om5J0KSOjtfEEghUIW2ZySHmphr3b1Gj7uqBKEwaBnNIjQ6YEg515LrWbm994WaTvK4ViKVGeubeZfl7iqo9EuCvGrncZ/GCuKDd032RuBfyGw4+bhyRdxTpmm2OdF9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783909424; c=relaxed/simple;
	bh=0Kgf1jJcIt508dtCuvpigFXWV6I0l7lB10NjWYghx1g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mlggSTx3d+GRihhY/84EIKNXxz7FxLj65io4WKkA5YPmiXWBq3ceDWu5o5sSnFdViUji8BjPNUiu+wi0swYX4ykYdNr/hm4yzuajOM+1IDbtttkywcsJe5bsx45lTAze12H9HRah6tXHIdsAGukBaoX3wniiUuJhwt0goT34wK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRw8BHsn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRw8BHsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF641F000E9;
	Mon, 13 Jul 2026 02:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783909423;
	bh=BGhG09SfW0RSxk7AO+LhxlfLYlMpwaSEDKb7395tk9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SRw8BHsnxh0e9hm/A3ie7slBxUMVyxdscpfY9/XOYWjmG5R480v9tm0KEL4tYUJ3s
	 y7wbn18yntmzE1KupuHl+PeGozb9aqPyablN8GAx5+SnEZScqNsGPTBlmVHAmje69a
	 6UVLmCsPpCgRiUiH78fS3NC36wsQ0Pgs7e/bSTRm1Tn8TpKohmKk+nCQYbk6vkB0By
	 ornZvpnSK+2tMaJ2JJZKNvPX3QWgP1n9eNmwuoq7AVpOF5pZFLcTuv/nYcr17OinPs
	 Qj4ZXqWfFAGs7Xue39PRCgXRHrMMo05j4xRyKh3NvZasoiDP9rgiPuuovqZcty6NRP
	 cBkacJL3nXhAA==
Date: Mon, 13 Jul 2026 11:23:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Markus Schneider-Pargmann" <msp@baylibre.com>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: fprobe: Remove __packed from generic
 __fprobe_header
Message-Id: <20260713112339.53ed390e1c6f18b2fb1cd901@kernel.org>
In-Reply-To: <DJU105LESLBJ.1O3UZRY325T2M@baylibre.com>
References: <20260428-topic-fprobe-packed-v7-1-v1-1-9abc9b866b4c@baylibre.com>
	<20260610171740.c30c43c5faee0beac3ad7546@kernel.org>
	<DJ59B5LEGPER.3UURGUC8IW7E2@baylibre.com>
	<20260622135659.ff84ef3b831a464b802d7c33@kernel.org>
	<DJU105LESLBJ.1O3UZRY325T2M@baylibre.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 09 Jul 2026 14:06:32 +0200
"Markus Schneider-Pargmann" <msp@baylibre.com> wrote:

> Hi Masami,
> 
> On Mon Jun 22, 2026 at 6:56 AM CEST, Masami Hiramatsu wrote:
> > On Wed, 10 Jun 2026 11:20:24 +0200
> > "Markus Schneider-Pargmann" <msp@baylibre.com> wrote:
> >
> >> Hi Masami,
> >> 
> >> On Wed Jun 10, 2026 at 10:17 AM CEST, Masami Hiramatsu wrote:
> >> > Hi Markus,
> >> >
> >> > Thanks for ping me.
> >> >
> >> > On Tue, 28 Apr 2026 10:30:29 +0200
> >> > "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com> wrote:
> >> >
> >> >> fp pointer and unsigned long have the same size on all relevant
> >> >> architectures that build Linux. Furthermore this struct is only used in
> >> >> architectures that do not set ARCH_DEFINE_ENCODE_FPROBE_HEADER which is
> >> >> set only for 64bit architectures (apart from LoongArch).
> >> >> 
> >> >> Both fields are aligned on these architectures so the struct with
> >> >> __packed and without it are the same.
> >> >> 
> >> >> Remove the __packed as it is unnecessary.
> >> >> 
> >> >> Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> >> >
> >> > NOTE: This is not a Fix, but just cleanup or minor update. Or, you have
> >> > any problem with this __packed attribute?
> >> 
> >> Thanks, yes it is not fixing a bug, I can remove this.
> >> 
> >> >
> >> > Unless there is no problem (or any concern), I would like to keep this
> >> > as it is.
> >> 
> >> There is currently no problem with __packed in the upstream kernel. I
> >> just thought this would be a good cleanup to remove the unnecessary
> >> attribute. I am working on CHERI architectures where pointers have
> >> capabilities. __packed breaks these capability tags and therefore
> >> doesn't work on CHERI. When looking into why this struct has a __packed
> >> attribute I didn't see a reason, so I thought this would be a good patch
> >> for upstream as well even though CHERI is not yet relevant for upstream
> >> linux.
> >
> > Hi Markus,
> >
> > Ah, OK. CHERI makes pointers to non-long value. Are you sure
> > removing __packed makes fprobe working with CHERI? If so,
> > please describe it. Then I can pick it.
> 
> Sorry for the late response.
> 
> No, this patch alone doesn't make fprobe work with CHERI. __packed is
> problematic for CHERI because it sets the alignment to 1 which forces
> the compiler to do unaligned access operations even if the
> struct/pointer is aligned. Unaligned operations do not keep the CHERI
> capabilities. Without __packed the compiler knows everything is aligned
> and can use aligned operations and keep the CHERI capabilities. CHERI
> hardware does not support unaligned pointer capability access.
> 
> On its own it doesn't help CHERI, there are more patches that are more
> CHERI specific that are needed for fprobe to work on CHERI. I just
> thought it would be a great standalone patch for upstream.

OK, anyway, I would like to pick your patch but without fixes tag.
It may make no differences, so should be treated as a cleanup patch.
Let me pick it to probes/for-next.

Thank you,

> 
> Best
> Markus


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
