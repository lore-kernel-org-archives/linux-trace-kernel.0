Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791831;
	b=kPXCX4dgY08GvbeQBBlqdAXNfF3AVjrGaffEHRLhgcQaQ4hhjE8fE1lDh6e87Lb7Mh2m
	 lLiXjC15QIY4zXcBdl86d8Bf82lTzM/gST9o66d9oXf9Ejc+unF5g2AJp2B38NRea8PlQ
	 M+Dx8MSu6RKJWQJTAoXoxCheLD0EK8KxXieKX3nNfp2XJPOJCrwojDWGwqFYv+SL52aX4
	 mIM5O/ToURsaxC1EMpSJkmRRTTDz5jYZOpNantsi40r2IPow9bhOUV/ykSUmXl213xWVi
	 F2CgZUOem5gkZtoaLC4Mw287+AZADsH2cGVAH1Mwat+kslMF+QMtK2xMG7cKLxF9UWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791831;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=HTsNEFdag3FLow13gNwrWPqr9RuSS6VGPBj7nBJXbBs=;
	b=ZprmEVf2v8K0RkAYi7LcIYjhLebk4UOQIgzBd3+Fr2LDP3THUx09sjEzpL+N6D50U/A2
	 DLmNhCMxvhpLmpj+PZfDAStbiFc7FAVMdqZWqrh/QrbUwlPAJ5sMdq9E6EVvMapm9N7t9
	 AIwwwPbvdeM1P+QjQ1smzGS20A72Q0BnLJDqBQ1unicqZwsoDg4UeFkP2TN/WgIXab5D1
	 ftlZWzMBRYdb/4P2gSTYlFxwryRYL39Nf/5akuPCPdeY0hIPFbcuL/5wnsm3rQP6muWZi
	 S0rhLXWNEBj/VPxoKfBlHbA8AClVql5TWz46Md/OC8A26YtZK8L2kon5oHQy+Z6HaOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AfXQ5I/n";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F6C606A31F;
	Fri, 27 Nov 2026 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfXQ5I/n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283F41F000C1;
	Fri, 27 Nov 2026 15:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791830;
	bh=HTsNEFdag3FLow13gNwrWPqr9RuSS6VGPBj7nBJXbBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AfXQ5I/ncWiUS+XG5a6ulZQQLbXKF9UOyn/8RazJyU2fzEiQ4HydxY3JSQhY4TJff
	 FbN11xcrwu7edOw7Htf9HdJTaQgpNqszcygI0dh65AT485sjpGcQy+e85Ms3ps+/3b
	 DqyrkFPIbE3pB6hVtk4kue5cNJTfWm8tIYqxhe6hXMJ/xVRnegq/bkpUqM9Tn6AMjG
	 UFtgoAopN9wh6AfTxC4paoeTrxA2T9sLBPXQTpRAd9LBKcFvH6Sn3Vf3Qz6KxusdpA
	 ehn8sp2OjFMK0kNQaL/Xfiw7reDTExIgn7VzpizK5aD3olmzW4CrQNWgyjU9bgO+e+
	 SO+pQ4xd/deyA==
Date: Fri, 27 Nov 2026 15:03:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Liang Yang <liang.yang@amlogic.com>, Feng Chen <feng.chen@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>, Han Xu <han.xu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Haibo Chen <haibo.chen@nxp.com>, Jyan Chou <jyanchou@realtek.com>,
	Yu-Chun Lin <eleanor.lin@realtek.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Michal Simek <michal.simek@amd.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org, imx@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH RFC v2 00/35] spi: spi-mem: Express the dummy phase using
 cycles when relevant
Message-ID: <d95e931f-0521-42db-85ac-a4d1fc4018fd@sirena.org.uk>
References: <20261127-macronix-upstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EKfE0NJTn63pxWNZ"
Content-Disposition: inline
In-Reply-To: <20261127-macronix-upstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com>
X-Cookie: Sank heaven for leetle curls.


--EKfE0NJTn63pxWNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 27, 2026 at 03:22:22PM +0100, Miquel Raynal wrote:

> ---
> base-commit: 19d1b4de6d37bccecc3ad9144d279f1baa405eb1
> change-id: 20261125-macronix-upstreaming-spi-mem-cycles-103274708fec
> prerequisite-message-id: <20261126-macronix-upstreaming-spi-driver-fixes-v1-0-ca8e924cca1b@bootlin.com>
> prerequisite-patch-id: 2f68de4139876dfa8e57afb65b429a69628214ab
> prerequisite-patch-id: 7182a6b4808193323664f79c226ae2a57104b473
> prerequisite-patch-id: 34a99e8e6644d1db0978b5aa6ca90342a42561f8
> prerequisite-patch-id: cc060f58179f09af4593df6909b958a29bf11cb2
> prerequisite-patch-id: c5a7a78ef01696c25c10b6d2968c0b65ab0f4ec6
> prerequisite-patch-id: 340ee3d69095259d6141c017ea59c0c137d353b5
> prerequisite-patch-id: 1629dd27a1f0b1d6622199cc7603dad4b17d29b6
> prerequisite-patch-id: 29bc9e59b1d732a00cd65ba1d73270e051898fd7
> prerequisite-patch-id: 7a028831f1df214099241bfac0dc290e2f799276
> prerequisite-patch-id: c28c78ff316ce2ac8c1b6151367662ca8039acd3
> prerequisite-patch-id: eea3b5adeb19b753a14bf03c5114eb407566c248
> prerequisite-patch-id: 87bd95813776fe216ac157f9fad23586c71db87b

Please do not stack serieses on top of of each other like this,
especially not enormous ones like this.  It makes it far too difficult
to track what is going on.

--EKfE0NJTn63pxWNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsJm8oACgkQJNaLcl1U
h9Dqkgf9E0bJ2UXkjbckVvjHc+7mjSLOnT6yLtoLsCIaplWfF3H7hanJ7Crja+w9
0NL1DSaqeHjHuahV3QcpGdIcxsNNFpHiqU/S/hCxVjPLmFGFaoBD79xppeSPeP0J
laUs2W3a2Z/DHt4/whYH6QyMKF3UbJe9uH1VjXixiGQ4ZEuXX1mzwUnQq9Oa650k
wu6xRgXl0C/Ts8LRbg4vwtf/AelEaDGshnkWfcszi/b0hgwIgcvYWo7XNdNcknb/
EU4JBHGO5mbrmR4P6t5ABa+wD4LeaUCFP2Trov9vSRC14lL0hh9X8TpKLt4/B6wF
OdsSR/Ry9PuwuhvrMT5bEtcLFpv27A==
=8Hf0
-----END PGP SIGNATURE-----

--EKfE0NJTn63pxWNZ--
