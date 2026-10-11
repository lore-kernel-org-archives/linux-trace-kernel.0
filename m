Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A8C43F8C8
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748264; cv=none; b=rkazjBDo/bQyRLGNL01BJ6Z+CifbVCm+tChQQMPhS8zdMnWJZYzcwyDuM82YyjPaLaQveKpDfUlkXdTJRKTFZ4J5sOHR3z1kXNQKK4zd11eB7CiEkUkDOlsb9oYwhBxKSMhsl/dQFc9fmt7hM4j0TdWDpxErt3ie1PVfYcbHtes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748264; c=relaxed/simple;
	bh=4R63cy8C2li5u/K2puQwfnzmCsNqhTqvdII0fgyrv7I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RImBZEMZbjlBOC9qoJLb3jM9CFhUpn8I7DJ1doJLg3+8h9ELPk4xQo6MsU9TVkhf/6mklDJFwLJ4CVyYbe+lY9FX9uOF2jwZlUBj2KvGP0haXwcBFWNG3QJHnJCRy4a7OR3ImQ62qLqvKxkVvbt6chNhuk9O1laEAkDx40ut9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD1t9O0u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD1t9O0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD571F0089B;
	Sun, 11 Oct 2026 19:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748262;
	bh=gyhi67JYlo3JhyacBiK/ibb5UbBDN3sE6y1JXI590X4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UD1t9O0ugG5Hd7DGYrj0vezZqqDC4kiR23ohydB0aG1PcOdmey2BF5ZhMJusnL+RT
	 SRr8jolaVx4pk13ZALn49VzIFL2bi1KTmH8BlrTrbPbLBCHxrVNDeuFiXDmktNOINe
	 vwTAQv029kCw9jC5jcuLVbx4u7g9jePyESs389SZY9dqw9kpBJZXzbhvm9tWWWloJj
	 cM2cY2wE+jSdaSDMw/0M639JBgrwUJ5TpM8sDqeN9+5xu515sWnvlJHnZaN4WgJWsz
	 QLtkrWr6T4NLEH5PEPvItyFNC2MCPpRjrzvZOV8loCwlLGf/yCouwbYCNhu4lUmTFi
	 KW56eQAwtUt8w==
Message-ID: <sashiko-outbox-167421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/14] selftests/verification: Add tlob selftests
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <130a11faa5222f71d4074dcf4b1a77c020b997ed.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
 <130a11faa5222f71d4074dcf4b1a77c020b997ed.1791745088.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 19:51:01 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests: commit message incorrectly claims run_tlob_tests.sh buil=
ds helpers
--

commit efda93f229ffc44f9ac300b085e473092fbfd5fd
Author: Wen Yang <wen.yang@linux.dev>

selftests/verification: Add tlob selftests

This commit adds ten ftrace-style test scripts for the tlob RV monitor, alo=
ng
with a target helper binary. It also introduces a runner script to handle
ftracetest delegation.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>

> Helper binarie tlob_target is built via TEST_GEN_FILES, following
> the kselftests convention.  run_tlob_tests.sh builds the helpers
> and delegates argument handling to ftracetest.

[Severity: Low]
This isn't a bug in the code, but there is a typo (binarie), and the commit
message states that run_tlob_tests.sh builds the helpers. Is this descripti=
on
accurate?

Looking at the added script, it explicitly refuses to build the helper and
errors out if the binary is missing:

> diff --git a/tools/testing/selftests/verification/test.d/tlob/run_tlob_te=
sts.sh b/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
> new file mode 100755
> index 0000000000000..c87484813fc86
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/run_tlob_tests.sh
[ ... ]
> +# The helper is built on the host by the selftests Makefile
> +# (TEST_GEN_FILES in $BINDIR/Makefile); the VM (virtme-ng) mounts the
> +# source read-only and may lack a compiler, so this runner never builds.
> +# Build it on the host first:
> +#   make -C "$BINDIR" tlob_target
> +if [ ! -x "$BINDIR/tlob_target" ]; then
> +	echo "ERROR: tlob_target not built in $BINDIR" >&2
> +	echo "       build it on the host: make -C $BINDIR tlob_target" >&2
> +	exit 1
> +fi

Could the commit message be updated to clarify that the script expects the
helper to be pre-built on the host rather than building it automatically?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791745088.gi=
t.wen.yang@linux.dev?part=3D13
