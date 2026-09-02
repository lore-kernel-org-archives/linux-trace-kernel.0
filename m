Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6853AA4E4
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 06:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331902; cv=none; b=DxGvph16HBXepJIGg6IMQpH4TJ3WIHRxfMgX343+c4gwXN2uDTdoshar95vpnNvNyPSKHHRi+A7QwmjDcf7Eg+i8JkbGvyIsGWXo/Vinn8LZyDX/u9hKK+XTdDrL4stCzydRpYfdFt/t7Uv7bMcP+joekMj1ikV4jR1cnF1oOIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331902; c=relaxed/simple;
	bh=fjg0GqXCLeiVr/nFyq/EMNabuIOYyF0bkhPyAHYIofw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y0rK8EJPipCrM2mSqozs3Bj9fpmXVItpaCyyEe9+MRN4yAouY/roqXk4SH/CLHe8617FO006HpPQ59BOyyfF07jjcODUGc0G5P8TfdrjHOpFeRNi8O8cRRUgzaXQsjLwKZ+C3UTVSc9ag07jDndgUGT39Jaz0iclyJrX+Tiu6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7TfsyxU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7TfsyxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662BC1F000E9;
	Wed,  2 Sep 2026 06:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788331887;
	bh=oWApl/DRvW4/OqoxI4ZbbdEvDL2hmH+42l5++F5YFHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H7TfsyxU1k3y2PY+4Xa0jM7AT7kWRd3yECtyacRQfDJhPncu0JJfe1Bjh2kJTs1Zb
	 obfcChHSG6at8n2cKowEAR1echPpJ48DaVBkbJLVvpw0I9snX94LmMOXUk6pGrED+V
	 3l2Xp/DTpqBSstJ5cbNZW7/FSWB4G8XvQGiQtPtw9WlBav7mDUGOjC8oRurhtWkEVL
	 OZpi1JiK+q/K9VW78CMm/PHvMBTC/KLG8CDLzIRZ2nhGJaCuMB0tunOQ1sYg/844fO
	 h1eDmKTOzSmaZthi+CX0k+wvsX/6ECwCY7VpCAUTBH8a0+BmcF20Mae9Q2iGAXUKuE
	 5KT5QUlPrOiCg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 3/3] trace: add documentation, selftest and
 tooling for stackmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Pengfei" <ljdlns1987@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260902064242.28606-4-lipengfei28@xiaomi.com>
References: <20260902064242.28606-1-lipengfei28@xiaomi.com>
 <20260902064242.28606-4-lipengfei28@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:51:26 +0000
Message-Id: <20260902065127.662BC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The commit message explicitly contradicts the documentation and =
selftests regarding the stack map reset behavior.
- [Medium] The `stackmap-instance-gate.tc` selftest lacks an EXIT trap to c=
lean up the secondary trace instance if the script is interrupted.
--

commit a336359d2bbb858ace4ecacee011a90b6d577fea
Author: Pengfei Li <lipengfei28@xiaomi.com>

trace: add documentation, selftest and tooling for stackmap

This commit adds supporting documentation, selftests, and a python parser
for the ftrace stackmap feature. It documents the tracefs interfaces,
configuration options, and tests both standard and error conditions.

Closes: https://lore.kernel.org/oe-kbuild-all/202605160010.fakzGVVq-lkp@int=
el.com/

>     - Reset is destructive: it requires tracing to be stopped and also
>       clears the ring buffer so no stale <stack_id N> survives

[Severity: Medium]
The commit message states that reset requires tracing to be stopped and
clears the ring buffer. However, the documentation and selftests in this
patch enforce the exact opposite behavior. Could the commit message be out
of date with the actual implementation?

> diff --git a/Documentation/trace/ftrace-stackmap.rst b/Documentation/trac=
e/ftrace-stackmap.rst
> --- /dev/null
> +++ b/Documentation/trace/ftrace-stackmap.rst
[ ... ]
> +To reset the stack map::
> +
> +    echo 0 > /sys/kernel/debug/tracing/stack_map
> +
> +Reset returns ``-EBUSY`` only if another reset is already in progress.
> +
> +Reset clears the map and nothing else: the trace buffer is left
> +untouched and tracing does not have to be stopped. As a result a trace

[Severity: Medium]
As noted above, this documentation explicitly describes a non-destructive
behavior, completely contradicting the commit description. Is the
documentation correct, or is the commit message correct?

> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.=
tc b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
[ ... ]
> +# Reset does not require tracing to be stopped: it clears the map only
> +# and leaves the ring buffer alone, so it must succeed with tracing on.
> +enable_tracing
> +echo 0 > stack_map || fail "stackmap reset failed while tracing is activ=
e"

[Severity: Medium]
This test actively enforces that reset succeeds while tracing is active,
again contradicting the commit message claim that it should require tracing
to be stopped.

> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instan=
ce-gate.tc b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance=
-gate.tc
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-instance-gate=
.tc
[ ... ]
> +fail() {
> +    echo "FAIL: $1"
> +    rmdir instances/test_stackmap_gate 2>/dev/null
> +    exit_fail
> +}
[ ... ]
> +# 2. Create a secondary instance and verify it does NOT see the option
> +#    or the stack_map* nodes.
> +mkdir instances/test_stackmap_gate || fail "could not create secondary i=
nstance"

[Severity: Medium]
If this selftest is interrupted (e.g., by a signal), won't the manual
cleanup in fail() be bypassed, leaking the test_stackmap_gate trace
instance?=20

Other selftests in this patchset correctly use an EXIT trap to ensure
cleanup happens even on interruption. Would it make sense to add a similar
cleanup trap here to prevent poisoning the tracefs environment for
subsequent tests?

> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.=
tc b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc
[ ... ]
> +# Reset clears the map only. It must succeed and must not disturb the
> +# trace buffer.
> +echo 0 > stack_map || fail "reset failed"
> +
> +after=3D$(grep -c "<stack_id" trace || true)
> +: "${after:=3D0}"
> +if [ "$after" -ne "$before" ]; then
> +    fail "reset changed the trace buffer: $before -> $after <stack_id> e=
vents"
> +fi

[Severity: Medium]
Similarly, this test verifies the ring buffer is not cleared during a reset.
Could we update the commit message to reflect the current design?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902064242.2860=
6-1-lipengfei28@xiaomi.com?part=3D3
