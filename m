Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10A63E025C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975642; cv=none; b=sIQVtUlvWCxn3q2dGazQdmVsCHUb1o0IbmydAAHvJvPUdxC9Lu7gaELcDidJaKKg5GFDoETZk5UsKQ8dFh0A0RwgwS6jix7f+wnq8fsfIaPPS7/JUNtTWF1HG6TAOCanQb98RzoYGRAY7iwBxwvhG9S1yEJfyX3zuvdZQ9OPIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975642; c=relaxed/simple;
	bh=hcea2t2Ew8H+ct2gEC/RA+V34uFkZwm8UdUJd1epO5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hPJxBnzUJeG1fcA1aJ3ftfok08tVNpwcokS0QONpTHESMujuAyG/OWQtGSQ5d+2ybSCDG/wLFs1yxpGTkd4dNnORSYV6O0KIesHenNMwMsXaqL7BgMKGA+ms+bwOg565YFoW3/UkOrG7eZ6FpTjbId8S2DHkJGXFbl7qtAHxwhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVTZH/9E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVTZH/9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD5A1F00A3A;
	Mon, 17 Aug 2026 14:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975641;
	bh=xIvczk2AtuEJQwMB8EOA5yP8zHyu4k13TfdO9qrtQY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IVTZH/9EGdGULf5WgQG13uHfjiSIMYLRuq5I5E5Z2xlvzSGSNhiJ9/7ECisgX7E5F
	 auWubYWe6OFsDrfNBrAcaxk6PaS8esNPTNgUmxbSeBKwiRKDsrcZ+OTOplwLcLj2kX
	 0kkjjCXrjnHAqodNDE7a2/zgox4xeakC4nbS5GaK5L3bYFd8XcTk/PKx3GDhRPa2Np
	 4R1HRxRFbkByqib96ZwKLXdZ6lqNH/JomZ4jyQ7akijLuo8B8XuK+vlL4ifhZSgMBJ
	 OczqtJeXc1mqruqEthy6Cjtn7LosN2X/cac9fqJUlAfO2abNzlSWWpsIZg1I8m8HjC
	 FA70UPYgMMZbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/18] tracing/remotes: selftests: Add a test for the
 dump_on_panic tracefs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260817135517.3919534-15-vdonnefort@google.com>
References: <20260817135517.3919534-1-vdonnefort@google.com>
 <20260817135517.3919534-15-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:07:20 +0000
Message-Id: <20260817140721.6DD5A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The selftest `dump_on_panic.tc` contains an intentional early re=
turn leaving dead code that, if modified and executed, would trigger a host=
 kernel panic.
--

--- Patch [14]: [PATCH v6 14/18] tracing/remotes: selftests: Add a test for=
 the dump_on_panic tracefs file ---
commit b661e8678db50e2f2bef3cbb826c8b850f1bdfa3
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: selftests: Add a test for the dump_on_panic tracefs file

This commit introduces a new selftest script to exercise the dump_on_panic
tracefs file, which toggles the remote buffer dump on system panic. It
verifies the behavior when the buffer is loaded and unloaded.

> diff --git a/tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.=
tc b/tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.tc
> new file mode 100644
> index 0000000000000..1ba025ff9838c
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.tc
> @@ -0,0 +1,51 @@
[ ... ]
> +test_dump_on_panic()
> +{
[ ... ]
> +    echo 1 > dump_on_panic
> +    echo 1 > tracing_on
> +    echo 0 > tracing_on
> +
> +    # REMOVE ME FOR A PROPER OOPS TEST
> +    return
> +
> +    echo 1 > tracing_on
> +
> +    for i in $(seq 1 32); do
> +        echo $i > write_event
> +    done
> +
> +    echo c > /proc/sysrq-trigger
> +}

[Severity: Medium]
Does leaving dead code like this in the repository create issues for test
automation?

If a developer removes the early return to run the full test, it appears it
would unconditionally panic the host kernel via sysrq-trigger.

Could this destructive part of the regression test be guarded by an explicit
opt-in environment variable instead of relying on manual code modification?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817135517.3919=
534-1-vdonnefort@google.com?part=3D14
