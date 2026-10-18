Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40872230BD5
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Oct 2026 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792296472; cv=none; b=l3VtARWuVhQm6f/VUAnt5CsCQgs04Xc1ie40F8OPagM1ifFCRGHaMMdumLju0SPoMBOfCrCpj/2u92PW9jqT6HMJLyzC10omUmk6zP2IEXjg60nHfBq9WGikHBwgYMwM9A2US5FB/wi/iXPDm+oxOyfna343XQMHqr3H3+bjLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792296472; c=relaxed/simple;
	bh=tirZF2GUOKeyLm6lGe9wVVQXzUTUgfLwnjOWa4Syk7I=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=NoJ8zL7x3wA8r19sHypfsQluPuREZckvRE9+BS7Cd5X9JQ02OXCfr8sKtWjK4FjNFjYClZb7UWeTqTMbB+p6d2LPyIYYQUmhWS39ru7yDkEZn48hZ18vyHdjJFxN5ELp86yQ4WRm37SUNZoRcejC5ZuDZgwDK4WiJzLrXTqB92w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oiz+90YM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oiz+90YM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B3D1F000C4;
	Sun, 18 Oct 2026 04:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792296470;
	bh=fL3XbIXdagvp/2Wq9nfQKoxo2UpLsbSYJGyylaZsZpw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Oiz+90YMGiZKfUX4I3FRfCTt4Fj0/5ylKhRuHGkhO95/E528aIBL3Lm5CML52kse+
	 +VAjo3L0/yUpgslxZKhbhvgNAtoV3fSNo2674uAbPmeE+j4YWDF6Gzxi8PpoA2+P/B
	 VPCyJllDDpcSm/nZK2T0e5TGnsfp+83gUSetke07PgP03xbsICDfl2Udg5z/XRUbx/
	 HByg7DGbQhhdCyAKQ4EL1NQwWAB0jbro5x4Wr3NAeUMB5Oq0MdsO5f+ha8ZNPOxelB
	 962uO5OZin9Pj/TlvMdvwauIV19SO1GBDO3URhE7dx1WZxHoYlzr6sMIHd9RHcNvKu
	 z+bZmILklHQUA==
Message-ID: <sashiko-outbox-175917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtla: add tests for tracefs instance cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chaosheng Qu" <chaosheng.qu.linux@gmail.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179229581980.42222.4083144248804063295@gmail.com>
References: <179229581980.42222.4083144248804063295@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 04:07:50 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] rtla: subcase SKIP treated as group skip in run_cleanup_cases()
- [Medium] rtla: tests: invalid --version check in check-cleanup.sh skips a=
ll tests
--

commit 39ad3784406cff716e91c58adc60f6311f089ea0
Author: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

rtla: add tests for tracefs instance cleanup

This commit adds a SIGTERM handler to rtla so tracefs instances are cleaned
up on termination, along with a new test suite verifying tracefs instance
cleanup across abnormal exit paths.

> diff --git a/tools/tracing/rtla/tests/cleanup.t b/tools/tracing/rtla/test=
s/cleanup.t
> new file mode 100644
> index 0000000000000..f3b495b0aee4e
> --- /dev/null
> +++ b/tools/tracing/rtla/tests/cleanup.t
> @@ -0,0 +1,71 @@

[ ... ]

> +run_cleanup_cases() {

[ ... ]

> +	out=3D$($timeout_cmd "$helper" "$RTLA" 2>&1)
> +	rc=3D$?
> +	if [ $rc -eq 0 ]; then
> +		# The helper may skip individual cases; a group-level SKIP means it
> +		# could not run at all.
> +		skip=3D$(printf '%s\n' "$out" | sed -n 's/^SKIP: //p' | head -n 1)
> +		if [ -n "$skip" ]; then
> +			echo "ok $ctr - instances cleaned up on SIGINT, timeout and action fa=
ilure # SKIP $skip"
> +			return
> +		fi
> +		printf '%s\n' "$out" | grep '^SKIP: ' | while read -r line; do
> +			echo "# ${line}"
> +		done
> +		echo "ok $ctr - instances cleaned up on SIGINT, timeout and action fai=
lure"

[Severity: Medium]
In run_cleanup_cases(), sed -n 's/^SKIP: //p' matches any line in $out
starting with "SKIP: ". When the action-failure subtest in
tools/tracing/rtla/tests/scripts/check-cleanup.sh does not cross the
stop-total threshold on an idle system, it logs:

	if [ "$action_rc" -eq 0 ]; then
		log "SKIP: action-failure: stop-total threshold was not crossed"

Won't $skip be populated from that subtest skip even when all other subtests
ran and passed, causing run_cleanup_cases() to report the entire TAP test as
skipped and leaving the grep '^SKIP: ' loop right below it unreachable?

[ ... ]

> diff --git a/tools/tracing/rtla/tests/scripts/check-cleanup.sh b/tools/tr=
acing/rtla/tests/scripts/check-cleanup.sh
> new file mode 100755
> index 0000000000000..1b4397123708e
> --- /dev/null
> +++ b/tools/tracing/rtla/tests/scripts/check-cleanup.sh
> @@ -0,0 +1,197 @@

[ ... ]

> +# Leave nothing behind from the test before it starts, and make sure the
> +# command under test is actually usable.
> +cleanup_all
> +if ! "$RTLA" --version >/dev/null 2>&1; then
> +	log "SKIP: $RTLA is not usable"
> +	exit 0
> +fi

[Severity: Medium]
Does rtla support the --version flag? Looking at main() in
tools/tracing/rtla/src/cli.c:

	if (strcmp(argv[1], "-h") =3D=3D 0)
		rtla_usage(129);
	else if (strcmp(argv[1], "--help") =3D=3D 0)
		rtla_usage(129);

	retval =3D run_tool_command(argc, argv, 1);
	if (retval)
		exit(0);

usage:
	rtla_usage(129);

It looks like passing --version falls through to rtla_usage(129) and exits
with status 129. Won't this check always fail and cause check-cleanup.sh to
skip the entire test suite on every run?

[ ... ]

=E2=94=80=E2=94=80=E2=94=80=E2=94=80
To understand more about how the conclusions weredrawn,Normally:
- Stage 1 (goal): VF1
- Stage 2 (implementation): PVF1
=E2=94=80=E2=94=80=E2=94=80=E2=94=80

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179229581980.42222.=
4083144248804063295@gmail.com?part=3D1
