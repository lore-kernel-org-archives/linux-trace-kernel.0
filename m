Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902893;
	b=VByJuTIcX+2AhVkT2fPhRjcX8yELFdCA8nGOmDJubr+enhUcXQH7r0tp6a7g3Q2XEJ73
	 qcOOfsgF2hJL9I6zvz7//6ZK+dOVa7GCQuSSKM7zueku+JLb2RM5jPzdvDAeC5yDZOmUv
	 CDgJkZDmhrwfdwOWppuSILjb0T8OnRmynuPebkgzW8gu9H/AbJ1c07iUleA0aEVILOYrL
	 fUjH+YfGZn4cR2/2WBW6lmpbUEPGyqwKTfGz+qP9hpADSGekrWkbdys80sv+9xp+Xl8va
	 ij5ryjGgaoImTNhI8UNSgqSKXXWanfp8vK4fC8Tzbf+StDKW3Na+e3v3ivKtSzEyR7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902893;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TXMrn0Nhf1gVgM+Vdy2JEVC1Ty4VVT17ko2f+5K+seo=;
	b=S19G1hu8n83P2JDJAtgrMY4xSLYeOGMWTGnIetvnRJcqiQSNfdDUbIBzqW+N1G5FZJ9k
	 xRRVacrZuVyzSpCAlGsWJhQZ4oG53HUYgcoTrfrzLPZXCqWreuJNeO9lkpYbTXKJmdtxV
	 wgfcvoV5HxoQosz5zWYbJWUGJfeZjCA7RUmfR2tWHpi59isB/Oj/vtck+NqfOpDimt/TN
	 rTxl8lwxkrSSZi4rT8QbdGFCDzC6jfiOB2G4uu3EeQzSjRSKGRpqoB7EJCdh6WTvtiz8x
	 jSZr28a8332v7h9urKFWKedq2ox2oiX2/4oZ0hzArQat/up9tkd/cLn+JHupybsjYPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dl4HhBuE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED52606A330
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dl4HhBuE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7521F00A17;
	Thu,  5 Nov 2026 18:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793902893;
	bh=TXMrn0Nhf1gVgM+Vdy2JEVC1Ty4VVT17ko2f+5K+seo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dl4HhBuEbOkmcuRGCtECoEE4RvzyRx9oRt6EzcQdWwZaIyW8ltBEoN9u56+D3gQTb
	 EHJuSKPVDtYQ3yFiuqtDYYtY931qArf87sECHh3jt3bkk/yqCAST91g3YnUr9d9SGZ
	 YI3+bsSZK2fYr+ysP5Qk7hFTK+BGXNTyphuiibBpxR/SAy/FB2UlcLv6fSCgmwyvNw
	 Yi9C3APn8tFj74ont6/zn9PwrfD1+Ac9+fCaBFTe44bIzqABqAvJKYLznylWma9P5x
	 qzyUioOMeyZfmEl5vULial4T1yFhgcbJ8UohphRdWWa8lwIe2ryCIcKAWYgh1a23jm
	 2CLlcKKUqWwxg==
Message-ID: <sashiko-outbox-199740@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 14/14] i2c: designware: add support for
 I2C_XFER_V2 - detailed fault reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Guzman" <Dmitry.Guzman@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261105-i2c-fault-reporting-v3-14-515ad74ac4c9@mobileye.com>
References: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
 <20261105-i2c-fault-reporting-v3-14-515ad74ac4c9@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:21:32 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] i2c: designware: stale rx_buf_len used in i2c_dw_fault_report()
- [High] i2c: designware: stale msgs_cplt across retries in i2c_dw_fault_re=
port()
- [Medium] i2c: designware: missing outer loop break on abort in i2c_dw_xfe=
r_msg()
- [Medium] i2c: designware: unread DW_IC_TXFLR on early stop in __i2c_dw_xf=
er_one_part()
- [Low] i2c: designware: unaddressed v2 review feedback on style and loop i=
ndex type
--

commit 99b998b5107033a19225ae77e0693b6c68191b43
Author: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

i2c: designware: add support for I2C_XFER_V2 - detailed fault reporting

This commit adds i2c_dw_xfer_v2() and fault reporting support to the
DesignWare I2C master driver using the ABORT_SOURCE FLUSH_CNT field,
TXFLR register, and per-byte abort checks in the FIFO read and write
loops.

> diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/bus=
ses/i2c-designware-master.c
> index 14350c53a5241..c7efb8551aa30 100644
> --- a/drivers/i2c/busses/i2c-designware-master.c
> +++ b/drivers/i2c/busses/i2c-designware-master.c
> @@ -11,6 +11,7 @@
> =20
>  #define DEFAULT_SYMBOL_NAMESPACE	"I2C_DW"
> =20
> +#include <linux/bitfield.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
> @@ -33,6 +34,14 @@
>  #define AMD_TIMEOUT_MAX_US	250
>  #define AMD_MASTERCFG_MASK	GENMASK(15, 0)
> =20
> +static bool i2c_dw_check_abort_flag(struct dw_i2c_dev *dev)
> +{
> +	u32 stat;
> +
> +	regmap_read(dev->map, DW_IC_RAW_INTR_STAT, &stat);
> +	return (!!(stat & DW_IC_INTR_TX_ABRT));
> +}
> +
>  static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
>  {
>  	unsigned int comp_param1;
> @@ -198,6 +207,8 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
> =20
>  	i2c_dw_set_mode(dev, DW_IC_MASTER);
> =20
> +	dev->rx_buf_len =3D 0;
> +
>  	/* If the slave address is ten bit address, enable 10BITADDR */
>  	if (msgs[dev->msg_write_idx].flags & I2C_M_TEN) {
>  		ic_con =3D DW_IC_CON_10BITADDR_MASTER;
> @@ -459,6 +470,21 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
>  					     cmd | *buf++);
>  			}
>  			tx_limit--; buf_len--;
> +
> +			/* If precise fault reporting is required, check if the transfer
> +			 * is aborted after writing each byte.
> +			 * Otherwise, if it is aborted during filling FIFO, there is no way
> +			 * to know how many bytes was written to FIFO after transfer abort
> +			 * and thus are not counted in FLUSH_CNT.
> +			 * If we are checking abort flag after each byte, we can lose only 1 =
byte.
> +			 */
> +			if (dev->need_precise_report) {
> +				if (i2c_dw_check_abort_flag(dev)) {
> +					dev_warn_ratelimited(dev->dev, "Transfer aborted during FIFO writin=
g. Report may be imprecise.");
> +					break;
> +				}
> +				dev->bytes_written++;
> +			}
>  		}

[Severity: Medium]
In i2c_dw_xfer_msg(), buf_len is decremented before checking
i2c_dw_check_abort_flag(dev), and the break only exits the inner while
loop:

	tx_limit--; buf_len--;
	if (dev->need_precise_report) {
		if (i2c_dw_check_abort_flag(dev)) {
			...
			break;
		}
		dev->bytes_written++;
	}

After the inner while loop, the outer loop over dev->msg_write_idx only
breaks when flags & I2C_M_RECV_LEN or buf_len > 0:

	if (flags & I2C_M_RECV_LEN) {
		dev->status |=3D STATUS_WRITE_IN_PROGRESS;
		intr_mask &=3D ~DW_IC_INTR_TX_EMPTY;
		break;
	} else if (buf_len > 0) {
		/* more bytes to be written */
		dev->status |=3D STATUS_WRITE_IN_PROGRESS;
		break;
	} else
		dev->status &=3D ~STATUS_WRITE_IN_PROGRESS;

If the abort flag is detected while writing the final byte of a message
(where buf_len was 1 and has just been decremented to 0), won't buf_len > 0
be false, causing the outer for loop to clear STATUS_WRITE_IN_PROGRESS,
advance dev->msg_write_idx, and continue writing subsequent messages into
DW_IC_DATA_CMD after the abort?

[ ... ]

> @@ -784,6 +819,8 @@ __i2c_dw_xfer_one_part(struct dw_i2c_dev *dev, struct=
 i2c_msg *msgs, size_t num)
>  	dev->status =3D 0;
>  	dev->abort_source =3D 0;
>  	dev->rx_outstanding =3D 0;
> +	dev->bytes_written =3D 0;
> +	dev->tx_flushed =3D 0;
> =20
>  	ret =3D i2c_dw_wait_bus_not_busy(dev);
>  	if (ret < 0)
> @@ -795,6 +832,9 @@ __i2c_dw_xfer_one_part(struct dw_i2c_dev *dev, struct=
 i2c_msg *msgs, size_t num)
