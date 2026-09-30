Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2E9501F59;
	Wed, 30 Sep 2026 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780423; cv=none; b=VPk+uAvimZ21P/VXJMF3TpZqBhsxx62cmdkFHoqcfCyu5VlSnlD12JttZjIjkuQeZ+1yfajZZCke9E9l8FfDwtfDq95HuFNot0/oXqUAQUChYjNZAl6VItoTYT+aO6UUXpb098+M+LyJiYuAZNSxVfqGKCCQePJW0RV7t+Yrj+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780423; c=relaxed/simple;
	bh=i3FRFkIaMW2llPHrmtfngpMqrlzbY/wiS9oasC+qKjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LCXX2lXupxCxIU+xUxsuoPm2RaZPIkjIAu/99j3vftRwqT0hf1NWcJMLOBb6oRJX+TC/c2C5RFs2EixaGWrgMmy0ZQxEAyvzuV7d2jIp+vgNDed6dYPsbsG41P0nIubq0Xncu8tgWFDkVzrJRUT4hwJkHGfeqYMo600h6hKvNdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mhr0Ouby; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mhr0Ouby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB591F000FF;
	Wed, 30 Sep 2026 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780406;
	bh=pq2I7oBfwwAN1pn1SjjN65O6paCASx3ibOzYNd1e/Ic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mhr0Ouby3Ui7UEo+VdMnXv3o8R+z95TdUwx4bwPYo/Ztmc5RvfVQZnbZ7wSi+sf5I
	 xUf5ONvbdjYWLdfsx6MidwamWeSFkpRLrB1x2gwKcwZ2DYhVQTST3VbZTj+yUS4CTn
	 WC9+NueI+jlQ3jLgSFQMCSFNmZhsZ1Je5NvF1qJ/pUYQlv9jQWvu8tQjR/jVMDjgeK
	 1Ya/ujg9t0/eNlTKqYqS/DrO25RS/h3r1axWTSXfcea1uodURnk2pUYxplHPCTlW9A
	 1nGE7vNFc+nFtoIPubiDpNOXeiweGp8XVjPoTDCSVl2pSrUUWBzeBtON85T/DgerRW
	 xPLOpI8oOpGVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] trace: qpace: Add tracepoints for QPaCE operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Georgi Djakov" <georgi.djakov@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-trace-kernel@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260930145215.3380977-4-georgi.djakov@oss.qualcomm.com>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-4-georgi.djakov@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:00:05 +0000
Message-Id: <20260930150006.4FB591F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] trace: unpaired end tracepoint in qpace_urgent_decompress() on e=
rror
- [Low] trace: qpace tracepoints violate subsystem_event naming convention
--

commit 95671997f765567ada636d922558170e766019a7
Author: Georgi Djakov <georgi.djakov@oss.qualcomm.com>

trace: qpace: Add tracepoints for QPaCE operations

Add ftrace tracepoints for the Qualcomm Page Compression Engine
to allow performance analysis and debugging of QPaCE hardware
operations.

> diff --git a/drivers/soc/qcom/qpace.c b/drivers/soc/qcom/qpace.c
> index 69aa14b7c4772..f5b21ffbcbff5 100644
> --- a/drivers/soc/qcom/qpace.c
> +++ b/drivers/soc/qcom/qpace.c

[ ... ]

> @@ -356,6 +362,9 @@ int qpace_urgent_decompress(dma_addr_t input_addr,
>  	if (ret)
>  		goto out;
> =20
> +	trace_start_qpace_urgent_decompress((u64)input_addr,
> +					    (u64)output_addr, input_size);
> +
>  	urg_reg_num =3D get_cpu() % NUM_TRS_ERS_URG_CMD_REGS;

[ ... ]

>  	ret =3D FIELD_GET(URG_CMD_0_ED_STAT_SIZE, stat_reg);
>  out:
> +	trace_end_qpace_urgent_decompress((u64)input_addr,
> +					  (u64)output_addr,
> +					  input_size, ret);
>  	return ret;
>  }

[Severity: Medium]
If qpace_get() fails at the beginning of qpace_urgent_decompress(), the code
jumps to the 'out' label, bypassing trace_start_qpace_urgent_decompress()
entirely.

Does this result in an unpaired end tracepoint being emitted unconditionall=
y?

> diff --git a/include/trace/events/qpace.h b/include/trace/events/qpace.h
> new file mode 100644
> index 0000000000000..3f0ccdb8f2060
> --- /dev/null
> +++ b/include/trace/events/qpace.h
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM qpace
> +
> +#if !defined(_TRACE_QPACE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_QPACE_H
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(start_qpace_urgent_decompress,

[Severity: Low]
Does this tracepoint name violate the mandatory subsystem_event naming
convention by using an action prefix instead of the subsystem prefix?

Could these be renamed to use the subsystem prefix, such as
qpace_start_urgent_decompress?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930145215.3380=
977-1-georgi.djakov@oss.qualcomm.com?part=3D3
