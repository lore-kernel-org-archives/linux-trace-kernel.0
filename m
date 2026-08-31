Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D4833F5B6;
	Mon, 31 Aug 2026 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203147; cv=none; b=HvX0UCyDuWzPvInpGcjB9IB7aq5NOB3/Z0vlQEZbiF5X3OFTG+a0nnRmimRP1VjDmD37GKqDYBiHJrHyTOZiNUS/dfUp4t4HkIAy1QJpkjYWJJUwoogY7pgvGHRlfgqJZ7X7j2vK6ZF1uXhdrxaH5OJLMC3Bk91nRxRcwQo2y6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203147; c=relaxed/simple;
	bh=Csthy57ktccSc+0KQm5MmKKsegOe8otP4rT6EneUY6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=clZKzvzcjuX4FI9TorO9hh6y9R21QJPeGaHwBnbtPvO2F/xBrYgEC0uMyNZhClmtpmRiPzhFGZFJw/9dxefPfBEkNcrJfwFFh9simCinoUbNfEHVyYSN1jMNiTAsymBn1RNyC6GHBW8oqPfeIasYYas5wxjNMzTp3UoVNef3Ib4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdaN+1y6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdaN+1y6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AC01F000E9;
	Mon, 31 Aug 2026 19:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788203146;
	bh=Csthy57ktccSc+0KQm5MmKKsegOe8otP4rT6EneUY6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WdaN+1y6JQeNL5e02wVeGr/0Dx99rQxuRa2y0tX5oqNEA5kPqYgB4zzNNjxUDnmq1
	 /41IORqEfbyPNY53YS5PrSqnB0nQxLs2TNSJ27oHELry2tUCfkPklZGXbrEoBrB1tf
	 A9MvgPwrmtGitbpK4ovY7OibTV+CioKqvKvJ3+FgXK2snceOfFgzo//sKGlr4Vrd6Q
	 UjKaLDOxIT+T4N+ZrjUQiUZ8WZBdvY6snXaPPaBW111d3At6vQQ89aH6z5BaZJ8inr
	 l4tBybMV3q5cjL7drmOCwmzxREylzUuPOv1hi67RkcjTVEmqXDfpvqSdc9vk8O/Dgq
	 jUefY68iyP88w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dmaengine: qcom: gpi: trace: Add trace events
 header for Qualcomm GPI DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, linux-trace-kernel@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260831-add-trace-support-gpio-v1-1-7b0fd0d0ddb3@oss.qualcomm.com>
References: <20260831-add-trace-support-gpio-v1-0-7b0fd0d0ddb3@oss.qualcomm.com>
 <20260831-add-trace-support-gpio-v1-1-7b0fd0d0ddb3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:05:45 +0000
Message-Id: <20260831190545.D4AC01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Tracepoint names violate the `subsystem_event` naming convention.
--

commit 247e0c64dd13ba460fb185bdf6a4727ca8e574bd
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

dmaengine: qcom: gpi: trace: Add trace events header for Qualcomm GPI DMA

This commit adds a tracepoint header for the Qualcomm GPI DMA engine driver.
The events provide runtime visibility into the driver's behavior, replacing
former debug logging.

> diff --git a/include/trace/events/qcom_gpi.h b/include/trace/events/qcom_=
gpi.h
> new file mode 100644
> index 0000000000000..5474e762f4b64
> --- /dev/null
> +++ b/include/trace/events/qcom_gpi.h
> @@ -0,0 +1,313 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM qcom_gpi
> +
> +#if !defined(_TRACE_QCOM_GPI_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_QCOM_GPI_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(gpi_send_cmd,

[Severity: Low]
Should this tracepoint name be prefixed with the subsystem name to match the
subsystem_event naming convention?

Since TRACE_SYSTEM is defined as qcom_gpi above, defining the event as
gpi_send_cmd instead of qcom_gpi_send_cmd creates namespace inconsistencies=
 in
tracing tools and debugfs. This naming pattern appears to be repeated for t=
he
other TRACE_EVENT definitions in this file.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-add-trace-=
support-gpio-v1-0-7b0fd0d0ddb3@oss.qualcomm.com?part=3D1
