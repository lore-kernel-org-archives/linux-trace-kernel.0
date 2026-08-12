Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE552C0F7F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786496253; cv=none; b=n3DsgnSYnZSVmG3F3HtabohTQ2OzSMTP9qXUyXtpeY2t7cXm8E3OiNStWh9BdZKrmmgMpkhRtQB6j0Kop2i6GpRHsA8xd2fZk3DpGZ1tIuMrZrcbGrMIu0B+ZrOwNizVHV4DCKH7gS9c5VwIf3dfJpD4U76HvPmnQBVC74CK3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786496253; c=relaxed/simple;
	bh=SxVGNeGwgxTyMxUFutqP/Z0ajLRGB5d3GhltYeR7Eu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KtzWPTYLZ0OZ/ArZu13zeMDLctNNkpo4V2xYElRLBD01KjKbB6+zgQvoFemdF2DzX1yiCkUvWUq/or555o8G63Yk1yojAcG6GevJ7Gd9Hy9p5u8bMjA9gb5LiB8UOLTz7j/G6GiuiGsWwetVO3pld4ZlUJYrfXysrHEUN40nI24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRrbvl8Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRrbvl8Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E1F1F000E9;
	Wed, 12 Aug 2026 00:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786496252;
	bh=R6K6o62fjW/NKtmKA4IOZW5TimPc4PMTRGDJs0BUfW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XRrbvl8Y6PnOpn5fbN46gw6dKZdd7WMzgaWf0hw/YFUO+EKUucIkzpU7AALclSHZQ
	 HXRpcZFYjTPu8RdRqnDCI5oaKw4B3hCEFhwS/0Mg/xEHEKFY6UYQ/5ZNam7xeS/wR1
	 Ak6QV9jlDqbq7wY52Hl864/4tPeJbfqfcKudfUzbcLgonJ4QD3mZE2Z81TaCT5Etrv
	 jMOODxjRxemdw4ZBzHsPuKk0JDHKH2LHcMOtIiwXgWJT+Ed/Z98RiKoak5sSOcknO4
	 j/Utp0zRYVKLMSKoTwB7Sk3EQBpM61zYrZFI8wa0QTtKBG7/UDvO8GAbFyY31g+sGP
	 kGXJjWWWKSScQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] selftests/ftrace: Add persistent ring buffer
 testcases
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <178649544683.438282.14573895196260214231.stgit@devnote2>
References: <178649540853.438282.4271870161169100680.stgit@devnote2>
 <178649544683.438282.14573895196260214231.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 00:57:31 +0000
Message-Id: <20260812005732.48E1F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Test enters an infinite reboot loop if the persistent trace feat=
ure fails.
--

--- Patch [4]: [PATCH v3 4/4] selftests/ftrace: Add persistent ring buffer =
testcases ---
commit d365a5483f67b1295e536e6d26fd4ee7166e27b3
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

selftests/ftrace: Add persistent ring buffer testcases

Add test cases for persistent ring buffer and backup instance across guest
crash/reboot. These verify trace data retention in the boot_map instance and
preservation in the backup instance on subsequent boot.

> diff --git a/tools/testing/selftests/ftrace/boottime/tests/persistent-01-=
reserve-mem.sh b/tools/testing/selftests/ftrace/boottime/tests/persistent-0=
1-reserve-mem.sh
> new file mode 100644
> index 0000000000000..49abaf518481f
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/boottime/tests/persistent-01-reserve=
-mem.sh
> @@ -0,0 +1,28 @@

[ ... ]

> +
> +# Check if Boot 1 marker was already written
> +if grep -q "BOOT1_MARKER" "$TRACEDIR/instances/boot_map/trace" 2>/dev/nu=
ll; then
> +	# Second boot: verify persistent ring buffer content from first boot
> +	echo "PASS: persistent-01-reserve-mem"
> +	exit 0
> +fi
> +
> +# First boot: write marker to persistent buffer and trigger kernel crash=
/reboot
> +echo "BOOT1_MARKER" > "$TRACEDIR/instances/boot_map/trace_marker"
> +sync
> +
> +# Trigger reboot to restart into second boot
> +echo b > /proc/sysrq-trigger 2>/dev/null || echo c > /proc/sysrq-trigger=
 2>/dev/null || true

[Severity: Medium]
If the persistent trace feature fails to retain the BOOT1_MARKER across
reboot, could this script enter an infinite reboot loop?

Since the test falls through to the first-boot logic when the marker is
missing, it appears it will write the marker and reboot again indefinitely.
This might cause the test to run until it is killed by a global timeout
rather than failing cleanly.

> +sleep 5
> +echo "FAIL: reboot trigger failed on first boot"
> +exit 1
> diff --git a/tools/testing/selftests/ftrace/boottime/tests/persistent-02-=
backup-instance.sh b/tools/testing/selftests/ftrace/boottime/tests/persiste=
nt-02-backup-instance.sh
> new file mode 100644
> index 0000000000000..0b2a2f03ce4f2
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/boottime/tests/persistent-02-backup-=
instance.sh
> @@ -0,0 +1,40 @@

[ ... ]

> +
> +# Check if BOOT1_MARKER is in boot_map/trace (indicates second boot)
> +if grep -q "BOOT1_MARKER" "$TRACEDIR/instances/boot_map/trace" 2>/dev/nu=
ll; then
> +	# Second boot: verify BOOT1_MARKER was copied into backup/trace from Bo=
ot 1
> +	if grep -q "BOOT1_MARKER" "$TRACEDIR/instances/backup/trace" 2>/dev/nul=
l; then
> +		echo "PASS: persistent-02-backup-instance"
> +		exit 0
> +	else
> +		echo "FAIL: BOOT1_MARKER found in boot_map/trace" \
> +			"but missing from backup/trace on second boot"
> +		exit 1
> +	fi
> +fi
> +
> +# First boot: write BOOT1_MARKER to boot_map and reboot via sysrq-trigger
> +echo "BOOT1_MARKER" > "$TRACEDIR/instances/boot_map/trace_marker"
> +sync
> +
> +# Trigger reboot to restart into second boot
> +echo b > /proc/sysrq-trigger 2>/dev/null || echo c > /proc/sysrq-trigger=
 2>/dev/null || true

[Severity: Medium]
Similarly, does this script also risk an infinite reboot loop if the marker
is missing from boot_map/trace on the second boot?

It looks like it would also fall back to triggering another reboot instead
of reporting a failure.

> +sleep 5
> +echo "FAIL: reboot trigger failed on first boot"
> +exit 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178649540853.438282=
.4271870161169100680.stgit@devnote2?part=3D4
