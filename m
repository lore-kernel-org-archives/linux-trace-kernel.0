Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6DE4D37AF;
	Wed, 30 Sep 2026 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780400; cv=none; b=MtDyfM5myMcp7F8ZByhfpkIyGIbbqq9y7CrDCSO2yysPU4tAM1Q2YddhnhqKPOB1Wg3Wq2UA4dmrJIABFztKRKCiL3XYgiwVKjkj8iCBdC9L1HoKn48UdEmBAkQEugdI18mVQ7YG6zkytT6lpew6XmR0Dcd1EUlWVimonrNxizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780400; c=relaxed/simple;
	bh=JTUPf9XUBQzKO2vXNalRlaadYfBmThAibCe4wKL4h48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k/3riQerJgomW53qL9JfWAfn8zPZ7viBFg/3OiOfISfsGS76zT9Z3GWA9priXpxLHVkmj0nx5sZZmzS+sOUpl9CXveecy8uZrL2g3WoJWhpvXxOtmu4leh7mtFD636BEPJ+EUqbwvvPEYVAdKovAMKf6OuBwFJL6ir2coo8fSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ky61y9Fh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky61y9Fh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9A31F000FF;
	Wed, 30 Sep 2026 14:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780390;
	bh=xTsgCOUgpcwoweYlEXBqZqEPJsTNhzil9TzD6j4MR84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ky61y9FhJozficDDtQ27h6+2+awEIdBy+hoBTkK0IvBQpe/czHvznRuIiIPiUwu2l
	 pFgaKZTIP+qmHOZlTROxgegpMG2K321wRgFw3dm7pPLa5FlBvoZa8JCnt8kp1InyxV
	 folsjNxEEzhBlpA92foeDz3mfIx944BWP4Fnn7N+fP4oljIPhM5qnnzds+8zH0CiXB
	 b5lMrboFE3lsqnxuUXEhtpUSTr//qXNSb/4RwtbPWvFGq3gZyCgQPZLYGb6RxM+CkC
	 i6OQUDKC8u+YSrhSxm4MpzJp4rH0nESgbcuaZDUQuONZRjZcpx7oiViUp52J+HXZb5
	 UWpK641Md6yZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: qcom: hawi: Add QPaCE DT node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Georgi Djakov" <georgi.djakov@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-trace-kernel@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260930145215.3380977-7-georgi.djakov@oss.qualcomm.com>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-7-georgi.djakov@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:59:49 +0000
Message-Id: <20260930145950.6D9A31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arm64: dts: qcom: qpace interrupt index mismatch
--

commit d697c8786fb69e9e9786a688577373ec76f73ba9
Author: Georgi Djakov <georgi.djakov@oss.qualcomm.com>

arm64: dts: qcom: hawi: Add QPaCE DT node

Add the device-tree node for the Qualcomm Page Compression Engine on
the Hawi platform.

> diff --git a/arch/arm64/boot/dts/qcom/hawi.dtsi b/arch/arm64/boot/dts/qco=
m/hawi.dtsi
> index 6b0a0ff0faa45..283a5acfa0738 100644
> --- a/arch/arm64/boot/dts/qcom/hawi.dtsi
> +++ b/arch/arm64/boot/dts/qcom/hawi.dtsi
> @@ -5677,6 +5677,23 @@ llclpi_noc: interconnect@31310000 {
>  			qcom,bcm-voters =3D <&apps_bcm_voter>;
>  		};
> =20
> +		qpace: compression@31400000 {
> +			compatible =3D "qcom,hawi-qpace";
> +			reg =3D <0x0 0x31400000 0x0 0x80000>;
> +			iommus =3D <&apps_smmu 0x1c20 0x13>,
> +				 <&apps_smmu 0x1c24 0x13>,
> +				 <&apps_smmu 0x1c28 0x13>,
> +				 <&apps_smmu 0x1c2c 0x13>;
> +			dma-coherent;
> +			interconnects =3D <&gem_noc MASTER_QPACE QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> +			interconnect-names =3D "qpace-mem";
> +			interrupts =3D <GIC_ESPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_ESPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "ring-and-bus-err",
> +					  "urgent";

[Severity: Medium]
Will this interrupt mapping cause an IRQ storm?

Looking at drivers/soc/qcom/qpace.c in qpace_register_interrupts(), the
driver fetches the urgent interrupt by index 0 (QPACE_IRQ_URGENT =3D 0):

enum qpace_interrupts {
	QPACE_IRQ_URGENT
};

static int qpace_register_interrupts(struct platform_device *pdev)
{
	...
	irq =3D platform_get_irq(pdev, QPACE_IRQ_URGENT);

However, this device tree node places the urgent interrupt at index 1.

This would cause the driver to bind its urgent interrupt handler to the
ring-and-bus-err interrupt instead.

When an urgent completion IRQ fires (ESPI 71), it will be unhandled,
eventually causing an IRQ storm that the kernel must forcibly disable.
Meanwhile, error interrupts (ESPI 72) will incorrectly trigger the urgent
handler.

> +		};
> +
>  		system-cache-controller@31800000 {
>  			compatible =3D "qcom,hawi-llcc";
>  			reg =3D <0x0 0x31800000 0x0 0x200000>,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930145215.3380=
977-1-georgi.djakov@oss.qualcomm.com?part=3D6
