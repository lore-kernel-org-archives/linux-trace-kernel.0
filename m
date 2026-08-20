Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B547DD4B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245103; cv=none; b=TGaw9PzdCa8dff9arze8erjdfg4VW09IobiCiZyORXfV+Pvt3NOmwuQJud3LJ/f9lzVnW2zpevbGq+Nr3w4UDnfikpXg8dRdvclYi+xtJIA7WWdwMVQkyElzQ7PkEziSosXzd3riidT3pyeGIjPpCfLa0A60ug0WLQXFuEZXwko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245103; c=relaxed/simple;
	bh=vPJNi8PVoqLO2QQYgTvwSUDab7HXWfohAJu9CIWmYOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SMIgoa8e61GQtsHgOMXHQ1H8STB5Jvm1QbQlcGjXfMimoAbMC+WfaAeYw35bVsY0Hp+J4/yp0tKZFp8tXN2K9rl2UPcM+8ke7oZQjdHJAMwjbvs0kPk03QtICAQw7UpmgtrwOz6cQUCBM0v+hm5diHCw+xdlKLR/7akvm076It4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRLE4VQN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRLE4VQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCC71F00A3A;
	Thu, 20 Aug 2026 16:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787245099;
	bh=loXxIZFIXSXHJU2VtS2lInvjdN5gyEJNndRrg6nW3r4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aRLE4VQN7lNuMuvLIay9QaLdFjpe+ktQB7vg19fCpo1UDUUZX3pzcG5kWSkoN3i+T
	 ReikcJfO/Gn5MQgukmOASgoLs0ywSYlKT1hipHk27USsKnvQHg+hjIKfoL/eHuxuq7
	 Wbrg/AGWlav0BZxZ2+ffc9fCPOm5qOsFo3t185cVFW+7/rtk3I3fI4bZbsCOpaO5ri
	 K68qvN7flN/a9sFrSPYBhfodc4JNz1/E6+a8hNZX4KcEMLGslYROzoLpyiIJ0FR2Tg
	 M0+bha7p5E3U28gxYgGWpngsK6+7gduyZMrH+6nUonJsaHjZy+3oKZj0wZaY5UnHKz
	 edj/55OngABWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 9/9] selftests/ftrace: Walk up to find
 test.d/functions when a subdirectory is passed
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <dc58717cc225389b041dc36c684df23e3253c473.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
 <dc58717cc225389b041dc36c684df23e3253c473.1787243842.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 16:58:18 +0000
Message-Id: <20260820165819.5CCC71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The directory traversal logic fails to check directory ownership a=
nd fails open on `stat` error, allowing arbitrary code execution as root vi=
a an attacker-controlled ancestor directory.
--

--- Patch [9]: [PATCH v6 9/9] selftests/ftrace: Walk up to find test.d/func=
tions when a subdirectory is passed ---
commit 71305ea3fc4b8a7294d098d4bcdd8624fd21ca70
Author: Wen Yang <wen.yang@linux.dev>

selftests/ftrace: Walk up to find test.d/functions when a subdirectory is p=
assed

This commit modifies ftracetest to walk up the directory tree from a passed
test directory until it finds a test.d/functions file. This allows monitor
subdirectories to be used directly as the test root without needing dummy
functions shims.

> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/se=
lftests/ftrace/ftracetest
> index 0a56bf209f6c0..8f9d9291bf4ce 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest

[ ... ]

> @@ -159,9 +159,29 @@ parse_opts() { # opts
>    if [ -n "$OPT_TEST_CASES" ]; then
>      TEST_CASES=3D$OPT_TEST_CASES
>    fi
> -  if [ -n "$OPT_TEST_DIR" -a -f "$OPT_TEST_DIR"/test.d/functions ]; then
> -    TOP_DIR=3D$OPT_TEST_DIR
> -    TEST_DIR=3D$TOP_DIR/test.d
> +  if [ -n "$OPT_TEST_DIR" ]; then
> +    # Walk up from OPT_TEST_DIR to find the nearest ancestor that contai=
ns
> +    # test.d/functions.  This allows a monitor subdirectory (e.g.
> +    # verification/test.d/tlob/) to be passed directly without placing a
> +    # dummy functions shim in each new subdirectory.
> +    # Security: only walk within directories owned by root or the curren=
t user
> +    # to prevent sourcing a functions file planted in a world-writable a=
ncestor.
> +    dir=3D$(realpath "$OPT_TEST_DIR" 2>/dev/null || echo "$OPT_TEST_DIR")
> +    while [ "$dir" !=3D "/" ] && [ "$dir" !=3D "//" ]; do
> +      if [ -f "$dir/test.d/functions" ]; then
> +        # Verify the directory is not world-writable to prevent LPE.
> +        dirperms=3D$(stat -c "%a" "$dir" 2>/dev/null || stat -f "%Lp" "$=
dir" 2>/dev/null)
> +        case "$dirperms" in
> +          *2|*3|*6|*7) ;; # world-writable: skip this candidate
> +          *)
> +            TOP_DIR=3D$dir

[Severity: High]
Does this logic actually check directory ownership as mentioned in the comm=
ents?

It appears the code only checks if the directory is world-writable, but omi=
ts
validating that it is owned by root or the current user. An attacker could
potentially create a directory with standard 0755 permissions, plant a
malicious test.d/functions script, and if a privileged user or automated te=
st
harness runs ftracetest against a subdirectory, the script would traverse up
and source the payload.

Additionally, if the stat command fails for any reason, dirperms will be em=
pty.
Would an empty string match the *) fallback case and cause the script to si=
lently
fail open, accepting even a world-writable directory?

> +            TEST_DIR=3D$TOP_DIR/test.d
> +            break
> +            ;;
> +        esac
> +      fi
> +      dir=3D$(dirname "$dir")
> +    done
>    fi
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787243842.gi=
t.wen.yang@linux.dev?part=3D9