>  	/* Wait for tx to complete */
>  	ret =3D i2c_dw_wait_transfer(dev);
>  	if (ret) {
> +		if (dev->need_precise_report)
> +			regmap_read(dev->map, DW_IC_TXFLR, &dev->tx_flushed);
> +
>  		dev_err(dev->dev, "controller timed out\n");
>  		/* i2c_dw_init() implicitly disables the adapter */
>  		i2c_recover_bus(&dev->adapter);

[Severity: Medium]
As reported by Sashiko on v2 [1], __i2c_dw_xfer_one_part() only reads
DW_IC_TXFLR into dev->tx_flushed when i2c_dw_wait_transfer() times out, and
i2c_dw_fault_report() only reads FLUSH_CNT when dev->abort_source is
non-zero.

However, __i2c_dw_xfer_one_part() can also fail with -EIO without a timeout
or TX_ABRT when i2c_dw_process_transfer() detects a spurious STOP
mid-transfer (setting dev->msg_err =3D -EIO) or when dev->status remains
non-zero on early termination:

	if (dev->msg_err)
		return dev->msg_err;
	...
	if (dev->status)
		dev_err(dev->dev,
			"transfer terminated early - interrupt latency too high?\n");

	return -EIO;

In addition, in i2c_dw_process_transfer(), if DW_IC_INTR_TX_EMPTY and
DW_IC_INTR_STOP_DET are both set in stat, i2c_dw_xfer_msg() refills the TX
FIFO and increments dev->bytes_written before the spurious STOP check sets
dev->msg_err =3D -EIO. Because __i2c_dw_xfer_one_part() then disables or
reinitializes the controller before returning, the hardware FIFO is flushed
while both dev->abort_source and dev->tx_flushed remain 0.

When i2c_dw_fault_report() runs for these -EIO errors, won't unsent bytes
still sitting in the TX FIFO be counted as transmitted on the wire?

> @@ -886,13 +926,72 @@ i2c_dw_msg_is_valid(struct dw_i2c_dev *dev, const s=
truct i2c_msg *msgs, size_t i
>  	return true;
>  }
> =20
> +static int i2c_dw_fault_report(struct dw_i2c_dev *dev, struct i2c_transf=
er_report *report)
> +{
> +	unsigned int idx;
> +
> +	/*
> +	 * Get the number of bytes that were put into TX FIFO but were not sent=
 on wire.
> +	 * If abort IRQ was received, this number is stored in abort_source reg=
ister.
> +	 * Otherwise, if ic_dw_wait_transfer() returned timeout, use TXFLR regi=
ster value
> +	 * read before the controller was reset.
> +	 */
> +	if (dev->abort_source)
> +		dev->tx_flushed =3D FIELD_GET(DW_IC_TX_ABRT_SOURCE_FLUSH_CNT_MASK, dev=
->abort_source);
> +
> +	if (dev->tx_flushed <=3D dev->bytes_written)
> +		dev->bytes_written -=3D dev->tx_flushed;
> +	else
> +		dev->bytes_written =3D 0;
> +
> +	/*
> +	 * The last byte that the transmission was interrupted on is not counte=
d as flushed.
> +	 * We should not report it as transferred successfully, so decrement th=
e counter.
> +	 */
> +	if (dev->bytes_written)
> +		dev->bytes_written--;
> +
> +	for (idx =3D 0; idx < dev->msg_write_idx; idx++) {
> +		if (dev->msgs[idx].len <=3D dev->bytes_written)
> +			dev->bytes_written -=3D dev->msgs[idx].len;
> +		else
> +			break;
> +	}
> +
> +	report->fault_msg_idx =3D idx;
> +	for (int i =3D dev->msg_read_idx; i <=3D idx && i < dev->msgs_num; i++)=
 {

[Severity: Low]
As reported by Andy Shevchenko on v2 [2], there are a few style and type
issues remaining from the previous revision:

1. In i2c_dw_fault_report(), idx was changed to unsigned int, but the loop
   counter i in for (int i =3D dev->msg_read_idx; i <=3D idx && i <
   dev->msgs_num; i++) is still a signed int compared against unsigned int
   idx.
2. In i2c_dw_check_abort_flag(), return (!!(stat & DW_IC_INTR_TX_ABRT));
   still uses redundant outer parentheses and double negation in a function
   returning bool.
3. In i2c_dw_xfer_msg(), the multi-line comment starting with "/* If
   precise fault reporting is required..." still places text on the opening
   /* line instead of starting with a separate /* line.

Could these be cleaned up to match the feedback from v2?

> +		if (dev->msgs[i].flags & I2C_M_RD) {
> +			report->msgs_cplt =3D i;
> +			if (!(dev->rx_buf_len))
> +				report->bytes_cplt =3D 0;
> +			else
> +				report->bytes_cplt =3D dev->rx_buf - dev->msgs[i].buf;

[Severity: High]
Can i2c_dw_fault_report() use a stale dev->rx_buf_len and dangling
dev->rx_buf pointer from an earlier transfer if i2c_dw_wait_bus_not_busy()
fails?

When an earlier I2C_M_RD transfer is interrupted in i2c_dw_read() while
len > 0, i2c_dw_read() saves dev->rx_buf_len =3D len and dev->rx_buf =3D buf
(pointing into that transfer's message buffer) and returns.

On the next transfer (or a subsequent part in a multi-part transfer),
__i2c_dw_xfer_one_part() calls i2c_dw_wait_bus_not_busy(dev) before calling
i2c_dw_xfer_init(dev), which is where dev->rx_buf_len =3D 0 was placed:

	ret =3D i2c_dw_wait_bus_not_busy(dev);
	if (ret < 0)
		return ret;

	/* Start the transfers */
	i2c_dw_xfer_init(dev);

If i2c_dw_wait_bus_not_busy(dev) returns a negative error,
__i2c_dw_xfer_one_part() returns early without calling i2c_dw_xfer_init().
i2c_dw_xfer_common_v2() then calls i2c_dw_fault_report(dev, report) with
idx =3D=3D 0 and dev->msg_read_idx =3D=3D 0. If the new transfer's msgs[0] =
has
I2C_M_RD set, dev->rx_buf_len is still non-zero from the previous failed
transfer, so i2c_dw_fault_report() computes:

	report->bytes_cplt =3D dev->rx_buf - dev->msgs[i].buf;

subtracting the current message's buffer address from the previous
transfer's freed dev->rx_buf pointer. In i2cdev_ioctl_rdwr_v2(),
msgs[msgs_done].len is then set to report.bytes_cplt and passed to
copy_to_user(), which can read out of bounds past msgs[0].buf. Should
dev->rx_buf_len =3D 0 be initialized at the start of __i2c_dw_xfer_one_part=
()
alongside dev->msg_read_idx and dev->bytes_written?

> +			if ((i < idx) || (report->bytes_cplt < dev->bytes_written))
> +				dev_warn_ratelimited(dev->dev, "Read data lost due to FIFO flush");
> +			break;
> +		}
> +	}
> +
> +	if (report->msgs_cplt < 0) {
> +		report->msgs_cplt =3D idx;
> +		report->bytes_cplt =3D dev->bytes_written;
> +	}
> +
> +	return idx;
> +}

