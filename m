Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004738;
	b=o4+fV9K/2DFqSa91Es9mA0lAnvHvHrep5c4vwcRp5To5Seiht2IF3wIBQGofJU0oGpsr
	 lruxe5lBySVJETNYy32WqaGFuxgd+dPCPqcR8tsMF7FdkBcKD7DUMB79Mhze5qPyUKEtu
	 50SoTGZ64IdpYVOBFrwD0g37syjSqWlVBoHVVwUlhrpRC8FEs1AlaiQ7Elj/HS/d5VJd7
	 VHmlr1H/lgoV1sxOuDk4BFh8n19Fdj+HDqfEuMHsWQrbkWpDMiw3ueMXsLbl3iTtBBSW7
	 eyJ6wTkhyRYAY0BkKgs1K1QF+SAGBRo9kMvNxwY6cJ2nx1Lntpv9yfHr7mswHVsJB3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004738;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XGyXNU7tj9zkBAXR1oitkIEGznzhSCqqRaExrbXAeGQ=;
	b=z8OQL2XnB7VVflK5TJq+Tow9cyMaXm/LkcKg7Q2saxPLIRPDdIxnKik10qZJkXjbtI5r
	 t6x5VyVQAEmpzZ1kEkzGOPXRxsT+VJpT92bvIj0j9CGzrexID/o8nm/Z9GjVYAGetIqQg
	 8b51gxympSrIkTOUT9KXpuUZWB8hx2RlnNx88XzllohUVE0ccernclvA2ohIjpVJ1oqyZ
	 27qyqLISdnc2tqe5Fqxtm9Te4sCqq+Ocovrnm4q95Y9Kt+/6OAZtcPzRens+/xn1iSkJH
	 cQKPEjs5bYaRZIFXhiPAtnmfOuabWyZA7uaiL8aCmTGihUtrBpcImkwq7iPpDsnHRMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1WGuEtx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC14606A325;
	Mon, 26 Oct 2026 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1WGuEtx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572201F031E0;
	Mon, 26 Oct 2026 08:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004737;
	bh=XGyXNU7tj9zkBAXR1oitkIEGznzhSCqqRaExrbXAeGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k1WGuEtxcAqdEhinHQUJqmNm3W8L9EGRmhj3v+WJ4MuTRihmkjL7oYKiSM4w+1lS4
	 8GR7DBuEfstB11K00shpXlmyR6T64AlLG437v6FPsXhlXi6iBHdj+qa7+vQVJi22jb
	 sP/6l4qkr+HEBV0Un8KD2PMoalmE/yARXnh57VMlc4d0KKDEDcsA52uzZRwNm18jpU
	 DPJyKpVt9sxrJ8NnrN7lv497eBC2wuXeT5xC3lAgM32ypwZSPhQn/KQ4zxmnhcdoJg
	 aonoejoSrLQuHxW4z+6yCRmxPWMNaEPR2tTFG2COIDNPfOL/GmeIpMTYckbR6Ljp+c
	 3OJb2Q+6yF8yA==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jaewon Jung <jaewon8868@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Add debugfs requirement suffix
Date: Mon, 26 Oct 2026 17:52:14 +0900
Message-ID: <undine-1793004734173086687-aee9dd63729792f1@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261025072956.1739981-1-jaewon8868@gmail.com>
References: <20261025072956.1739981-1-jaewon8868@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Sun, 25 Oct 2026 16:29:41 +0900, Jaewon Jung <jaewon8868@gmail.com> wrote:
> Add a :debugfs requirement suffix to check interfaces under debugfs.
> Use it in the kprobe optimization test to report unsupported instead
> of failed when debugfs is unavailable.
> 
> Tested on x86_64 with QEMU:
> - debugfs not mounted: UNSUPPORTED
> - debugfs mounted: PASS
> 
> Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>

Good improvement! Let me pick it.

Thanks!

> ---
>  tools/testing/selftests/ftrace/test.d/functions        | 10 ++++++++++
>  .../selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc |  4 ++--
>  tools/testing/selftests/ftrace/test.d/template         |  1 +
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index 826141e299e5..3cf8ac5fb4d4 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -145,6 +145,7 @@ check_requires() { # Check required files and tracers
>  	p=${i%:program}
>          r=${i%:README}
>          t=${i%:tracer}
> +	d=${i%:debugfs}
>  	if [ "$p" != "$i" ]; then
>  	    if ! which "$p" ; then
>                  echo "Required program $p is not found."
> @@ -166,6 +167,15 @@ check_requires() { # Check required files and tracers
>                  echo "Required feature pattern \"$r\" is not in README."
>                  exit_unsupported
>              fi
> +	elif [ "$d" != "$i" ]; then
> +	    DEBUGFS_DIR=$(awk '$3 == "debugfs" { print $2; exit }' /proc/mounts)
> +	    if [ -z "$DEBUGFS_DIR" ]; then
> +		echo "Required filesystem debugfs is not mounted."
> +		exit_unsupported
> +	    elif [ ! -e "$DEBUGFS_DIR/$d" ]; then
> +		echo "Required debugfs interface $d doesn't exist."
> +		exit_unsupported
> +	    fi
>          elif [ ! -e "$i" ]; then
>              echo "Required feature interface $i doesn't exist."
>              exit_unsupported
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> index 9f5d99328086..25f7192f887b 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
> @@ -2,7 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (C) 2023 Akanksha J N, IBM corporation
>  # description: Register/unregister optimized probe
> -# requires: kprobe_events
> +# requires: kprobe_events kprobes/list:debugfs
>  
>  case `uname -m` in
>  x86_64)
> @@ -22,7 +22,7 @@ for i in `seq 0 255`; do
>          echo  "p:testprobe $FUNCTION_FORK+${i}" > kprobe_events || continue
>          echo 1 > events/kprobes/enable || continue
>          (echo "forked")
> -	PROBE=$(grep $FUNCTION_FORK /sys/kernel/debug/kprobes/list)
> +	PROBE=$(grep $FUNCTION_FORK "$DEBUGFS_DIR/kprobes/list")
>          echo 0 > events/kprobes/enable
>          echo > kprobe_events
>  	if echo $PROBE | grep -q OPTIMIZED; then
> diff --git a/tools/testing/selftests/ftrace/test.d/template b/tools/testing/selftests/ftrace/test.d/template
> index 2cd8947edf72..d4a2500498f6 100644
> --- a/tools/testing/selftests/ftrace/test.d/template
> +++ b/tools/testing/selftests/ftrace/test.d/template
> @@ -5,6 +5,7 @@
>  # The required tracer needs :tracer suffix, e.g. function:tracer
>  # The required README string needs :README suffix, e.g. "x8/16/32/64":README
>  # and the README string is treated as a fixed-string instead of regexp pattern.
> +# The required debugfs interface needs :debugfs suffix, e.g. kprobes/list:debugfs
>  # you have to add ".tc" extention for your testcase file
>  # Note that all tests are run with "errexit" option.
>  
> -- 
> 2.43.0
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
