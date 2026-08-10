Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34843128AB;
	Mon, 10 Aug 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371453; cv=none; b=d5v8tLbMIiV6UEDmdpuJ6pbmkKrK0+e1eZQznBDA8MlucvEYQ3wd76abalpYmGHRl1J8WIrs7bKabfNY5SrYbxqk9M+aA/i7Ro1iX9ckCJOJwWSlzYdv2/57v8uJGq+mggpLzVTYf65z9/eeA/UqjiLD40b/WDddLsPcmho/Vd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371453; c=relaxed/simple;
	bh=VZvdwSAXBkIt8Db7mp8XY+9fCbK+WzAkQF+E19qcoUc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PIHbBtdAhaznTsDuPmTQl4yaaejxodWBpuXUhugWXMB/hlZ5GnFW5/lks5VHwjTkZrPEEKQSOIsIxaviTVWhb55S7hNm6wrkaWCmeXGrDhmePMWBrpAbp1mroRQT1CFOY+bJPvUclby62R6NwGTvCH7mASnYt3Qz+YkTGNpY++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcmMvG98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcmMvG98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF6A1F000E9;
	Mon, 10 Aug 2026 14:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786371451;
	bh=AidgFK9ECbWnRirhs4sbISDeksY3dhvI6l2P2J9th+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QcmMvG985PFFN5MZmcYCuUWENGfwsKuuHVT7kyq60BW3P4v0RvMWO8IKurrAq8y0f
	 x1ZkNQD8BLoWbPCXQkKbhYUCp3dKwi4l1/MC16+ZaVRBy4Iq7REqA7JSNBYnwUzWxR
	 F/gVD9+Rlgju3xBsQkVGhLurjEWaWUO6XWXxq09n4a/DtwOQ2S9HVGRZIVItRTbTZA
	 /g6ODE3g9rRx8sO0le+jRL3VjVgOaYX5Vw4r+Z4wkwTNPKsQ1/nImeOjGHdO7A+Eq0
	 5fUcQkXB08k6AhpRmhrNzyX8R6Wh1ZEZqSNvSoGIvu10E5WuC5J9VFmGxatZiaPicM
	 pmYOVXZf9yRZQ==
Date: Mon, 10 Aug 2026 23:17:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 4/4] selftests/ftrace: Add persistent ring buffer
 testcases
Message-Id: <20260810231727.caafe1c947ad3f113bb991b9@kernel.org>
In-Reply-To: <178635446219.380779.14935908214040944426.stgit@devnote2>
References: <178635442508.380779.3709136256425432083.stgit@devnote2>
	<178635446219.380779.14935908214040944426.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 18:34:22 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> +
> +# Check if BOOT1_MARKER is in boot_map/trace (indicates second boot)
> +if grep -q "BOOT1_MARKER" "$TRACEDIR/instances/boot_map/trace" 2>/dev/null; then

Sashiko commented:
> Could this test logic lead to an infinite reboot loop if the primary trace
> instance is cleared?

Yes, but the test framework will stop because timeout monitors it.

> If the boot_map instance is cleared on boot (for example, if boot events were
> enabled to start a fresh trace), the marker would be missing from boot_map on
> the second boot.

This can happen if KASLR changes the address.

> The script would assume it is the first boot, write the marker, and reboot
> repeatedly until the QEMU timeout is reached.
> Should this check use the backup instance instead
> (e.g., "$TRACEDIR/instances/backup/trace") to detect the second boot?

No, since the backup instance is always be allocated.

OK, so let's give bigger alignment option so that in most case it will not
change the address.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