[ ... ]

> @@ -937,16 +1048,34 @@ i2c_dw_xfer_common(struct dw_i2c_dev *dev, struct =
i2c_msg msgs[], int num)
> =20
>  	i2c_dw_release_lock(dev);
> =20
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (report) {
> +			i2c_dw_fault_report(dev, report);
> +			report->msgs_cplt +=3D msgs_in_prev_parts;
> +			report->fault_msg_idx +=3D msgs_in_prev_parts;
> +		}
>  		return ret;
> +	}

[Severity: High]
What happens to report->msgs_cplt and report->bytes_cplt when an attempt
fails with -EAGAIN (for example on DW_IC_TX_ARB_LOST) and __i2c_transfer_v2=
()
retries the transfer?

In __i2c_transfer_v2(), i2c_transfer_report_init(report) (which sets
report->msgs_cplt =3D -EOPNOTSUPP) is called only once before the retry loo=
p:

	if (report)
		i2c_transfer_report_init(report);
	...
	for (ret =3D 0, try =3D 0; try <=3D adap->retries; try++) {
		...
		if (report)
			ret =3D adap->algo->xfer_v2(adap, msgs, num, report);
		...
		if (ret !=3D -EAGAIN)
			break;
	}

On the first failed attempt returning -EAGAIN, i2c_dw_fault_report() sets
report->msgs_cplt to a non-negative index and sets report->bytes_cplt. When
__i2c_transfer_v2() calls i2c_dw_xfer_v2() again for the next try and that
attempt also fails, if there is no I2C_M_RD message in
[dev->msg_read_idx, idx], i2c_dw_fault_report() checks:

	if (report->msgs_cplt < 0) {
		report->msgs_cplt =3D idx;
		report->bytes_cplt =3D dev->bytes_written;
	}

Because report->msgs_cplt is already >=3D 0 from the earlier try, neither
report->msgs_cplt nor report->bytes_cplt is updated. Furthermore, if
msgs_in_prev_parts > 0, i2c_dw_xfer_common_v2() executes
report->msgs_cplt +=3D msgs_in_prev_parts on each failed retry, accumulating
msgs_in_prev_parts onto the stale report->msgs_cplt until it can exceed num.
Should report be reinitialized on entry to i2c_dw_xfer_common_v2() or
i2c_dw_fault_report()?

[1] https://lore.kernel.org/r/20260903-i2c-fault-reporting-v2-12-fedeb91792=
e6@mobileye.com
[2] https://lore.kernel.org/r/apkl_XHaZreKoipX@ashevche-desk.local

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-i2c-fault-=
reporting-v3-0-515ad74ac4c9@mobileye.com?part=3D14
