Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5D353EF7
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 05:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414964; cv=none; b=tq+H8m7u4eX9LnUUQleGvGG0FYbVOL/kzlDfnTT+A/NRvChcmS9s2Mpuuo3YnC6PCq4uCVlfuUbboWSDW36qcyDYwKj9WPL+hjhGNaOmKy/sqUE+vawCsMuGtYHayOtc6UdIJM+nXNAlxk1dYHzb0F/5yQ/kFl9TXQoM7EYyZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414964; c=relaxed/simple;
	bh=wbDX3j6djyb3+S+Bzw3jUi05kG4xsWYJfvU7zRum6Q8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ivfqG3k5QgxAxJr7l2dOUuH+YlMP81bdH8RnZbVAhGBUl7ZrrBx02bbgJIHpUOM4+3LhngQIDHaUG5mW2VdUZTVGcxa83e21XBdPFWx/0qPG4qGj/WZuj0ZqQw1dZEHyMiuRD7DR8ZIURCVtv6eQcHXLcxM8vJv330rfc61GM1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceQoLk8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceQoLk8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6342E1F00A3A;
	Thu,  3 Sep 2026 05:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788414963;
	bh=v2Oov7el+8SCD+rsWjKorutne3c6hokXfhfFX09jMOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ceQoLk8ZP1vd2buLkDbrXQbGe8uFv5UUO4dJ/oGP/I7Cvc2mTQqU/Ysz7NcWjuUcD
	 SBqgyIFTtr7CNp0icQz42efIKoyUX9BMdauR6ALy4tIGfrHtVngZnAQtKmzi7cMWMT
	 aUvAmqEiM+o7acvzZAj7etUYAT5p394CIPHHbXsN25vA7r6Gpp915fojVZ9GmdSykY
	 pDSH6X3gihm5g+il9bnZPXgkRLutIcXivmJo5bGaFCIEjgqLoe76sxtzMRiNOWSgE3
	 Edd+jQEff5J+MyWzSAdCZtxAr8OxoN3sQsI2ZPlpvV7es8jUEKExnLMnOF8csw0tw2
	 Pdl8AYGSLEcrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/12] i2c: designware: use separate `i2c_algorithm`
 for AMD_NAVI_GPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Guzman" <Dmitry.Guzman@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260903-i2c-fault-reporting-v2-11-fedeb91792e6@mobileye.com>
References: <20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com>
 <20260903-i2c-fault-reporting-v2-11-fedeb91792e6@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 05:56:03 +0000
Message-Id: <20260903055603.6342E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `amd_i2c_dw_xfer_quirk()` returns 0 on success instead of the numb=
er of successfully transferred messages, violating the I2C `master_xfer` al=
gorithm contract.
- [High] `amd_i2c_dw_xfer_quirk()` fails to read the RX FIFO for read messa=
ges that are not the final message in a transaction, leaving client buffers=
 uninitialized.
--

commit dd05c8cde6068b0c819673691fc4626bca60cd8f
Author: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

i2c: designware: use separate i2c_algorithm for AMD_NAVI_GPU

This commit creates a separate i2c_algorithm structure for the AMD_NAVI_GPU
variant instead of checking flags at runtime. The pointer to
amd_i2c_dw_xfer_quirk is placed directly in the new structure, and the
function signature is updated to match the master_xfer API.

> diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/bus=
ses/i2c-designware-master.c
> index 936b9150754e8..f029aa1eadbf8 100644
> --- a/drivers/i2c/busses/i2c-designware-master.c
> +++ b/drivers/i2c/busses/i2c-designware-master.c
[ ... ]
> @@ -291,8 +291,9 @@ static int i2c_dw_status(struct dw_i2c_dev *dev)
>   * Initiate and continue master read/write transaction with polling
>   * based transfer routine afterward write messages into the Tx buffer.
>   */
> -static int amd_i2c_dw_xfer_quirk(struct dw_i2c_dev *dev, struct i2c_msg =
*msgs, int num_msgs)
> +int amd_i2c_dw_xfer_quirk(struct i2c_adapter *adap, struct i2c_msg *msgs=
, int num_msgs)
>  {
> +	struct dw_i2c_dev *dev =3D i2c_get_adapdata(adap);
>  	int msg_wrt_idx, msg_itr_lmt, buf_len, data_idx;
>  	int cmd =3D 0, status;
>  	u8 *tx_buf;

[Severity: High]
This isn't a bug introduced by this patch, but looking at the RX FIFO
draining loop later in this function:

				if (cmd) {
					regmap_write(dev->map, DW_IC_TX_TL, 2 * (buf_len - 1));
					regmap_write(dev->map, DW_IC_RX_TL, 2 * (buf_len - 1));

Does this code fail to read the RX FIFO for read messages that are not the
final message in a transaction?

When processing a read message that is not the final message, the cmd
variable remains 0. As a result, the if (cmd) block is entirely skipped,
bypassing the regmap_read loop that drains the FIFO.

Will this leave client buffers uninitialized for early read messages and
misalign the hardware RX FIFO for subsequent operations?

[Severity: High]
This is also a pre-existing issue, but looking at the success return path at
the end of this function:

		status =3D i2c_dw_check_stopbit(dev);
		if (status)
			return status;
	}

	return 0;

Does this code return 0 on success instead of the number of successfully
transferred messages?

Since the I2C master_xfer algorithm contract requires returning num_msgs on
success, I2C client drivers that check if (ret !=3D num_msgs) might treat t=
he
transfer as incomplete or failed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-i2c-fault-=
reporting-v2-0-fedeb91792e6@mobileye.com?part=3D11
