Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0540F3B4E84;
	Mon,  8 Jun 2026 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910242; cv=none; b=Mn+2VyXz1PnxzYDSYb8xj3NWmkfuwzMK5Cg7mupkYCHyuu1GjB/er98hD5qFls1w8Dns7pJwJzbjtkUMO1BLIbIeOEsXKhhxZ0S89/eUJQxaIMh5UDMXDHTAbD7Jw/Qb6KK+6PrS763yMoDDoMXcO+BdWhy948c3ld7KE0cig6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910242; c=relaxed/simple;
	bh=VCEs5thF0HcxdTp52UUMgGH17U9lIvOSaM1EHqrG7pA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r1oyaDlc6kWkfvxdV3mnx/cymV4fmLcUPmuikLrVRe1sOTllGetgDjORZxuZJnBB3ieYaCDZDbBOblf3L6oetT8cnJhnmLXH0mnhoYlC4uCjj/h17jCJBSShFpT3wzu8Vybw0UMFIzdTkdY/0224XAk2K8Gy/XpZS7oz2s2oOpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0vUtKNo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0vUtKNo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8B31F00893;
	Mon,  8 Jun 2026 09:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780910240;
	bh=gkLIaTscoCnVDRa3Re0bl/NCLLxGRZqG/r6RpTgMv5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C0vUtKNoajNAJpjdxt+7WmSFH8h5OmpWhkZPVRK7IJ7kFHzUhHnb8x+SQnk8Ootyl
	 wMF6frhWwJy+Irtyco8xC3GF6JgPUbl18qBlYSpdheOZepiQfL1yxzHZcCWtLx1hBf
	 5tjoRgVR8Hc+Tyqyd0e95OJWwW5uXpnhrMWcjhwUSZA3JWrM6lxWRXoYZsCXac+b2f
	 1W/bBuEp1ZvX73B8hXXI265ijKhWKXzxwqJLSPZMpGAu0iZs74ikL8r3NPQ8iH052X
	 gBRe/XUAUspKeg6lDsJk7lX/dc+MfReQEI3dpFuakLQXvwvslM4O9uAdsfgt2G/70j
	 rSQl+h3lOmRGw==
Date: Mon, 8 Jun 2026 18:17:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, pjw@kernel.org,
 linux-trace-kernel@vger.kernel.org, shuah@kernel.org,
 wangfushuai@baidu.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/ftrace: Account for 8-byte aligned
 trace_marker_raw events
Message-Id: <20260608181716.726cb9c81d41d49095e7f3cf@kernel.org>
In-Reply-To: <20260607072431.125633-3-hui.wang@canonical.com>
References: <20260607072431.125633-1-hui.wang@canonical.com>
	<20260607072431.125633-3-hui.wang@canonical.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Jun 2026 15:24:31 +0800
Hui Wang <hui.wang@canonical.com> wrote:

> trace_marker_raw.tc assumes that the raw marker payload length
> reported in trace_pipe is the result of int((id + 3) / 4) * 4, but
> that is not true on kernels with CONFIG_HAVE_64BIT_ALIGNED_ACCESS
> enabled.
> 
> With forced 8-byte alignment, the ring buffer event forces 8-byte
> alignment. The event length is stored in array[0], the payload data
> and id are placed in a struct raw_data_entry which is stored starting
> at array[1]. In this case, the printed payload data length is 8*N+4
> bytes.
> 
> To make the testcase pass in this case, add a kconfig_enabled() helper
> and use it to detect CONFIG_HAVE_64BIT_ALIGNED_ACCESS so
> trace_marker_raw.tc can calculate the expected length correctly.
> 

Hmm this fix lacks consideration for the environment.

> Assisted-by: Copilot:gpt-5.5
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  .../ftrace/test.d/00basic/trace_marker_raw.tc | 16 +++++++--
>  .../testing/selftests/ftrace/test.d/functions | 33 +++++++++++++++++++
>  2 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> index 8e905d4fe6dd..beda0f8627b3 100644
> --- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> @@ -15,6 +15,11 @@ is_little_endian() {
>  }
>  
>  little=`is_little_endian`
> +raw_data_align=4
> +
> +if kconfig_enabled CONFIG_HAVE_64BIT_ALIGNED_ACCESS; then

Checking Kconfig is OK, but in this case, if the existence of the
dependent Kconfig file itself cannot be confirmed, this test should
return an unresolved error.

> +       raw_data_align=8
> +fi
>  
>  make_str() {
>  	id=$1
> @@ -60,7 +65,8 @@ test_multiple_writes() {
>  	echo stop > trace_marker
>  
>  	# Check to make sure the number of entries is the id (rounded up by 4)
> -	awk '/.*: # [0-9a-f]* / {
> +	# or is (((id + 3) rounded by 8) + 4) if raw_data_align is 8
> +	awk -v data_align=$raw_data_align '/.*: # [0-9a-f]* / {
>  			print;
>  			cnt = -1;
>  			for (i = 0; i < NF; i++) {
> @@ -69,8 +75,12 @@ test_multiple_writes() {
>  					i++;
>  					cnt = strtonum("0x" $i);
>  					num = NF - (i + 1);
> -					# The number of items is always rounded up by 4
> -					cnt2 = int((cnt + 3) / 4) * 4;
> +					# The number of items is rounded up by 4
> +					# or is (8 * N + 4) if data_align is 8
> +					if (data_align == 4)
> +						cnt2 = int((cnt + 3) / 4) * 4;
> +					else
> +						cnt2 = int((cnt + 3) / 8) * 8 + 4;
>  					if (cnt2 != num) {
>  						exit 1;
>  					}
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index 826141e299e5..0f778087d81b 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -177,6 +177,39 @@ check_awk_strtonum() { # strtonum is GNU awk extension
>      awk 'BEGIN{strtonum("0x1")}'
>  }
>  
> +# a helper to check if a kconfig is enabled or not
> +# return value: 0 (if kconfig is enabled)
> +#               1 (if kconfig is not enabled)
> +#               2 (if the config files don't exist or are unreadable)
> +kconfig_enabled() { # config-name
> +    local config="$1"
> +    local uname_r=`uname -r`
> +    local config_file
> +
> +    case "$config" in
> +    CONFIG_*) ;;
> +    *) config="CONFIG_$config" ;;
> +    esac
> +
> +    if [ -f /proc/config.gz ] && zgrep --version >/dev/null 2>&1; then
> +        zgrep -Eq "^${config}=(y|m)$" /proc/config.gz 2>/dev/null

Do not use zgrep (this requires to install zgrep pacakge) in this test,
instead, use more widely available `gzip -dc | grep ...`.
I would like to keep this runnable on a minimum environment.

> +        return $?
> +    fi
> +
> +    for config_file in \
> +        /boot/config-$uname_r \
> +        /lib/modules/$uname_r/config \
> +        /lib/modules/$uname_r/build/.config

Hmm, also I don't like this, because this highly depends on the environment.
Instead, we can add CONFIG_IKCONFIG_PROC=y in tools/testing/selftests/ftrace/config.

Thank you,

> +    do
> +        if [ -f "$config_file" ]; then
> +            grep -Eq "^${config}=(y|m)$" "$config_file"
> +            return $?
> +        fi
> +    done
> +
> +    return 2
> +}
> +
>  LOCALHOST=127.0.0.1
>  
>  yield() {
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
