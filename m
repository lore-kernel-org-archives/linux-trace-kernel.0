Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F6F1F5842
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553556; cv=none; b=BsdZBzuRmccOXSOIatUaS5haRup6lWmIl1knaDx9KgTYWSmr/UvstIuGy2Y8+HMuyTfb/SISJ0rfsf00MtOmECvQvdseZ5Jzq3Ikhd2sX46yUMFIUe3Fv6GecG+AxuK6YTmVnkbYtb8lFRyaEXeFAW0ClRfIpMDzs4UXwDqUHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553556; c=relaxed/simple;
	bh=mgHqECVtxixt6zRXz3wxRH1+FsWezrj9c0iONoakhO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MN0fBrFBCwEedvFMaz1aEuh3qE9X5AzOsmbN6O7vNTehtIdh55d5iLpAAQlBCFEfBXHIWqlJANB6cMyDRQae66W6giaBMnt+SfPwS/z1BXSmb08u8BQEDpP12hiNSQ3I8yXb35NXwq3/3Asc8MAnCyLa4aSmU8UoZwGwUtG/ge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHARJIZI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHARJIZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107A81F000E9;
	Wed, 12 Aug 2026 16:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786553555;
	bh=4XGnyk4+J4Xr2yoSNLDO4yX9Mcr0xFi2fQDAgJT2Rbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fHARJIZIM7szn81jW4OSqAKPSHaO3zZCneo4gs2H463rJx3Xf+IsZYVMGCHTN7Jbq
	 kILxxmUy92ujhxJWDBoP3m6Lbe9YwZVmohz4Wybhs38E5Z90M1q9UoV3HGgc4wAlNU
	 iIqSzKoJwL3HhFm7G8oKIUUPbpfWTY05m+bK5qiOknU8t8BnGtOyqgGGU33T9Se+Lw
	 M0I/LLpf6ZlcCMc9D7k554vhaHsJ6vvpKXZu8OFbQw0XESIsDYYy9hrH+/5qVsMVYh
	 Xd6iIJNfA8kVNuOTPeidF8YFGbcQREn7fN33nJrOx2r2sh2yNdaRteOufbBGD90am4
	 07qjzjIIi5QnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/18] tracing/remotes: selftests: Prefix hypervisor
 folder
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812161340.2417322-9-vdonnefort@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-9-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:52:34 +0000
Message-Id: <20260812165235.107A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The dmesg forwarder will stall indefinitely if pr_info() returns=
 0.
--

--- Patch [8]: [PATCH v5 08/18] tracing/remotes: selftests: Prefix hypervis=
or folder ---
commit 72aa88bcfffb90718532218e7344002c71fad7d0
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: selftests: Prefix hypervisor folder
   =20
Rename the hypervisor tests directory to "00hypervisor" to ensure they
run first. This prevents the hypervisor tests from being interleaved
with other remote tests which is confusing.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index e6724f947170d..3a5e0d84c1722 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c
[ ... ]
> @@ -795,26 +908,105 @@ static const struct file_operations trace_fops =3D=
 {
>  	.release	=3D trace_release,
>  };
> =20
> +static bool trace_remote_do_dmesg(struct trace_remote *remote)
> +{
> +	struct trace_remote_iterator *iter =3D smp_load_acquire(&remote->dmesg);
> +	unsigned int max_events =3D 1000;
> +
> +	if (!iter)
> +		return false;
> +
> +	trace_remote_iter_read_start(iter);
> +
> +	while (trace_remote_iter_read_event(iter)) {
> +		trace_seq_init(&iter->seq);
> +
> +		trace_remote_iter_print_event(iter);
> +		trace_seq_putc(&iter->seq, 0);
> +		if (!pr_info("%s", seq_buf_str(&iter->seq.seq)))
> +			break;
> +
> +		trace_remote_iter_move(iter);

[Severity: Medium]
Will this loop stall indefinitely if CONFIG_PRINTK is disabled?

When CONFIG_PRINTK is disabled, the pr_info() macro expands to an inline
function that unconditionally returns 0.

If that happens, the loop will break before calling trace_remote_iter_move(=
).

Because the iterator is never advanced, the next time the polling work runs,
won't it read the exact same event and break again, creating an infinite po=
lling
loop without making any progress?

> +
> +		if (!(--max_events))
> +			break;
> +	}
> +
> +	trace_remote_iter_read_finished(iter);
> +
> +	return !max_events;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812161340.2417=
322-1-vdonnefort@google.com?part=3D8
