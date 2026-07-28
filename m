Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9F3BE16E;
	Tue, 28 Jul 2026 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262044; cv=none; b=l2bzTXOIYoDJRutYs+tGfiCwbw75Pp+IveIiV7xMKtIsgeTYvlEGjqGG785iZtYgu3WieEenSOgfP2kK6THvveN6JieP1uTSqUuQ5o1jhzHz1wObk4fZ6t+bvgEafUj8HTyl71AbTLK+uc8XedJo+eAeV9BT4E9e5TRJpaK5TzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262044; c=relaxed/simple;
	bh=W0iB4+AT1cPCKQg6Rp/xWTfVfmE+6q4ImU4tigbv/uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftMt4SEG/i0g6JA+gNmJl7oFx6lKkflmzzxwfnwgpaX9DbnqQ96Hyj6KuShxoijnUkV9MCwU532GNDsKPvhafz0P0i96FsgaKTa4nwP69kwF+ymBYiXeOLw/DimwmW9ia9AReGpHZyBx5kOSnyh9bJS9t8oPbFX6WEmPn16RGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeB992mk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeB992mk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33D31F000E9;
	Tue, 28 Jul 2026 18:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785262043;
	bh=W0iB4+AT1cPCKQg6Rp/xWTfVfmE+6q4ImU4tigbv/uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AeB992mktcBaBtCfEPdb3yObg95xcLx+i4xHjC0hZHWMYAnqEgKRDToZF5mxrIpTd
	 KhnhU+vISSsWF951twN+uJ/EuL4jCh4KfDnL3/Ji9Rkcf8kRNbmImM60AbfhgfL5cv
	 BPsawIHVgqp8ZFM4+DZNZ0BulwzPR7qUtbAvOinu774a0abwMa86B1mwkSw9OJGrI2
	 Oc96OChCAyYQ6Cdob9n8GeokNFuMWK9P7x+q2zhBk5Qml8JYWYnfnuWyJLYiZv3D1N
	 SE97zNMpIWLeL6MnXnUBzfWDoQleEOylVroZaW/kH3pxovAhavM/i4lhKmkuqCDIfh
	 P771GmeXlr58g==
Date: Tue, 28 Jul 2026 19:07:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: add GENI SE registers trace event
 on error paths
Message-ID: <97815304-6952-4db4-8bb3-111e04b9e0b5@sirena.org.uk>
References: <20260715-add-tracepoints-for-se-reg-dump-v3-0-0f787f93badd@oss.qualcomm.com>
 <20260715-add-tracepoints-for-se-reg-dump-v3-2-0f787f93badd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0/r9wjd+OZ4HyyO2"
Content-Disposition: inline
In-Reply-To: <20260715-add-tracepoints-for-se-reg-dump-v3-2-0f787f93badd@oss.qualcomm.com>
X-Cookie: Stop me, before I kill again!


--0/r9wjd+OZ4HyyO2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2026 at 10:50:48AM +0530, Praveen Talari wrote:
> The GENI SPI driver reports various transfer failures such as command
> timeouts, DMA reset timeouts, DMA transaction errors, and unexpected
> interrupt conditions. However, diagnosing the root cause of these
> failures is difficult as the hardware state is not captured when the
> error occurs.

This breaks at least an x86_64 allmodconfig build:

ERROR: modpost: "__tracepoint_geni_se_regs" [drivers/spi/spi-geni-qcom.ko] undefined!
ERROR: modpost: "__SCT__tp_func_geni_se_regs" [drivers/spi/spi-geni-qcom.ko] undefined!
ERROR: modpost: "__SCK__tp_func_geni_se_regs" [drivers/spi/spi-geni-qcom.ko] undefined!

--0/r9wjd+OZ4HyyO2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpo79UACgkQJNaLcl1U
h9BSqAf+M/DbYeVQ4i/5qnKWuxushz2kAEpeZtoUYXJOlCfvA5eWPxn9NWR4OPOS
yHKNeUaBP3aDbNJNXLRwxyMw648J+UjAmCLQhDBQ+evb1sLFeHAFyVzH2ai6FIW9
QM3x2bmknBwuVop+EXbTSwAiblJAqDbosoSQhmOY50WN6rUtC3ZTauPWWtOecUE8
V1bTzdRVCI/VkKSBhtFZcmXWJU/4PjYZQ4LgTQBhSIU8X7ybOt2N/aFhBv/A5RSn
Ax/1InibDPqfWUjiK2WnsL8utwpOKdyhsHwIrv6qipp5KQlgurgyu/BJhctCUpvu
JSe/aUF1CMWy7dpq0DVGNxfV3xaY0A==
=sfnX
-----END PGP SIGNATURE-----

--0/r9wjd+OZ4HyyO2--
